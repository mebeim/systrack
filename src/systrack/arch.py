import logging
from os import sched_getaffinity
from typing import Tuple, List, Dict, Type, Optional
from platform import machine
from pathlib import Path
from abc import ABC, abstractmethod

from .syscall import Syscall
from .elf import Symbol, ELF, E_MACHINE, E_FLAGS
from .utils import VersionedDict, VersionedList, anyprefix, anysuffix, noprefix, nosuffix, eprint
from .kconfig import VERSION_ZERO, VERSION_INF

# NOTE: For the sake of mental sanity, try keeping abi= the same name as the one
# in the *.tbl files in the kernel sources (exception x86).
SUPPORTED_ARCHS = {
	'x86'          : lambda v: ArchX86(v, abi='ia32', bits32=True), # "i386" ABI
	'x86-64'       : lambda v: ArchX86(v, abi='x64'),               # "64" ABI
	'x86-64-x32'   : lambda v: ArchX86(v, abi='x32'),
	'x86-64-ia32'  : lambda v: ArchX86(v, abi='ia32'),
	'arm'          : lambda v: ArchArm(v, abi='eabi'),
	'arm-oabi'     : lambda v: ArchArm(v, abi='oabi'),
	'arm64'        : lambda v: ArchArm64(v, abi='aarch64'),
	'arm64-aarch32': lambda v: ArchArm64(v, abi='aarch32'),
	'mips'         : lambda v: ArchMips(v, abi='o32', bits32=True),
	'mips64'       : lambda v: ArchMips(v, abi='n64'),
	'mips64-n32'   : lambda v: ArchMips(v, abi='n32'),
	'mips64-o32'   : lambda v: ArchMips(v, abi='o32'),
}

ARCH_ALIASES = (
	# name            alias
	('x86'          , 'i386'      ),
	('x86'          , 'ia32'      ),
	('x86-64'       , 'x64'       ),
	('x86-64-x32'   , 'x32'       ),
	('x86-64-ia32'  , 'ia32-64'   ),
	('arm'          , 'arm-eabi'  ),
	('arm'          , 'eabi'      ),
	('arm-oabi'     , 'oabi'      ),
	('arm64'        , 'aarch64'   ),
	('arm64-aarch32', 'aarch32-64'),
	('mips'         , 'mips32'    ),
	('mips'         , 'o32'       ),
	('mips64'       , 'n64'       ),
	('mips64-n32'   , 'n32'       ),
	('mips64-o32'   , 'o32-64'    ),
)

SUPPORTED_ARCHS.update({alias: SUPPORTED_ARCHS[arch] for arch, alias in ARCH_ALIASES})

# TODO: is AArch32-only kernel even a thing?
SUPPORTED_ARCHS_HELP = '''\
Supported architectures and ABIs (values are case-insensitive):

    Value          Aliases         Arch  Kernel  ABI             Build based on    Notes
    ------------------------------------------------------------------------------------
    x86            i386, ia32      x86   32-bit  32-bit IA32     i386_defconfig
    x86-64         x64             x86   64-bit  64-bit x86-64   x86_64_defconfig  [1]
    x86-64-x32     x32             x86   64-bit  64-bit x32      x86_64_defconfig  [1]
    x86-64-ia32    ia32-64         x86   64-bit  32-bit IA32     x86_64_defconfig  [1]
    ------------------------------------------------------------------------------------
    arm            arm-eabi, eabi  ARM   32-bit  32-bit EABI     defconfig         [1]
    arm-oabi       oabi            ARM   32-bit  32-bit OABI     defconfig         [2]
    ------------------------------------------------------------------------------------
    arm64          aarch64         ARM   64-bit  64-bit AArch64  defconfig
    arm64-aarch32  aarch32-64      ARM   64-bit  32-bit AArch32  defconfig         [3]
    ------------------------------------------------------------------------------------
    mips           mips32, o32     MIPS  32-bit  32-bit O32      defconfig
    mips64         n64             MIPS  64-bit  64-bit N64      defconfig         [1]
    mips64-n32     n32             MIPS  64-bit  64-bit N32      defconfig         [1]
    mips64-o32     o32-64          MIPS  64-bit  32-bit O32      defconfig         [1]

    [1] Building creates a kernel supporting all ABIs for this architecture.
    [2] Building creates an EABI kernel with compat OABI support. Building an OABI-only
        kernel is NOT supported. The seccomp filter system will be missing.
    [3] AArch64 with compat AArch32 support. AArch32-only kernel NOT supported.
'''

