from typing import Dict

from systrack.arch import Arch
from systrack.kernel import Syscall
from systrack.elf import Symbol

class MockELF:
	'''Mock ELF class to be used in place of the ELF class provided by Systrack
	for testing.
	'''
	def __init__(self, big_endian: bool, symbols: Dict[Symbol,bytes]):
		self.big_endian = big_endian
		self.symbols = symbols

	def read_symbol(self, sym: Symbol):
		return self.symbols[sym]

def arch_is_dummy_syscall(arch: Arch, code: bytes):
	sym = Symbol(0x0, 0x0, len(code), 'FUNC', 'test')
	sc  = Syscall(0x0, 0x0, 'test', 'test', sym, None)
	elf = MockELF(True, {sym: code})
	return arch.is_dummy_syscall(sc, elf)
