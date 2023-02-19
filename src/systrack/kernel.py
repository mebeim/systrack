import re
import sys
import logging
import struct
import atexit
from pathlib import Path
from time import monotonic
from os import sched_getaffinity
from operator import itemgetter, attrgetter
from collections import defaultdict, Counter
from itertools import zip_longest
from typing import Tuple, List, Iterator, Union

from .elf import ELF
from .arch import Arch
from .syscall import Syscall, common_syscall_symbol_prefixes
from .utils import run_command, ensure_command, VersionedDict, high_verbosity
from .utils import maybe_rel, noprefix
from .location import extract_syscall_locations
from .signature import extract_syscall_signatures
from .kconfig import edit_config, edit_config_check_deps
from .kconfig import kconfig_more_syscalls, kconfig_debugging
from .kconfig import kconfig_compatibility, kconfig_syscall_deps

class KernelVersionError(RuntimeError):
	pass

class KernelArchError(RuntimeError):
	pass

class KernelMultiABIError(RuntimeError):
	pass

class Kernel:
	__vmlinux         = None
	__version         = None
	__version_source  = None
	__syscalls        = None
	__backup_makefile = None

	def __init__(self, arch_name: str = None, vmlinux: Path = None,
			kdir: Path = None, outdir: Path = None, rdir: Path = None,
			toolchain_prefix: str = None):
		if not kdir and not vmlinux:
			raise ValueError('at least one of vmlinux or kdir is needed')

		if arch_name is None and vmlinux is None:
			raise ValueError('need vmlinux to determine arch if not supplied')

		self.kdir             = kdir
		self.outdir           = outdir
		self.rdir             = rdir
		self.vmlinux          = ELF(vmlinux) if vmlinux else None
		self.arch_name        = arch_name
		self.toolchain_prefix = toolchain_prefix

		if self.arch_name is None:
			m = Arch.match(self.vmlinux)
			if m is None:
				raise KernelArchError('Failed to detect kernel architecture/ABI')

			arch_class, bits32, abis = m
			if len(abis) > 1:
				raise KernelMultiABIError('Multiple ABIs supported, need to select one', arch_class, abis)

			self.arch = arch_class(self.version, abis[0], bits32)
		else:
			self.arch = Arch.from_name(self.arch_name, self.version)

		if self.vmlinux and not self.arch.matches(self.vmlinux):
			raise KernelArchError(f'Architecture {arch_name} does not match '
				'provided vmlinux')

	@staticmethod
	def version_from_str(s: str) -> Tuple[int,int,int]:
		m = re.match(r'(\d+)\.(\d+)(\.(\d+))?', s)
		if not m:
			return None

		a, b, c = int(m.group(1)), int(m.group(2)), m.group(4)
		return (a, b) if c is None else (a, b, int(c))

	@staticmethod
	def version_from_banner(banner: Union[str,bytes]) -> Tuple[int,int,int]:
		if isinstance(banner, bytes):
			banner = banner.decode()

		assert banner.startswith('Linux version ')
		return Kernel.version_from_str(banner[14:])

	def __version_from_vmlinux(self) -> Tuple[int,int,int]:
		banner = self.vmlinux.read_symbol('linux_banner')
		return self.version_from_banner(banner)

	def __version_from_make(self) -> Tuple[int,int,int]:
		v = ensure_command('make kernelversion', self.kdir)
		return self.version_from_str(v)

	@property
	def version(self) -> Tuple[int,int,int]:
		if self.__version is None:
			if self.vmlinux:
				self.__version = self.__version_from_vmlinux()
				self.__version_source = 'vmlinux banner'
			elif self.kdir:
				self.__version = self.__version_from_make()
				self.__version_source = 'make'
			else:
				raise KernelVersionError('unable to determine kernel version')

		return self.__version

	@property
	def version_str(self) -> str:
		return '.'.join(map(str, self.version)) + f' (from {self.__version_source})'

	@property
	def version_tag(self) -> str:
		a, b, c = self.version
		if c == 0:
			return f'v{a}.{b}'
		return f'v{a}.{b}.{c}'

	@property
	def syscalls(self) -> List[Syscall]:
		if self.__syscalls is None:
			self.__syscalls = self.__extract_syscalls()
		return self.__syscalls

	def __rel(self, path: Path) -> Path:
		return maybe_rel(path, self.kdir)

	def __iter_unpack_vmlinux(self, off: int, size: int = None) -> Iterator[bytes]:
		fmt = '<>'[self.vmlinux.big_endian] + 'QL'[self.vmlinux.bits32]
		f = self.vmlinux.file
		assert f.seek(off) == off

		if size is None:
			chunk_size = 4 if self.vmlinux.bits32 else 8
			while 1:
				yield struct.unpack(fmt, f.read(chunk_size))[0]
		else:
			yield from map(itemgetter(0), struct.iter_unpack(fmt, f.read(size)))

	def __extract_syscalls(self) -> List[Syscall]:
		if self.arch.bits32 != self.vmlinux.bits32:
			a, b = (32, 64) if self.arch.bits32 else (64, 32)
			logging.critical('Selected arch is %d-bit, but kernel is %d-bit', a, b)
			return []

		self.arch.adjust_abi(self.vmlinux)
		syscall_table_name = self.arch.syscall_table_name
		tbl = self.vmlinux.symbols.get(syscall_table_name)
		ni_syscalls = set()

		if not tbl:
			logging.critical('Unable to find %s symbol!', syscall_table_name)
			return []

		logging.debug('Syscall table: %r', tbl)

		# Find all ni_syscall symbols (there might be multiple) and keep track
		# of them for later in order to detect non-implemented syscalls.
		for sym in self.vmlinux.functions.values():
			if self.arch.symbol_is_ni_syscall(sym):
				ni_syscalls.add(sym)
				logging.debug('Found ni_syscall: %r', sym)

		if not ni_syscalls:
			logging.critical('No ni_syscall found!')
			return []

		# Read and parse the syscall table unpacking all virtual addresses it
		# contains

		addr_size    = 4 if self.vmlinux.bits32 else 8
		tbl_file_off = self.vmlinux.vaddr_to_file_offset(tbl.vaddr)
		text         = self.vmlinux.sections['.text']
		text_vstart  = text.vaddr
		text_vend    = text_vstart + text.size

		if tbl.size > 0x80:
			logging.info('Syscall table (%s) is %d bytes, %d entries', tbl.name,
				tbl.size, tbl.size // addr_size)

			vaddrs = list(self.__iter_unpack_vmlinux(tbl_file_off, tbl.size))

			# Sanity check: ensure all virtual addresses are within .text
			for idx, vaddr in enumerate(vaddrs):
				if not (text_vstart <= vaddr < text_vend):
					logging.warn('Virtual address 0x%x (%s[%d]) is outside '
						'.text: something is off!', vaddr, syscall_table_name, idx)
		else:
			# Apparently on some archs (looking at you, MIPS!) the syscall table
			# symbol can have size 0. In this case we'll just warn the user and
			# keep extracting vaddrs as long as they are within the .text
			# section, stopping at the first invalid one.
			logging.warn('Syscall table (%s) has bad size (%d), doing my best '
				'to figure out when to stop', syscall_table_name, tbl.size)

			vaddrs = []
			for vaddr in self.__iter_unpack_vmlinux(tbl_file_off):
				if not (text_vstart <= vaddr < text_vend):
					break

				vaddrs.append(vaddr)

			logging.info('Syscall table seems to be %d bytes, %d entries',
				len(vaddrs) * addr_size, len(vaddrs))

		if not vaddrs:
			logging.critical('Could not extract any valid virtual address from '
				'%s, giving up!', syscall_table_name)
			logging.critical('Is the kernel relocatable? Relocation entries '
				'for the syscall table are not supported.')
			return []

		seen = set(vaddrs)
		symbols_by_vaddr = {sym.vaddr: sym for sym in ni_syscalls}

		# Create a mapping vaddr -> symbol for every vaddr in the syscall table
		# for convenience.
		for sym in self.vmlinux.symbols.values():
			vaddr = sym.vaddr
			if vaddr not in seen or sym in ni_syscalls:
				continue

			other = symbols_by_vaddr.get(vaddr)

			if other is not None:
				if other in ni_syscalls:
					if sym in ni_syscalls:
						# Not really meaningful, but still prefer the right
						# prefix for ni_syscall too.
						symbols_by_vaddr[vaddr] = self.arch.preferred_symbol(sym, other)
						continue

					# Don't allow other symbols to "override" a ni_syscall.
					logging.debug('Discarding alias for %s: %s', other.name, sym.name)
					continue

				pref = self.arch.preferred_symbol(sym, other)
				sym, other = pref, other if pref is sym else sym

				if high_verbosity():
					logging.debug('Preferring %s over %s', pref.name, other.name)

			symbols_by_vaddr[vaddr] = sym

		del seen

		if not symbols_by_vaddr:
			logging.critical('Unable to find any symbol in the syscall table, giving up!')
			logging.critical('Is "%s" the correct arch/ABI combination for '
				'this kernel?', self.arch_name)
			return []

		# Sanity check: the only repeated vaddrs in the syscall table should be
		# the ones for *_ni_syscall. Warn in case there are others.
		counts = sorted(Counter(vaddrs).items(), key=itemgetter(1), reverse=True)
		best = symbols_by_vaddr[counts[0][0]]

		if best not in ni_syscalls:
			logging.error('Interesting! I was expecting *_ni_syscall to be the '
				'most frequent symbol in the syscall table, but %s is ('
				'appearing %d times).', best.name, counts[0][1])

		for va, n in counts[1:]:
			if n == 1:
				break

			logging.warn('Interesting! Vaddr 0x%x (%s) found %d times in %s',
				va, symbols_by_vaddr.get(va, '<unknown>'), n, syscall_table_name)

		symbols      = []
		symbol_names = []
		ni_count     = defaultdict(int)

		# Filter out only defined syscalls
		for idx, vaddr in enumerate(vaddrs):
			sym = symbols_by_vaddr.get(vaddr)
			if sym is None:
				logging.error('Unable to find symbol for %s[%d]: 0x%x',
					syscall_table_name, idx, vaddr)
				continue

			if high_verbosity():
				logging.debug('%s[%d]: %s', syscall_table_name, idx, sym)

			if sym in ni_syscalls:
				ni_count[sym.name] += 1
				continue

			symbols.append((idx, sym))
			symbol_names.append(sym.name)

		# Find common syscall symbol prefixes (e.g. "__x64_sys_") in order to be
		# able to strip them later to obtain the actual syscall name
		prefixes = common_syscall_symbol_prefixes(symbol_names, 20)
		logging.info('Common syscall symbol prefixes: %s', ', '.join(prefixes))

		syscalls  = []
		n_skipped = 0

		# Build list of syscalls (with prefixes stripped from the names) and
		# skip uneeded ones (e.g. implemented for other ABIs)
		for idx, sym in symbols:
			num      = self.arch.syscall_num_base + idx
			origname = noprefix(sym.name, *prefixes)
			origname = self.arch.translate_syscall_symbol_name(origname)
			name     = self.arch.normalize_syscall_name(origname)
			kdeps    = kconfig_syscall_deps(name, self.version)

			# We could need the original name to differentiate some syscalls
			# in order to understand if they need some Kconfig or not
			if not kdeps:
				kdeps = kconfig_syscall_deps(origname, self.version)

			sc = Syscall(idx, num, name, origname, sym, kdeps)

			if self.arch.skip_syscall(sc):
				logging.debug('Skipping %s', sym.name)
				n_skipped += 1
				continue

			syscalls.append(sc)

		# Add esoteric syscalls to the list, if any (these do not need any name
		# translation or signature search as they are hardcoded)
		esoteric = self.arch.esoteric_syscalls[self.version]
		n_esoteric = len(esoteric)

		for num, name, sym_name, sig in esoteric:
			sym = self.vmlinux.symbols[sym_name]
			syscalls.append(Syscall(None, num, name, name, sym, None, signature=sig, esoteric=True))

		ni_total = 0
		for name, n in sorted(ni_count.items(), key=itemgetter(1), reverse=True):
			logging.info('%d syscall table entries point to %s', n, name)
			ni_total += n

		assert len(syscalls) == len(vaddrs) - ni_total - n_skipped + n_esoteric

		if not self.vmlinux.has_debug_info:
			# Cannot extract location info without debug info.
			#
			# NOTE: unless we check sources, we can have have false positives
			# here! Syscalls that are not implemented but for which symbols are
			# present and don't point to sys_ni_syscall (i.e. just return
			# -ENOSYS by theirselves), like the infamous lookup_dcookie on
			# x86/arm64. Annoying! Arch.is_dummy_syscall() could have already
			# filtered those out, but it's not guaranteed to catch everything.
			#
			logging.info('No debug information available, skipping location info extraction')
			return syscalls

		# Find locations and signatures for all the syscalls we found (except
		# esoteric ones). Warn for potentially bad matches and filter out
		# invalid ones.
		extract_syscall_locations(syscalls, self.vmlinux, self.kdir, self.rdir, self.arch)
		extract_syscall_signatures(syscalls, self.vmlinux, self.kdir is not None)

		implemented = []
		have_syscall_metadata = '__start_syscalls_metadata' in self.vmlinux.symbols
		# Accumulate warnings/errors for prettier outout
		bad_loc_info = []
		no_loc_info  = []
		no_sig_info  = []

		for sc in syscalls:
			file, line, good = sc.file, sc.line, sc.good_location

			if not good and not sc.esoteric:
				# If we got to this point the location is still not "good",
				# chances are that this syscall is just a dummy function that
				# only does `return -ENOSYS`. If so, discard it.
				code = self.vmlinux.read_symbol(sc.symbol)

				if self.arch.is_dummy_syscall(code):
					logging.info('Syscall %s (%s) is not actually implemented, '
						'machine code: %s', sc.name, sc.symbol.name, code.hex())
					continue

			if not good and not sc.esoteric and file is not None:
				if file.match('**/kernel/sys_ni.c'):
					# If we got to this point the location is still not "good"
					# and points to sys_ni.c even after adjusting/grepping.
					# Assume the syscall is not implemented. Granted, this could
					# in theory lead to false negatives, but I did not encounter
					# one yet. Since we are grepping the source code this
					# should NOT happen for implemented syscalls. Nonetheless
					# warn about it, so we can double check and make sure
					# everything is fine.
					logging.warn('Assuming %s is not implemented as it points '
						'to %s:%d after adjustments', sc.name, self.__rel(file), line)
					continue

				if self.kdir:
					if file.match('*.S'):
						hint = ' (implemented in asm?)'
					elif file.match('*.c'):
						hint = ' (normal function w/o asmlinkage?)'
					else:
						hint = ''

					bad_loc_info.append((sc.name, sc.symbol.name, self.__rel(file), line, hint))

			if file is None:
				no_loc_info.append((sc.name, sc.symbol.name))

			if sc.signature is None and have_syscall_metadata:
				no_sig_info.append((sc.name, sc.symbol.name))

			implemented.append(sc)

		for info in bad_loc_info:
			logging.warn('Potentially bad location for %s (%s): %s:%d%s', *info)

		for info in no_loc_info:
			logging.error('Unable to find location for %s (%s)', *info)

		for info in no_sig_info:
			logging.error('Unable to extract signature for %s (%s)', *info)

		return implemented

	def __try_set_optimization_level(self, lvl: int) -> bool:
		# Might be the most ignorant thing in this whole codebase :')

		with (self.kdir / 'Makefile').open('r+') as f:
			self.__backup_makefile = data = f.read()
			assert f.seek(0) == 0

			match = re.search(r'^KBUILD_CFLAGS\s*\+=\s*-O(2)\n', data, re.MULTILINE)
			if not match:
				return False

			start, end = match.span(1)
			f.write(data[:start] + str(lvl) + data[end:])
			f.truncate()

		return True

	def __restore_makefile(self):
		if self.__backup_makefile:
			with (self.kdir / 'Makefile').open('w') as f:
				f.write(self.__backup_makefile)
		else:
			logging.error('Restoring Makefile without backing it up first???')

		atexit.unregister(self.__restore_makefile)

	def make(self, target: str, stdin=None, ensure=True) -> int:
		j = max(len(sched_getaffinity(0)) - 1, 1)
		cmd = ['make', f'-j{j}', f'ARCH={self.arch.name}']

		if self.toolchain_prefix:
			cmd += [f'CROSS_COMPILE={self.toolchain_prefix}']
		if self.outdir:
			cmd += [f'O={self.outdir}']

		if ensure:
			ensure_command(cmd + [target], self.kdir, stdin, False, high_verbosity())
			return 0

		return run_command(cmd + [target], self.kdir, stdin, high_verbosity())

	def sync_config(self):
		'''Set any config that was "unlocked" by others to its default value.
		The make target for this depends on the kernel version.
		'''
		if self.version >= (3, 7):
			self.make('olddefconfig')
		else:
			# Ugly, but oldconfig can error out if no input is given.
			self.make('oldconfig', stdin='\n' * 1000)

	def clean(self):
		self.__version = None
		self.make('distclean')

	def configure(self):
		config_file = (self.outdir or self.kdir) / '.config'
		self.__version = None

		logging.info('Base config target: %s', self.arch.config_target)
		self.make(self.arch.config_target)

		# TODO: maybe create a check that ensures these are actually applied and
		# consistent? E.G. check if all the configs that are supposed to exist
		# in a version actually exist when running the tool and keep the wanted
		# value after `make olddefconfig`.

		logging.info('Applying debugging configs')
		edit_config(self.kdir, config_file, kconfig_debugging(self.version))
		self.sync_config()

		logging.info('Applying compatibility configs')
		edit_config(self.kdir, config_file, kconfig_compatibility(self.version))
		self.sync_config()

		logging.info('Enabling more syscalls')
		edit_config_check_deps(self.kdir, config_file, kconfig_more_syscalls(self.version))
		self.sync_config()

		logging.info('Applying arch-specific configs')
		edit_config_check_deps(self.kdir, config_file, self.arch.kconfig[self.version])
		self.sync_config()

	def build(self, try_disable_opt: bool = False) -> float:
		start = monotonic()
		self.__version = None

		if try_disable_opt:
			logging.info('Trying to build with optimizations disabled (-O0)')

			# This will either work or fail for any level. If it fails, just
			# do a normal build with ensure=True, which will exit in case of
			# failure.
			if self.__try_set_optimization_level(0):
				atexit.register(self.__restore_makefile)
				res = self.make('vmlinux', ensure=False)
				self.__restore_makefile()

				if res == 0:
					return monotonic() - start

				logging.error('Failed to build with -O0, trying -O1')

				self.__try_set_optimization_level(1)
				res = self.make('vmlinux', ensure=False)
				self.__restore_makefile()

				if res == 0:
					return monotonic() - start

				logging.error('Failed to build with -O1, doing a normal build')
			else:
				logging.warn('Unable to patch Makefile to disable '
					'optimizations, doing a normal build instead')

		self.make('vmlinux')
		return monotonic() - start