class Arch(ABC):
	# Directory name for this arch in the kernel source, under arch/
	name: str = None

	# Are we looking for compat syscalls (COMPACT_SYSCALL_DEFINEn)?
	compat: bool = False

	# Make target to build for the base config
	config_target: str = 'defconfig'

	# Name of the syscall table symbol to look for
	syscall_table_name: str = 'sys_call_table'

	# Base syscall number (actual syscall number is base + idx in syscall table)
	# NOTE: the arch_syscall_addr() function can be useful to look at for this
	syscall_num_base: int = 0

	# Syscall number destination (register name, None if no register is used,
	# e.g. arm/OABI where the instruction is swi <nr>). Subclasses must override
	# this.
	syscall_num_reg: str = None

	# Registers for syscall arguments. Subclasses must override this.
	syscall_arg_regs: Tuple[str, ...] = None

	# Weird arch-specific syscalls not in the syscall table: there isn't much
	# else to do except manually list these... each entry should be in the form:
	# (number, syscall_name, symbol_name, signature). We also need the signature
	# since we are most likely not going to be able to extract it.
	esoteric_syscalls: VersionedList = VersionedList()

	# Additional kconfig options to set
	kconfig: VersionedDict = VersionedDict()

	def __init__(self, kernel_version: Tuple[int,int,int], abi: str, bits32: bool = False):
		self.kernel_version = kernel_version
		self.bits32 = bits32
		self.abi = abi # ABI to inspect/build for

	@staticmethod
	def from_name(name: str, kernel_version: Tuple[int,int,int]) -> 'Arch':
		# The name should be already validated
		return SUPPORTED_ARCHS[name](kernel_version)

	@staticmethod
	@abstractmethod
	def match(vmlinux: ELF) -> Optional[Tuple[Type['Arch'],bool,List[str]]]:
		'''Determine architecture and supported ABIs from vmlinux ELF; returns
		the correct Arch subclass, the bitness and a list of detected ABIs.
		'''
		for klass in ARCH_CLASSES:
			match = klass.match(vmlinux)
			if match:
				return match

		logging.fatal('Unknown or unsupported architecture (e_machine = %d)', vmlinux.e_machine)
		return None

	@abstractmethod
	def matches(self, vmlinux: ELF) -> bool:
		'''Determine whether this architecture matches the one of the provided
		vmlinux (machine and bits). This is useful as a sanity check, e.g. if
		a subclass is instantiated and then we want to use it on an unknown
		vmlinux (or multiple ones).
		'''
		pass

	def adjust_abi(self, vmlinux: ELF):
		'''Adjust internal ABI-specific attributes that can be ambiguous for a
		certain ABI selection (e.g. syscall_table_name) to the correct value
		based on the provided vmlinux.
		'''
		pass

	def prefer_compat(self, a: Symbol, b: Symbol) -> Symbol:
		'''If only one of the two symbols is "compat", pick the correct one
		according to self.compat.
		'''
		ca = 'compat' in a.name
		cb = 'compat' in b.name

		if ca ^ cb:
			if self.compat:
				return a if ca else b
			return b if ca else a
		return None

	@abstractmethod
	def preferred_symbol(self, a: Symbol, b: Symbol) -> Symbol:
		'''Decide which symbol should be preferred when multiple syscall symbols
		point to the same virtual address.

		For example, on x86-64 with IA32 emulation support, __x64_sys_getpid and
		__ia32_sys_getpid point to the same vaddr. We prefer __x64_sys_getpid if
		we are inspecting the 64-bit syscall table, and __ia32_sys_getpid if we
		are inspecting the 32-bit one.

		This does not have any meaningful effect on the correctness of the
		output, since at the end of the day if multiple symbols point to the
		same vaddr, they are in fact the same function, and the location
		information will also be correct regardless of which one is picked.
		'''
		pass

	def symbol_is_ni_syscall(self, sym: Symbol) -> bool:
		'''Determine whether the symbol name identifies the special
		"not implemented" syscall a.k.a. ni_syscall.

		There can be multiple ni_syscall implementations with different
		prefixes and at different vaddrs (go figure). Make sure to get all of
		them (readelf -s vmlinux | grep ni_syscall).

		For example on x86 v5.0+:

		    sys_ni_syscall
		    __x64_sys_ni_syscall
		    __ia32_sys_ni_syscall

		By default, also avoid ftrace-related _eil_addr_XXX symbols generated
		with CONFIG_FTRACE_SYSCALLS=y.
		'''
		# This generic approach should be good enough
		return (
			sym.type == 'FUNC'
			and anysuffix(sym.name, 'sys_ni_syscall', 'compat_ni_syscall')
			and not sym.name.startswith('_eil_addr_')
		)

	def skip_syscall(self, sc: Syscall) -> bool:
		'''Determine whether to skip this syscall.

		Kernels compiled with support for multiple ABIs might share the same
		syscall table between two or more ABIs, and in such case we want to
		filter out syscalls that aren't for the ABI we are currently inspecting.

		E.G. on x86-64 the 64 and x32 ABI share the same syscall table
		(sys_call_table) before v5.4, which also holds some x32 compat syscalls
		that are only available for applications using the x32 ABI.
		'''
		return False

	def translate_syscall_symbol_name(self, sym_name: str) -> str:
		'''Translate symbol name into syscall name, potentially stripping or
		replacing arch-specific suffixes/prefixes from the symbol name, in order
		to be able to correctly identify a syscall. Overriding this shouldn't be
		needed in most cases.

		This default implementation just removes prefixes/suffixes that are not
		common enough to be indentified as common prefixes and stripped
		automatically.
		'''
		return noprefix(sym_name, 'ptregs_sys_')

	def normalize_syscall_name(self, name: str) -> str:
		'''Normalize a syscall name removing unneeded prefixes and suffixes.
		These are prefixes/suffixes that are ACTUALLY PRESENT IN THE SOURCE,
		and not just in the symbol name.

		This generic method oly handles common prefixes/suffixes. Arch-specific
		ones (e.g. "ia32_", "aarch32_", "oabi_") will have to be handled by the
		appropriate subclass.

		NOTE: always call super().normalize_syscall_name() from subclasses to
		strip common prefixes/suffixes before stripping arch-specific ones.
		'''
		# In theory we could also remove the trailing "16" from 16-bit UID
		# syscalls (setuid16, chown16, etc.) since it's not the real syscall
		# name, but that'd make the output a bit confusing because we'd have
		# both 16-bit and 32-bit UID syscalls with the same names, so let's
		# avoid it.
		#name = nosuffix(name, '16')

		# Some syscalls have a "_time64" or "_time32" suffix to distinguish
		# whether they use 64-bit time structs (e.g. `struct __kernel_timespec`)
		# or 32-bit time structs (e.g. `struct old_timespec32`). Sometimes the
		# suffix is shortened to just "64" or "32" if the syscall name already
		# ends in "time". This suffix is independent of the arch, so strip it
		# regardless.
		#
		#     SYSCALL_DEFINE5(recvmmsg_time32, ...) -> recvmmsg
		#     SYSCALL_DEFINE2(clock_adjtime32, ...) -> clock_adjtime
		#
		name = nosuffix(name, '_time32', '_time64')
		if name.endswith('time32') or name.endswith('time64'):
			name = name[:-2]

		# Some architectures have a "sys32_" or "32_" prefix for... whatever
		# annoying reason (e.g. v5.1 MIPS 64bit o32). Stripping it regardless of
		# arch seems fine, so do it.
		#
		#     asmlinkage long sys32_sync_file_range(...) -> sync_file_range
		#     SYSCALL_DEFINE4(32_truncate64, ...)        -> truncate64
		#
		name = noprefix(name, '32_', 'sys32_')

		# Some architectures have an "old_" prefix for old syscalls which have
		# been superseded by new ones. There is also stuff like "oldumount"
		# (v5.18 ARM), but that's actually a different syscall and the kernel
		# also has "umount" under a different number, so leave it be.
		#
		#     SYSCALL_DEFINE2(old_getrlimit, ...) -> getrlimit
		#     SYSCALL_DEFINE1(oldumount, ...)     -> oldumount (leave it be)
		#
		return noprefix(name, 'old_')

	def is_dummy_syscall(self, code: bytes) -> bool:
		'''Determine whether the provided machine code is just `return -ENOSYS`,
		meaning that the syscall it was extracted from is not actually
		implemented.
		'''
		return False

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

	def __init__(self, *a, **kwa):
		super().__init__(*a, **kwa)
		assert self.abi in ('x64', 'ia32', 'x32')

		# i386_defconfig and x86_64_defconfig don't exist before v2.6.24: need
		# a different configuration in such case. We'll think about it when (if)
		# we ever get to supporting such old kernels. Additionally, there were
		# two directories under arch before v2.6.24 ("i386" and "x86_64"), so
		# self.name should reflect that too too.
		assert self.kernel_version >= (2,6,24), 'kernel too old, sorry!'

		if self.bits32:
			assert self.abi == 'ia32'
			self.syscall_num_reg   = 'eax'
			self.syscall_arg_regs = ('ebx', 'ecx', 'edx', 'esi', 'edi', 'ebp')
			self.config_target    = 'i386_defconfig'

			# vm86 (x86 only, 32-bit only, no compat support in 64-bit kernels)
			self.kconfig.add((2,6,16), (2,6,18)   , 'VM86=y', ['X86=y', 'EMBEDDED=y']),
			self.kconfig.add((2,6,18), (2,6,24)   , 'VM86=y', ['EMBEDDED=y']),
			self.kconfig.add((2,6,24), (4,3)      , 'VM86=y', ['X86_32=y', 'EXPERT=y']),
			self.kconfig.add((4,3)   , VERSION_INF, 'VM86=y', []),
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
			self.syscall_num_reg  = 'rax'
			self.syscall_arg_regs = ('rdi', 'rsi', 'rdx', 'r10', 'r8', 'r9')
			self.config_target    = 'x86_64_defconfig'
			self.compat           = self.abi != 'x64'

			if self.abi == 'ia32':
				self.syscall_table_name = 'ia32_sys_call_table'
			elif self.abi == 'x32' and self.kernel_version >= (5,4):
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
			self.kconfig.add((4,6)       , VERSION_INF, 'X86_INTEL_MEMORY_PROTECTION_KEYS=y', [])

	@staticmethod
	def match(vmlinux: ELF) -> Optional[Tuple[Type['Arch'],bool,List[str]]]:
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
			if not nb.islower(): return a
			if not na.islower(): return b
			return a if self.__is_x64(na) else b

		if self.abi == 'x32':
			if self.__is_x32(na): return a
			if self.__is_x32(nb): return b

		if self.__is_ia32(nb): return a
		if self.__is_ia32(na): return b
		if not nb.islower(): return a
		if not na.islower(): return b
		return a if self.__is_x64(na) else b

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

	def is_dummy_syscall(self, code: bytes) -> bool:
		# Check if the code of the syscall only consists of `MOV RAX, -ENOSYS`
		# followed by a RET or relative JMP, e.g. lookup_dcookie in v5.19:
		#
		#     48 c7 c0 da ff ff ff     mov    rax,  0xffffffffffffffda
		#     e9 84 ca f6 00           jmp    0xf6ca90

		if self.abi == 'ia32':
			if code[:5] == b'\xb8\xda\xff\xff\xff':                 # mov eax, -ENOSYS
				if len(code) == 6  and code[5] == 0xc3: return True # ret
				if len(code) == 7  and code[5] == 0xeb: return True # jmp rel8
				if len(code) == 10 and code[5] == 0xe9: return True # jmp rel32
			return False

		if code[:7] == b'\x48\xc7\xc0\xda\xff\xff\xff':         # mov rax, -ENOSYS
			if len(code) == 8  and code[7] == 0xc3: return True # ret
			if len(code) == 9  and code[7] == 0xeb: return True # jmp rel8
			if len(code) == 12 and code[7] == 0xe9: return True # jmp rel32
		return False

