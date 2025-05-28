from typing import Tuple, List, Optional

from ..elf import ELF, E_MACHINE
from ..kconfig_options import VERSION_ZERO, VERSION_INF
from ..syscall import Syscall
from ..type_hints import KernelVersion
from ..utils import VersionedDict, anyprefix, noprefix

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
			self.config_targets = ('defconfig',)

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
			self.config_targets = ('ip27_defconfig',)

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
	def match(vmlinux: ELF) -> Optional[Tuple[bool,List[str]]]:
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

		return vmlinux.bits32, abis

	def matches(self, vmlinux: ELF) -> bool:
		return (
			vmlinux.e_machine == E_MACHINE.EM_MIPS
			and vmlinux.bits32 == self.bits32
		)

	def _normalize_syscall_name(self, name: str) -> str:
		# E.G. v5.1 asmlinkage int sysm_pipe(void) for weird historical reasons
		# E.G. v5.18 SYSCALL_DEFINE6(mips_mmap, ...)
		# E.G. v5.0-6.13+ asmlinkage long mipsmt_sys_sched_setaffinity(...)
		return noprefix(name, 'sysm_', 'mips_', 'mipsmt_sys_')

	def _dummy_syscall_code(self, sc: Syscall, vmlinux: ELF) -> Optional[bytes]:
		# Match the following code exactly with either -22 (EINVAL) or -89
		# (-ENOSYS), which of course is different than normalon MIPS) as
		# immediate for LI:
		#
		#     03e00008    jr  ra
		#     2402ffa7    li  v0,-89
		#
		# Taken from __se_sys_cachectl on v6.9 64-bit ip27_defconfig.
		#
		if sc.symbol.size != 8:
			return None

		code = vmlinux.read_symbol(sc.symbol)

		if vmlinux.big_endian:
			if not code.startswith(b'\x03\xe0\x00\x08\x24\x02'):
				return None

			imm = int.from_bytes(code[6:], 'big', signed=True)
		else:
			if not (code.startswith(b'\x08\x00\xe0\x03') and code.endswith(b'\x02\x24')):
				return None

			imm = int.from_bytes(code[4:6], 'little', signed=True)

		if imm == -22 or imm == -89:
			return code
		return None

	def syscall_def_regexp(self, syscall_name: Optional[str]=None) -> Optional[str]:
		# Absolutely insane old-style prefixes on MIPS...
		exps = []

		if syscall_name is not None:
			if anyprefix(syscall_name, 'sysm_', 'mipsmt_sys_'):
				exps.append(rf'\basmlinkage\s*(unsigned\s+)?\w+\s*{syscall_name}\s*\(')
			else:
				exps.append(rf'\basmlinkage\s*(unsigned\s+)?\w+\s*(sysm|mipsmt_sys)_{syscall_name}\s*\(')

			if self.abi == 'n32':
				if anyprefix(syscall_name, 'sysn32_'):
					exps.append(rf'\basmlinkage\s*(unsigned\s+)?\w+\s*{syscall_name}\s*\(')
				else:
					exps.append(rf'\basmlinkage\s*(unsigned\s+)?\w+\s*sysn32_{syscall_name}\s*\(')
		else:
			exps.append(r'\basmlinkage\s*(unsigned\s+)?\w+\s*(sysm|mipsmt_sys)_\w+\s*\(')

			if self.abi == 'n32':
				exps.append(r'\basmlinkage\s*(unsigned\s+)?\w+\s*sysn32_\w+\s*\(')

		return '|'.join(exps)
