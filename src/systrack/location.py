import logging
import re
import sys

from operator import attrgetter
from pathlib import Path
from typing import Tuple, List, Set, Iterable, Iterator, Optional

from .arch import Arch
from .elf import ELF
from .syscall import Syscall
from .utils import ensure_command, command_available, maybe_rel

def addr2line(elf: Path, addrs: Iterable[int]) -> Iterator[Tuple[Optional[Path],Optional[int]]]:
	out = ensure_command(['addr2line', '-e', elf, *map(hex, addrs)])

	for file, line in map(lambda d: d.split(':'), out.splitlines()):
		if file == '??':
			yield None, None
			continue

		line = int(line) if line.isdigit() else None
		yield Path(file), line

def smart_addr2line(elf: Path, addrs: Iterable[int], srcdir: Path = None) -> Iterator[Tuple[Optional[Path],Optional[int]]]:
	'''Run addr2line on the given elf for the given virtual addresses remapping
	any returned paths to the given srcdir.

	addr2line will always output absolute paths. In case the paths in the ELF
	DWARF sections are relative (i.e. don't start with "/"), the directory
	containing the ELF is taken as base. This is problematic because if the ELF
	is moved from the original source directory the paths returned by addr2line
	will be invalid.

	To avoid this problem, whenever we know a different source directory, this
	function remaps the paths returned by addr2line to that directory instead.
	'''
	locs = addr2line(elf, addrs)
	if srcdir is None:
		yield from locs

	elfdir = elf.parent
	for file, line in locs:
		if file is not None and file.is_relative_to(elfdir):
			yield srcdir / file.relative_to(elfdir), line
		else:
			yield file, line

def grep_file(root: Path, exp: re.Pattern, file: Path) -> Iterator[str]:
	# Use binary mode since some kernel source files may contain weird
	# non-unicode chars and break everything (go figure). Decode a line only in
	# case of a match.
	with file.open('rb') as f:
		for lineno, line in enumerate(f, 1):
			if exp.search(line):
				yield f'{file.relative_to(root)}:{lineno}:{line.rstrip().decode()}'

def grep_recursive(root: Path, exp: re.Pattern, exclude: Set[str],
		curdir: Path = None) -> Iterator[str]:
	if curdir is None:
		curdir = root

	for path in curdir.iterdir():
		if path.match('.*'):
			continue

		if path.is_file() and path.match('*.c'):
			yield from grep_file(root, exp, path)
		elif path.is_dir() and path.resolve() not in exclude:
			yield from grep_recursive(root, exp, exclude, path)

def grep_kernel_sources(kdir: Path, arch: Arch, syscalls: List[Syscall]) -> Iterator[Tuple[Syscall,Path,int]]:
	if arch.compat:
		base_exp = r'\b(COMPAT_)?SYSCALL(32)?_DEFINE\d\s*\('
	elif arch.bits32:
		base_exp = r'\bSYSCALL(32)?_DEFINE\d\s*\('
	else:
		base_exp = r'\bSYSCALL_DEFINE\d\s*\('

	oddstyle = arch.syscall_def_regexp()
	if oddstyle is not None:
		base_exp = f'(({base_exp})|({oddstyle}))'

	if not command_available('rg'):
		logging.debug('No ripgrep available :( falling back to slow python implementation')

		exclude = {
			(kdir / 'Documentation').resolve(),
			(kdir / 'drivers').resolve(),
			(kdir / 'lib').resolve(),
			(kdir / 'samples').resolve(),
			(kdir / 'sound').resolve(),
			(kdir / 'tools').resolve(),
			(kdir / 'usr').resolve(),
		}

		# Ignore other architectures
		for path in (kdir / 'arch').iterdir():
			if not path.match(arch.name):
				exclude.add(path.resolve())

		out = list(grep_recursive(kdir, re.compile((base_exp + r'\s*\w+').encode()), exclude))
	else:
		out = ensure_command((
			'rg', '--line-number',
			'--glob', '!Documentation/*',
			'--glob', '!drivers/*',
			'--glob', '!lib/*',
			'--glob', '!samples/*',
			'--glob', '!sound/*',
			'--glob', '!tools/*',
			'--glob', '!usr/*',
			'--glob', '!arch/*',           # ignore other architectures (important)
			'--glob', f'arch/{arch.name}', # include the correct one
			'--glob', '*.c',
			base_exp + r'\s*\w+'
		), cwd=kdir).splitlines()

	exps = {s: re.compile(rf':{base_exp}{s.origname}[,)]') for s in syscalls}

	if arch.compat:
		key = lambda l: (l.startswith('arch'), ('COMPAT' in l) + ('SYSCALL32' in l))
	elif arch.bits32:
		key = lambda l: (l.startswith('arch'), 'SYSCALL32' in l)
	else:
		key = lambda l: l.startswith('arch')

	# Prioritize files under arch/ and prefer compat/32bit syscalls if needed
	out.sort(key=key, reverse=True)

	for line in out:
		for sc, exp in exps.items():
			if exp.search(line):
				file, line = line.split(':')[:2]
				yield sc, kdir / file, int(line)
				del exps[sc]
				break

	# Report failed matches
	for sc in exps:
		yield sc, None, None