class ArchArm(Arch):
	name = 'arm'

	# These two will be set by adjust_abi(), use None as placeholder to make
	# sure they are actually set
	compat = None
	syscall_table_name = None

	syscall_arg_regs = ('r0', 'r1', 'r2', 'r3', 'r4', 'r5', 'r6')

	kconfig = VersionedDict((
		# kexec_load
		((2,6,21), VERSION_INF, 'KEXEC=y'  , ['PM_SLEEP_SMP=y', 'MMU=y']),
		# seccomp
		((2,6,37), (5,10)     , 'SECCOMP=y', []),
		# No NUMA support => no mbind, migrate_pages, {get,set}_mempolicy
	))

	def __init__(self, *a, **kwa):
		super().__init__(*a, **kwa)
		self.bits32 = True
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

			# Building an old OABI-only kernel is annoying. Assume EABI + compat
			# OABI (OABI_COMPAT=y) and just build with support for both ABIs.
			# FIXME: this will disable the seccomp syscall. Configure for an
			# OABI-only kernel here in the future...
			self.kconfig.add((2,6,16), VERSION_INF, 'OABI_COMPAT=y', ['AEABI=y', 'THUMB2_KERNEL=n'])

		# ARM-specific syscalls that are outside the syscall table, with numbers
		# in the range 0x0f0000-0x0fffff for EABI and 0x9f0000-0x9fffff for
		# OABI. These are all implemented in arm_syscall()
		# (arch/arm/kernel/traps.c) with a switch statement. WEEEIRD!
		base = self.syscall_num_base + 0x0f0000
		self.esoteric_syscalls = VersionedList((
			(VERSION_ZERO, VERSION_INF, (
				# number   name          symbol name    signature
				(base + 1, 'breakpoint', 'arm_syscall', ()),
				(base + 2, 'cacheflush', 'arm_syscall', ('unsigned long start', 'unsigned long end', 'int flags')),
				(base + 3, 'usr26'     , 'arm_syscall', ()),
				(base + 4, 'usr32'     , 'arm_syscall', ()),
				(base + 5, 'set_tls'   , 'arm_syscall', ('unsigned long val',)),
			)),
			((4,15), VERSION_INF, (
				(base + 6, 'get_tls'   , 'arm_syscall', ()),
			)),
		))

	@staticmethod
	def match(vmlinux: ELF) -> Optional[Tuple[Type['Arch'],bool,List[str]]]:
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

		# Just prefer symbols starting with the classic "sys_"
		return a if a.name.startswith('sys_') else b

	def translate_syscall_symbol_name(self, sym_name: str) -> str:
		sym_name = super().translate_syscall_symbol_name(sym_name)
		# For some reason some syscalls are wrapped in assembly at the entry
		# point e.g. sys_sigreturn_wrapper v5.18 arch/arm/kernel/entry-common.S.
		# Stripping the "_wrapper" suffix can help locate them through source
		# code grepping.
		return nosuffix(sym_name, '_wrapper')

	def normalize_syscall_name(self, name: str) -> str:
		name = super().normalize_syscall_name(name)
		if self.abi == 'oabi':
			# E.g. v5.18 asmlinkage long sys_oabi_connect(...)
			name = noprefix(name, 'oabi_')
		# E.g. v5.18 asmlinkage long sys_arm_fadvise64_64(...)
		return noprefix(name, 'arm_')

