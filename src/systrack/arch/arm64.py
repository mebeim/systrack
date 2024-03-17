from typing import Tuple, List, Type, Optional

from ..elf import Symbol, ELF, E_MACHINE
from ..kconfig_options import VERSION_INF
from ..type_hints import KernelVersion
from ..utils import VersionedDict, noprefix

from .arch_base import Arch

class ArchArm64(Arch):
	name             = 'arm64'
	bits32           = False
	syscall_num_reg  = 'w8'
	syscall_arg_regs = ('x0', 'x1', 'x2', 'x3', 'x4', 'x5')

	kconfig = VersionedDict((
		# Enable aarch32 ABI regardless, should be =y by default, but better safe than sorry
		((3,7) , VERSION_INF, 'COMPAT=y', ['ARM64_4K_PAGES=y', 'EXPERT=y']),
		# kexec[_file]_load
		((4,8) , VERSION_INF, 'KEXEC=y'     , ['PM_SLEEP_SMP=y']),
		((5,0) , VERSION_INF, 'KEXEC_FILE=y', []),
		# seccomp
		((3,19), (5,10)     , 'SECCOMP=y'   , []),
		# mbind, migrate_pages, {get,set}_mempolicy
		((4,7) , VERSION_INF, 'NUMA=y'      , []),
	))

	def __init__(self, kernel_version: KernelVersion, abi: str, bits32: bool = False):
		assert not bits32, f'{self.__class__.__name__} is 64-bit only'
		assert kernel_version >= (3,7), 'Linux only supports arm64 from v3.7'
		super().__init__(kernel_version, abi, False)
		assert not self.bits32
		assert self.abi in ('aarch64', 'aarch32')

		if self.abi == 'aarch32':
			self.compat = True
			self.abi_bits32 = True
			self.syscall_table_name = 'compat_sys_call_table'

	@staticmethod
	def match(vmlinux: ELF) -> Optional[Tuple[Type[Arch],bool,List[str]]]:
		if vmlinux.e_machine != E_MACHINE.EM_AARCH64:
			return None

		assert not vmlinux.bits32, 'EM_AARCH64 32-bit? WAT'

		if 'compat_sys_call_table' in vmlinux.symbols:
			abis = ['aarch64', 'aarch32']
		else:
			abis = ['aarch64']

		return ArchArm64, False, abis

	def matches(self, vmlinux: ELF) -> bool:
		return not vmlinux.bits32 and vmlinux.e_machine == E_MACHINE.EM_AARCH64

	def preferred_symbol(self, a: Symbol, b: Symbol) -> Symbol:
		c = self.prefer_compat(a, b)
		if c is not None:
			return c

		# See commit 4378a7d4be30ec6994702b19936f7d1465193541
		if a.name.startswith('__arm64_'): return a
		if b.name.startswith('__arm64_'): return b
		return super().preferred_symbol(a, b)

	def _normalize_syscall_name(self, name: str) -> str:
		# E.g. v5.18 COMPAT_SYSCALL_DEFINE6(aarch32_mmap2, ...)
		return noprefix(name, 'aarch32_')