def good_location(file: Path, line: int, arch: Arch, name: str = '') -> bool:
	# Here name is optional, pass it to match the given syscall name in the
	# source code exactly.

	with file.open('rb') as f:
		for _ in range(line - 1):
			next(f)

		definition = f.readline().decode()

	# There are a lot of legacy/weird syscall definitions and some symbols can
	# therefore point (addr2line output) to old-style `asmlinkage` functions
	newstyle = ('^(COMPAT_)?' if arch.compat else '^') + rf'SYSCALL(32)?_DEFINE\d\({name}'
	oldstyle = rf'^asmlinkage \w+' + (rf' sys(32)?_{name}\(' if name else '')

	if re.match(f'{oldstyle}|{newstyle}', definition) is not None:
		return True

	# Some archs use weirdly named SYSCALL_DEFINEn macros, e.g. PPC32 ABI on
	# PowerPC 64-bit with its "PPC32_SYSCALL_DEFINEn".
	oddstyle = arch.syscall_def_regexp(name)
	return oddstyle is not None and re.match(oddstyle, definition) is not None

def adjust_line(file: Path, line: int) -> int:
	try:
		with file.open('rb') as f:
			lines = f.readlines()
	except FileNotFoundError:
		# This will happen if we mismatch vmlinux and kernel sources. There's no
		# way we can keep going if kernel sources do not match the kernel we are
		# analyzing. It'd be nice to detect this and abort earlier, but without
		# make or git we have no good way of knowing what's the version for the
		# source code we are inspecting, and we will only realize something's
		# wrong if we encounter a missing file or a file that is too short.
		logging.critical('File "%s" does not exist!', file)
		logging.critical('Do you have the correct source code version for this kernel?')
		sys.exit(1)

	# line is 1-based
	line_0 = line - 1

	# Try gettint up to the top of the current function body
	for i in range(line_0, -1, -1):
		try:
			l = lines[i].rstrip()
		except IndexError:
			# This will happen if we mismatch vmlinux and kernel sources. Same
			# reasoning as above applies.
			logging.critical('File "%s" does not have enough lines of code!', file)
			logging.critical('Do you have the correct source code version for this kernel?')
			sys.exit(1)

		if i < line_0 and l == b'}':
			# We went up at least one line and found a '}': this means we were
			# not inside a function, give up
			break

		if l == b'{':
			for j in range(i - 1, -1, -1):
				char = lines[j][0:1]

				if not char.isspace():
					if char == b'#':
						# SYSCALL_DEFINE macro wrapped in preprocessor guards,
						# annoying but it can happen (e.g., clone in v5.0 at
						# kernel/fork.c:2328). Just skip the directive.
						continue

					# Found function signature
					return j + 1

			# Found start of function body (weird)
			logging.debug('Found start of function body, but not the actual '
				'signature: %s:%d', file, i + 1)
			return i + 1

	return line

