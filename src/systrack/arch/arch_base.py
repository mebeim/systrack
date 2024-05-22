import logging

from abc import ABC, abstractmethod
from typing import Tuple, List, Dict, Type, Optional

from ..elf import Symbol, ELF
from ..syscall import Syscall
from ..type_hints import KernelVersion, EsotericSyscall
from ..utils import VersionedDict, anysuffix, noprefix, nosuffix

class Arch(ABC):
	# Directory name for this arch in the kernel source, under arch/
	name: str = None

	# Whether this arch is 32-bits or not
	bits32: bool = False

	# Selected ABI
	abi: str = None

	# Whether the selected ABI is 32-bits or not
	abi_bits32: bool = False

	# Whether this architecture makes use of function descriptors for function
	# pointers or not
	uses_function_descriptors: bool = False

	# Are we looking for compat syscalls (COMPACT_SYSCALL_DEFINEn)? Or, in other
	# words, is this not the "main" ABI of the kernel we're analyzing?
	compat: bool = False

	# Kernel version that we are intersted in analyzing
	kernel_version: KernelVersion = None

	# Make target to build for the base config
	config_target: str = 'defconfig'

	# Name of the syscall table symbol to look for
	syscall_table_name: Optional[str] = 'sys_call_table'

	# Base syscall number (actual syscall number is base + idx in syscall table)
	# NOTE: easiest way to check this is to just compile a binary that makes a
	# raw syscall for the right arch/ABI. The arch_syscall_addr() kernel
	# function can also be useful to inspect.
	syscall_num_base: int = 0

	# Syscall number destination (register name, None if no register is used,
	# e.g. arm/OABI where the instruction is swi <nr>). Subclasses must override
	# this.
	syscall_num_reg: str = None

	# Registers for syscall arguments. Subclasses must override this.
	syscall_arg_regs: Tuple[str, ...] = None

	# Additional kconfig options to set
	kconfig: VersionedDict = VersionedDict()

	# Arch-specific syscall kconfig options dependency (supersedes global
	# arch-agnostic KCONFIG_SYSCALL_DEPS (see the comment in kconfig_options.py
	# to know how to fill this)
	kconfig_syscall_deps: VersionedDict = VersionedDict()

	def __init__(self, kernel_version: KernelVersion, abi: str, bits32: bool):
		self.kernel_version = kernel_version
		self.bits32 = bits32
		self.abi = abi # ABI to inspect/build for

	def __repr__(s):
		return f'{s.__class__.__name__}(name={s.name!r}, abi={s.abi!r}, compat={s.compat!r}, ...)'

	# TODO: don't make this return the class too, it's redundant
	@staticmethod
	@abstractmethod
	def match(vmlinux: ELF) -> Optional[Tuple[Type['Arch'],bool,List[str]]]:
		'''Determine if the given vmlinux ELF was built for this architecture,
		and if so return the class itself, the bitness and a list of detected
		ABIs. This is useful to determine which Arch subclass to instantiate (if
		any).
		'''
		pass

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

	def preferred_symbol(self, a: Symbol, b: Symbol) -> Symbol:
		'''Decide which symbol should be preferred when multiple syscall symbols
		point to the same virtual address. By default, just prefer symbols with
		the classic "sys_" or "compat_sys_" prefix over anything else.
		Subclesses can override this to implement their own preferences.

		For example, on x86-64 with IA32 emulation support, __x64_sys_getpid and
		__ia32_sys_getpid point to the same vaddr. We prefer __x64_sys_getpid if
		we are inspecting the 64-bit syscall table, and __ia32_sys_getpid if we
		are inspecting the 32-bit one.

		This does not have any meaningful effect on the correctness of the
		output, since at the end of the day if multiple symbols point to the
		same vaddr, they are in fact the same function, and the location
		information will also be correct regardless of which one is picked.
		'''
		if a.name.startswith('sys_'): return a
		if b.name.startswith('sys_'): return b
		return a if a.name.startswith('compat_sys_') else b

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
			# Avoid ftrace-related symbols
			and not sym.name.startswith('_eil_addr_')
			# Avoid KCFI-related symbols
			and not sym.name.startswith('__cfi_')
			and not sym.name.startswith('__pfx_')
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
		return noprefix(sym_name, 'ptregs_sys_', 'ptregs_compat_sys_',
			'__se_compat_sys_', '__se_sys_', '__sys_', 'compat_sys_')

	def _normalize_syscall_name(self, name: str) -> str:
		'''Normalize a syscall name possibly stripping unneeded arch-specific
		prefixes/suffixes (e.g., "ia32_", "aarch32_", "oabi_", "ppc_" etc.).
		These are prefixes/suffixes that are ACTUALLY PRESENT IN THE SOURCE,
		and not just in the symbol name.
		'''
		return name

	def normalize_syscall_name(self, name: str) -> str:
		'''Normalize a syscall name removing unneeded prefixes and suffixes.
		These are prefixes/suffixes that are ACTUALLY PRESENT IN THE SOURCE,
		and not just in the symbol name.
		'''
		# NOTE: subclesses should NOT override this method and override
		# ._normalize_syscall_name() above instead, so that common prefixes are
		# always stripped first.

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
		name = noprefix(name, 'old_')
		return self._normalize_syscall_name(name)

	def _dummy_syscall_code(self, sc: Syscall, vmlinux: ELF) -> Optional[bytes]:
		'''Determine whether a syscall has a dummy implementation (e.g. one that
		only does `return -ENOSYS/-EINVAL`). If this is the case, return the
		machine code of the syscall, otherwise None.
		'''
		return None

	def is_dummy_syscall(self, sc: Syscall, vmlinux: ELF) -> bool:
		'''Determine whether a syscall has a dummy implementation (e.g. one that
		only does `return -ENOSYS/-EINVAL`).

		NOTE: this is just a wrapper around ._dummy_syscall_code() that also
		logs some useful info in case a dummy syscall is detected. Subclesses
		should only override ._dummy_syscall_code().
		'''
		code = self._dummy_syscall_code(sc, vmlinux)
		if code is None:
			return False

		logging.info('Syscall %s (%s) is not really implemented (dummy '
			'implementation), code: %s.', sc.name, sc.symbol.name, code.hex())
		return True

	def adjust_syscall_number(self, number: int) -> int:
		'''Adjust the number for the given syscall according to any
		arch-specific quirk there might be (e.g. PowerPC with its interleaved
		syscall numbers).
		'''
		return number

	def extract_syscall_vaddrs(self, vmlinux: ELF) -> Dict[int,int]:
		'''Extract virtual addresses of syscall functions. Implemented in case
		this isn't just as simple as looking at the addresses in the syscall
		table (e.g., there might not be one to begin with).
		'''
		logging.error("Sorry, don't know how to extract syscall vaddrs for this arch!")
		return {}

	def extract_esoteric_syscalls(self, vmlinux: ELF) -> EsotericSyscall:
		'''Extract weird arch-specific syscalls not in the syscall table: there
		isn't much else to do except either manually list these (if they are
		always present) or perform static binary analysis.

		The returned value is a list of tuples of the form: (number, name,
		symbol_name, signature, kconfig_opts).

		NOTE: the symbol_name that is returned needs to exist in the given
		vmlinux.
		'''
		return []

	def syscall_def_regexp(self, syscall_name: Optional[str]=None) -> Optional[str]:
		'''Return a regexp capable of matching syscall definitions using
		arch-specific SYSCALL_DEFINEx macros with weird names. If syscall_name
		is given, return a regexp to match this syscall definition exactly,
		otherwise just a generic one.

		With syscall_name: the returned regexp should match a macro call up to
		and including the syscall name, e.g., "SYSCALL_DEFINE3(name".

		Without syscall_name: the returned regexp should match the macro call up
		to and including the first open parenthesis, e.g., "SYSCALL_DEFINE3(".
		'''
		return None
