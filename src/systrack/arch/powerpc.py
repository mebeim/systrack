from struct import iter_unpack
from typing import Tuple, List, Type, Optional
from operator import itemgetter

from ..elf import Symbol, ELF, E_MACHINE
from ..kconfig_options import VERSION_ZERO, VERSION_INF
from ..syscall import Syscall
from ..type_hints import KernelVersion, EsotericSyscall
from ..utils import VersionedDict, noprefix

from .arch_base import Arch

class ArchPowerPC(Arch):
	name = 'powerpc'
	syscall_num_base = 0
	syscall_num_reg = 'r0'

	# NOTE: We treat "SPU" as an ABI, even though it's not a real ABI. It stands
	# for "Synergistic Processor Unit", one of the CPUs composing a Cell
	# processor: https://en.wikipedia.org/wiki/Cell_(processor). SPUs are quite
	# peculiar: as the comment in arch/powerpc/platforms/cell/spu_callbacks.c
	# (v5.0) explains, they can only use a subset of the syscalls defined for
	# the "64" ABI.

	# NOTE: we are assuming to have PPC_BOOK3S=y (and therefore PPC_BOOK3S_32=y
	# for 32-bit or PPC_BOOK3S_64=y for 64-bit)
	kconfig = VersionedDict((
		# These are needed for RELOCATABLE=n, we do not really need to list
		# dependencies since we are disabling them.
		((2,6,30)    , VERSION_INF, 'PPC_OF_BOOT_TRAMPOLINE=n', []),
		((2,6,16)    , (2,6,27)   , 'CRASH_DUMP=n'            , []),
		((2,6,27)    , VERSION_INF, 'CRASH_DUMP=n'            , []),
		((4,12)      , VERSION_INF, 'CRASH_DUMP=n'            , []),
		((3,4)       , VERSION_INF, 'FA_DUMP=n'               , []),
		# Needs to be set here too because arch-specific kconfigs are applied
		# after those listed in KCONFIG_DEBUGGING (kconfig_options.py)
		(VERSION_ZERO, VERSION_INF, 'RELOCATABLE=n', ['PPC_OF_BOOT_TRAMPOLINE=n', 'CRASH_DUMP=n', 'FA_DUMP=n']),
		# kexec_load
		((2,6,15)    , (3,9)      , 'KEXEC=y', ['PPC_BOOK3S=y', 'EXPERIMENTAL=y']),
		((3,9)       , VERSION_INF, 'KEXEC=y', ['PPC_BOOK3S=y']),
		# seccomp
		((2,6,15)    , (5,10)     , 'SECCOMP=y', ['PROC_FS=y']),
		# rtas
		((2,6,15)    , VERSION_INF, 'PPC_RTAS=y', []),
	))

	# FIXME: more like a curiosity, but why the hell do migrate_pages and
	# move_pages look like they depend on MIGRATION and not necessarily on NUMA,
	# but then aren't available for PPC 32-bit which has NUMA=n???

	kconfig_syscall_deps = VersionedDict((
		(VERSION_ZERO, VERSION_INF, 'pkey_alloc'   , 'PPC_MEM_KEYS'),
		(VERSION_ZERO, VERSION_INF, 'pkey_free'    , 'PPC_MEM_KEYS'),
		(VERSION_ZERO, VERSION_INF, 'pkey_mprotect', 'PPC_MEM_KEYS'),
	))

	def __init__(self, kernel_version: KernelVersion, abi: str, bits32: bool = False):
		super().__init__(kernel_version, abi, bits32)
		assert self.abi in ('ppc32', 'ppc64', 'spu')

		# The "powerpc" directory was added under arch in v2.6.15 and it weirdly
		# coexisted with "ppc" until v2.6.27, when the latter was removed.
		assert self.kernel_version >= (2,6,15), 'kernel too old, sorry!'

		if self.abi == 'spu':
			# spu_syscall_table only exists since v2.6.16, I have no idea how
			# things were handled before then. This is a rather old kernel
			# version, we'll worry about it in the future (if ever).
			assert self.kernel_version >= (2,6,16), 'kernel too old, sorry!'

		if self.abi == 'ppc32':
			self.syscall_arg_regs = ('r3', 'r4', 'r5', 'r6', 'r7', 'r8', 'r9')
			self.abi_bits32 = True
		else:
			self.syscall_arg_regs = ('r3', 'r4', 'r5', 'r6', 'r7', 'r8')
			self.abi_bits32 = False

		if self.bits32:
			self.compat = False
			self.uses_function_descriptors = False
			self.syscall_table_name = 'sys_call_table'

			# PPC_BOOK3S_32 was introduced in v2.6.31. We'll worry about
			# older kernels in the future (if ever).
			assert self.kernel_version >= (2,6,31), 'kernel too old, sorry!'

			# Apparently there isn't a nice 32-bit defconfig and one needs
			# to manually disable 64-bit??? What in tarnation >:( lame!
			# There's ppc_defconfig from v5.2, which also takes half the time to
			# build so it'd be nice to use... but using it as is without tweaks
			# compiles a kernel without memfd_create.
			self.config_target = 'ppc64_defconfig'
			self.kconfig.add(VERSION_ZERO, VERSION_INF, 'PPC64=n', [])
			self.kconfig.add(VERSION_ZERO, VERSION_INF, 'PPC_BOOK3S_32=y', [])
		else:
			self.compat = self.abi != 'ppc64'
			self.abi_bits32 = self.abi == 'ppc32'
			self.config_target = 'ppc64_defconfig'
			self.uses_function_descriptors = True

			if self.abi == 'spu':
				self.syscall_table_name = 'spu_syscall_table'
			elif self.abi == 'ppc32' and self.kernel_version >= (5,0):
				# 32-bit and 64-bit syscalls before v5.0 share the same table
				# (see skip_syscall() below), they are split in two tables only
				# from v5.0.
				self.syscall_table_name = 'compat_sys_call_table'

			# PowerPC64 supports all ABIs: 64, 32, "spu". Enable all of them, we
			# will be able to extract the right syscall table regardless.
			self.kconfig.add((2,6,15), (5,7)      , 'COMPAT=y', ['PPC64=y'])
			self.kconfig.add((5,7)   , VERSION_INF, 'COMPAT=y', ['PPC64=y', 'CPU_LITTLE_ENDIAN=n', 'CC_IS_CLANG=n'])

			# Needed for NUMA=y
			self.kconfig.add((2,6,15), (2,6,22)   , 'PPC_PSERIES=y', ['PPC64=y', 'PPC_MULTIPLATFORM=y']),
			self.kconfig.add((2,6,22), VERSION_INF, 'PPC_PSERIES=y', ['PPC64=y', 'PPC_BOOK3S=y']),
			# mbind, migrate_pages, {get,set}_mempolicy
			#   NOTE: in theory depends on (PPC_PSERIES || PPC_POWERNV) after
			#   5.10, but we are assuming PPC_PSERIES=y
			self.kconfig.add((2,6,15), VERSION_INF, 'NUMA=y', ['PPC64=y', 'SMP=y', 'PPC_PSERIES=y'])
			# kexec_file_load
			self.kconfig.add((4,10)  , VERSION_INF, 'KEXEC_FILE=y', ['PPC64=y', 'CRYPTO=y', 'CRYPTO_SHA256=y'])
			# Needed for PPC_SUBPAGE_PROT=y
			#   NOTE: in theory depends on (44x || PPC_BOOK3S_64), but we are
			#   assuming PPC_BOOK3S_64=y
			self.kconfig.add((2,6,15), VERSION_INF, 'PPC_64K_PAGES=y', ['PPC_BOOK3S_64=y'])
			# subpage_prot (ppc only, 64-bit only)
			self.kconfig.add((2,6,25), (5,9)      , 'PPC_SUBPAGE_PROT=y', ['PPC_64K_PAGES=y', 'PPC_BOOK3S_64=y'])
			self.kconfig.add((5,9)   , VERSION_INF, 'PPC_SUBPAGE_PROT=y', ['PPC_64K_PAGES=y', 'PPC_64S_HASH_MMU=y'])
			# pkey_alloc, pkey_free, pkey_mprotect
			self.kconfig.add((4,16)  , VERSION_INF, 'PPC_MEM_KEYS=y', ['PPC_BOOK3S_64=y', 'PPC_64S_HASH_MMU=y'])
			# switch_endian (esoteric fast version)
			self.kconfig.add((4,15)  , VERSION_INF, 'PPC_FAST_ENDIAN_SWITCH=y', []),
			# spu_run, spu_create
			self.kconfig.add((2,6,16), VERSION_INF, 'SPU_FS=y'  , ['PPC_CELL=y', 'COREDUMP=y']),
			self.kconfig.add((2,6,18), VERSION_INF, 'SPU_BASE=y', []),

	@staticmethod
	def match(vmlinux: ELF) -> Optional[Tuple[Type[Arch],bool,List[str]]]:
		if vmlinux.e_machine == E_MACHINE.EM_PPC:
			assert vmlinux.bits32, 'EM_PPC 64-bit? WAT'
		elif vmlinux.e_machine == E_MACHINE.EM_PPC64:
			assert not vmlinux.bits32, 'EM_PPC64 32-bit? WAT'
		else:
			return None

		if vmlinux.bits32:
			abis = ['ppc32']
		else:
			abis = ['ppc64']

			# v5.0+ has a separate compat table and can be built with COMPAT=n.
			# Before v5.0 64-bit and 32-bit syscalls share a single table and
			# apparently it's always COMPAT=y. If none of these match, we must
			# be dealing with a v5.0+ COMPAT=n kernel, which is the only case
			# where there's no 32-bit syscall table.
			if 'compat_sys_call_table' in vmlinux.symbols \
					or 'compat_sys_execve' in vmlinux.symbols \
					or '.compat_sys_execve' in vmlinux.symbols:
				abis.append('ppc32')

			if 'spu_syscall_table' in vmlinux.symbols:
				abis.append('spu')

		return ArchPowerPC, vmlinux.bits32, abis

	def matches(self, vmlinux: ELF) -> bool:
		# Linux PPC 32-bit should be big-endian only
		assert vmlinux.big_endian, 'Little-endian PowerPC 32-bit kernel? WAT'
		return (
			vmlinux.e_machine == (E_MACHINE.EM_PPC64, E_MACHINE.EM_PPC)[self.bits32]
			and vmlinux.bits32 == self.bits32
		)

	def preferred_symbol(self, a: Symbol, b: Symbol) -> Symbol:
		if self.bits32:
			return super().preferred_symbol(a, b)

		# Function descriptors take the "nice" symbol name, while the actual
		# functions have a goofy dot prefix.
		adot = a.name.startswith('.')
		bdot = b.name.startswith('.')

		if adot or bdot:
			if not adot: return b
			if not bdot: return a
			if a.name.startswith('.sys_'): return a
			if b.name.startswith('.sys_'): return b
			return a if a.name.startswith('.compat_sys_') else b

		# Base method does not know about dotted symbols
		return super().preferred_symbol(a, b)

	def skip_syscall(self, sc: Syscall) -> bool:
		if self.bits32 or self.kernel_version >= (5,0):
			return False

		# On PowerPC 64-bit before v5.0, 64-bit and 32-bit syscalls are
		# *interleaved* in the same syscall table, with 64-bit syscalls at even
		# indexes. This means that we need to ignore half the syscall table! :')
		if self.abi == 'ppc32':
			return sc.index % 2 == 0
		# 'ppc64' or 'spu'
		return sc.index % 2 == 1

	def translate_syscall_symbol_name(self, sym_name: str) -> str:
		return super().translate_syscall_symbol_name(noprefix(sym_name, '.sys_', '.'))

	def _normalize_syscall_name(self, name: str) -> str:
		return noprefix(name, 'ppc64_', 'ppc32_', 'ppc_')

	def _dummy_syscall_code(self, sc: Syscall, vmlinux: ELF) -> Optional[bytes]:
		# Check for `li r3,-ENOSYS; blr` optionally accompained by some other
		# known non-branching instructions along the way:
		#
		#   - {mflr,mtlr} r0
		#   - {stw,std,lwz,ld} r0,X(r1)
		#   - matching stwu/stdu and addi on r1 (stack pointer)
		#   - bl (to call _mcount() or other func, which *has* to return)
		#   - nop (ori 0,0,0)
		#
		# TODO: relies on the symbol having a valid size (!= 0), improve?
		if sc.symbol.size < 8:
			return None

		code = vmlinux.read_symbol(sc.symbol)
		r1_dec = r1_inc = None
		insns = []

		for insn in map(itemgetter(0), iter_unpack('<>'[vmlinux.big_endian] + 'L', code)):
			hi = insn >> 16

			# mflr r0 / mtlr r0 / nop (ori 0,0,0)
			if insn in (0x7c0802a6, 0x7c0803a6, 0x60000000):
				continue
			# bl X
			if (hi >> 8) == 0x4b:
				continue
			# stw r0,X(r1) / std r0,X(r1) / lwz r0,X(r1) / ld r0,X(r1)
			if hi in (0x9001, 0xf801, 0xe801, 0x8001):
				continue
			# stdu r1,X(r1)
			if insn & 0xffff0003 == 0xf8210001:
				r1_dec = 0x10000 - (insn & 0xfffc)
				continue
			# stwu r1,X(r1)
			if hi in (0x9421, 0xf821):
				r1_dec = 0x10000 - (insn & 0xffff)
				continue
			# addi r1,r1,X (after stwu/stdu)
			if hi == 0x3821 and r1_dec is not None:
				r1_inc = insn & 0xffff
				continue

			if len(insns) > 2:
				return None

			insns.append(insn)

		# Stack pointer decrement/increment must match
		if (r1_dec is not None or r1_inc is not None) and r1_dec != r1_inc:
			return None

		# li r3,-ENOSYS; blr
		if insns == [0x3860ffda, 0x4e800020]:
			return code

		return None

	def adjust_syscall_number(self, number: int) -> int:
		if self.bits32 or self.kernel_version >= (5,0):
			return number

		# See comment in skip_syscall() above.
		return number // 2

	def extract_esoteric_syscalls(self, vmlinux: ELF) -> EsotericSyscall:
		# The switch_endian syscall has a "fast" version implemented with a
		# branch at syscall entry point (arch/powerpc/kernel/exceptions-64s.S).
		#
		# The symbol to look at is exc_real_0xc00_system_call, where we should
		# find `cmpdi r0,0x1ebe` followed by a `beq-` to code that updates the
		# saved LE bit in SRR1. The same code has been there since at least
		# v2.6.31.
		#
		#   2c 20 1e be     cmpdi    r0,7870
		#   41 c2 00 20     beq      X
		#   ...
		#   7d 9b 02 a6  X: mfsrr1   r12
		#   69 8c 00 01     xori     r12,r12,1
		#   7d 9b 03 a6     mtsrr1   r12
		#   4c 00 00 24     rfid
		#
		# This "fast" implementation depends on PPC_FAST_ENDIAN_SWITCH from
		# v4.15 onwards. Old kernels only had this fast version and no
		# switch_endian syscall in the syscall table, which was added in v4.1
		# (529d235a0e190ded1d21ccc80a73e625ebcad09b).
		#
		# FIXME: on older kernels (< v5.0) the associated syscall entry symbol
		# may be different.
		#
		if self.abi != 'ppc64':
			return []

		exc = vmlinux.symbols.get('exc_real_0xc00_system_call')
		if exc is None:
			return []

		# Unfortunately we cannot rely on the symbol having a good size, so just
		# find the next symbol after it and use it as a boundary.
		boundary = vmlinux.next_symbol(exc)
		boundary = boundary.vaddr if boundary else exc.vaddr + 0x80
		code     = vmlinux.vaddr_read(exc.vaddr, boundary - exc.vaddr)
		insns    = iter_unpack('<>'[vmlinux.big_endian] + 'L', code)
		insns    = list(map(itemgetter(0), insns))

		try:
			idx_cmpdi = insns.index(0x2c201ebe)
			beq = insns[idx_cmpdi + 1]
		except (IndexError, ValueError):
			return []

		idx_mfsrr1 = idx_cmpdi + 1	 + (beq & 0xffff) // 4
		if idx_mfsrr1 >= len(insns) or insns[idx_mfsrr1] != 0x7d9b02a6:
			return []

		# Match the branch after the cmpdi. Technically it should be a `beq-`
		# (beq with not taken branch prediction), but also accept others.
		#                      beq-    beq+    beq     beq
		if (beq >> 16) not in (0x41c2, 0x41e2, 0x4182, 0x41a2):
			return []

		try:
			idx_xori   = insns.index(0x698c0001, idx_mfsrr1 + 1)
			idx_mtsrr1 = insns.index(0x7d9b03a6, idx_xori + 1)
			insns.index(0x4c000024, idx_mtsrr1 + 1)
		except ValueError:
			return []

		# We have the syscall
		kconf = 'PPC_FAST_ENDIAN_SWITCH' if self.kernel_version >= (4,15) else None
		return [(0x1ebe, 'switch_endian', exc.name, (), kconf)]

	def syscall_def_regexp(self, syscall_name: Optional[str]=None) -> Optional[str]:
		if self.abi != 'ppc32':
			return None

		if syscall_name is not None:
			return rf'\bPPC32_SYSCALL_DEFINE\d\({syscall_name}'
		return r'\bPPC32_SYSCALL_DEFINE\d\s*\('
