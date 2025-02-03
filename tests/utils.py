from pathlib import Path
from subprocess import check_call
from typing import Dict, Union

from systrack.arch import Arch
from systrack.kernel import Syscall
from systrack.elf import Symbol

class MockELF:
	'''Mock ELF class to be used in place of the ELF class provided by Systrack
	for testing.
	'''
	def __init__(self, big_endian: bool, symbols_with_code: Dict[Symbol,bytes]):
		self.big_endian = big_endian
		self.symbols_code = symbols_with_code
		self.symbols = {}

		for sym in symbols_with_code:
			self.symbols[sym.name] = sym

	def next_symbol(self, sym: Symbol) -> Union[Symbol,None]:
		return None

	def vaddr_read(self, vaddr: int, size: int) -> bytes:
		for sym in self.symbols_code:
			if sym.real_vaddr == vaddr:
				code = self.symbols_code[sym]
				return code.ljust(size, b'\x00')

		assert False, 'Bad call to mocked ELF.vaddr_read()'

	def read_symbol(self, sym: Union[str,Symbol]) -> bytes:
		if not isinstance(sym, Symbol):
			sym = self.symbols[sym]

		return self.vaddr_read(sym.real_vaddr, sym.size)

def arch_is_dummy_syscall(arch: Arch,  big_endian: bool, code: bytes) -> bool:
	sym = Symbol(0x0, 0x0, len(code), 'FUNC', 'test')
	sc  = Syscall(0x0, 0x0, 'test', 'test', sym, None)
	elf = MockELF(big_endian, {sym: code})
	return arch.is_dummy_syscall(sc, elf)

def make_test_elf(name: str) -> Path:
	target = Path(__file__).parent / 'data' / name
	check_call(['make', '-C', target.parent, target.name])
	return target
