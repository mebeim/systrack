from typing import Tuple, List, Optional

from ..elf import Symbol, ELF, E_MACHINE
from ..kconfig_options import VERSION_INF
from ..type_hints import KernelVersion
from ..utils import VersionedDict

from .arch_base import Arch

class ArchRiscV(Arch):
	name = 'riscv'
	syscall_num_reg = 'a7'
	syscall_arg_regs = ('a0', 'a1', 'a2', 'a3', 'a4', 'a5')

	kconfig = VersionedDict((
		# kexec_load
		((4,8) , VERSION_INF, 'KEXEC=y'     , ['MMU=y']),
		# seccomp
		((5,5) , (5,10)     , 'SECCOMP=y'   , []),
		# mbind, migrate_pages, {get,set}_mempolicy
		((5,12), VERSION_INF, 'NUMA=y'      , ['SMP=y', 'MMU=y']),
	))

	def __init__(self, kernel_version: KernelVersion, abi: str, bits32: bool=False):
		super().__init__(kernel_version, abi, bits32)
		assert kernel_version >= (4,15), 'Linux only supports RISC-V from v4.15'
		assert self.abi in ('rv32', 'rv64')

		if self.abi == 'rv32':
			self.abi_bits32 = True

			if not self.bits32:
				assert self.kernel_version >= (5,19), 'Linux only supports compat RV32 from v5.19'
				self.compat = True
				self.syscall_table_name = 'compat_sys_call_table'

		if self.bits32:
			if self.kernel_version >= (6,8):
				# rv32_defconfig removed in v6.8
				self.config_targets = ('defconfig', '32-bit.config')
			elif self.kernel_version >= (5,1):
				self.config_targets = ('rv32_defconfig',)
			else:
				self.config_targets = ('defconfig',)

			# No "easy" make target for 32-bit before 5.1. Need manual config.
			self.kconfig.add((4,15), (5,1), '32BIT=y', [])
			self.kconfig.add((4,15), (5,1), '64BIT=n', [])
			self.kconfig.add((4,15), (5,1), 'ARCH_RV32I=y', [])
			self.kconfig.add((4,15), (5,1), 'ARCH_RV64I=n', [])
			self.kconfig.add((4,15), (5,1), 'CPU_SUPPORTS_32BIT_KERNEL=y', [])
			self.kconfig.add((4,15), (5,1), 'CPU_SUPPORTS_64BIT_KERNEL=n', [])
		else:
			self.config_targets = ('defconfig',)

			# Enable compat ABI regardless (should be =y by default, but better
			# safe than sorry)
			self.kconfig.add((5,19), VERSION_INF, 'COMPAT=y', ['64BIT=y', 'MMU=y']),
			# kexec_file_load
			self.kconfig.add((5,19), VERSION_INF, 'KEXEC_FILE=y', ['64BIT=y','MMU=y'])


	@staticmethod
	def match(vmlinux: ELF) -> Optional[Tuple[bool,List[str]]]:
		if vmlinux.e_machine != E_MACHINE.EM_RISCV:
			return None

		if vmlinux.bits32:
			abis = ['rv32']
		else:
			abis = ['rv64']

			if 'compat_sys_call_table' in vmlinux.symbols:
				abis.append('rv32')

		return vmlinux.bits32, abis

	def matches(self, vmlinux: ELF) -> bool:
		return (
			vmlinux.e_machine == E_MACHINE.EM_RISCV
			and vmlinux.bits32 == self.bits32
		)

	def preferred_symbol(self, a: Symbol, b: Symbol) -> Symbol:
		c = self.prefer_compat(a, b)
		if c is not None:
			return c

		if a.name.startswith('__riscv_'): return a
		if b.name.startswith('__riscv_'): return b
		return super().preferred_symbol(a, b)
