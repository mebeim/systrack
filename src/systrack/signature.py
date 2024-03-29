import logging

from operator import itemgetter
from pathlib import Path
from struct import unpack, iter_unpack
from typing import Tuple, List, Iterable, Iterator

from .elf import ELF
from .syscall import Syscall
from .utils import noprefix

def expand_macros(sig: Iterable[str], big_endian: bool) -> Iterator[str]:
	for field in sig:
		newfield = noprefix(field, 'SC_ARG64(', 'arg_u32p(', 'compat_arg_u64_dual(', 'compat_arg_u64(')

		if newfield == field:
			yield field
			continue

		assert newfield[-1] == ')'
		field = newfield[:-1]

		if big_endian:
			yield from ('u32', f'{field}_hi', 'u32', f'{field}_lo')
		else:
			yield from ('u32', f'{field}_lo', 'u32', f'{field}_hi')

def parse_signature(sig: str, big_endian: bool) -> Tuple[str, ...]:
	split_sig = map(str.strip, sig.split(','))

	# SC_ARG64 is standard for all archs
	# arg_u32p is arm64-specific
	# compat_arg_u64[_dual] is riscv-specific
	if all(x not in sig for x in ('SC_ARG64', 'arg_u32p', 'compat_arg_u64')):
		# Make sure it doesn't contain any other macros that we don't know about
		assert '(' not in sig and ')' not in sig, f'Unexpected parentheses in signature: {sig!r}'
		return tuple(split_sig)

	return tuple(expand_macros(split_sig, big_endian))

def syscall_signature_from_source(file: Path, line: int, big_endian: bool) -> Tuple[str, ...]:
	sig = b''

	with file.open('r') as f:
		for _ in range(line - 1):
			next(f)

		sig = f.readline().strip()
		while not sig.endswith(')'):
			sig += f.readline().strip()

	# We only handle two scenarios here:
	#
	#     SYSCALL_DEFINEx(name, type1, arg1, type2, arg2, ...)
	#     asmlinkage xxx sys_xxx(type1 arg1, type2 arg2, ...)

	newsig = noprefix(sig, 'SYSCALL_DEFINE', 'SYSCALL32_DEFINE',
		'COMPAT_SYSCALL_DEFINE', 'COMPAT_SYSCALL32_DEFINE',
		'PPC32_SYSCALL_DEFINE')

	if sig != newsig:
		sig = newsig
		start = sig.find(',') + 1
		nargs = int(sig[0])
		assert nargs <= 6, f'SYSCALL_DEFINE{nargs}? {file}:{line}'

		if start == 0:
			assert nargs == 0, f'Expected {nargs} arguments, but found 0: {file}:{line}'
			return () # no arguments

		sig = sig[start:sig.rfind(')')]
		# Remove __user annotation, collapse multiple spaces into one and remove
		# spaces between double pointers
		sig = ' '.join(sig.replace(' __user', '').split()).replace('* *', '**')
		sig = parse_signature(sig, big_endian)

		assert len(sig) % 2 == 0 and len(sig) // 2 == nargs, f'Bad signature after parsing: {file}:{line}'
		sig = tuple(f'{t}{" " * (t[-1] != "*")}{n}' for t, n in zip(sig[::2], sig[1::2]))
	elif sig.startswith('asmlinkage'):
		start = sig.find('(') + 1
		sig = sig[start:sig.rfind(')')].strip()
		if not sig or sig == 'void':
			return () # no arguments

		# Remove __user annotation, collapse multiple spaces into one and remove
		# spaces between asterisks of pointers
		sig = ' '.join(sig.replace(' __user', '').split()).replace('* *', '**')

		# We are assuming macros like arg_u32p are only used for SYSCALL_DEFINEx
		assert '(' not in sig and ')' not in sig, f'Unexpected parentheses in signature: {file}:{line}'
		sig = tuple(map(str.strip, sig.split(',')))
		assert len(sig) <= 7, f'Syscall with {len(sig)} arguments? {file}:{line}'
	else:
		logging.error("This doesn't look like a syscall signature: %s:%d", file, line)
		return None

	return sig

