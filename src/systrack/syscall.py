from collections import Counter
from pathlib import Path
from typing import List

from .elf import Symbol

class Syscall:
	'''Class representing a Linux syscall.
	'''
	# NOTE: do not remove, __slots__ are used used by the JSON encoder
	__slots__ = (
		'index', 'number',
		'name', 'origname', 'symbol',
		'file', 'line', 'signature',
		'esoteric', 'good_location', 'grepped_location', 'kconfig'
	)

	def __init__(self, index: int, number: int, name: str, origname: str,
			symbol: Symbol, kconfig: str, file: Path = None, line: int = None,
			signature: List[str] = None, esoteric: bool = False):
		self.index            = index
		self.number           = number
		self.name             = name
		self.origname         = origname
		self.symbol           = symbol
		self.kconfig          = kconfig
		self.file             = file
		self.line             = line
		self.signature        = signature
		self.esoteric         = esoteric
		self.good_location    = False
		self.grepped_location = False

	def __repr__(s):
		file = '??' if s.file is None else s.file
		line = '?' if s.line is None else s.line
		res  = f'Syscall(index={s.index} number={s.number}, name="{s.name}", '
		res += f'symbol="{s.symbol.name}", defined at {file}:{line}, '
		res += f'takes {len(s.signature) if s.signature else "?"} args'
		res += f', depends on {s.kconfig})' if s.kconfig else ')'
		return res

def common_syscall_symbol_prefixes(names: List[str], threshold: int) -> List[str]:
	'''Given a list of symbol names, find and return a list of common prefixes
	of the form "xxx_" that appear in a number of symbols greater than or equal
	to threshold.

	For example, given that a bunch of syscalls in x86-64 start with __x64_sys_,
	this function returns ['__x64_sys_', '__x64_', '__'].
	'''
	res = []

	for l in range(max(map(len, names)), 1, -1):
		candidates = list(filter(lambda n: len(n) >= l and n[l - 1] == '_', names))
		if len(candidates) < threshold:
			continue

		counts = Counter(name[:l] for name in candidates)
		res.extend(filter(lambda name: counts[name] >= threshold, counts))

	return res
