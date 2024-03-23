import sys

from itertools import starmap
from json import JSONEncoder, dump
from pathlib import Path
from typing import Iterable

from .kernel import Kernel
from .utils import eprint, noprefix
from .syscall import Syscall
from .version import VERSION, VERSION_COPY

class SyscallJSONEncoder(JSONEncoder):
	def default(self, o):
		if isinstance(o, Syscall):
			dikt = {k: getattr(o, k) for k in o.__slots__}
			# Symbol is a namedtuple subclass, but we only care about its .name
			dikt['symbol'] = o.symbol.name
			# Let's not waste space and remove CONFIG_ prefixes
			if o.kconfig:
				dikt['kconfig'] = noprefix(o.kconfig, 'CONFIG_')
			return dikt

		if isinstance(o, Path):
			return str(o)

		return super().default(o)

def output_syscalls_text(syscalls: Iterable[Syscall], spacing: int = 2):
	prevnum  = syscalls[0].number
	table    = [(
		'INDEX', 'NUMBER', 'NAME', 'ORIG NAME', 'SYMBOL', 'LOCATION', 'KCONFIG',
		'SIGNATURE'
	)]

	for sc in syscalls:
		if sc.number - prevnum > 1:
			# Blank line to separate groups of contiguous syscall numbers
			table.append(None)

		prevnum = sc.number

		if sc.file and sc.line:
			loc = f'{sc.file}:{sc.line}'
		elif sc.file:
			loc = str(sc.file)
		else:
			loc = ''

		if loc and not sc.good_location:
			loc = '(?) ' + loc

		table.append((
			f'{sc.index:-3d}' if sc.index is not None else '-  ',
			hex(sc.number),
			sc.name,
			sc.origname if sc.origname != sc.name else '',
			sc.symbol.name,
			loc,
			sc.kconfig.replace('CONFIG_', '') if sc.kconfig else '',
			', '.join(sc.signature) if sc.signature else '?' if sc.signature is None else 'void'
		))

	widths = [max(map(lambda row: len(row[i]) if row else 0, table)) for i in range(len(table[0]))]
	sep = ' ' * spacing

	for row in table:
		if row:
			print(sep.join(starmap(lambda c, w: c.ljust(w), zip(row, widths))))
		else:
			print()

	sys.stdout.flush()

def output_syscalls_json(kernel: Kernel):
	data = {
		'systrack_version': VERSION,
		'kernel': {
			'version': kernel.version_tag,
			'version_source': kernel.version_source,
			'architecture': {
				'name': kernel.arch.name,
				'bits': 32 if kernel.arch.bits32 else 64
			},
			'abi': {
				'name': kernel.arch.abi,
				'compat': kernel.arch.compat,
				'bits': 32 if kernel.arch.abi_bits32 else 64,
				'calling_convention': {
					'syscall_nr': kernel.arch.syscall_num_reg,
					'parameters': kernel.arch.syscall_arg_regs
				}
			},
			'syscall_table_symbol': kernel.arch.syscall_table_name
		},
		'syscalls': kernel.syscalls
	}

	dump(data, sys.stdout, cls=SyscallJSONEncoder, sort_keys=True, indent='\t')

def output_syscalls_html(kernel: Kernel):
	try:
		from jinja2 import Environment, PackageLoader
	except ImportError:
		eprint('HTML output not supported, could not import needed dependencies.')
		eprint('Install the systrack[html] or systrack[full] package through pip.')
		sys.exit(1)

	env = Environment(loader=PackageLoader('systrack'), line_statement_prefix='#', autoescape=True)
	template = env.get_template('syscall_table.html')
	max_args = max(len(s.signature) for s in kernel.syscalls if s.signature is not None)

	template.stream(
		kernel_version_tag=kernel.version_tag,
		arch=kernel.arch.name,
		bits=32 if kernel.arch.bits32 else 64,
		abi=kernel.arch.abi,
		abi_bits=32 if kernel.arch.abi_bits32 else 64,
		compat=kernel.arch.compat,
		num_reg=kernel.arch.syscall_num_reg,
		arg_regs=kernel.arch.syscall_arg_regs,
		max_args=max_args,
		syscalls=kernel.syscalls,
		systrack_version=VERSION,
		systrack_copy=VERSION_COPY.strip().replace('\n', ' \u2014 ')
	).dump(sys.stdout)

def output_syscalls(kernel: Kernel, fmt: str):
	if fmt == 'text':
		output_syscalls_text(kernel.syscalls)
	elif fmt == 'json':
		output_syscalls_json(kernel)
	elif fmt == 'html':
		output_syscalls_html(kernel)
	else:
		sys.exit('Output format not implemented!')