def extract_syscall_locations(syscalls: List[Syscall], vmlinux: ELF, arch: Arch,
		kdir: Optional[Path], rdir: Optional[Path]):
	if not command_available('addr2line'):
		logging.warning('Command "addr2line" unavailable, skipping location info extraction')
		return

	# STEP 1: Ask addr2line for file/lineno info. Most of the times this will
	# work with at most a simple line adjustment.

	vmlinux = vmlinux.path
	locs = smart_addr2line(vmlinux, map(lambda s: s.symbol.real_vaddr, syscalls), kdir)
	locs = list(locs)

	if not kdir:
		for sc, (file, line) in zip(syscalls, locs):
			sc.file = file
			sc.line = line
			sc.good_location = False

		if any(map(attrgetter('file'), syscalls)):
			logging.warning('No kernel source available, trusting addr2line output for location info')
		else:
			logging.warning('No kernel source available and no addr2line output, cannot extract location info')

		return

	rel = lambda p: maybe_rel(p, kdir)
	bad_paths = False
	to_adjust = []
	to_retry = []
	to_grep = []

	if rdir:
		remap = lambda p: kdir / maybe_rel(p, rdir) if p is not None else None
	else:
		remap = lambda p: kdir / p if p is not None else None

	# Try a simple line adjustment: lineno might point inside a function, but we
	# want the function signature.

	for sc, loc in zip(syscalls, locs):
		file, line = loc
		sc.file = file = remap(file)
		sc.good_location = False

		if file is None or not file.is_file() or line is None:
			if sc.symbol.size > 1:
				to_adjust.append(sc)
				logging.debug('Location needs adjustment (invalid): %s (%s) -> '
					'%s:%s', sc.origname, sc.symbol.name, *loc)
			else:
				to_grep.append(sc)
				logging.debug('Location needs grepping (invalid and sz <= 0): '
					'%s (%s) -> %s:%s', sc.origname, sc.symbol.name, *loc)
			continue

		if not file.is_relative_to(kdir.resolve()):
			bad_paths = True

		sc.line = line = adjust_line(file, line)

		# For esoteric syscalls, only find a decent location for the symbol,
		# it's pointless to go deeper
		if sc.esoteric:
			continue

		if good_location(file, line, arch):
			sc.good_location = True
		elif sc.symbol.size > 1:
			to_adjust.append(sc)
			logging.debug('Location needs adjustment (bad): %s (%s) -> %s:%d',
				sc.origname, sc.symbol.name, rel(file), line)
		else:
			to_grep.append(sc)
			logging.debug('Location needs grepping (bad and sz <= 0): %s (%s) '
				'-> %s:%d', sc.origname, sc.symbol.name, rel(file), line)

	# STEP 2: Simple adjustment for bad/invalid locations: ask addr2line again
	# for vaddr + sz - 1 (except for symbols with sz <= 1).
	#
	# Rationale: The debug info for some syscall symbols points to the wrong
	# file/line, however the last few instructions of the function have a
	# better chance of pointing to the correct place. This is because in simple
	# syscalls (e.g. getuid, which only extracts a field from current) there is
	# no prolog/epilog, and since function calls like get_current() are
	# inlined, almost all instructions in the function body come from a macro or
	# function defined somewhere else. The final RET instruction is basically
	# the only one that truly belongs to the function. The workaround is to also
	# try checking vaddr + symbol_size - 1 with addr2line.
	to_adjust.sort(key=attrgetter('name'))

	if to_adjust:
		if len(to_adjust) == len(locs):
			# If we need to adjust every single location it's very likely that
			# the user gave us a wrong path as KDIR. This will make us attempt
			# full adjustment and grepping for every single syscall, which is
			# very slow. Warn so that the user figures this out without having
			# to wait for everything to complete.
			logging.warn('All the locations obtained from addr2line look bad, '
				'did you provide the correct KDIR?')

		vaddrs = tuple(map(lambda s: s.symbol.real_vaddr + s.symbol.size - 1, to_adjust))
		new_locs = smart_addr2line(vmlinux, vaddrs, kdir)

		for sc, loc in zip(to_adjust, new_locs):
			file, line = loc
			sc.file = file = remap(file)

			if file is None or not file.is_file() or line is None:
				sc.line = line

				if sc.symbol.size > 2:
					to_retry.append(sc)
					logging.debug('Location needs full-range adjustment '
						'(invalid): %s (%s+0x%x) -> %s:%s', sc.origname,
						sc.symbol.name, sc.symbol.size - 1, *loc)
				else:
					to_grep.append(sc)
					logging.debug('Location needs grepping (invalid and sz <= '
						'1): %s (%s+0x%x) -> %s:%s', sc.origname, sc.symbol.name,
						sc.symbol.size - 1, *loc)
				continue

			sc.line = line = adjust_line(file, line)

			if good_location(file, line, arch, sc.origname):
				sc.good_location = True
			else:
				if sc.symbol.size > 2:
					to_retry.append(sc)
					logging.debug('Location needs full-range adjustment (bad): '
						'%s (%s+0x%x) -> %s:%d', sc.origname, sc.symbol.name,
						sc.symbol.size - 1, rel(file), line)
				else:
					to_grep.append(sc)
					logging.debug('Location needs grepping (bad and sz <= 1): '
						'%s (%s+0x%x) -> %s:%s', sc.origname, sc.symbol.name,
						sc.symbol.size - 1, rel(file), line)

	# STEP 3: Full-range adjustment for locations that are still bad/invalid:
	# ask addr2line again for ALL addresses from vaddr + 1 to vaddr + sz - 2
	# (except for symbols with sz <= 1).
	#
	# Reasoning: not much, just being optimistic. This is unlikely to work if
	# addr2line didn't find anything for vaddr nor for vaddr + sz - 1. If we get
	# to this point, there is probably no file/line debug info for it at all.
	to_retry.sort(key=attrgetter('name'))

	for sc in to_retry:
		addrs = range(sc.symbol.real_vaddr + 1, sc.symbol.real_vaddr + sc.symbol.size - 2)
		invalid = True

		for offset, loc in enumerate(smart_addr2line(vmlinux, addrs, kdir), 1):
			file, line = loc
			sc.file = file = remap(file)

			if file is None or not file.is_file() or line is None:
				sc.line = line
				continue

			invalid = False
			sc.line = line = adjust_line(file, int(line))

			if good_location(file, line, arch, sc.origname):
				sc.good_location = True
				logging.debug('Location found through full-range adjustment: %s'
					' (%s+0x%x) -> %s:%d', sc.origname, sc.symbol.name, offset,
					rel(file), line)
				break
		else:
			if invalid:
				logging.debug('Location needs grepping (invalid): %s (%s) -> '
					'%s:%s', sc.origname, sc.symbol.name, *loc)
			else:
				logging.debug('Location needs grepping (bad): %s (%s) -> %s:%d',
					sc.origname, sc.symbol.name, rel(file), line)

			to_grep.append(sc)

	if bad_paths:
		logging.error('Cannot grep source code, debug info points outside '
			'provided kernel source directory')
		return

	# STEP 4: Still bad? Use the big hammer: recursively grep kernel sources.
	#
	# Rationale: On x86 (and maybe others) some syscalls wrongly point to the
	# first COND_SYSCALL() macro found in kernel/sys_ni.c (e.g. userfaultfd).
	# Clang gives a slightly better location than gcc: still in this file, but
	# at the right line and not just pointing to the first COND_SYSCALL().
	# Still, this is not the real location for the actual syscall code. The
	# symbols for these syscalls are also marked WEAK for some reason (as can be
	# seen from `readelf -Ws`). The only real workaround I can think of in this
	# case is to just grep the source code for definitions of the form
	# "SYSCALL_DEFINEx(name, ...".
	#
	# Disabling compiler optimizations could help, but the kernel does not have
	# a CONFIG_ option for that, and generally highly relies on optimizations.
	# Granted, the point here is not to build a runnable kernel, but still.
	#
	# In any case, even if they look legitimate, we cannot be sure of the
	# correctness of definitions found through grepping. For example, we could
	# be working with a 64-bit kernel with compat 32-bit support and find two
	# definitions using the exact same SYSCALL_DEFINEx macro guarded by some
	# preprocessor guards: we cannot know which one is correct in such case, the
	# only way would be to manually analyze the code or magically invoke the
	# preprocessor (which we are not even going to bother trying).

	# Sort by syscall name, group not found first
	grepped = grep_kernel_sources(kdir, arch, to_grep)
	grepped = sorted(grepped, key=lambda x: (x[1] is not None, x[0].name))

	for sc, file, line in grepped:
		if file is None:
			logging.info('Location could not be found through grepping: %s '
				'(orig name %s)', sc.name, sc.origname)
			continue

		if good_location(file, line, arch, sc.origname):
			sc.file = file
			sc.line = line
			sc.good_location = True
			sc.grepped_location = True

			logging.warn('Location found through grepping: %s -> %s:%d',
				sc.origname, rel(file), line)
