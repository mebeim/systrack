import re
import sys
import logging
from enum import IntEnum
from typing import Union, Dict
from pathlib import Path
from struct import unpack
from collections import namedtuple

from .utils import ensure_command

# Only EM_* macros relevant for vmlinux ELFs
class E_MACHINE(IntEnum):
	EM_386     = 3   # x86
	EM_MIPS    = 8   # MIPS R3000 (32 or 64 bit)
	EM_ARM     = 40  # ARM 32-bit
	EM_X86_64  = 62  # x86-64
	EM_AARCH64 = 183 # ARM 64-bit

# Only EF_* macros that we actually use
class E_FLAGS(IntEnum):
	EF_ARM_EABI_MASK = 0xff000000

Section  = namedtuple('Section', ('vaddr', 'off', 'size'))
_Symbol  = namedtuple('_Symbol', ('vaddr', 'size', 'type', 'name'))

class Symbol(_Symbol):
	def __repr__(s):
		return f'Symbol({s.name} at 0x{s.vaddr:x}, type={s.type}, size=0x{s.size:x})'

class ELF:
	__slots__ = (
		'path', 'file', 'bits32', 'big_endian', 'e_machine', 'e_flags',
		'__sections', '__symbols', '__functions'
	)

	def __init__(self, path: Union[str,Path]):
		self.path = Path(path)
		self.file        = self.path.open('rb')
		self.__sections  = None
		self.__symbols   = None
		self.__functions = None

		magic, ei_class, ei_data = unpack('<4sBB', self.file.read(6))

		if magic != b'\x7fELF':
			logging.warning('Bad ELF magic: %r', magic)

		if ei_class == 1:
			self.bits32 = True
		elif ei_class == 2:
			self.bits32 = False
		else:
			logging.critical('Invalid ELF e_ident[EI_CLASS] = %d', ei_data)
			sys.exit(1)

		if ei_data == 1:
			self.big_endian = False
		elif ei_data == 2:
			self.big_endian = True
		else:
			logging.critical('Invalid ELF e_ident[EI_DATA] = %d', ei_data)
			sys.exit(1)

		unpack_endian = '<>'[self.big_endian]

		assert self.file.seek(0x12) == 0x12
		self.e_machine = unpack(unpack_endian + 'H', self.file.read(2))[0]

		assert self.file.seek(0x24) == 0x24
		self.e_flags = unpack(unpack_endian + 'L', self.file.read(4))[0]

	@property
	def sections(self) -> Dict[str,Section]:
		if self.__sections is not None:
			return self.__sections

		# We actually only really care about SHT_PROBBITS or SHT_NOBITS
		exp = re.compile(r'\s([.\w]+)\s+(PROGBITS|NOBITS)\s+([0-9a-fA-F]+)\s+([0-9a-fA-F]+)\s+([0-9a-fA-F]+)')
		out = ensure_command(['readelf', '-WS', self.path])
		secs = {}

		for match in exp.finditer(out):
			name, _, va, off, sz = match.groups()
			secs[name] = Section(int(va, 16), int(off, 16), int(sz, 16))

		self.__sections = secs
		return secs

	@property
	def symbols(self) -> Dict[str, Symbol]:
		if self.__symbols is None:
			self.__extract_symbols()
		return self.__symbols

	@property
	def functions(self) -> Dict[str, Symbol]:
		if self.__functions is None:
			self.__extract_symbols()
		return self.__functions

	@property
	def has_debug_info(self) -> bool:
		return '.debug_line' in self.sections

	def __extract_symbols(self):
		exp = re.compile(r'\d+:\s+([0-9a-fA-F]+)\s+(\d+)\s+(\w+).+\b(\w+)$')
		out = ensure_command(['readelf', '-Ws', self.path]).splitlines()
		syms = {}
		funcs = {}

		for line in out:
			match = exp.search(line)
			if not match:
				continue

			v, s, t, n = match.groups()
			sym = Symbol(int(v, 16), int(s), t, n)
			syms[sym.name] = sym

			if t == 'FUNC':
				funcs[sym.name] = sym

		self.__symbols = syms
		self.__functions = funcs

	def vaddr_to_file_offset(self, vaddr: int) -> int:
		for sec in self.sections.values():
			if sec.vaddr <= vaddr < sec.vaddr + sec.size:
				return sec.off + vaddr - sec.vaddr
		raise ValueError('vaddr not in range of any known section')

	def vaddr_read_string(self, vaddr: int) -> str:
		off = self.vaddr_to_file_offset(vaddr)
		assert self.file.seek(off) == off

		data = self.file.read(1)
		while data[-1]:
			data += self.file.read(1)
		return data[:-1].decode()

	def vaddr_read(self, vaddr: int, size: int) -> bytes:
		off = self.vaddr_to_file_offset(vaddr)
		assert self.file.seek(off) == off
		return self.file.read(size)

	def read_symbol(self, sym: Union[str,Symbol]) -> bytes:
		if type(sym) is str:
			sym = self.symbols[sym]
		return self.vaddr_read(sym.vaddr, sym.size)