def extract_syscall_signatures(syscalls: List[Syscall], vmlinux: ELF, have_source: bool):
	have_syscall_metadata = '__start_syscalls_metadata' in vmlinux.symbols
	meta = {}
	res = []

	# TODO: could we also extract signatures from DWARF or BTF even if we have
	# no ftrace metadata and no KDIR? How?

	# First extract signatures from ftrace metadata. If the kernel was compiled
	# with CONFIG_FTRACE_SYSCALLS=y we have signature information available in a
	# bunch of `struct syscall_metadata` objects.
	if have_syscall_metadata:
		logging.info('Kernel has ftrace syscall metadata from FTRACE_SYSCALLS=y')

		start    = vmlinux.symbols['__start_syscalls_metadata'].real_vaddr
		stop     = vmlinux.symbols['__stop_syscalls_metadata'].real_vaddr
		ptr_fmt  = '<>'[vmlinux.big_endian] + 'QL'[vmlinux.bits32]
		meta_fmt = '<>'[vmlinux.big_endian] + ('QllQQ', 'LllLL')[vmlinux.bits32]
		ptr_sz   = 4 if vmlinux.bits32 else 8
		meta_sz  = 8 + 3 * ptr_sz
		ptrs     = map(itemgetter(0), iter_unpack(ptr_fmt, vmlinux.vaddr_read(start, stop - start)))

		# Sanity check
		open_meta = vmlinux.symbols.get('__syscall_meta__open')
		if open_meta and open_meta.size:
			assert open_meta.size >= meta_sz

		for ptr in ptrs:
			# Number (second field) is filled at boot and always -1
			name, _, nargs, types, args = unpack(meta_fmt, vmlinux.vaddr_read(ptr, meta_sz))
			# Sanity check: nargs > 0 => types != NULL and args != NULL
			assert nargs >= 0 and (nargs == 0 or (types and args))

			name = vmlinux.vaddr_read_string(name).strip()
			name = noprefix(name, 'sys_')
			sig = []

			for i in range(nargs):
				typ = unpack(ptr_fmt, vmlinux.vaddr_read(types + i * ptr_sz, ptr_sz))[0]
				arg = unpack(ptr_fmt, vmlinux.vaddr_read(args + i * ptr_sz, ptr_sz))[0]
				typ = vmlinux.vaddr_read_string(typ).strip()
				arg = vmlinux.vaddr_read_string(arg).strip()
				# Double pointers can have spaces between asterisks
				typ = typ.replace('* *', '**')
				sig.append(f'{typ}{" " * (typ[-1] != "*")}{arg}')

			meta[name] = tuple(sig)
	else:
		logging.info('Kernel DOES NOT have ftrace syscall metadata')

	# Now extract signatures from the source code based on the location info we
	# [should] already have
	for sc in filter(lambda s: not s.esoteric, syscalls):
		if sc.good_location:
			# We know that this location points to a `SYSCALL_DEFINEx` or an
			# `asmlinkage` function: extract signature right from source code
			assert have_source, 'good location with no kernel source? WHAT'
			sc.signature = syscall_signature_from_source(sc.file, sc.line, vmlinux.big_endian)
		elif have_syscall_metadata:
			# Weird/bad location, fallback to FTRACE_SYSCALLS metadata if
			# possible
			sig = meta.get(sc.origname)
			if sig is None:
				sig = meta.get(sc.name)
				if sig is None:
					logging.debug('Signature NOT found in ftrace metadata: %s', sc.name)
					continue

			sc.signature = sig
			logging.debug('Signature extracted from ftrace metadata: %s', sc.name)
		else:
			# Weird/bad location and no FTRACE_SYSCALLS metadata :(
			if sc.file is not None and sc.line is not None:
				logging.debug('Signature extraction skipped: %s at %s:%d',
					sc.name, sc.file, sc.line)

	return res

