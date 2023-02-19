import os
import re
import sys
import logging
from pathlib import Path
from os.path import commonprefix
from typing import Union, Iterable
from textwrap import indent
from subprocess import Popen, DEVNULL, PIPE
from collections import defaultdict
from datetime import timedelta
from operator import itemgetter
from shutil import which

class VersionedDict:
	__slots__ = ('versions', 'cache')

	def __init__(self, iterable=None):
		self.cache    = {}
		self.versions = defaultdict(dict)

		if iterable is not None:
			for vstart, vend, key, val in iterable:
				self.versions[vstart, vend][key] = val

	def __getitem__(self, version):
		if version not in self.cache:
			self.cache[version] = self.__getversion(version)
		return self.cache[version]

	def __getversion(self, version):
		res = {}
		for (vstart, vend), dct in self.versions.items():
			if vstart <= version < vend:
				res.update(dct)
		return res

	def add(self, vstart, vend, key, value):
		self.versions[vstart, vend][key] = value

class VersionedList:
	__slots__ = ('versions', 'cache')

	def __init__(self, iterable=None):
		self.cache    = {}
		self.versions = defaultdict(list)

		if iterable is not None:
			for vstart, vend, values in iterable:
				self.versions[vstart, vend].extend(values)

	def __getitem__(self, version):
		if version not in self.cache:
			self.cache[version] = self.__getversion(version)
		return self.cache[version]

	def __getversion(self, version):
		res = []
		for (vstart, vend), lst in self.versions.items():
			if vstart <= version < vend:
				res.extend(lst)
		return res

	def add(self, vstart, vend, values):
		self.versions[vstart, vend].extend(values)

SILENT = False
HIGH_VERBOSITY = False

def high_verbosity() -> bool:
	return HIGH_VERBOSITY

def enable_high_verbosity():
	# We don't want to log what subcommands are invoked unless high verbosity
	# is needed, as it clutters the output.
	global HIGH_VERBOSITY
	HIGH_VERBOSITY = True

def silent() -> bool:
	return SILENT

def enable_silent():
	global SILENT
	SILENT = True

def eprint(*a, **kwa):
	if not SILENT:
		print(*a, **kwa, file=sys.stderr, flush=True)

def maybe_rel(path: Path, root: Path) -> Path:
	return path.relative_to(root) if root is not None and path.is_relative_to(root) else path

def anyprefix(s: str, *pxs: str) -> str:
	return any(s.startswith(px) for px in pxs)

def anysuffix(s: str, *sxs: str) -> str:
	return any(s.endswith(sx) for sx in sxs)

def noprefix(s: str, *pxs: str) -> str:
	for px in pxs:
		if s.startswith(px):
			return s[len(px):]
	return s

def nosuffix(s: str, *sxs: str) -> str:
	for sx in sxs:
		if s.endswith(sx):
			return s[:-len(sx)]
	return s

def do_popen(cmd: Union[str,Iterable[str]], cwd: Union[str,Path], **kwargs) -> Popen:
	try:
		return Popen(cmd, cwd=cwd, **kwargs)
	except FileNotFoundError:
		# We can also get here if the passed cwd= is invalid, so differentiate
		# between the two. Yes this is racy... see if I care.
		if cwd.exists():
			cmd = cmd.split()[0] if isinstance(cmd, str) else cmd[0]
			logging.critical('Command not found: %s', cmd)
		else:
			logging.critical('Directory does not exist: %s', cwd)
	except NotADirectoryError:
		logging.critical('Path is not a directory: %s', cwd)

	return None

def run_command(cmd: Union[str,Iterable[str]], cwd: Union[str,Path] = None,
		stdin: str = None, console_output: bool = False) -> int:
	if HIGH_VERBOSITY:
		logging.debug('Running command: %s', cmd)

	if console_output:
		stdout, stderr = sys.stdout, sys.stderr
	else:
		stdout = stderr = DEVNULL

	child = do_popen(cmd, cwd=cwd, shell=isinstance(cmd, str), stdout=stdout, stderr=stderr)
	if child is None:
		return 127

	child.communicate(stdin)
	return child.returncode

def ensure_command(cmd: Union[str,Iterable[str]], cwd: Union[str,Path] = None,
		stdin: str = None, capture_stdout: bool = True, console_output: bool = False):
	# console_output implies not capture_stdout
	assert not console_output or not capture_stdout

	if HIGH_VERBOSITY:
		logging.debug('Running command: %s', cmd)

	if console_output:
		stdout, stderr = sys.stdout, sys.stderr
	else:
		stdout = PIPE if capture_stdout else DEVNULL
		stderr = PIPE

	child = do_popen(cmd, cwd=cwd, shell=isinstance(cmd, str), stdout=stdout, stderr=stderr, text=True)
	if child is None:
		sys.exit(127)

	out, err = child.communicate(stdin)

	if child.returncode != 0:
		if stderr == PIPE:
			err = ('\n' + indent(err, '\t')) if err.strip() else ' (no stderr output)'
		else:
			err = ''

		logging.critical('Command returned %d: %s%s', child.returncode, cmd, err)
		sys.exit(1)

	return out

def command_available(name: str) -> bool:
	return which(name) is not None

def gcc_version(gcc_cmd: str) -> str:
	return ensure_command((gcc_cmd, '--version')).splitlines()[0].strip()

def format_duration(s: float) -> str:
	s = round(s)
	h = s // 3600
	s %= 3600
	m = s // 60
	s %= 60

	if h > 0:
		return f'{h}h {m:02d}m {s:02d}s'
	if m > 0:
		return f'{m}m {s:02d}s'
	return f'{s}s'
