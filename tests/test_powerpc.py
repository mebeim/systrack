from systrack.arch import ArchPowerPC

from .utils import MockELF, Symbol, arch_is_dummy_syscall


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

	assert not arch_is_dummy_syscall(ArchPowerPC((6,8), 'ppc32', True),
		bytes.fromhex(
			'94 21 ff f0' # stwu    r1,-16(r1)
			'38 60 ff 00' # li      r3,-256
			'38 21 00 10' # addi    r1,r1,16
			'4e 80 00 20' # blr
		)
	)


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


def test_esoteric_fast_endian_switch_simple():
	sym = Symbol(0x0, 0x0, 0x0, 'NOTYPE', 'exc_real_0xc00_system_call')
	elf = MockELF(True, {sym: bytes.fromhex(
		# Minimal code example that should match
		'2c 20 1e be' #    cmpdi   r0,7870
		'41 c2 00 04' #    beq-    X
		'7d 9b 02 a6' # X: mfsrr1  r12
		'69 8c 00 01' #    xori    r12,r12,1
		'7d 9b 03 a6' #    mtsrr1  r12
		'4c 00 00 24' #    rfid
	)})

	# Should only be available for 64-bit ppc64 ABI
	assert not ArchPowerPC((6,8), 'ppc32', True).extract_esoteric_syscalls(elf)
	assert not ArchPowerPC((6,8), 'ppc32', False).extract_esoteric_syscalls(elf)
	assert not ArchPowerPC((6,8), 'spu', False).extract_esoteric_syscalls(elf)

	arch = ArchPowerPC((6,8), 'ppc64', False)
	res = arch.extract_esoteric_syscalls(elf)
	assert res and res[0][:3] == (7870, 'switch_endian', sym.name)

	# Also test beq+, and beq (2 encodings)
	for beq in (0x41e2, 0x4182, 0x41a2):
		code = elf.symbols_code[sym]
		code = code[:4] + beq.to_bytes(2, 'big') + code[6:]
		elf.symbols_code[sym] = code

		res = arch.extract_esoteric_syscalls(elf)
		assert res and res[0][:3] == (7870, 'switch_endian', sym.name)


def test_esoteric_fast_endian_switch_real():
	sym = Symbol(0x0, 0x0, 0x0, 'NOTYPE', 'exc_real_0xc00_system_call')
	elf = MockELF(True, {sym: bytes.fromhex(
		# <exc_real_0xc00_system_call>: (64-bit, v6.8)
		'7d a9 03 a6' # mtctr   r13
		'7d b1 42 a6' # mfsprg  r13,1
		'f9 4d 00 88' # std     r10,136(r13)
		'60 00 00 00' # nop
		'60 00 00 00' # nop
		'60 00 00 00' # nop
		'60 00 00 00' # nop
		'60 00 00 00' # nop
		'60 00 00 00' # nop
		'89 4d 0a b8' # lbz     r10,2744(r13)
		'2c 0a 00 00' # cmpwi   r10,0
		'39 40 0c 00' # li      r10,3072
		'40 82 0d e0' # bne     c000000000001a10 <kvm_hcall>
		'7d 29 02 a6' # mfctr   r9
		'2c 20 1e be' # cmpdi   r0,7870
		'41 c2 00 20' # beq-    c000000000000c5c <exc_real_0xc00_system_call+0x5c>
		'7d 7a 02 a6' # mfsrr0  r11
		'7d 9b 02 a6' # mfsrr1  r12
		'7c 42 13 78' # mr      r2,r2
		'e9 4d 00 18' # ld      r10,24(r13)
		'61 4a ca d0' # ori     r10,r10,51920
		'7d 49 03 a6' # mtctr   r10
		'4e 80 04 20' # bctr
		'7d 9b 02 a6' # mfsrr1  r12
		'69 8c 00 01' # xori    r12,r12,1
		'7d 9b 03 a6' # mtsrr1  r12
		'7d 2d 4b 78' # mr      r13,r9
		'60 00 00 00' # nop
		'60 00 00 00' # nop
		'60 00 00 00' # nop
		'60 00 00 00' # nop
		'60 00 00 00' # nop
		'60 00 00 00' # nop
		'60 00 00 00' # nop
		'60 00 00 00' # nop
		'60 00 00 00' # nop
		'4c 00 00 24' # rfid
		'48 00 14 ac' # b       c000000000002140 <rfi_flush_fallback>
		'48 00 00 00' # b       c000000000000c98 (infinite loop)
	)})

	# Should only be available for 64-bit ppc64 ABI
	assert not ArchPowerPC((6,8), 'ppc32', True).extract_esoteric_syscalls(elf)
	assert not ArchPowerPC((6,8), 'ppc32', False).extract_esoteric_syscalls(elf)
	assert not ArchPowerPC((6,8), 'spu', False).extract_esoteric_syscalls(elf)

	res = ArchPowerPC((6,8), 'ppc64', False).extract_esoteric_syscalls(elf)
	assert res and res[0][:3] == (7870, 'switch_endian', sym.name)
