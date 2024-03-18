from typing import Tuple, List, Type, Optional

from ..elf import Symbol, ELF, E_MACHINE
from ..kconfig_options import VERSION_ZERO, VERSION_INF
from ..type_hints import KernelVersion
from ..utils import VersionedDict, noprefix

from .arch_base import Arch

class ArchMips(Arch):
	name            = 'mips'
	syscall_num_reg = 'v0'

	kconfig = VersionedDict((
		# kexec[_file]_load
		((2,6,20), (3,9)      , 'KEXEC=y'  , ['EXPERIMENTAL=y']),
		((3,9)   , VERSION_INF, 'KEXEC=y'  , []),
		# seccomp
		((2,6,15), (5,10)     , 'SECCOMP=y', []),
	))

	def __init__(self, kernel_version: KernelVersion, abi: str, bits32: bool = False):
		super().__init__(kernel_version, abi, bits32)
		assert self.abi in ('o32', 'n32', 'n64')

		if self.abi == 'o32':
			self.abi_bits32 = True
			# Interestingly, man 2 syscall states: "The mips/o32 system call
			# convention passes arguments 5 through 8 on the user stack".
			# What syscall takes 8 arguments on MIPS o32? WTF.
			self.syscall_num_base = 4000
			self.syscall_arg_regs = ('a0', 'a1', 'a2', 'a3', 'stack', 'stack', 'stack', 'stack')

			if not self.bits32:
				self.syscall_table_name = 'sys32_call_table'
		else:
			self.abi_bits32 = False
			self.syscall_arg_regs = ('a0', 'a1', 'a2', 'a3', 'a4', 'a5')

			if self.abi == 'n64':
				self.syscall_num_base = 5000
			else: # n32
				self.syscall_num_base = 6000
				self.syscall_table_name = 'sysn32_call_table'

		if self.bits32:
			# MIPS 32bit means o32 ABI.
			assert self.abi == 'o32'

			# Just to be clear: for 32-bit we are ok with defconfig
			self.config_target = 'defconfig'

			self.kconfig.add(VERSION_ZERO, VERSION_INF, '32BIT=y', [])
			self.kconfig.add(VERSION_ZERO, VERSION_INF, '64BIT=n', [])

			# Select CPU release. It does not seem to matter much, so select R2,
			# which has the best kernel version compatibility (along with R1).
			# These are a multiple choice menu, so better set all of them.
			self.kconfig.add((2,6,15), VERSION_INF, 'CPU_MIPS32_R1=n', [])
			self.kconfig.add((2,6,15), VERSION_INF, 'CPU_MIPS32_R2=y', ['SYS_HAS_CPU_MIPS32_R2=y'])
			self.kconfig.add((4,0)   , VERSION_INF, 'CPU_MIPS32_R6=n', [])
		else:
			self.compat = self.abi != 'n64'

			# Grab SGI IP27 (Origin200/2000), which apparently is one of the
			# only two MIPS machine with NUMA support along with Longsoon64
			# (loongson3_defconfig), as the latter is more of a pain in the ass
			# to build. No need to select CPU release for this, it's R10000.
			self.config_target = 'ip27_defconfig'

			self.kconfig.add(VERSION_ZERO, VERSION_INF, '32BIT=n', [])
			self.kconfig.add(VERSION_ZERO, VERSION_INF, '64BIT=y', [])

			# 32-bit has no NUMA support (apparently), but 64-bit does and
			# ip27_defconfig should include it. Make sure an error is raised in
			# case of no NUMA. Needed for mbind, migrate_pages,
			# {get,set}_mempolicy.
			self.kconfig.add(VERSION_ZERO, VERSION_INF, 'NUMA=y', ['SYS_SUPPORTS_NUMA=y'])

			# MIPS 64bit supports all ABIs: 32bit o32, 64bit n32, 64bit n64.
			# Enable all of them regardless, we will be able to extract the
			# right syscall table anyway.
			self.kconfig.add(VERSION_ZERO, VERSION_INF, 'MIPS32_O32=y', [])
			self.kconfig.add(VERSION_ZERO, VERSION_INF, 'MIPS32_N32=y', [])

	@staticmethod
	def match(vmlinux: ELF) -> Optional[Tuple[Type[Arch],bool,List[str]]]:
		if vmlinux.e_machine != E_MACHINE.EM_MIPS:
			return None

		if vmlinux.bits32:
			abis = ['o32']
		else:
			abis = ['n64']

			if 'sys32_call_table' in vmlinux.symbols:
				abis.append('o32')
			if 'sysn32_call_table' in vmlinux.symbols:
				abis.append('n32')

		return ArchMips, vmlinux.bits32, abis

	def matches(self, vmlinux: ELF) -> bool:
		return (
			vmlinux.e_machine == E_MACHINE.EM_MIPS
			and vmlinux.bits32 == self.bits32
		)

	def preferred_symbol(self, a: Symbol, b: Symbol) -> Symbol:
		c = self.prefer_compat(a, b)
		if c is not None:
			return c
		return super().preferred_symbol(a, b)

	def _normalize_syscall_name(self, name: str) -> str:
		# E.g. v5.1 asmlinkage int sysm_pipe(void) for weird historical reasons
		# E.g. v5.18 SYSCALL_DEFINE6(mips_mmap, ...)
		return noprefix(name, 'sysm_', 'mips_')
