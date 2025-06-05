#
# Automatic kernel Kconfig configuration.
#
# This module contains utility functions to edit configuration options through
# the kernel's `scripts/config` script, plus all arch-agnostig Kconfig options
# needed.
#

import logging

from pathlib import Path
from typing import List, Dict, Iterable, Optional

from .arch import Arch
from .kconfig_options import *
from .type_hints import KernelVersion
from .utils import anyprefix, ensure_command

def kconfig_debugging(kernel_version: KernelVersion) -> List[str]:
	return KCONFIG_DEBUGGING[kernel_version]

def kconfig_compatibility(kernel_version: KernelVersion) -> List[str]:
	return KCONFIG_COMPATIBILITY[kernel_version]

def kconfig_more_syscalls(kernel_version: KernelVersion) -> Dict[str,List[str]]:
	return KCONFIG_MORE_SYSCALLS[kernel_version]

def kconfig_syscall_deps(syscall_name: str, kernel_version: KernelVersion, arch: Arch) -> str:
	opt = arch.kconfig_syscall_deps[kernel_version].get(syscall_name)
	opt = opt or KCONFIG_SYSCALL_DEPS[kernel_version].get(syscall_name)
	return ('CONFIG_' + opt) if opt else None

def run_config_script(kdir: Path, config_file: Path, args: List[str]):
	return ensure_command(['./scripts/config', '--file', config_file] + args, cwd=kdir)

class Kconfig:
	file: Path
	kdir: Path
	config: Dict[str,Optional[str]]
	__slots__ = ['file', 'kdir', 'config']

	def __init__(self, file: Path, kdir: Path):
		self.file = file
		self.kdir = kdir
		self.config = {}
		lines = map(str.strip, self.file.open().readlines())

		for line in lines:
			# Unset is equivalent to =n, but keep track of it with None
			if line.startswith('# CONFIG_') and line.endswith(' is not set'):
				name = line[9:-11]
				self.config[name] = None
				continue

			# Skip empty lines and comments
			if not line or line.startswith('#'):
				continue

			name, val = line.split('=', 1)
			assert name.startswith('CONFIG_')
			self.config[name[7:]] = val

	def get(self, name: str) -> Optional[str]:
		'''Get the value of a config option given its name. Query scripts/config
		in case it is not present in the config file. Return None if not set.
		'''
		try:
			return self.config[name]
		except KeyError:
			# Option not explicitly set: try getting its default value
			val = run_config_script(self.kdir, self.file, ['-s', name]).strip()
			if val == 'undef':
				val = None

			self.config[name] = val
			return val

	def check(self, name: str, wanted: str) -> bool:
		'''Check if two values are equal accounting for unset values and
		treating them as =n.
		'''
		actual = self.get(name)
		return wanted == ('n' if actual is None else actual)

	def human_readable(self, name: str) -> str:
		'''Return a human-readable representation for a config option and its
		actual value.'''
		val = self.get(name)
		if val is None:
			return f'CONFIG_{name} is undef'
		return f'CONFIG_{name}={val}'

# TODO: auto check for choice menus to enable only one opt and disable others?
def kconfig_edit(config_file: Path, kdir: Path, options: Iterable[str]):
	if not options:
		return

	args = []
	for opt in options:
		name, val = opt.split('=', 1)

		if val == 'y':
			args += ['-e', name]
		elif val == 'n':
			args += ['-d', name]
		elif val == 'm':
			args += ['-m', name]
		else:
			args += ['--set-val', name, val]

	run_config_script(kdir, config_file, args)

# TODO: actually check deps parsing Kconfig instead of taking an hardcoded
#   dictionary {opt: deps} which is error prone and very annoying to maintain.
def kconfig_check_with_deps(config_file: Path, kdir: Path, options: Dict[str,List[str]]):
	config = Kconfig(config_file, kdir)

	# TODO: check options that are set even though deps not set as intended?
	for opt, deps in options.items():
		opt_name, opt_wanted = opt.split('=', 1)
		if config.check(opt_name, opt_wanted):
			continue

		bad_deps: List[str] = []
		unsupported = False

		# Something is not right, check dependencies for more insight...
		for dep in deps:
			dep_name, dep_wanted = dep.split('=', 1)
			if config.check(dep_name, dep_wanted):
				continue

			# It's ok if we want to enable some config, but we cannot do it
			# because the arch we are building for doesn't declare support
			# for one of its dependencies
			dep_actual = config.get(dep_name)
			if dep_wanted != 'n' and (dep_actual is None or dep_actual == 'n'):
				if anyprefix(dep_name, 'HAVE_', 'ARCH_HAS_', 'ARCH_SUPPORTS_'):
					unsupported = True
					logging.warning(config.human_readable(opt_name)
						+ f' instead of ={opt_wanted}, likely because '
						+ config.human_readable(dep_name))
					continue

			bad_deps.append(dep_name)

		if unsupported:
			continue

		if bad_deps:
			# Config does not match, likely because of deps
			logging.error(config.human_readable(opt_name)
				+ f' instead of ={opt_wanted}, likely because '
				+ ', '.join(map(config.human_readable, bad_deps)))
		else:
			# Config does not match, but deps are ok (weird!)
			logging.error(config.human_readable(opt_name)
				+ f' instead of ={opt_wanted} (deps ok)')

def kconfig_debug_check(config_file: Path, kdir: Path, options: Iterable[str]):
	config = Kconfig(config_file, kdir)

	for opt in options:
		opt_name, opt_wanted = opt.split('=', 1)
		if config.check(opt_name, opt_wanted):
			continue

		# As of now we are quite lax here. We only use this to check for configs
		# that we apply for compatibility or debugging and are not vital. Unlike
		# kconfig_check_with_deps() above, encountering a mismatch is usually
		# not an error.
		logging.debug(config.human_readable(opt_name) + f' instead of ={opt_wanted}')
