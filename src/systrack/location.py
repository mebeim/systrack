import re
import sys
import logging
from pathlib import Path
from operator import attrgetter
from typing import Tuple, List, Set, Iterable, Iterator

from .arch import Arch
from .elf import ELF, Symbol
from .syscall import Syscall
from .utils import ensure_command, run_command, command_available, maybe_rel

def addr2line(elf: Path, addrs: Iterable[int]) -> List[Tuple[str,str]]:
	out = ensure_command(['addr2line', '-e', elf, *map(hex, addrs)])
	locs = out.splitlines()
	return list(map(lambda d: d.split(':'), locs))

def grep_file(root: Path, exp: re.Pattern, file: Path) -> Iterator[str]:
	# Use binary mode since some kernel source files may contain weird
	# non-unicode chars and break everything
	with file.open('rb') as f:
		for lineno, line in enumerate(f, 1):
			if exp.search(line):
				yield f'{file.relative_to(root)}:{lineno}:{line.rstrip()}'

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
		exp = rb'\b(COMPAT_)?SYSCALL_DEFINE\d\s*\(\s*\w+'
	else:
		exp = rb'\bSYSCALL_DEFINE\d\s*\(\s*\w+'

	if not command_available('rg'):
		logging.debug('No ripgrep available :( falling back to slow python implementation')

		exclude = {
			(kdir / 'Documentation').resolve(),
			(kdir / 'drivers').resolve(),
			(kdir / 'samples').resolve(),
			(kdir / 'tools').resolve(),
		}

		for path in (kdir / 'arch').iterdir():
			if not path.match(arch.name):
				exclude.add(path.resolve())

		out = list(grep_recursive(kdir, re.compile(exp), exclude))
	else:
		out = ensure_command((
			'rg', '--line-number',
			'--glob', '!Documentation/*',
			'--glob', '!drivers/*',
			'--glob', '!samples/*',
			'--glob', '!tools/*',
			'--glob', '!arch/*',           # ignore other architectures (important)
			'--glob', f'arch/{arch.name}', # include the correct one
			'--glob', '*.c',
			exp
		), cwd=kdir).splitlines()

	if arch.compat:
		exps = {s: re.compile(rf':(COMPAT_)?SYSCALL_DEFINE\d\({s.origname}[,)]') for s in syscalls}
	else:
		exps = {s: re.compile(rf':SYSCALL_DEFINE\d\({s.origname}[,)]') for s in syscalls}

	# Prioritize files under arch/ and also prefer compat syscalls if needed
	out.sort(key=lambda l: (l.startswith('arch'), arch.compat and 'COMPAT' in l), reverse=True)

	for line in out:
		for sc, exp in tuple(exps.items()):
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
	newstyle = ('^(COMPAT_)?' if arch.compat else '^') + rf'SYSCALL_DEFINE\d\({name}'
	oldstyle = rf'^asmlinkage \w+' + (rf' sys(32)?_{name}\(' if name else '')
	return re.match(f'{oldstyle}|{newstyle}', definition) is not None

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
				if not lines[j][0:1].isspace():
					# Found function signature
					return j + 1

			# Found start of function body (weird)
			logging.debug('Found start of function body, but not the actual '
				'signature: %s:%d', file, i + 1)
			return i + 1

	return line

def extract_syscall_locations(syscalls: List[Syscall], vmlinux: ELF, kdir: Path, rdir: Path, arch: Arch):
	if not command_available('addr2line'):
		logging.warning('Command "addr2line" unavailable, skipping location info extraction')
		return

	vmlinux = vmlinux.path
	locs = addr2line(vmlinux, map(lambda s: s.symbol.vaddr, syscalls))

	if not kdir:
		logging.info('No kernel source available, trusting addr2line output for location info')

		for sc, (file, line) in zip(syscalls, locs):
			sc.file = Path(file) if file != '??' else None
			sc.line = int(line) if line.isdigit() else None
			sc.good_location = False

		return

	rel = lambda p: maybe_rel(p, kdir)
	bad_paths = False
	to_adjust = []
	to_retry = []
	to_grep = []
	res = []

	if rdir:
		remap = lambda p: kdir / maybe_rel(Path(p), rdir)
	else:
		remap = lambda p: kdir / p

	# STEP 1: Ask addr2line for file/lineno info. Most of the times this will
	# work with at most a simple line adjustment (lineno might point inside a
	# function, but we want the function signature).

	for sc, loc in zip(syscalls, locs):
		file, line = loc
		sc.file = file = remap(file)
		sc.good_location = False

		if not file.is_file() or not line.isdigit():
			sc.line = line

			if sc.symbol.size > 1:
				to_adjust.append(sc)
				logging.debug('Location needs adjustment (invalid): %s (%s) -> '
					'%s:%s', sc.origname, sc.symbol.name, *loc)
			else:
				to_grep.append(sc)
				logging.debug('Location needs grepping (invalid and sz <= 0): '
					'%s (%s) -> %s:%s', sc.origname, sc.symbol.name, *loc)
			continue

		if not file.is_relative_to(kdir):
			bad_paths = True

		sc.line = line = adjust_line(file, int(line))

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
	# for vaddr + sz - 1 (except for symbols with sz <= 0).
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

	if to_adjust:
		vaddrs = tuple(map(lambda s: s.symbol.vaddr + s.symbol.size - 1, to_adjust))
		new_locs = addr2line(vmlinux, vaddrs)

		for sc, loc in zip(to_adjust, new_locs):
			file, line = loc
			sc.file = file = remap(file)

			if not file.is_file() or not line.isdigit():
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

			sc.line = line = adjust_line(file, int(line))

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

	for sc in to_retry:
		addrs = range(sc.symbol.vaddr + 1, sc.symbol.vaddr + sc.symbol.size - 2)
		invalid = True

		for offset, loc in enumerate(addr2line(vmlinux, addrs), 1):
			file, line = loc
			sc.file = file = remap(file)

			if not file.is_file() or not line.isdigit():
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
	for sc, file, line in grep_kernel_sources(kdir, arch, to_grep):
		if file is None:
			logging.info('Location could not be found through grepping: %s%s',
				sc.name, '(orig %s)' if sc.origname != sc.name else '')
			continue

		if good_location(file, line, arch, sc.origname):
			sc.file = file
			sc.line = line
			sc.good_location = True

			logging.warn('Location found through grepping: %s -> %s:%d',
				sc.origname, rel(file), line)
