from typing import Tuple, List, Type, Optional

from ..syscall import Syscall
from ..elf import Symbol, ELF, E_MACHINE
from ..utils import VersionedDict, noprefix
from ..kconfig import VERSION_ZERO, VERSION_INF
from ..type_hints import KernelVersion

from .arch_base import Arch

class ArchX86(Arch):
	name = 'x86'

	kconfig = VersionedDict((
		# Disable retpoline mitigations for better compiler compatibility
		((4,15)  , VERSION_INF, 'RETPOLINE=n'         , []),
		# kexec_load
		((2,6,13), (2,6,19)   , 'KEXEC=y'             , ['EXPERIMENTAL=y']),
		((2,6,19), VERSION_INF, 'KEXEC=y'             , []),
		# seccomp
		((2,6,12), (2,6,24)   , 'SECCOMP=y'           , ['PROC_FS=y']),
		((2,6,24), (5,10)     , 'SECCOMP=y'           , []),
		# iopl, ioperm (x86 only)
		((5,5)   , VERSION_INF, 'X86_IOPL_IOPERM=y'   , []),
		# modify_ldt
		((4,3)   , VERSION_INF, 'MODIFY_LDT_SYSCALL=y', []),
	))

	def __init__(self, kernel_version: KernelVersion, abi: str, bits32: bool = False):
		super().__init__(kernel_version, abi, bits32)
		assert self.abi in ('x64', 'ia32', 'x32')

		# i386_defconfig and x86_64_defconfig don't exist before v2.6.24: need
		# a different configuration in such case. We'll think about it when (if)
		# we ever get to supporting such old kernels. Additionally, there were
		# two directories under arch before v2.6.24 ("i386" and "x86_64"), so
		# self.name should reflect that too too.
		assert self.kernel_version >= (2,6,24), 'kernel too old, sorry!'

		if self.abi == 'ia32':
			self.syscall_num_reg  = 'eax'
			self.syscall_arg_regs = ('ebx', 'ecx', 'edx', 'esi', 'edi', 'ebp')
		else:
			self.syscall_num_reg  = 'rax'
			self.syscall_arg_regs = ('rdi', 'rsi', 'rdx', 'r10', 'r8', 'r9')

		if self.bits32:
			assert self.abi == 'ia32'
			self.abi_bits32       = True
			self.config_target    = 'i386_defconfig'

			# vm86 (x86 only, 32-bit only, no compat support in 64-bit kernels)
			self.kconfig.add((2,6,16), (2,6,18)   , 'VM86=y'           , ['X86=y', 'EMBEDDED=y']),
			self.kconfig.add((2,6,18), (2,6,24)   , 'VM86=y'           , ['EMBEDDED=y']),
			self.kconfig.add((2,6,24), (4,3)      , 'VM86=y'           , ['X86_32=y', 'EXPERT=y']),
			self.kconfig.add((4,3)   , VERSION_INF, 'X86_LEGACY_VM86=y', ['X86_32=y']),
			self.kconfig.add((4,3)   , VERSION_INF, 'X86_LEGACY_VM86=y', ['X86_32=y']),
			# Needed for NUMA=y
			self.kconfig.add(VERSION_ZERO, VERSION_INF, 'NOHIGHMEM=n', [])
			self.kconfig.add(VERSION_ZERO, VERSION_INF, 'HIGHMEM4G=n', [])
			self.kconfig.add(VERSION_ZERO, VERSION_INF, 'HIGHMEM64G=y', [])
			self.kconfig.add(VERSION_ZERO, VERSION_INF, 'X86_BIGSMP=y', ['SMP=y'])
			# mbind, migrate_pages, {get,set}_mempolicy
			#   NOTE: before v2.6.29 NUMA actually also needs more options in
			#   OR, but we don't support checking kconfig expressions
			self.kconfig.add(VERSION_ZERO, (2,6,23)   , 'NUMA=y', ['SMP=y', 'HIGHMEM64G=y'])
			self.kconfig.add((2,6,23)    , (2,6,29)   , 'NUMA=y', ['SMP=y', 'HIGHMEM64G=y', 'EXPERIMENTAL=y'])
			self.kconfig.add((2,6,29)    , VERSION_INF, 'NUMA=y', ['SMP=y', 'HIGHMEM64G=y', 'X86_BIGSMP=y'])
		else:
			self.abi_bits32       = self.abi == 'ia32'
			self.compat           = self.abi != 'x64'
			self.config_target    = 'x86_64_defconfig'

			if self.abi == 'ia32':
				self.syscall_table_name = 'ia32_sys_call_table'
			elif self.abi == 'x32':
				# x32 syscalls have this bit set (__X32_SYSCALL_BIT)
				self.syscall_num_base = 0x40000000
				if self.kernel_version >= (5,4):
					self.syscall_table_name = 'x32_sys_call_table'

			# x86-64 supports all ABIs: ia32, x64, x32. Enable all of them, we
			# will be able to extract the right syscall table regardless.
			self.kconfig.add(VERSION_ZERO, VERSION_INF, 'IA32_EMULATION=y', [])
			self.kconfig.add((3,4)       , (3,9)      , 'X86_X32=y'       , ['EXPERIMENTAL=y'])
			self.kconfig.add((3,9)       , (5,18)     , 'X86_X32=y'       , [])
			self.kconfig.add((5,18)      , VERSION_INF, 'X86_X32_ABI=y'   , [])

			# kexec_file_load
			self.kconfig.add((3,17), VERSION_INF, 'KEXEC_FILE=y', ['X86_64=y', 'CRYPTO=y', 'CRYPTO_SHA256=y'])
			# mbind, migrate_pages, {get,set}_mempolicy
			self.kconfig.add(VERSION_ZERO, (2,6,15)   , 'NUMA=y', [])
			self.kconfig.add((2,6,15)    , (2,6,29)   , 'NUMA=y', ['SMP=y'])
			self.kconfig.add((2,6,29)    , VERSION_INF, 'NUMA=y', ['SMP=y'])
			# pkey_alloc, pkey_free, pkey_mprotect
			#   NOTE: in theory depends on (CPU_SUP_INTEL || CPU_SUP_AMD) but we
			#   are pretty sure that CPU_SUP_INTEL will be =y
			self.kconfig.add((4,6)       , VERSION_INF, 'X86_INTEL_MEMORY_PROTECTION_KEYS=y', ['X86_64=y', 'CPU_SUP_INTEL=y'])

	@staticmethod
	def match(vmlinux: ELF) -> Optional[Tuple[Type[Arch],bool,List[str]]]:
		if vmlinux.e_machine == E_MACHINE.EM_386:
			assert vmlinux.bits32, 'EM_386 64-bit? WAT'
		elif vmlinux.e_machine == E_MACHINE.EM_X86_64:
			assert not vmlinux.bits32, 'EM_X86_64 32-bit? WAT'
		else:
			return None

		if vmlinux.bits32:
			abis = ['ia32']
		else:
			abis = ['x64']

			if 'ia32_sys_call_table' in vmlinux.symbols:
				abis.append('ia32')
			if 'x32_sys_call_table' in vmlinux.symbols or any('x32_compat_sys' in s for s in vmlinux.symbols):
				# The `any` check is needed since before v5.4 x32 syscalls did
				# NOT have their own table.
				abis.append('x32')

		return ArchX86, vmlinux.bits32, abis

	def matches(self, vmlinux: ELF) -> bool:
		return (
			vmlinux.e_machine == (E_MACHINE.EM_X86_64, E_MACHINE.EM_386)[self.bits32]
			and vmlinux.bits32 == self.bits32
		)

	__is_ia32 = staticmethod(lambda n: n.startswith('__ia32_')) # __ia32_[compat_]sys_xxx
	__is_x64  = staticmethod(lambda n: n.startswith('__x64_'))  # __x64_[compat_]sys_xxx
	__is_x32  = staticmethod(lambda n: n.startswith('__x32_'))  # __x32_compat_sys_xxx

	def preferred_symbol(self, a: Symbol, b: Symbol) -> Symbol:
		# Try preferring the symbol with the right ABI in its prefix.
		na, nb = a.name, b.name

		if self.abi == 'ia32':
			if self.__is_ia32(na): return a
			if self.__is_ia32(nb): return b
			if self.__is_x64(na): return a
			if self.__is_x64(nb): return b
			if not na.islower(): return b
			if not nb.islower(): return a
			return super().preferred_symbol(a, b)

		if self.abi == 'x32':
			if self.__is_x32(na): return a
			if self.__is_x32(nb): return b

		if self.__is_x64(na): return a
		if self.__is_x64(nb): return b
		if self.__is_ia32(na): return b
		if self.__is_ia32(nb): return a
		if not na.islower(): return b
		if not nb.islower(): return a
		return super().preferred_symbol(a, b)

	def skip_syscall(self, sc: Syscall) -> bool:
		# Syscalls 512 through 547 are historically misnumbered and x32 only,
		# see comment in arch/x86/entry/syscalls/syscall_64.tbl
		if self.abi != 'x32' and 512 <= sc.number <= 547:
			return True

		# vm86 and vm86old are only available in 32-bit kernels, but might still
		# be implemented as simple wrappers that print a warning to dmesg and
		# return -ENOSYS in 64-bit kernels, so ignore them
		if self.abi == 'ia32' and not self.bits32 and sc.number in (113, 166):
			return True

		return False

	def translate_syscall_symbol_name(self, sym_name: str) -> str:
		sym_name = super().translate_syscall_symbol_name(sym_name)
		# For whatever reason some syscalls are wrapped in assembly at the entry
		# point e.g. in v4.0 stub_execve in arch/x86/kernel/entry_64.S or
		# stub32_execve in arch/x86/ia32/ia32entry.S. These stubs with prefix
		# "stub[32]_" make calls to the actual syscall function.
		#
		# Removing the prefix helps locate the actual syscall definition through
		# source code grepping IFF they do not have any other prefix/suffix in
		# the source (stub_fork -> fork -> easily find SYSCALL_DEFINE0(fork)).
		#
		# In some cases this is not enough though, because the actual function
		# has another prefix: e.g. stub_rt_sigreturn, which calls
		# sys_rt_sigreturn, defined as `asmlinkage long sys_rt_sigreturn`
		# and not `asmlinkage long rt_sigreturn` or
		# `SYSCALL_DEFINE0(rt_sigreturn)`. Kind of a bummer, but I don't really
		# want to become insane to accomodate all these quirks.
		return noprefix(sym_name, 'stub32_', 'stub_')

	def normalize_syscall_name(self, name: str) -> str:
		name = super().normalize_syscall_name(name)
		# E.g. v5.18 COMPAT_SYSCALL_DEFINE1(ia32_mmap, ...)
		return noprefix(name, 'ia32_', 'x86_', 'x32_')

	def _dummy_syscall_code(self, sc: Syscall, vmlinux: ELF) -> Optional[bytes]:
		# Check if the code of the syscall only consists of
		# `MOV rax/eax, -ENOSYS/-EINVAL` followed by a RET or relative JMP, e.g.
		# lookup_dcookie in v5.19:
		#
		#     48 c7 c0 da ff ff ff     mov    rax,  0xffffffffffffffda
		#     e9 84 ca f6 00           jmp    0xf6ca90
		#
		sz = sc.symbol.size
		if sz < 6 or sz > 12:
			return None

		code = vmlinux.read_symbol(sc.symbol)
		bad_imm = (b'\xda\xff\xff\xff', b'\xea\xff\xff\xff')

		if self.abi == 'ia32':
			if code[:1] == b'\xb8' and code[1:5] in bad_imm: # mov eax, -ENOSYS/-EINVAL
				if sz == 6  and code[5] == 0xc3: return code # ret
				if sz == 7  and code[5] == 0xeb: return code # jmp rel8
				if sz == 10 and code[5] == 0xe9: return code # jmp rel32
			return None

		if code[:3] == b'\x48\xc7\xc0' and code[3:7] in bad_imm: # mov rax, -ENOSYS/-EINVAL
			if sz == 8  and code[7] == 0xc3: return code # ret
			if sz == 9  and code[7] == 0xeb: return code # jmp rel8
			if sz == 12 and code[7] == 0xe9: return code # jmp rel32
		return None
