#
# Automatic kernel Kconfig configuration.
#
# This module contains utility functions to edit configuration options through
# the kernel's `scripts/config` script, plus all arch-agnostig Kconfig options
# needed.
#

import logging

from pathlib import Path
from typing import List, Dict, Iterable

from .arch import Arch
from .kconfig_options import *
from .type_hints import KernelVersion
from .utils import anyprefix, ensure_command

def kconfig_debugging(kernel_version: KernelVersion) -> Dict[str,List[str]]:
	return KCONFIG_DEBUGGING[kernel_version]

def kconfig_compatibility(kernel_version: KernelVersion) -> Dict[str,List[str]]:
	return KCONFIG_COMPATIBILITY[kernel_version]

def kconfig_more_syscalls(kernel_version: KernelVersion) -> Dict[str,List[str]]:
	return KCONFIG_MORE_SYSCALLS[kernel_version]

def kconfig_syscall_deps(syscall_name: str, kernel_version: KernelVersion, arch: Arch) -> str:
	opt = arch.kconfig_syscall_deps[kernel_version].get(syscall_name)
	opt = opt or KCONFIG_SYSCALL_DEPS[kernel_version].get(syscall_name)
	return ('CONFIG_' + opt) if opt else None

def run_config_script(kdir: Path, config_file: Path, args: List[str]):
	return ensure_command(['./scripts/config', '--file', config_file] + args, cwd=kdir)

# TODO: maybe turn this into a class with a __getitem__ that invokes
# scripts/config -s VAL if VAL is not explicitly set so that we can avoid
# manually checking?
def parse_config(config_file: Path) -> Dict[str,str]:
	lines = map(str.strip, config_file.open().readlines())
	lines = filter(lambda l: l and not l.startswith('#'), lines)
	config = {}

	for line in lines:
		name, val = line.split('=', 1)
		assert name.startswith('CONFIG_')
		config[name[7:]] = val

	return config

# TODO: check if the options were set correctly?
def edit_config(kdir: Path, config_file: Path, options: Iterable[str]):
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
# dictionary {opt: deps} which is error prone and very annoying to maintain.
def edit_config_check_deps(kdir: Path, config_file: Path, options: Dict[str,List[str]]):
	if not options:
		return

	toset = dict(map(lambda x: x.split('=', 1), options))
	config = parse_config(config_file)

	for opt, deps in options.items():
		for dep in deps:
			dep_name, dep_wanted = dep.split('=', 1)
			dep_actual = toset.get(dep_name) or config.get(dep_name)

			if dep_actual is None:
				# Dependency not explicitly set, try getting its default value
				dep_actual = run_config_script(kdir, config_file, ['-s', dep_name]).strip()
				if dep_actual == 'undef':
					dep_actual = None

			if dep_actual != dep_wanted:
				# It's OK if we want =n but it's unset
				if dep_wanted == 'n' and dep_actual is None:
					continue

				if dep_actual is None:
					dep_name_and_val = f'CONFIG_{dep_name} is not set'
				else:
					dep_name_and_val = f'CONFIG_{dep_name}={dep_actual}'

				# It's ok if we want to enable some config, but we cannot do it
				# because the arch we are building for doesn't declare support
				# for one of its dependencies
				if dep_wanted == 'y' and dep_actual in ('n', None):
					if anyprefix(dep_name, 'HAVE_', 'ARCH_HAS_'):
						logging.warning(f"CONFIG_{opt} won't be set because "
							f'{dep_name_and_val}')
						continue

				logging.error(f'CONFIG_{opt} wants CONFIG_{dep_name}='
					f'{dep_wanted}, but {dep_name_and_val}!')

	edit_config(kdir, config_file, options.keys())
