import logging
from collections import defaultdict
from operator import itemgetter
from typing import Tuple, List, Dict, DefaultDict, Set, Type, Optional

from iced_x86 import Decoder, Instruction
from iced_x86.Mnemonic import Mnemonic, RET, CMP, TEST, JA, JAE, JB, JBE, JE, JNE
from iced_x86.OpKind import REGISTER

from ..elf import Symbol, ELF, E_MACHINE
from ..kconfig_options import VERSION_ZERO, VERSION_INF
from ..syscall import Syscall
from ..type_hints import KernelVersion
from ..utils import VersionedDict, noprefix

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
		((4,3)   , VERSION_INF, 'MODIFY_LDT_SYSCALL=y', []),
	))

	kconfig_syscall_deps = VersionedDict((
		(VERSION_ZERO, VERSION_INF, 'pkey_alloc'   , 'X86_INTEL_MEMORY_PROTECTION_KEYS'),
		(VERSION_ZERO, VERSION_INF, 'pkey_free'    , 'X86_INTEL_MEMORY_PROTECTION_KEYS'),
		(VERSION_ZERO, VERSION_INF, 'pkey_mprotect', 'X86_INTEL_MEMORY_PROTECTION_KEYS'),
	))

	# Numbers marked as "64" in syscall_64.tbl before v5.4 (when x64 and x32
	# still shared the same table), which should therefore NOT be used in x32
	# mode. These also include the (lower) x64 numbers for the misnumbered
	# 512-547 syscalls.
	#
	#     cat arch/x86/entry/syscalls/syscall_64.tbl | rg '\t64' | cut -f1
	#
	__bad_x32_numbers = {
		13, 15, 16, 19, 20, 45, 46, 47, 54, 55, 59, 101, 127, 128, 129, 131,
		134, 156, 174, 177, 178, 180, 205, 206, 209, 211, 214, 215, 222, 236,
		244, 246, 247, 273, 274, 278, 279, 295, 296, 297, 299, 307, 310, 311,
		322, 327, 328
	}

	def __init__(self, kernel_version: KernelVersion, abi: str, bits32: bool = False):
		super().__init__(kernel_version, abi, bits32)
		assert self.abi in ('x64', 'ia32', 'x32')

		# i386_defconfig and x86_64_defconfig don't exist before v2.6.24: need
		# a different configuration in such case. We'll think about it when (if)
		# we ever get to supporting such old kernels. Additionally, there were
		# two directories under arch before v2.6.24 ("i386" and "x86_64"), so
		# self.name should reflect that too too.
		assert self.kernel_version >= (2,6,24), 'kernel too old, sorry!'

		# Syscall tables are no longer guaranteed to exists since v6.9
		# (see commit 1e3ad78334a69b36e107232e337f9d693dcc9df2). We will
		# determine later in adjust_abi() if we actually have a table for the
		# selected ABI (in case of FTRACE_SYSCALLS=y we may have one).
		if self.kernel_version < (6,9):
			self.syscall_table_name = 'sys_call_table'

			if not self.bits32:
				if self.abi == 'ia32':
					self.syscall_table_name = 'ia32_sys_call_table'
				elif self.abi == 'x32' and self.kernel_version >= (5,4):
					self.syscall_table_name = 'x32_sys_call_table'
		else:
			self.syscall_table_name = None

		if self.abi == 'ia32':
			self.syscall_num_reg  = 'eax'
			self.syscall_arg_regs = ('ebx', 'ecx', 'edx', 'esi', 'edi', 'ebp')
		else:
			self.syscall_num_reg  = 'rax'
			self.syscall_arg_regs = ('rdi', 'rsi', 'rdx', 'r10', 'r8', 'r9')

		if self.bits32:
			assert self.abi == 'ia32'
			self.abi_bits32    = True
			self.config_target = 'i386_defconfig'

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

			if self.abi == 'x32':
				# x32 syscalls have this bit set (__X32_SYSCALL_BIT)
				self.syscall_num_base = 0x40000000

			# x86-64 supports all ABIs: ia32, x64, x32. Enable all of them, we
			# will be able to extract the right syscall table regardless.
			self.kconfig.add(VERSION_ZERO, VERSION_INF, 'IA32_EMULATION=y', [])
			self.kconfig.add((3,4)       , (3,9)      , 'X86_X32=y'       , ['EXPERIMENTAL=y'])
			self.kconfig.add((3,9)       , (5,18)     , 'X86_X32=y'       , [])
			self.kconfig.add((5,18)      , VERSION_INF, 'X86_X32_ABI=y'   , [])

			# kexec_file_load
			self.kconfig.add((3,17)      , VERSION_INF, 'KEXEC_FILE=y', ['X86_64=y', 'CRYPTO=y', 'CRYPTO_SHA256=y'])
			# mbind, migrate_pages, {get,set}_mempolicy
			self.kconfig.add(VERSION_ZERO, (2,6,15)   , 'NUMA=y', [])
			self.kconfig.add((2,6,15)    , (2,6,29)   , 'NUMA=y', ['SMP=y'])
			self.kconfig.add((2,6,29)    , VERSION_INF, 'NUMA=y', ['SMP=y'])
			# pkey_alloc, pkey_free, pkey_mprotect
			#   NOTE: in theory depends on (CPU_SUP_INTEL || CPU_SUP_AMD) but we
			#   are pretty sure that CPU_SUP_INTEL will be =y
			self.kconfig.add((4,6)       , VERSION_INF, 'X86_INTEL_MEMORY_PROTECTION_KEYS=y', ['X86_64=y', 'CPU_SUP_INTEL=y'])
			# map_shadow_stack
			#   NOTE: depends on assembler support for WRUSS instruction
			#   (GNU binutils >= 2.31)
			self.kconfig.add((6,6)       , VERSION_INF, 'X86_USER_SHADOW_STACK=y', ['AS_WRUSS=y'])

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
			elif 'ia32_sys_call' in vmlinux.symbols:
				# Since v6.9 no more tables, but we have this function instead
				abis.append('ia32')

			if 'x32_sys_call_table' in vmlinux.symbols:
				abis.append('x32')
			elif 'x32_sys_call' in vmlinux.symbols:
				# Since v6.9 no more tables, but we have this function instead
				abis.append('x32')
			elif any('x32_compat_sys' in s for s in vmlinux.symbols):
				# Before v5.4 x32 did NOT have its own table
				abis.append('x32')

		return ArchX86, vmlinux.bits32, abis

	def matches(self, vmlinux: ELF) -> bool:
		return (
			vmlinux.e_machine == (E_MACHINE.EM_X86_64, E_MACHINE.EM_386)[self.bits32]
			and vmlinux.bits32 == self.bits32
		)

	def adjust_abi(self, vmlinux: ELF):
		if self.kernel_version < (6,9):
			return

		# Figure out if we have a syscall table (FTRACE_SYSCALLS=y) or not. The
		# sys_call_table symbol represents the x64 table for 64-bit and the ia32
		# table for 32-bit. There is no ia32 nor x32 table for 64-bit kernels.
		if 'sys_call_table' in vmlinux.symbols and not self.compat:
			self.syscall_table_name = 'sys_call_table'

	__is_ia32_name = staticmethod(lambda n: n.startswith('__ia32_')) # __ia32_[compat_]sys_xxx
	__is_x64_name  = staticmethod(lambda n: n.startswith('__x64_'))  # __x64_[compat_]sys_xxx
	__is_x32_name  = staticmethod(lambda n: n.startswith('__x32_'))  # __x32_compat_sys_xxx

	def preferred_symbol(self, a: Symbol, b: Symbol) -> Symbol:
		# Try preferring the symbol with the right ABI in its prefix.
		na, nb = a.name, b.name

		if self.abi == 'ia32':
			if self.__is_ia32_name(na): return a
			if self.__is_ia32_name(nb): return b
			if self.__is_x64_name(na): return a
			if self.__is_x64_name(nb): return b
			if not na.islower(): return b
			if not nb.islower(): return a
			return super().preferred_symbol(a, b)

		if self.abi == 'x32':
			if self.__is_x32_name(na): return a
			if self.__is_x32_name(nb): return b

		if self.__is_x64_name(na): return a
		if self.__is_x64_name(nb): return b
		if self.__is_ia32_name(na): return b
		if self.__is_ia32_name(nb): return a
		if not na.islower(): return b
		if not nb.islower(): return a
		return super().preferred_symbol(a, b)

	def skip_syscall(self, sc: Syscall) -> bool:
		# Syscalls 512 through 547 are historically misnumbered and x32 only,
		# see comment in v5.10 arch/x86/entry/syscalls/syscall_64.tbl.
		#
		# x32 should only use the x32 numbers (512-547) ORed with the special
		# __X32_SYSCALL_BIT, and NOT the x64 numbers for the same syscalls.
		# x64 should use the x64 numbers and NOT the x32 numbers (512-547) for
		# the same syscalls.
		#
		# The checks performed by the kernel (mostly in do_syscall_64() under
		# arch/x86/entry/common.c) however are completely idiotic, and the fact
		# that before v5.4 there is only one syscall table for both x64 and x32
		# does not help: this makes it technically possible to mix up the
		# numbers in funny ways.
		#
		# In fact, in v5.3, execve can be called using *four* different numbers
		# from both x64 and x32 mode (determining which number/mode combination
		# will result in rax=-EFAULT is left as an exercise to the reader):
		#
		#   1. 0x3b      : the x64 number
		#                  (techincally only correct for x64 mode)
		#   2. 0x208     : the x32 number without __X32_SYSCALL_BIT set
		#                  (techincally incorrect in both modes)
		#   3. 0x4000003b: the x64 number with __X32_SYSCALL_BIT set
		#                  (techincally incorrect in both modes)
		#   4. 0x40000208: the x32 number with __X32_SYSCALL_BIT set
		#                  (techincally only correct for x32 mode)
		#
		# In v5.4 (commit 6365b842aae4490ebfafadfc6bb27a6d3cc54757) a separate
		# x32 syscall table was introduced to try and make things less
		# confusing. After this commit, options 2 and 3 above give -ENOSYS,
		# while 1 and 4 both work (again, try to guess which number/mode combo
		# will result in rax=-EFAULT).
		#
		if self.abi == 'x64' and 512 <= sc.number <= 547:
			# x64 cannot use x32 numbers even though they are in the table
			return True

		if self.abi == 'x32':
			if self.kernel_version >= (5,4):
				# We have our own table, anything we find there is acceptable
				return False

			if (sc.number & ~0x40000000) in self.__bad_x32_numbers:
				# x32 should NOT use these!
				return True

		if self.abi == 'ia32':
			# vm86 and vm86old are only available in 32-bit kernels, but might
			# still be implemented as simple wrappers that print a warning to
			# dmesg and return -ENOSYS in 64-bit kernels, so ignore them
			if not self.bits32 and sc.number in (113, 166):
				return True

			# pkey_{alloc,free,mprotect} are available for compat ia32 on
			# 64-bit, but not for 32-bit kernels (on x86 they depend X86_64=y),
			# so avoid wasting time with these
			if self.bits32 and sc.number in (380, 381, 382):
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

	def _normalize_syscall_name(self, name: str) -> str:
		# E.g. v5.18 COMPAT_SYSCALL_DEFINE1(ia32_mmap, ...)
		return noprefix(name, 'ia32_', 'x86_', 'x32_')

	def _dummy_syscall_code(self, sc: Syscall, vmlinux: ELF) -> Optional[bytes]:
		# Check if the code of the syscall only consists of
		# `MOV rax/eax, -ENOSYS/-EINVAL` followed by a RET or relative JMP and
		# optionally preceded by an ENDBR64/32. E.G., lookup_dcookie in v6.3:
		#
		# <__x64_sys_lookup_dcookie>:
		#        f3 0f 1e fa             endbr64
		#        48 c7 c0 da ff ff ff    mov    rax,0xffffffffffffffda
		#        e9 74 8d 90 00          jmp    ffffffff819b8b84 <__x86_return_thunk>
		#
		# TODO: relies on the symbol having a valid size (!= 0), improve?
		sz = sc.symbol.size
		if sz < 6 or sz > 16:
			return None

		orig = code = vmlinux.read_symbol(sc.symbol)
		bad_imm = (b'\xda\xff\xff\xff', b'\xea\xff\xff\xff')

		# endbr64/endbr32
		if code.startswith(b'\xf3\x0f\x1e\xfa') or code.startswith(b'\xf3\x0f\x1e\xfb'):
			code = code[4:]
			sz -= 4

		# 32-bit kernel
		if code[:1] == b'\xb8' and code[1:5] in bad_imm: # mov eax, -ENOSYS/-EINVAL
			if sz == 6  and code[5] == 0xc3: return orig # ret
			if sz == 7  and code[5] == 0xeb: return orig # jmp rel8
			if sz == 10 and code[5] == 0xe9: return orig # jmp rel32

		# 64-bit kernel
		if code[:3] == b'\x48\xc7\xc0' and code[3:7] in bad_imm: # mov rax, -ENOSYS/-EINVAL
			if sz == 8  and code[7] == 0xc3: return orig # ret
			if sz == 9  and code[7] == 0xeb: return orig # jmp rel8
			if sz == 12 and code[7] == 0xe9: return orig # jmp rel32

		return None

	def __emulate_syscall_switch(self, func: Symbol, func_code: bytes) -> Optional[Tuple[DefaultDict[int,Set[int]],Set[Instruction]]]:
		start = func.real_vaddr
		end   = func.real_vaddr + func.size
		insns = list(Decoder(32 if self.bits32 else 64, func_code, ip=start))

		# Register used to hold syscall number
		nr_reg = None

		# Assume first compared register holds syscall number
		for insn in insns:
			if insn.op_code().mnemonic in (CMP, TEST):
				for i in range(insn.op_count):
					if insn.op_kind(i) == REGISTER:
						nr_reg = insn.op_register(i)
						break

				if nr_reg is not None:
					break

		if nr_reg is None:
			logging.error('Could not find syscall number register')
			return None

		# Supported Jcc instructions
		jccs = {JA, JAE, JB, JBE, JE, JNE}
		# Maximum syscall number supported plus 1
		nr_max = 0x1000
		# Possible syscall numbers at a given address (instruction pointer)
		nrs: DefaultDict[int,Set[int]] = defaultdict(set, {start: set(range(nr_max))})
		# Candidate branches to syscall functions
		candidate_insns: Set[Instruction] = set()
		# Accumulate non-NOP skipped insns for logging/debugging purposes
		skipped_insns: DefaultDict[Instruction,int] = defaultdict(int)

		keep_going = True
		iteration = 0

		# Symbolically trace the function code to determine the possible syscall
		# numbers and the instructions that lead to them
		while keep_going:
			iteration += 1
			keep_going = False

			invert_condition = False
			mnemonic: Optional[Mnemonic] = None
			last_cmp_immediate: Optional[int] = None

			for insn in insns:
				ip            = insn.ip
				next_ip       = insn.next_ip
				prev_mnemonic = mnemonic
				mnemonic      = insn.op_code().mnemonic
				cur_nrs       = nrs[ip]

				# Only support a TEST that appears right before JE/JNE, which is
				# functionally to a CMP with 0.
				if prev_mnemonic == TEST and mnemonic not in (JE, JNE):
					logging.error('Unsupported instruction after TEST: %#x: %r', ip, insn)
					return None

				if mnemonic == RET:
					continue

				if mnemonic == TEST:
					if insn.op0_kind != REGISTER or insn.op1_kind != REGISTER:
						logging.error('Unsupported TEST instruction %#x: %r', ip, insn)
						return None

					# Treat `TEST reg, reg` as `CMP reg, 0`. We make sure that this
					# is the only possible case above.
					last_cmp_immediate = 0
					nrs[next_ip] |= cur_nrs
					continue

				if mnemonic == CMP:
					if insn.op0_kind == REGISTER:
						reg = insn.op0_register
						imm_op_idx = 1
						invert_condition = False
					elif insn.op1_kind == REGISTER:
						reg = insn.op1_register
						imm_op_idx = 0
						invert_condition = True
					else:
						# Should not happen, but guard against it anyway.
						imm_op_idx = None

					try:
						last_cmp_immediate = insn.immediate(imm_op_idx)
					except (ValueError, TypeError):
						logging.error('Unsupported CMP instruction %#x: %r', ip, insn)
						return None

					if reg != nr_reg:
						logging.error('Unexpected register in CMP instruction '
							'%#x: %r', ip, insn)
						return None

					nrs[next_ip] |= cur_nrs
					continue

				new_taken_nrs = frozenset()
				new_not_taken_nrs = frozenset()

				if insn.is_jmp_short_or_near:
					target_ip = insn.near_branch_target
					new_taken_nrs = cur_nrs
				elif insn.is_jcc_short_or_near:
					if mnemonic not in jccs:
						logging.error('Unsupported Jcc instruction %#x: %r', ip, insn)
						return None
					if last_cmp_immediate is None:
						logging.error('No previous CMP/TEST instruction for Jcc: '
							'%#x: %r', ip, insn)
						return None

					target_ip = insn.near_branch_target

					if mnemonic == JA:
						taken_filter = set(range(last_cmp_immediate + 1, nr_max))
					elif mnemonic == JAE:
						taken_filter = set(range(last_cmp_immediate, nr_max))
					elif mnemonic == JB:
						taken_filter = set(range(last_cmp_immediate))
					elif mnemonic == JBE:
						taken_filter = set(range(last_cmp_immediate + 1))
					elif mnemonic == JE:
						taken_filter = {last_cmp_immediate}
					elif mnemonic == JNE:
						taken_filter = set(range(0, last_cmp_immediate))
						taken_filter |= set(range(last_cmp_immediate + 1, nr_max))

					new_taken_nrs = cur_nrs & taken_filter
					new_not_taken_nrs = cur_nrs - taken_filter

					if invert_condition:
						new_taken_nrs, new_not_taken_nrs = new_not_taken_nrs, new_taken_nrs
				elif insn.is_call_near:
					target_ip = insn.near_branch_target
					if start <= target_ip < end:
						logging.error('%s calling itself??? %r', func.name, insn)
						return None
				else:
					if iteration == 1 and not insn.op_code().is_nop:
						skipped_insns[insn] += 1

					# YOLO
					nrs[next_ip] |= cur_nrs
					continue

				# We get here for JMP, Jcc and CALL near
				if start <= target_ip < end:
					# Branch target inside function
					if target_ip < ip:
						# Backward branch: new numbers may be added to the
						# target instruction, but we are already past it. In
						# such case, we'll need an additional iteration to
						# propagate the information.
						if not new_taken_nrs.issubset(nrs[target_ip]):
							keep_going = True
				else:
					# Branch target outside function, assume it's a branch to a
					# syscall function
					candidate_insns.add(insn)

				nrs[target_ip] |= new_taken_nrs
				nrs[next_ip] |= new_not_taken_nrs

		logging.info('Symbolic emulation done in %d iteration%s', iteration,
			's'[:iteration ^ 1])

		if skipped_insns:
			n_skipped = sum(skipped_insns.values())
			skipped = sorted(skipped_insns.items(), key=itemgetter(1, 0), reverse=True)
			skipped = '; '.join((f'{i:r} (x{n})' for i, n in skipped))
			logging.debug('Skipped %d instruction%s: %s', n_skipped,
				's'[:n_skipped ^ 1], skipped)

		return nrs, candidate_insns

	def extract_syscall_vaddrs(self, vmlinux: ELF) -> Dict[int,int]:
		# We need to go through a painful examination of the switch statement
		# implemented by {x64,x32,ia32}_sys_call():
		#
		#    #define __SYSCALL(nr, sym) case nr: return __x64_##sym(regs);
		#
		#    long x64_sys_call(const struct pt_regs *regs, unsigned int nr)
		#    {
		#        switch (nr) {
		#        #include <asm/syscalls_64.h>
		#        default: return __x64_sys_ni_syscall(regs);
		#        }
		#    }
		#
		# The switch statement on the second argument is implemented as a binary
		# search. Therefore, the generated instructions should simply be a bunch
		# of CMP/Jcc/JMP. No other implementation is supported right now.
		#
		assert self.syscall_table_name is None

		func_name = f'{self.abi}_sys_call'
		sym = vmlinux.functions.get(func_name)
		if sym is None:
			logging.error('Could not find function %s', func_name)
			return {}

		if sym.size < 0x10:
			logging.error('%s is too small (%d bytes)', sym.name, sym.size)
			return {}

		logging.info('Extracting syscalls from code of %s() at %#x', sym.name,
			sym.real_vaddr)

		res = self.__emulate_syscall_switch(sym, vmlinux.read_symbol(sym))
		if res is None:
			return {}

		nrs, candidate_insns = res
		vaddrs: Dict[int,int] = {}
		found_default_case = False

		for insn in candidate_insns:
			# Guaranteed to have .near_branch_target by the code in
			# __emulate_syscall_switch() above
			vaddr = insn.near_branch_target
			numbers = nrs[vaddr]

			if len(numbers) == 0:
				# This should never happen, bail out
				logging.error('Empty set of syscall numbers for %#x (target of '
					'%r). Unreachable!?', vaddr, insn)
				return {}

			if len(numbers) > 100:
				logging.debug('Default switch case at %#x (reachable %d '
					'times): %r => %#x is ni_syscall', insn.ip,
					len(numbers), insn, vaddr)

				if found_default_case:
					logging.error('Multiple default switch cases?')
					return {}

				found_default_case = True
				continue

			# Let the caller handle de-duplication in case a single vaddr can be
			# reached by multiple syscall numbers
			for nr in numbers:
				if nr in vaddrs:
					if vaddrs[nr] != vaddr:
						logging.error('Number %d leads to multiple vaddrs: '
							'%#x %#x. Bailing out!', nr, vaddrs[nr], vaddr)
						return {}
					continue

				vaddrs[nr] = vaddr

		return vaddrs
