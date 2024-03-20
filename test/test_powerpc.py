from systrack.arch import ArchPowerPC

from .utils import *

def test_dummy_syscall_64():
	assert arch_is_dummy_syscall(ArchPowerPC((5,0), 'ppc64', False),
		# <.sys_ni_syscall>: (64-bit, v5.0)
		bytes.fromhex(
			'7c 08 02 a6' # mflr    r0
			'f8 01 00 10' # std     r0,16(r1)
			'f8 21 ff 91' # stdu    r1,-112(r1)
			'4b ee 47 45' # bl      c0000000000707e0 <._mcount>
			'60 00 00 00' # nop
			'38 21 00 70' # addi    r1,r1,112
			'38 60 ff da' # li      r3,-38
			'e8 01 00 10' # ld      r0,16(r1)
			'7c 08 03 a6' # mtlr    r0
			'4e 80 00 20' # blr
			'60 00 00 00' # nop
			'60 00 00 00' # nop
		)
	)

def test_dummy_syscall_32():
	assert arch_is_dummy_syscall(ArchPowerPC((6,8), 'ppc32', True),
		bytes.fromhex(
			# <sys_migrate_pages>: (32-bit, v6.8)
			'7c 08 02 a6' # mflr    r0
			'90 01 00 04' # stw     r0,4(r1)
			'4b f9 20 11' # bl      c0039860 <_mcount>
			'94 21 ff f0' # stwu    r1,-16(r1)
			'38 60 ff da' # li      r3,-38
			'38 21 00 10' # addi    r1,r1,16
			'4e 80 00 20' # blr
		)
	)

def test_dummy_syscall_simple():
	assert arch_is_dummy_syscall(ArchPowerPC((6,8), 'ppc64', False),
		bytes.fromhex(
			'38 60 ff da' # li      r3,-38
			'4e 80 00 20' # blr
		)
	)

	assert arch_is_dummy_syscall(ArchPowerPC((6,8), 'ppc32', True),
		bytes.fromhex(
			'94 21 ff f0' # stwu    r1,-16(r1)
			'38 60 ff da' # li      r3,-38
			'38 21 00 10' # addi    r1,r1,16
			'4e 80 00 20' # blr
		)
	)