class ArchArm64(Arch):
	# NOTE: this arch only exists since kernel v3.7
	name = 'arm64'

	syscall_num_reg = 'w8'
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

	def __init__(self, *a, **kwa):
		super().__init__(*a, **kwa)
		assert not self.bits32

		if self.abi == 'aarch32':
			self.compat = True
			self.syscall_table_name = 'compat_sys_call_table'

	@staticmethod
	def match(vmlinux: ELF) -> Optional[Tuple[Type['Arch'],bool,List[str]]]:
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
		return a if a.name.startswith('__arm64_') else b

	def normalize_syscall_name(self, name: str) -> str:
		name = super().normalize_syscall_name(name)
		# E.g. v5.18 COMPAT_SYSCALL_DEFINE6(aarch32_mmap2, ...)
		return noprefix(name, 'aarch32_')

class ArchMips(Arch):
	name = 'mips'
	syscall_num_reg = 'v0'

	kconfig = VersionedDict((
		# kexec[_file]_load
		((2,6,20)    , (3,9)      , 'KEXEC=y'  , ['EXPERIMENTAL=y']),
		((3,9)       , VERSION_INF, 'KEXEC=y'  , []),
		# seccomp
		((2,6,15)    , (5,10)     , 'SECCOMP=y', []),
		# mbind, migrate_pages, {get,set}_mempolicy
		(VERSION_ZERO, VERSION_INF, 'NUMA=y'   , ['SYS_SUPPORTS_NUMA=y'])
	))

	def __init__(self, *a, **kwa):
		super().__init__(*a, **kwa)
		assert self.abi in ('o32', 'n32', 'n64')

		if self.abi == 'o32':
			self.syscall_num_base = 4000
			# TODO: man 2 syscall states: "The mips/o32 system call convention
			# passes arguments 5 through 8 on the user stack"... which syscall
			# takes 8 arguments on MIPS o32? WTF.
			self.syscall_arg_regs = ('a0', 'a1', 'a2', 'a3', 'stack', 'stack', 'stack', 'stack')

			if not self.bits32:
				self.syscall_table_name = 'sys32_call_table'
		else:
			self.syscall_arg_regs = ('a0', 'a1', 'a2', 'a3', 'a4', 'a5')

			if self.abi == 'n64':
				self.syscall_num_base = 5000
			else: # n32
				self.syscall_num_base = 6000
				self.syscall_table_name = 'sysn32_call_table'

		# Select CPU type and kernel bits. These config options are a multiple
		# choice menu, so better set all of them just to be sure.
		# TODO: Does CPU release selection matter? Just select the most generic.
		if self.bits32:
			# MIPS 32bit means o32 ABI.
			assert self.abi == 'o32'

			self.kconfig.add(VERSION_ZERO, VERSION_INF, '32BIT=y'        , [])
			self.kconfig.add(VERSION_ZERO, VERSION_INF, '64BIT=n'        , [])
			self.kconfig.add((2,6,15)    , VERSION_INF, 'CPU_MIPS32_R1=y', ['SYS_HAS_CPU_MIPS32_R1=y'])
			self.kconfig.add((2,6,15)    , VERSION_INF, 'CPU_MIPS32_R2=n', [])
			self.kconfig.add((4,0)       , VERSION_INF, 'CPU_MIPS32_R6=n', [])
		else:
			self.compat = self.abi != 'n64'

			self.kconfig.add(VERSION_ZERO, VERSION_INF, '32BIT=n'        , [])
			self.kconfig.add(VERSION_ZERO, VERSION_INF, '64BIT=y'        , [])
			self.kconfig.add((2,6,15)    , VERSION_INF, 'CPU_MIPS64_R1=y', ['SYS_HAS_CPU_MIPS64_R1=y'])
			self.kconfig.add((2,6,15)    , VERSION_INF, 'CPU_MIPS64_R2=n', [])
			self.kconfig.add((4,0)       , VERSION_INF, 'CPU_MIPS64_R6=n', [])

			# MIPS 64bit supports all ABIs: 32bit o32, 64bit n32, 64bit n64.
			# Enable all of them regardless, we will be able to extract the
			# right syscall table anyway.
			self.kconfig.add(VERSION_ZERO, VERSION_INF, 'MIPS32_O32=y', [])
			self.kconfig.add(VERSION_ZERO, VERSION_INF, 'MIPS32_N32=y', [])

	@staticmethod
	def match(vmlinux: ELF) -> Optional[Tuple[Type['Arch'],bool,List[str]]]:
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

		# Just prefer symbols starting with the classic "sys_"
		return a if a.name.startswith('sys_') else b

	def normalize_syscall_name(self, name: str) -> str:
		name = super().normalize_syscall_name(name)
		# E.g. v5.1 asmlinkage int sysm_pipe(void) for weird historical reasons
		# E.g. v5.18 SYSCALL_DEFINE6(mips_mmap, ...)
		return noprefix(name, 'sysm_', 'mips_')

# TODO PA-RISC: {alloc,free}_hugepages only exist for this arch
# TODO Xtensa: FAST_SYSCALL_XTENSA, FAST_SYSCALL_SPILL_REGISTERS

ARCH_CLASSES = [ArchX86, ArchArm, ArchArm64, ArchMips]
