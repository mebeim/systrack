from typing import Tuple, List, Type, Optional

from ..elf import Symbol, ELF, E_MACHINE, E_FLAGS
from ..kconfig_options import VERSION_INF
from ..syscall import Syscall
from ..type_hints import KernelVersion, EsotericSyscall
from ..utils import VersionedDict, noprefix, nosuffix

from .arch_base import Arch

class ArchArm(Arch):
	name             = 'arm'
	bits32           = True
	abi              = None # Chosen by .adjust_abi()
	abi_bits32       = True
	compat           = None # Chosen by .adjust_abi()
	syscall_arg_regs = ('r0', 'r1', 'r2', 'r3', 'r4', 'r5', 'r6')

	kconfig = VersionedDict((
		# kexec_load
		((2,6,21), VERSION_INF, 'KEXEC=y'  , ['PM_SLEEP_SMP=y', 'MMU=y']),
		# seccomp
		((2,6,37), (5,10)     , 'SECCOMP=y', []),
		# No NUMA support => no mbind, migrate_pages, {get,set}_mempolicy
	))

	def __init__(self, kernel_version: KernelVersion, abi: str, bits32: bool = True):
		assert bits32, f'{self.__class__.__name__} is 32-bit only'
		super().__init__(kernel_version, abi, True)
		assert self.bits32 and self.abi_bits32
		assert self.abi in ('eabi', 'oabi')

		if self.kernel_version >= (3,7):
			# We want a modern-enough processor for which SMP=y by default
			self.config_target = 'multi_v7_defconfig'
		else:
			# TODO: not sure which config is best for < 3.7, but defconfig
			# definitely isn't that good, we might be missing some syscalls e.g.
			# kexec if SMP=n, so warn about it. This is something to think about
			# when we get around supporting such kernel versions.
			self.config_target = 'defconfig'

		if self.abi == 'eabi':
			# Apparently OABI_COMPAT is on by default on old kernels (e.g. 4.0),
			# so disable it if not needed, or we're gonna build a kernel with
			# no seccomp.
			self.kconfig.add((2,6,16), VERSION_INF, 'OABI_COMPAT=n', [])
			self.syscall_num_reg = 'r7'
		elif self.abi == 'oabi':
			self.syscall_num_base = 0x900000
			# No register, number passed as immediate to the SWI instruction
			self.syscall_num_reg = 'swi <NR>'

			# Building an old OABI-only kernel is annoying. Assume EABI + compat
			# OABI (OABI_COMPAT=y) and just build with support for both ABIs.
			# FIXME: this will disable the seccomp syscall. Configure for an
			# OABI-only kernel here in the future...
			self.kconfig.add((2,6,16), VERSION_INF, 'OABI_COMPAT=y', ['AEABI=y', 'THUMB2_KERNEL=n'])

	@staticmethod
	def match(vmlinux: ELF) -> Optional[Tuple[Type[Arch],bool,List[str]]]:
		if vmlinux.e_machine != E_MACHINE.EM_ARM:
			return None

		assert vmlinux.bits32, 'EM_ARM 64-bit? WAT'

		if 'sys_oabi_call_table' in vmlinux.symbols:
			abis = ['eabi', 'oabi']
		else:
			# For EABI, e_flags in the ELF header should tell us the EABI
			# version (assuming it is set).
			if (vmlinux.e_flags & E_FLAGS.EF_ARM_EABI_MASK) != 0:
				abis = ['eabi']
			abis = ['oabi']

		return ArchArm, True, abis

	def matches(self, vmlinux: ELF) -> bool:
		return vmlinux.bits32 and vmlinux.e_machine == E_MACHINE.EM_ARM

	def adjust_abi(self, vmlinux: ELF):
		# We could be dealing with an EABI + compat OABI kernel or an
		# EABI/OABI-only kernel. In the former case, we'll need to select the
		# compat syscall table.
		if self.abi == 'oabi' and 'sys_oabi_call_table' in vmlinux.symbols:
			# EABI + compat OABI
			self.compat = True
			self.syscall_table_name = 'sys_oabi_call_table'
		else:
			# EABI/OABI only
			self.compat = False
			self.syscall_table_name = 'sys_call_table'

	def preferred_symbol(self, a: Symbol, b: Symbol) -> Symbol:
		c = self.prefer_compat(a, b)
		if c is not None:
			return c
		return super().preferred_symbol(a, b)

	def translate_syscall_symbol_name(self, sym_name: str) -> str:
		sym_name = super().translate_syscall_symbol_name(sym_name)
		# For some reason some syscalls are wrapped in assembly at the entry
		# point e.g. sys_sigreturn_wrapper v5.18 arch/arm/kernel/entry-common.S.
		# Stripping the "_wrapper" suffix can help locate them through source
		# code grepping.
		return nosuffix(sym_name, '_wrapper')

	def _normalize_syscall_name(self, name: str) -> str:
		if self.abi == 'oabi':
			# E.g. v5.18 asmlinkage long sys_oabi_connect(...)
			name = noprefix(name, 'oabi_')
		# E.g. v5.18 asmlinkage long sys_arm_fadvise64_64(...)
		return noprefix(name, 'arm_')

	def _dummy_syscall_code(self, sc: Syscall, vmlinux: ELF) -> Optional[bytes]:
		# Match the following code exactly with either #21 (EINVAL - 1) or #37
		# (ENOSYS - 1) as immediate for MVN:
		#
		#     f06f 0015    mvn.w   r0, #21
		#     4770         bx      lr
		#
		# Taken from sys_fork on v5.0 multi_v7_defconfig with MMU=n.
		#
		if sc.symbol.size != 6:
			return None

		code = vmlinux.read_symbol(sc.symbol)
		if code in (b'\x6f\xf0\x15\x00\x70\x47', b'\x6f\xf0\x25\x00\x70\x47'):
			return code
		return None

	def extract_esoteric_syscalls(self, vmlinux: ELF) -> EsotericSyscall:
		# ARM-specific syscalls that are outside the syscall table, with numbers
		# in the range 0x0f0000-0x0fffff for EABI and 0x9f0000-0x9fffff for
		# OABI. These are all implemented in arm_syscall()
		# (arch/arm/kernel/traps.c) with a switch statement. WEEEIRD!
		#
		if 'arm_syscall' not in vmlinux.functions:
			return []

		base = self.syscall_num_base + 0x0f0000
		res = [
			(base + 1, 'breakpoint', 'arm_syscall', (), None),
			(base + 2, 'cacheflush', 'arm_syscall', ('unsigned long start', 'unsigned long end', 'int flags'), None),
			(base + 3, 'usr26'     , 'arm_syscall', (), None),
			(base + 4, 'usr32'     , 'arm_syscall', (), None),
			(base + 5, 'set_tls'   , 'arm_syscall', ('unsigned long val',), None),
		]

		if self.kernel_version >= (4,15):
			res.append((base + 6, 'get_tls', 'arm_syscall', (), None))

		return res
