import re
import struct
from typing import Tuple, List, Optional, Dict

from ..elf import Symbol, ELF, E_MACHINE
from ..kconfig_options import VERSION_INF
from ..type_hints import KernelVersion
from ..utils import VersionedDict, noprefix

from .arch_base import Arch

class ArchS390(Arch):
	name               = 's390'
	syscall_table_name = 'sys_call_table'
	syscall_num_reg    = 'r1'
	syscall_arg_regs   = ('r2', 'r3', 'r4', 'r5', 'r6', 'r7')

	kconfig = VersionedDict((
		# TODO: validate and see which ones of these (if any) may make sense to
		# move in global kconfig options.
		# 32-bit abi
		((2,6,12), VERSION_INF, 'COMPAT=y', []),
		# error: invalid hard register usage between output operands
		((2,6,19), VERSION_INF, 'ZCRYPT=n', []),
		# Error: junk at end of line
		((2,6,37), VERSION_INF, 'JUMP_LABEL=n', []),
		# s390-specific pci syscalls implemented in
		# commit cd24834130ac ("s390/pci: base support")
		((3,8), VERSION_INF, 'PCI=y', []),
		# misaligned symbol `__nospec_call_start'
		((4,16), VERSION_INF, 'EXPOLINE=n', []),
		# load BTF from vmlinux: Invalid argument
		((5,16), (6,0), 'DEBUG_INFO_BTF=n', []),
	))

	def __init__(self, kernel_version: KernelVersion, abi: str, bits32: bool = False):
		assert not bits32, f'{self.__class__.__name__} is 64-bit only'
		super().__init__(kernel_version, abi, False)

		assert self.abi in ('s390', 's390x')
		if self.abi == 's390':
			self.compat = True
			self.abi_bits32 = True
			self.syscall_table_name = 'sys_call_table_emu'

	@staticmethod
	def match(vmlinux: ELF) -> Optional[Tuple[bool,List[str]]]:
		if vmlinux.e_machine != E_MACHINE.EM_S390:
			return None

		assert not vmlinux.bits32, 'EM_S390 32-bit? WAT'

		if 'sys_call_table_emu' in vmlinux.symbols:
			abis = ['s390', 's390x']
		else:
			abis = ['s390x']

		return False, abis

	def matches(self, vmlinux: ELF) -> bool:
		return not vmlinux.bits32 and vmlinux.e_machine == E_MACHINE.EM_S390

	def _preferred_symbol(self, a: Symbol, b: Symbol) -> Optional[Symbol]:
		# See commit aa0d6e70d3b34e710a6a57a53a3096cb2e0ea99f
		if a.name.startswith('__s390x_'):
			return a
		if b.name.startswith('__s390x_'):
			return b
		return None

	def _translate_syscall_symbol_name(self, sym_name: str) -> str:
		if self.abi == 's390':
			# sys_ prefix is used for compat syscalls with 0 arguments, which
			# do not need wrapping. It is not common enough to be detected by
			# common_syscall_symbol_prefixes().
			return noprefix(sym_name, 'sys_')
		return sym_name

	def _normalize_syscall_name(self, name: str) -> str:
		# Unlike most other archs where there is an arch-specific prefix for a
		# significant number of (or nearly all) syscalls, in S390 this prefix
		# is actually part of the syscall name for some arch-specific syscalls.
		# Use a whitelist approach instead of blindly stripping it. These
		# syscalls are also named using the prefix in man section 2.
		known = {
			's390_guarded_storage',
			's390_pci_mmio_read',
			's390_pci_mmio_write',
			's390_runtime_instr',
			's390_sthyi',
		}

		if name.startswith('s390_') and name not in known:
			return noprefix(name, 's390_')
		return name

	def have_syscall_table(self) -> bool:
		# FIXME: This is not true, we do have a table, it just requires custom
		# parsing. Move parsing logic in Arch class?
		return False

	def extract_syscall_vaddrs(self, vmlinux: ELF) -> Dict[int, int]:
		symbol = vmlinux.symbols[self.syscall_table_name]
		size = symbol.size
		if size == 0:
			# FIXME: In case of 32-bit (abi=='s390') we calculate the size of
			# sys_call_table, but then look at sys_call_table_emu. Can we do any
			# better?
			# sys_call_table_emu immediately follows sys_call_table.
			# See arch/s390/kernel/entry.S.
			size = (vmlinux.symbols['sys_call_table_emu'].vaddr -
					vmlinux.symbols['sys_call_table'].vaddr)
		entry_size, format = 8, "Q"
		entry0 = vmlinux.vaddr_read(symbol.vaddr, entry_size)
		vaddr0, = struct.unpack(f">{format}", entry0)
		text = vmlinux.sections[".text"]
		if not (text.vaddr <= vaddr0 < text.vaddr + text.size):
			# s390 before commit ff4a742dde3c stored vaddrs as ints, because
			# they were guaranteed to be < 4G before relocatable kernel support
			# was added.
			entry_size, format = 4, "I"
		count = size // entry_size
		table = vmlinux.vaddr_read(symbol.vaddr, size)
		vaddrs = struct.unpack(">" + format * count, table)
		return dict(enumerate(vaddrs))

	def syscall_def_regexp(self, syscall_name: Optional[str]=None) -> Optional[str]:
		if self.abi == 's390':
			if syscall_name is None:
				return r'\bCOMPAT_SYSCALL_WRAP\d\s*\('
			else:
				return rf'\bCOMPAT_SYSCALL_WRAP\d\s*\({syscall_name}\b'
		else:
			return None
