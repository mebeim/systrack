.section .text

.globl x64_sys_call
.type x64_sys_call @function
x64_sys_call:
	endbr64
	cmp    $0xbe,%esi
	je     0xffffffff81003b4b - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x169b> */
	ja     0xffffffff81002532 - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x82> */
	cmp    $0x59,%esi
	je     0xffffffff81003b46 - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x1696> */
	jbe    0xffffffff810029c5 - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x515> */
	cmp    $0x87,%esi
	je     0xffffffff81003b41 - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x1691> */
	jbe    0xffffffff81002976 - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x4c6> */
	cmp    $0x9f,%esi
	je     0xffffffff81003b3c - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x168c> */
	jbe    0xffffffff81002912 - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x462> */
	cmp    $0xaa,%esi
	je     0xffffffff81003b37 - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x1687> */
	jbe    0xffffffff810028e1 - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x431> */
	cmp    $0xb3,%esi
	je     0xffffffff81003b32 - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x1682> */
	jbe    0xffffffff810025c8 - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x118> */
	cmp    $0xbc,%esi
	je     0xffffffff81003b2d - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x167d> */
	cmp    $0xbd,%esi
	jne    0xffffffff810025ab - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0xfb> */
	jmp    0xffffffff8135ae20 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_lsetxattr> */
	cmp    $0x11e,%esi
	je     0xffffffff81003b28 - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x1678> */
	jbe    0xffffffff8100275f - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x2af> */
	cmp    $0x14b,%esi
	je     0xffffffff81003b23 - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x1673> */
	jbe    0xffffffff8100270a - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x25a> */
	cmp    $0x1b9,%esi
	je     0xffffffff81003b1e - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x166e> */
	jbe    0xffffffff810026a6 - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x1f6> */
	cmp    $0x1c4,%esi
	je     0xffffffff81003b19 - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x1669> */
	jbe    0xffffffff81002675 - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x1c5> */
	cmp    $0x1ca,%esi
	je     0xffffffff8100386c - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x13bc> */
	jbe    0xffffffff81002610 - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x160> */
	cmp    $0x1cd,%esi
	je     0xffffffff81003867 - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x13b7> */
	jbe    0xffffffff810025f3 - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x143> */
	cmp    $0x1ce,%esi
	jne    0xffffffff81002c6b - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x7bb> */
	jmp    0xffffffff812de850 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_mseal> */
	cmp    $0xba,%esi
	je     0xffffffff81003cdb - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x182b> */
	cmp    $0xbb,%esi
	jne    0xffffffff81002c6b - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x7bb> */
	jmp    0xffffffff81284070 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_readahead> */
	cmp    $0xad,%esi
	je     0xffffffff81003cd6 - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x1826> */
	jbe    0xffffffff8100263b - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x18b> */
	cmp    $0xaf,%esi
	je     0xffffffff81003cd1 - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x1821> */
	cmp    $0xb0,%esi
	jne    0xffffffff81002c6b - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x7bb> */
	jmp    0xffffffff8113bdc0 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_delete_module> */
	cmp    $0x1cb,%esi
	je     0xffffffff81003ccc - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x181c> */
	cmp    $0x1cc,%esi
	jne    0xffffffff81002c6b - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x7bb> */
	jmp    0xffffffff815111a0 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_lsm_set_self_attr> */
	cmp    $0x1c7,%esi
	je     0xffffffff81003cc7 - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x1817> */
	jbe    0xffffffff81002658 - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x1a8> */
	cmp    $0x1c8,%esi
	je     0xffffffff81003cc2 - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x1812> */
	cmp    $0x1c9,%esi
	jne    0xffffffff81002c6b - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x7bb> */
	jmp    0xffffffff813570d0 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_statmount> */
	cmp    $0xab,%esi
	je     0xffffffff81003cbd - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x180d> */
	cmp    $0xac,%esi
	jne    0xffffffff81002c6b - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x7bb> */
	jmp    0xffffffff810370f0 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_iopl> */
	cmp    $0x1c5,%esi
	je     0xffffffff81003cb8 - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x1808> */
	cmp    $0x1c6,%esi
	jne    0xffffffff81002c6b - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x7bb> */
	jmp    0xffffffff81161930 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_futex_wake> */
	cmp    $0x1bf,%esi
	je     0xffffffff81003cb3 - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x1803> */
	jbe    0xffffffff81002fe5 - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0xb35> */
	cmp    $0x1c2,%esi
	je     0xffffffff81003cae - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x17fe> */
	jbe    0xffffffff810026ed - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x23d> */
	cmp    $0x1c3,%esi
	jne    0xffffffff81002c6b - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x7bb> */
	jmp    0xffffffff8127a6d0 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_cachestat> */
	cmp    $0x1ae,%esi
	je     0xffffffff81003ca9 - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x17f9> */
	jbe    0xffffffff810036de - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x122e> */
	cmp    $0x1b4,%esi
	je     0xffffffff81003ca4 - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x17f4> */
	jbe    0xffffffff810030b9 - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0xc09> */
	cmp    $0x1b7,%esi
	je     0xffffffff81003c9f - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x17ef> */
	jbe    0xffffffff810030e4 - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0xc34> */
	cmp    $0x1b8,%esi
	jne    0xffffffff81002c6b - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x7bb> */
	jmp    0xffffffff812f2ea0 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_process_madvise> */
	cmp    $0x1c0,%esi
	je     0xffffffff81003c9a - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x17ea> */
	cmp    $0x1c1,%esi
	jne    0xffffffff81002c6b - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x7bb> */
	jmp    0xffffffff81161650 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_futex_waitv> */
	cmp    $0x135,%esi
	je     0xffffffff81003c95 - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x17e5> */
	jbe    0xffffffff81002818 - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x368> */
	cmp    $0x140,%esi
	je     0xffffffff81003c90 - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x17e0> */
	jbe    0xffffffff810027e7 - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x337> */
	cmp    $0x146,%esi
	je     0xffffffff81003c8b - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x17db> */
	jbe    0xffffffff8100287c - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x3cc> */
	cmp    $0x149,%esi
	je     0xffffffff81003c86 - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x17d6> */
	jbe    0xffffffff810027ca - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x31a> */
	cmp    $0x14a,%esi
	jne    0xffffffff81002c6b - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x7bb> */
	jmp    0xffffffff812cce90 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_pkey_alloc> */
	cmp    $0xf1,%esi
	je     0xffffffff81003c81 - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x17d1> */
	jbe    0xffffffff810032ea - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0xe3a> */
	cmp    $0x108,%esi
	je     0xffffffff81003c7c - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x17cc> */
	jbe    0xffffffff81003072 - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0xbc2> */
	cmp    $0x113,%esi
	je     0xffffffff81003c77 - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x17c7> */
	jbe    0xffffffff8100325b - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0xdab> */
	cmp    $0x119,%esi
	je     0xffffffff81003c72 - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x17c2> */
	jbe    0xffffffff81002fb6 - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0xb06> */
	cmp    $0x11c,%esi
	je     0xffffffff81003c6d - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x17bd> */
	jbe    0xffffffff810028a7 - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x3f7> */
	cmp    $0x11d,%esi
	jne    0xffffffff81002c6b - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x7bb> */
	jmp    0xffffffff8131bcc0 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_fallocate> */
	cmp    $0x147,%esi
	je     0xffffffff81003c68 - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x17b8> */
	cmp    $0x148,%esi
	jne    0xffffffff81002c6b - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x7bb> */
	jmp    0xffffffff81321d80 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_pwritev2> */
	cmp    $0x13b,%esi
	je     0xffffffff81003c63 - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x17b3> */
	jbe    0xffffffff81003014 - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0xb64> */
	cmp    $0x13e,%esi
	je     0xffffffff81003c5e - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x17ae> */
	jbe    0xffffffff8100285f - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x3af> */
	cmp    $0x13f,%esi
	jne    0xffffffff81002c6b - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x7bb> */
	jmp    0xffffffff81319ee0 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_memfd_create> */
	cmp    $0x12a,%esi
	je     0xffffffff81003c59 - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x17a9> */
	jbe    0xffffffff81003166 - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0xcb6> */
	cmp    $0x130,%esi
	je     0xffffffff81003c54 - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x17a4> */
	jbe    0xffffffff8100313b - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0xc8b> */
	cmp    $0x133,%esi
	je     0xffffffff81003c4f - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x179f> */
	jbe    0xffffffff81003204 - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0xd54> */
	cmp    $0x134,%esi
	jne    0xffffffff81002c6b - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x7bb> */
	jmp    0xffffffff810c4860 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_setns> */
	cmp    $0x13c,%esi
	je     0xffffffff81003c4a - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x179a> */
	cmp    $0x13d,%esi
	jne    0xffffffff81002c6b - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x7bb> */
	jmp    0xffffffff8119e490 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_seccomp> */
	cmp    $0x143,%esi
	je     0xffffffff81003c45 - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x1795> */
	jbe    0xffffffff810028c4 - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x414> */
	cmp    $0x144,%esi
	je     0xffffffff81003c40 - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x1790> */
	cmp    $0x145,%esi
	jne    0xffffffff81002c6b - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x7bb> */
	jmp    0xffffffff812c24f0 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_mlock2> */
	cmp    $0x11a,%esi
	je     0xffffffff81003c3b - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x178b> */
	cmp    $0x11b,%esi
	jne    0xffffffff81002c6b - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x7bb> */
	jmp    0xffffffff81389ef0 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_timerfd_create> */
	cmp    $0x141,%esi
	je     0xffffffff81003c36 - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x1786> */
	cmp    $0x142,%esi
	jne    0xffffffff81002c6b - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x7bb> */
	jmp    0xffffffff8132d5b0 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_execveat> */
	cmp    $0xa5,%esi
	je     0xffffffff81003c31 - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x1781> */
	jbe    0xffffffff81003043 - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0xb93> */
	cmp    $0xa8,%esi
	je     0xffffffff81003c2c - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x177c> */
	jbe    0xffffffff81002959 - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x4a9> */
	cmp    $0xa9,%esi
	jne    0xffffffff81002c6b - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x7bb> */
	jmp    0xffffffff810c7f10 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_reboot> */
	cmp    $0x93,%esi
	je     0xffffffff81003c27 - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x1777> */
	jbe    0xffffffff810035e9 - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x1139> */
	cmp    $0x99,%esi
	je     0xffffffff81003c22 - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x1772> */
	jbe    0xffffffff810035be - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x110e> */
	cmp    $0x9d,%esi
	je     0xffffffff81003c1d - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x176d> */
	jbe    0xffffffff81003687 - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x11d7> */
	cmp    $0x9e,%esi
	jne    0xffffffff81002c6b - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x7bb> */
	jmp    0xffffffff81031bc0 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_arch_prctl> */
	cmp    $0xa6,%esi
	je     0xffffffff81003c18 - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x1768> */
	cmp    $0xa7,%esi
	jne    0xffffffff81002c6b - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x7bb> */
	jmp    0xffffffff812faf10 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_swapon> */
	cmp    $0x70,%esi
	je     0xffffffff81003c13 - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x1763> */
	jbe    0xffffffff81002a63 - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x5b3> */
	cmp    $0x7b,%esi
	je     0xffffffff81003c0e - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x175e> */
	jbe    0xffffffff81002a3b - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x58b> */
	cmp    $0x81,%esi
	je     0xffffffff81003c09 - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x1759> */
	jbe    0xffffffff81002ab5 - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x605> */
	cmp    $0x84,%esi
	je     0xffffffff81003c04 - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x1754> */
	jbe    0xffffffff81002a1e - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x56e> */
	cmp    $0x85,%esi
	jne    0xffffffff81002c6b - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x7bb> */
	jmp    0xffffffff813385b0 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_mknod> */
	cmp    $0x2c,%esi
	je     0xffffffff81003bff - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x174f> */
	jbe    0xffffffff81002be2 - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x732> */
	cmp    $0x43,%esi
	je     0xffffffff81003bfa - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x174a> */
	jbe    0xffffffff81002ba2 - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x6f2> */
	cmp    $0x4e,%esi
	je     0xffffffff81003bf5 - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x1745> */
	jbe    0xffffffff81002b2a - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x67a> */
	cmp    $0x54,%esi
	je     0xffffffff81003bf0 - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x1740> */
	jbe    0xffffffff81002b08 - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x658> */
	cmp    $0x57,%esi
	je     0xffffffff81003beb - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x173b> */
	jbe    0xffffffff81002ada - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x62a> */
	cmp    $0x58,%esi
	jne    0xffffffff81002c6b - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x7bb> */
	jmp    0xffffffff813392b0 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_symlink> */
	cmp    $0x82,%esi
	je     0xffffffff81003be6 - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x1736> */
	cmp    $0x83,%esi
	jne    0xffffffff81002c6b - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x7bb> */
	jmp    0xffffffff810a8060 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_sigaltstack> */
	cmp    $0x76,%esi
	je     0xffffffff81003be1 - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x1731> */
	jbe    0xffffffff81002cd8 - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x828> */
	cmp    $0x79,%esi
	je     0xffffffff81003bdc - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x172c> */
	jbe    0xffffffff81002a9e - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x5ee> */
	cmp    $0x7a,%esi
	jne    0xffffffff81002c6b - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x7bb> */
	jmp    0xffffffff810ac560 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_setfsuid> */
	cmp    $0x65,%esi
	je     0xffffffff81003bd7 - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x1727> */
	jbe    0xffffffff81002d37 - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x887> */
	cmp    $0x6b,%esi
	je     0xffffffff81003bd2 - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x1722> */
	jbe    0xffffffff81002d15 - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x865> */
	cmp    $0x6e,%esi
	je     0xffffffff81003bcd - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x171d> */
	jbe    0xffffffff81002db4 - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x904> */
	cmp    $0x6f,%esi
	jne    0xffffffff81002c6b - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x7bb> */
	jmp    0xffffffff810acd10 - 0xffffffff810024b0 + x64_sys_call /* <__ia32_sys_getpgrp> */
	cmp    $0x77,%esi
	je     0xffffffff81003bc8 - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x1718> */
	cmp    $0x78,%esi
	jne    0xffffffff81002c6b - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x7bb> */
	jmp    0xffffffff810ac380 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_getresgid> */
	cmp    $0x7e,%esi
	je     0xffffffff81003bc3 - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x1713> */
	jbe    0xffffffff81002af1 - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x641> */
	cmp    $0x7f,%esi
	je     0xffffffff81003bbe - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x170e> */
	cmp    $0x80,%esi
	jne    0xffffffff81002c6b - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x7bb> */
	jmp    0xffffffff810a6bb0 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_rt_sigtimedwait> */
	cmp    $0x55,%esi
	je     0xffffffff81003bb9 - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x1709> */
	cmp    $0x56,%esi
	jne    0xffffffff81002c6b - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x7bb> */
	jmp    0xffffffff81339740 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_link> */
	cmp    $0x7c,%esi
	je     0xffffffff81003bb4 - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x1704> */
	cmp    $0x7d,%esi
	jne    0xffffffff81002c6b - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x7bb> */
	jmp    0xffffffff8109d1a0 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_capget> */
	cmp    $0x51,%esi
	je     0xffffffff81003baf - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x16ff> */
	jbe    0xffffffff81002b4e - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x69e> */
	cmp    $0x52,%esi
	je     0xffffffff81003baa - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x16fa> */
	cmp    $0x53,%esi
	jne    0xffffffff81002c6b - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x7bb> */
	jmp    0xffffffff81338860 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_mkdir> */
	cmp    $0x49,%esi
	je     0xffffffff81003ba5 - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x16f5> */
	jbe    0xffffffff81002b7c - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x6cc> */
	cmp    $0x4c,%esi
	je     0xffffffff81003ba0 - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x16f0> */
	jbe    0xffffffff81002b65 - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x6b5> */
	cmp    $0x4d,%esi
	jne    0xffffffff81002c6b - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x7bb> */
	jmp    0xffffffff8131ba30 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_ftruncate> */
	cmp    $0x4f,%esi
	je     0xffffffff81003b9b - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x16eb> */
	cmp    $0x50,%esi
	jne    0xffffffff81002c6b - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x7bb> */
	jmp    0xffffffff8131bee0 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_chdir> */
	cmp    $0x4a,%esi
	je     0xffffffff81003b96 - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x16e6> */
	cmp    $0x4b,%esi
	jne    0xffffffff81002c6b - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x7bb> */
	jmp    0xffffffff8136b4b0 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_fdatasync> */
	cmp    $0x46,%esi
	je     0xffffffff81003b91 - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x16e1> */
	jbe    0xffffffff81002c28 - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x778> */
	cmp    $0x47,%esi
	je     0xffffffff81003b8c - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x16dc> */
	cmp    $0x48,%esi
	jne    0xffffffff81002c6b - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x7bb> */
	jmp    0xffffffff8133b120 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_fcntl> */
	cmp    $0x37,%esi
	je     0xffffffff81003b87 - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x16d7> */
	jbe    0xffffffff81002c70 - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x7c0> */
	cmp    $0x3d,%esi
	je     0xffffffff81003b82 - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x16d2> */
	jbe    0xffffffff81002c4e - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x79e> */
	cmp    $0x40,%esi
	je     0xffffffff81003b7d - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x16cd> */
	jbe    0xffffffff81002c3b - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x78b> */
	cmp    $0x41,%esi
	je     0xffffffff81003b78 - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x16c8> */
	cmp    $0x42,%esi
	jne    0xffffffff81002c6b - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x7bb> */
	jmp    0xffffffff814fc3b0 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_semctl> */
	cmp    $0x16,%esi
	je     0xffffffff81003b73 - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x16c3> */
	jbe    0xffffffff81002e21 - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x971> */
	cmp    $0x21,%esi
	je     0xffffffff81003b6e - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x16be> */
	jbe    0xffffffff81002df9 - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x949> */
	cmp    $0x27,%esi
	je     0xffffffff81003b69 - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x16b9> */
	jbe    0xffffffff81002e73 - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x9c3> */
	cmp    $0x2a,%esi
	je     0xffffffff81003b64 - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x16b4> */
	jbe    0xffffffff81002cfe - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x84e> */
	cmp    $0x2b,%esi
	jne    0xffffffff81002c6b - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x7bb> */
	jmp    0xffffffff81b96230 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_accept> */
	cmp    $0x44,%esi
	je     0xffffffff81003b5f - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x16af> */
	cmp    $0x45,%esi
	jne    0xffffffff81002c6b - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x7bb> */
	jmp    0xffffffff814f9070 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_msgsnd> */
	cmp    $0x3e,%esi
	je     0xffffffff81003b5a - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x16aa> */
	cmp    $0x3f,%esi
	jne    0xffffffff81002c6b - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x7bb> */
	jmp    0xffffffff810acfd0 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_newuname> */
	cmp    $0x3a,%esi
	je     0xffffffff81003b55 - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x16a5> */
	jbe    0xffffffff81002c90 - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x7e0> */
	cmp    $0x3b,%esi
	je     0xffffffff81003b50 - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x16a0> */
	cmp    $0x3c,%esi
	je     0xffffffff81003ce5 - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x1835> */
	jmp    0xffffffff81003d20 - 0xffffffff810024b0 + x64_sys_call /* <__ia32_sys_ni_syscall> */
	cmp    $0x32,%esi
	je     0xffffffff81003b14 - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x1664> */
	jbe    0xffffffff81002cb6 - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x806> */
	cmp    $0x35,%esi
	je     0xffffffff81003b0f - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x165f> */
	jbe    0xffffffff81002ca3 - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x7f3> */
	cmp    $0x36,%esi
	jne    0xffffffff81002c6b - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x7bb> */
	jmp    0xffffffff81b96cf0 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_setsockopt> */
	cmp    $0x38,%esi
	je     0xffffffff81003b0a - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x165a> */
	cmp    $0x39,%esi
	jne    0xffffffff81002c6b - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x7bb> */
	jmp    0xffffffff8108e070 - 0xffffffff810024b0 + x64_sys_call /* <__ia32_sys_fork> */
	cmp    $0x33,%esi
	je     0xffffffff81003b05 - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x1655> */
	cmp    $0x34,%esi
	jne    0xffffffff81002c6b - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x7bb> */
	jmp    0xffffffff81b96670 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_getpeername> */
	cmp    $0x2f,%esi
	je     0xffffffff81003b00 - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x1650> */
	jbe    0xffffffff81002dcb - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x91b> */
	cmp    $0x30,%esi
	je     0xffffffff81003afb - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x164b> */
	cmp    $0x31,%esi
	jne    0xffffffff81002c6b - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x7bb> */
	jmp    0xffffffff81b95d60 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_bind> */
	cmp    $0x73,%esi
	je     0xffffffff81003af6 - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x1646> */
	jbe    0xffffffff81002e95 - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x9e5> */
	cmp    $0x74,%esi
	je     0xffffffff81003af1 - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x1641> */
	cmp    $0x75,%esi
	jne    0xffffffff81002c6b - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x7bb> */
	jmp    0xffffffff810abfd0 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_setresuid> */
	cmp    $0x28,%esi
	je     0xffffffff81003aec - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x163c> */
	cmp    $0x29,%esi
	jne    0xffffffff81002c6b - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x7bb> */
	jmp    0xffffffff81b958c0 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_socket> */
	cmp    $0x68,%esi
	je     0xffffffff81003ae7 - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x1637> */
	jbe    0xffffffff81002d64 - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x8b4> */
	cmp    $0x69,%esi
	je     0xffffffff81003ae2 - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x1632> */
	cmp    $0x6a,%esi
	jne    0xffffffff81002c6b - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x7bb> */
	jmp    0xffffffff810aba10 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_setgid> */
	cmp    $0x5f,%esi
	je     0xffffffff81003add - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x162d> */
	jbe    0xffffffff81002d92 - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x8e2> */
	cmp    $0x62,%esi
	je     0xffffffff81003ad8 - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x1628> */
	jbe    0xffffffff81002d7b - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x8cb> */
	cmp    $0x63,%esi
	je     0xffffffff81003ad3 - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x1623> */
	cmp    $0x64,%esi
	jne    0xffffffff81002c6b - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x7bb> */
	jmp    0xffffffff810ac850 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_times> */
	cmp    $0x66,%esi
	je     0xffffffff81003ace - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x161e> */
	cmp    $0x67,%esi
	jne    0xffffffff81002c6b - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x7bb> */
	jmp    0xffffffff81106d40 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_syslog> */
	cmp    $0x60,%esi
	je     0xffffffff81003ac9 - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x1619> */
	cmp    $0x61,%esi
	jne    0xffffffff81002c6b - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x7bb> */
	jmp    0xffffffff810ade30 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_getrlimit> */
	cmp    $0x5c,%esi
	je     0xffffffff81003ac4 - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x1614> */
	jbe    0xffffffff81002de2 - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x932> */
	cmp    $0x5d,%esi
	je     0xffffffff81003abf - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x160f> */
	cmp    $0x5e,%esi
	jne    0xffffffff81002c6b - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x7bb> */
	jmp    0xffffffff8131cd50 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_lchown> */
	cmp    $0x6c,%esi
	je     0xffffffff81003aba - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x160a> */
	cmp    $0x6d,%esi
	jne    0xffffffff81002c6b - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x7bb> */
	jmp    0xffffffff810acc50 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_setpgid> */
	cmp    $0x2d,%esi
	je     0xffffffff81003ab5 - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x1605> */
	cmp    $0x2e,%esi
	jne    0xffffffff81002c6b - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x7bb> */
	jmp    0xffffffff81b976f0 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_sendmsg> */
	cmp    $0x5a,%esi
	je     0xffffffff81003ab0 - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x1600> */
	cmp    $0x5b,%esi
	jne    0xffffffff81002c6b - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x7bb> */
	jmp    0xffffffff8131c740 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_fchmod> */
	cmp    $0x1c,%esi
	je     0xffffffff81003aab - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x15fb> */
	jbe    0xffffffff81002ec3 - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0xa13> */
	cmp    $0x1f,%esi
	je     0xffffffff81003aa6 - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x15f6> */
	jbe    0xffffffff81002e5c - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x9ac> */
	cmp    $0x20,%esi
	jne    0xffffffff81002c6b - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x7bb> */
	jmp    0xffffffff8134d100 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_dup> */
	cmp    $0xb,%esi
	je     0xffffffff81003aa1 - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x15f1> */
	jbe    0xffffffff81002f35 - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0xa85> */
	cmp    $0x11,%esi
	je     0xffffffff81003a9c - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x15ec> */
	jbe    0xffffffff81002f13 - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0xa63> */
	cmp    $0x14,%esi
	je     0xffffffff81003a97 - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x15e7> */
	jbe    0xffffffff81002ee5 - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0xa35> */
	cmp    $0x15,%esi
	jne    0xffffffff81002c6b - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x7bb> */
	jmp    0xffffffff8131be80 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_access> */
	cmp    $0x1d,%esi
	je     0xffffffff81003a92 - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x15e2> */
	cmp    $0x1e,%esi
	jne    0xffffffff81002c6b - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x7bb> */
	jmp    0xffffffff81500c90 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_shmat> */
	cmp    $0x24,%esi
	je     0xffffffff81003a8d - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x15dd> */
	jbe    0xffffffff81002eac - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x9fc> */
	cmp    $0x25,%esi
	je     0xffffffff81003a88 - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x15d8> */
	cmp    $0x26,%esi
	jne    0xffffffff81002c6b - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x7bb> */
	jmp    0xffffffff81156ce0 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_setitimer> */
	cmp    $0x71,%esi
	je     0xffffffff81003a83 - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x15d3> */
	cmp    $0x72,%esi
	jne    0xffffffff81002c6b - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x7bb> */
	jmp    0xffffffff810ab8d0 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_setregid> */
	cmp    $0x22,%esi
	je     0xffffffff81003a7e - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x15ce> */
	cmp    $0x23,%esi
	jne    0xffffffff81002c6b - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x7bb> */
	jmp    0xffffffff81146f40 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_nanosleep> */
	cmp    $0x19,%esi
	je     0xffffffff81003a79 - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x15c9> */
	jbe    0xffffffff81002efc - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0xa4c> */
	cmp    $0x1a,%esi
	je     0xffffffff81003a74 - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x15c4> */
	cmp    $0x1b,%esi
	jne    0xffffffff81002c6b - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x7bb> */
	jmp    0xffffffff812c0920 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_mincore> */
	cmp    $0x12,%esi
	je     0xffffffff81003a6f - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x15bf> */
	cmp    $0x13,%esi
	jne    0xffffffff81002c6b - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x7bb> */
	jmp    0xffffffff813219e0 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_readv> */
	cmp    $0x17,%esi
	je     0xffffffff81003a6a - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x15ba> */
	cmp    $0x18,%esi
	jne    0xffffffff81002c6b - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x7bb> */
	jmp    0xffffffff810ee330 - 0xffffffff810024b0 + x64_sys_call /* <__ia32_sys_sched_yield> */
	cmp    $0xe,%esi
	je     0xffffffff81003a65 - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x15b5> */
	jbe    0xffffffff81002f62 - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0xab2> */
	cmp    $0xf,%esi
	je     0xffffffff81003a60 - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x15b0> */
	cmp    $0x10,%esi
	jne    0xffffffff81002c6b - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x7bb> */
	jmp    0xffffffff8133cf60 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_ioctl> */
	cmp    $0x5,%esi
	je     0xffffffff81003a5b - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x15ab> */
	jbe    0xffffffff81002f90 - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0xae0> */
	cmp    $0x8,%esi
	je     0xffffffff81003a56 - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x15a6> */
	jbe    0xffffffff81002f79 - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0xac9> */
	cmp    $0x9,%esi
	je     0xffffffff81003a51 - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x15a1> */
	cmp    $0xa,%esi
	jne    0xffffffff81002c6b - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x7bb> */
	jmp    0xffffffff812ccdc0 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_mprotect> */
	cmp    $0xc,%esi
	je     0xffffffff81003a4c - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x159c> */
	cmp    $0xd,%esi
	jne    0xffffffff81002c6b - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x7bb> */
	jmp    0xffffffff810a8940 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_rt_sigaction> */
	cmp    $0x6,%esi
	je     0xffffffff81003a47 - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x1597> */
	cmp    $0x7,%esi
	jne    0xffffffff81002c6b - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x7bb> */
	jmp    0xffffffff813409b0 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_poll> */
	cmp    $0x2,%esi
	je     0xffffffff81003a42 - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x1592> */
	jbe    0xffffffff81003288 - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0xdd8> */
	cmp    $0x3,%esi
	je     0xffffffff81003a3d - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x158d> */
	cmp    $0x4,%esi
	jne    0xffffffff81002c6b - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x7bb> */
	jmp    0xffffffff81329c00 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_newstat> */
	cmp    $0x116,%esi
	je     0xffffffff81003a38 - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x1588> */
	jbe    0xffffffff81003101 - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0xc51> */
	cmp    $0x117,%esi
	je     0xffffffff81003a33 - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x1583> */
	cmp    $0x118,%esi
	jne    0xffffffff81002c6b - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x7bb> */
	jmp    0xffffffff8136bef0 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_utimensat> */
	cmp    $0x1bc,%esi
	je     0xffffffff81003a2e - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x157e> */
	jbe    0xffffffff81003221 - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0xd71> */
	cmp    $0x1bd,%esi
	je     0xffffffff81003a29 - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x1579> */
	cmp    $0x1be,%esi
	jne    0xffffffff81002c6b - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x7bb> */
	jmp    0xffffffff8153fdf0 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_landlock_restrict_self> */
	cmp    $0x138,%esi
	je     0xffffffff81003a24 - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x1574> */
	jbe    0xffffffff810036a4 - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x11f4> */
	cmp    $0x139,%esi
	je     0xffffffff81003a1f - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x156f> */
	cmp    $0x13a,%esi
	jne    0xffffffff81002c6b - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x7bb> */
	jmp    0xffffffff810ed150 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_sched_setattr> */
	cmp    $0xa2,%esi
	je     0xffffffff81003a1a - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x156a> */
	jbe    0xffffffff8100334b - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0xe9b> */
	cmp    $0xa3,%esi
	je     0xffffffff81003a15 - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x1565> */
	cmp    $0xa4,%esi
	jne    0xffffffff81002c6b - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x7bb> */
	jmp    0xffffffff81140790 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_settimeofday> */
	cmp    $0xfd,%esi
	je     0xffffffff81003a10 - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x1560> */
	jbe    0xffffffff8100379f - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x12ef> */
	cmp    $0x103,%esi
	je     0xffffffff81003a0b - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x155b> */
	jbe    0xffffffff81003774 - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x12c4> */
	cmp    $0x106,%esi
	je     0xffffffff81003a06 - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x1556> */
	jbe    0xffffffff8100370b - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x125b> */
	cmp    $0x107,%esi
	jne    0xffffffff81002c6b - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x7bb> */
	jmp    0xffffffff81338f10 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_unlinkat> */
	cmp    $0x1b1,%esi
	je     0xffffffff81003a01 - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x1551> */
	jbe    0xffffffff8100311e - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0xc6e> */
	cmp    $0x1b2,%esi
	je     0xffffffff810039fc - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x154c> */
	cmp    $0x1b3,%esi
	jne    0xffffffff81002c6b - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x7bb> */
	jmp    0xffffffff8108e1c0 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_clone3> */
	cmp    $0x1b5,%esi
	je     0xffffffff810039f7 - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x1547> */
	cmp    $0x1b6,%esi
	jne    0xffffffff81002c6b - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x7bb> */
	jmp    0xffffffff810bb6a0 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_pidfd_getfd> */
	cmp    $0x114,%esi
	je     0xffffffff810039f2 - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x1542> */
	cmp    $0x115,%esi
	jne    0xffffffff81002c6b - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x7bb> */
	jmp    0xffffffff8136b780 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_sync_file_range> */
	cmp    $0x1af,%esi
	je     0xffffffff810039ed - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x153d> */
	cmp    $0x1b0,%esi
	jne    0xffffffff81002c6b - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x7bb> */
	jmp    0xffffffff81356650 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_fsmount> */
	cmp    $0x12d,%esi
	je     0xffffffff810039e8 - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x1538> */
	jbe    0xffffffff8100319f - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0xcef> */
	cmp    $0x12e,%esi
	je     0xffffffff810039e3 - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x1533> */
	cmp    $0x12f,%esi
	jne    0xffffffff81002c6b - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x7bb> */
	jmp    0xffffffff813a6890 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_name_to_handle_at> */
	cmp    $0x124,%esi
	je     0xffffffff810039de - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x152e> */
	jbe    0xffffffff810031d9 - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0xd29> */
	cmp    $0x127,%esi
	je     0xffffffff810039d9 - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x1529> */
	jbe    0xffffffff810031bc - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0xd0c> */
	cmp    $0x128,%esi
	je     0xffffffff810039d4 - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x1524> */
	cmp    $0x129,%esi
	jne    0xffffffff81002c6b - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x7bb> */
	jmp    0xffffffff810a7a80 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_rt_tgsigqueueinfo> */
	cmp    $0x12b,%esi
	je     0xffffffff810039cf - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x151f> */
	cmp    $0x12c,%esi
	jne    0xffffffff81002c6b - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x7bb> */
	jmp    0xffffffff81384810 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_fanotify_init> */
	cmp    $0x125,%esi
	je     0xffffffff810039ca - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x151a> */
	cmp    $0x126,%esi
	jne    0xffffffff81002c6b - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x7bb> */
	jmp    0xffffffff81380680 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_inotify_init1> */
	cmp    $0x121,%esi
	je     0xffffffff810039c5 - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x1515> */
	jbe    0xffffffff8100323e - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0xd8e> */
	cmp    $0x122,%esi
	je     0xffffffff810039c0 - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x1510> */
	cmp    $0x123,%esi
	jne    0xffffffff81002c6b - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x7bb> */
	jmp    0xffffffff813864c0 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_epoll_create1> */
	cmp    $0x131,%esi
	je     0xffffffff810039bb - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x150b> */
	cmp    $0x132,%esi
	jne    0xffffffff81002c6b - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x7bb> */
	jmp    0xffffffff8136b270 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_syncfs> */
	cmp    $0x1ba,%esi
	je     0xffffffff810039b6 - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x1506> */
	cmp    $0x1bb,%esi
	jne    0xffffffff81002c6b - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x7bb> */
	jmp    0xffffffff813b80d0 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_quotactl_fd> */
	cmp    $0x11f,%esi
	je     0xffffffff810039b1 - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x1501> */
	cmp    $0x120,%esi
	jne    0xffffffff81002c6b - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x7bb> */
	jmp    0xffffffff81b961d0 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_accept4> */
	cmp    $0x10e,%esi
	je     0xffffffff810039ac - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x14fc> */
	jbe    0xffffffff810032bb - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0xe0b> */
	cmp    $0x111,%esi
	je     0xffffffff810039a7 - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x14f7> */
	jbe    0xffffffff8100329e - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0xdee> */
	cmp    $0x112,%esi
	jne    0xffffffff81002c6b - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x7bb> */
	jmp    0xffffffff81160c90 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_get_robust_list> */
	test   %esi,%esi
	je     0xffffffff810039a2 - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x14f2> */
	cmp    $0x1,%esi
	jne    0xffffffff81002c6b - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x7bb> */
	jmp    0xffffffff81321500 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_write> */
	cmp    $0x10f,%esi
	je     0xffffffff8100399d - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x14ed> */
	cmp    $0x110,%esi
	jne    0xffffffff81002c6b - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x7bb> */
	jmp    0xffffffff8108e6d0 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_unshare> */
	cmp    $0x10b,%esi
	je     0xffffffff81003998 - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x14e8> */
	jbe    0xffffffff81003368 - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0xeb8> */
	cmp    $0x10c,%esi
	je     0xffffffff81003993 - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x14e3> */
	cmp    $0x10d,%esi
	jne    0xffffffff81002c6b - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x7bb> */
	jmp    0xffffffff8131bdc0 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_faccessat> */
	cmp    $0xd9,%esi
	je     0xffffffff8100398e - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x14de> */
	jbe    0xffffffff81003406 - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0xf56> */
	cmp    $0xe4,%esi
	je     0xffffffff81003989 - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x14d9> */
	jbe    0xffffffff810033d1 - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0xf21> */
	cmp    $0xea,%esi
	je     0xffffffff81003984 - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x14d4> */
	jbe    0xffffffff810033a2 - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0xef2> */
	cmp    $0xee,%esi
	je     0xffffffff8100397f - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x14cf> */
	jbe    0xffffffff81003385 - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0xed5> */
	cmp    $0xef,%esi
	je     0xffffffff8100397a - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x14ca> */
	cmp    $0xf0,%esi
	jne    0xffffffff81002c6b - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x7bb> */
	jmp    0xffffffff815040f0 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_mq_open> */
	cmp    $0xa0,%esi
	je     0xffffffff81003975 - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x14c5> */
	cmp    $0xa1,%esi
	jne    0xffffffff81002c6b - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x7bb> */
	jmp    0xffffffff8131c260 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_chroot> */
	cmp    $0x109,%esi
	je     0xffffffff81003970 - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x14c0> */
	cmp    $0x10a,%esi
	jne    0xffffffff81002c6b - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x7bb> */
	jmp    0xffffffff81339210 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_symlinkat> */
	cmp    $0xeb,%esi
	je     0xffffffff8100396b - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x14bb> */
	cmp    $0xed,%esi
	jne    0xffffffff81002c6b - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x7bb> */
	jmp    0xffffffff8130d160 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_mbind> */
	cmp    $0xe7,%esi
	je     0xffffffff81003ce0 - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x1830> */
	jbe    0xffffffff81003445 - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0xf95> */
	cmp    $0xe8,%esi
	je     0xffffffff81003966 - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x14b6> */
	cmp    $0xe9,%esi
	jne    0xffffffff81002c6b - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x7bb> */
	jmp    0xffffffff81387270 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_epoll_ctl> */
	cmp    $0xdf,%esi
	je     0xffffffff81003961 - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x14b1> */
	jbe    0xffffffff81003559 - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x10a9> */
	cmp    $0xe2,%esi
	je     0xffffffff8100395c - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x14ac> */
	jbe    0xffffffff8100353c - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x108c> */
	cmp    $0xe3,%esi
	jne    0xffffffff81002c6b - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x7bb> */
	jmp    0xffffffff81152780 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_clock_settime> */
	cmp    $0xc9,%esi
	je     0xffffffff81003957 - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x14a7> */
	jbe    0xffffffff810034aa - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0xffa> */
	cmp    $0xd0,%esi
	je     0xffffffff81003952 - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x14a2> */
	jbe    0xffffffff8100347f - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0xfcf> */
	cmp    $0xd5,%esi
	je     0xffffffff8100394d - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x149d> */
	jbe    0xffffffff81003462 - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0xfb2> */
	cmp    $0xd8,%esi
	jne    0xffffffff81002c6b - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x7bb> */
	jmp    0xffffffff812ca0b0 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_remap_file_pages> */
	cmp    $0xe5,%esi
	je     0xffffffff81003948 - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x1498> */
	cmp    $0xe6,%esi
	jne    0xffffffff81002c6b - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x7bb> */
	jmp    0xffffffff81153260 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_clock_nanosleep> */
	cmp    $0xd1,%esi
	je     0xffffffff81003943 - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x1493> */
	cmp    $0xd2,%esi
	jne    0xffffffff81002c6b - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x7bb> */
	jmp    0xffffffff81392ab0 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_io_cancel> */
	cmp    $0xcc,%esi
	je     0xffffffff8100393e - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x148e> */
	jbe    0xffffffff810034d7 - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x1027> */
	cmp    $0xce,%esi
	je     0xffffffff81003939 - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x1489> */
	cmp    $0xcf,%esi
	jne    0xffffffff81002c6b - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x7bb> */
	jmp    0xffffffff813923b0 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_io_destroy> */
	cmp    $0xc4,%esi
	je     0xffffffff81003934 - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x1484> */
	jbe    0xffffffff81003511 - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x1061> */
	cmp    $0xc7,%esi
	je     0xffffffff8100392f - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x147f> */
	jbe    0xffffffff810034f4 - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x1044> */
	cmp    $0xc8,%esi
	jne    0xffffffff81002c6b - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x7bb> */
	jmp    0xffffffff810a75f0 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_tkill> */
	cmp    $0xca,%esi
	je     0xffffffff8100392a - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x147a> */
	cmp    $0xcb,%esi
	jne    0xffffffff81002c6b - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x7bb> */
	jmp    0xffffffff810edfe0 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_sched_setaffinity> */
	cmp    $0xc5,%esi
	je     0xffffffff81003925 - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x1475> */
	cmp    $0xc6,%esi
	jne    0xffffffff81002c6b - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x7bb> */
	jmp    0xffffffff8135b6f0 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_lremovexattr> */
	cmp    $0xc1,%esi
	je     0xffffffff81003920 - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x1470> */
	jbe    0xffffffff81003584 - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x10d4> */
	cmp    $0xc2,%esi
	je     0xffffffff8100391b - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x146b> */
	cmp    $0xc3,%esi
	jne    0xffffffff81002c6b - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x7bb> */
	jmp    0xffffffff8135b4d0 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_llistxattr> */
	cmp    $0xe0,%esi
	je     0xffffffff81003916 - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x1466> */
	cmp    $0xe1,%esi
	jne    0xffffffff81002c6b - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x7bb> */
	jmp    0xffffffff81151ea0 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_timer_getoverrun> */
	cmp    $0xdc,%esi
	je     0xffffffff81003911 - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x1461> */
	jbe    0xffffffff810035a1 - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x10f1> */
	cmp    $0xdd,%esi
	je     0xffffffff8100390c - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x145c> */
	cmp    $0xde,%esi
	jne    0xffffffff81002c6b - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x7bb> */
	jmp    0xffffffff81151a20 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_timer_create> */
	cmp    $0xbf,%esi
	je     0xffffffff81003907 - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x1457> */
	cmp    $0xc0,%esi
	jne    0xffffffff81002c6b - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x7bb> */
	jmp    0xffffffff8135b270 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_lgetxattr> */
	cmp    $0xda,%esi
	je     0xffffffff81003902 - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x1452> */
	cmp    $0xdb,%esi
	jne    0xffffffff81002c6b - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x7bb> */
	jmp    0xffffffff810a2e20 - 0xffffffff810024b0 + x64_sys_call /* <__ia32_sys_restart_syscall> */
	cmp    $0x96,%esi
	je     0xffffffff810038fd - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x144d> */
	jbe    0xffffffff81003622 - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x1172> */
	cmp    $0x97,%esi
	je     0xffffffff810038f8 - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x1448> */
	cmp    $0x98,%esi
	jne    0xffffffff81002c6b - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x7bb> */
	jmp    0xffffffff812c2810 - 0xffffffff810024b0 + x64_sys_call /* <__ia32_sys_munlockall> */
	cmp    $0x8d,%esi
	je     0xffffffff810038f3 - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x1443> */
	jbe    0xffffffff8100365c - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x11ac> */
	cmp    $0x90,%esi
	je     0xffffffff810038ee - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x143e> */
	jbe    0xffffffff8100363f - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x118f> */
	cmp    $0x91,%esi
	je     0xffffffff810038e9 - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x1439> */
	cmp    $0x92,%esi
	jne    0xffffffff81002c6b - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x7bb> */
	jmp    0xffffffff810ee350 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_sched_get_priority_max> */
	cmp    $0x94,%esi
	je     0xffffffff810038e4 - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x1434> */
	cmp    $0x95,%esi
	jne    0xffffffff81002c6b - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x7bb> */
	jmp    0xffffffff812c2490 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_mlock> */
	cmp    $0x8e,%esi
	je     0xffffffff810038df - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x142f> */
	cmp    $0x8f,%esi
	jne    0xffffffff81002c6b - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x7bb> */
	jmp    0xffffffff810ed6b0 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_sched_getparam> */
	cmp    $0x8a,%esi
	je     0xffffffff810038da - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x142a> */
	jbe    0xffffffff810036c1 - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x1211> */
	cmp    $0x8b,%esi
	je     0xffffffff810038d5 - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x1425> */
	cmp    $0x8c,%esi
	jne    0xffffffff81002c6b - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x7bb> */
	jmp    0xffffffff810ab730 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_getpriority> */
	cmp    $0x9a,%esi
	je     0xffffffff810038d0 - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x1420> */
	cmp    $0x9b,%esi
	jne    0xffffffff81002c6b - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x7bb> */
	jmp    0xffffffff81356fe0 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_pivot_root> */
	cmp    $0x136,%esi
	je     0xffffffff810038cb - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x141b> */
	cmp    $0x137,%esi
	jne    0xffffffff81002c6b - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x7bb> */
	jmp    0xffffffff812de300 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_process_vm_writev> */
	cmp    $0x88,%esi
	je     0xffffffff810038c6 - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x1416> */
	cmp    $0x89,%esi
	jne    0xffffffff81002c6b - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x7bb> */
	jmp    0xffffffff8136e710 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_statfs> */
	cmp    $0x1a9,%esi
	je     0xffffffff810038c1 - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x1411> */
	jbe    0xffffffff81003745 - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x1295> */
	cmp    $0x1ac,%esi
	je     0xffffffff810038bc - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x140c> */
	jbe    0xffffffff81003728 - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x1278> */
	cmp    $0x1ad,%esi
	jne    0xffffffff81002c6b - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x7bb> */
	jmp    0xffffffff813566b0 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_move_mount> */
	cmp    $0x104,%esi
	je     0xffffffff810038b7 - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x1407> */
	cmp    $0x105,%esi
	jne    0xffffffff81002c6b - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x7bb> */
	jmp    0xffffffff8136c070 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_futimesat> */
	cmp    $0x1aa,%esi
	je     0xffffffff810038b2 - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x1402> */
	cmp    $0x1ab,%esi
	jne    0xffffffff81002c6b - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x7bb> */
	jmp    0xffffffff815bb5a0 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_io_uring_register> */
	cmp    $0x14e,%esi
	je     0xffffffff810038ad - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x13fd> */
	jbe    0xffffffff810037d8 - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x1328> */
	cmp    $0x14f,%esi
	je     0xffffffff810038a8 - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x13f8> */
	cmp    $0x1a8,%esi
	jne    0xffffffff81002c6b - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x7bb> */
	jmp    0xffffffff810a73d0 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_pidfd_send_signal> */
	cmp    $0x100,%esi
	je     0xffffffff810038a3 - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x13f3> */
	jbe    0xffffffff810037f5 - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x1345> */
	cmp    $0x101,%esi
	je     0xffffffff8100389e - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x13ee> */
	cmp    $0x102,%esi
	jne    0xffffffff81002c6b - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x7bb> */
	jmp    0xffffffff813387c0 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_mkdirat> */
	cmp    $0xf7,%esi
	je     0xffffffff81003899 - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x13e9> */
	jbe    0xffffffff8100382b - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x137b> */
	cmp    $0xfa,%esi
	je     0xffffffff81003894 - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x13e4> */
	jbe    0xffffffff81003812 - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x1362> */
	cmp    $0xfb,%esi
	je     0xffffffff8100388f - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x13df> */
	cmp    $0xfc,%esi
	jne    0xffffffff81002c6b - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x7bb> */
	jmp    0xffffffff81585f40 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_ioprio_get> */
	cmp    $0x14c,%esi
	je     0xffffffff8100388a - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x13da> */
	cmp    $0x14d,%esi
	jne    0xffffffff81002c6b - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x7bb> */
	jmp    0xffffffff81392f30 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_io_pgetevents> */
	cmp    $0xfe,%esi
	je     0xffffffff81003885 - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x13d5> */
	cmp    $0xff,%esi
	jne    0xffffffff81002c6b - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x7bb> */
	jmp    0xffffffff813809e0 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_inotify_rm_watch> */
	cmp    $0xf8,%esi
	je     0xffffffff81003880 - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x13d0> */
	cmp    $0xf9,%esi
	jne    0xffffffff81002c6b - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x7bb> */
	jmp    0xffffffff8150a450 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_request_key> */
	cmp    $0xf4,%esi
	je     0xffffffff8100387b - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x13cb> */
	jbe    0xffffffff8100384e - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x139e> */
	cmp    $0xf5,%esi
	je     0xffffffff81003876 - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x13c6> */
	cmp    $0xf6,%esi
	jne    0xffffffff81002c6b - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x7bb> */
	jmp    0xffffffff8116c590 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_kexec_load> */
	cmp    $0xf2,%esi
	je     0xffffffff81003871 - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x13c1> */
	cmp    $0xf3,%esi
	jne    0xffffffff81002c6b - 0xffffffff810024b0 + x64_sys_call /* <x64_sys_call+0x7bb> */
	jmp    0xffffffff81504670 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_mq_timedreceive> */
	jmp    0xffffffff81511260 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_lsm_list_modules> */
	jmp    0xffffffff81357130 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_listmount> */
	jmp    0xffffffff815044f0 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_mq_timedsend> */
	jmp    0xffffffff815048f0 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_mq_getsetattr> */
	jmp    0xffffffff815047f0 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_mq_notify> */
	jmp    0xffffffff8150a3f0 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_add_key> */
	jmp    0xffffffff81380750 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_inotify_add_watch> */
	jmp    0xffffffff81329ff0 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_statx> */
	jmp    0xffffffff81585ee0 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_ioprio_set> */
	jmp    0xffffffff8150be50 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_keyctl> */
	jmp    0xffffffff81095d60 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_waitid> */
	jmp    0xffffffff8131d8e0 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_openat> */
	jmp    0xffffffff8130aa00 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_migrate_pages> */
	jmp    0xffffffff810750c0 - 0xffffffff810024b0 + x64_sys_call /* <__ia32_sys_uretprobe> */
	jmp    0xffffffff81272810 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_rseq> */
	jmp    0xffffffff815a7ff0 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_io_uring_enter> */
	jmp    0xffffffff8131cc50 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_fchownat> */
	jmp    0xffffffff81354f90 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_open_tree> */
	jmp    0xffffffff815a80a0 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_io_uring_setup> */
	jmp    0xffffffff8136e870 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_ustat> */
	jmp    0xffffffff812de280 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_process_vm_readv> */
	jmp    0xffffffff81039330 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_modify_ldt> */
	jmp    0xffffffff8134d910 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_sysfs> */
	jmp    0xffffffff8136e7c0 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_fstatfs> */
	jmp    0xffffffff810ed0f0 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_sched_setparam> */
	jmp    0xffffffff810ee4d0 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_sched_rr_get_interval> */
	jmp    0xffffffff810ed590 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_sched_getscheduler> */
	jmp    0xffffffff810ed070 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_sched_setscheduler> */
	jmp    0xffffffff810ab6d0 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_setpriority> */
	jmp    0xffffffff812c27d0 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_mlockall> */
	jmp    0xffffffff812c25b0 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_munlock> */
	jmp    0xffffffff8108b310 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_set_tid_address> */
	jmp    0xffffffff8135b210 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_getxattr> */
	jmp    0xffffffff8127f200 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_fadvise64> */
	jmp    0xffffffff814fd900 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_semtimedop> */
	jmp    0xffffffff81151ca0 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_timer_gettime> */
	jmp    0xffffffff8135b470 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_listxattr> */
	jmp    0xffffffff8135b2d0 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_fgetxattr> */
	jmp    0xffffffff8135b690 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_removexattr> */
	jmp    0xffffffff81160ff0 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_futex> */
	jmp    0xffffffff8135b750 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_fremovexattr> */
	jmp    0xffffffff8135b530 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_flistxattr> */
	jmp    0xffffffff81392070 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_io_setup> */
	jmp    0xffffffff810ee1b0 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_sched_getaffinity> */
	jmp    0xffffffff81392590 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_io_submit> */
	jmp    0xffffffff81152b90 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_clock_getres> */
	jmp    0xffffffff81386520 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_epoll_create> */
	jmp    0xffffffff81392d90 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_io_getevents> */
	jmp    0xffffffff811401b0 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_time> */
	jmp    0xffffffff811523c0 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_timer_delete> */
	jmp    0xffffffff81151fc0 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_timer_settime> */
	jmp    0xffffffff813873d0 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_epoll_wait> */
	jmp    0xffffffff8136c0d0 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_utimes> */
	jmp    0xffffffff81339650 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_linkat> */
	jmp    0xffffffff810ae7b0 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_setrlimit> */
	jmp    0xffffffff8130aa60 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_get_mempolicy> */
	jmp    0xffffffff8130a9a0 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_set_mempolicy> */
	jmp    0xffffffff810a7430 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_tgkill> */
	jmp    0xffffffff81152920 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_clock_gettime> */
	jmp    0xffffffff8133def0 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_getdents64> */
	jmp    0xffffffff8131c8c0 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_fchmodat> */
	jmp    0xffffffff81329d50 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_readlinkat> */
	jmp    0xffffffff81340c30 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_ppoll> */
	jmp    0xffffffff813213b0 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_read> */
	jmp    0xffffffff81160c00 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_set_robust_list> */
	jmp    0xffffffff81340840 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_pselect6> */
	jmp    0xffffffff8138a0b0 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_timerfd_gettime> */
	jmp    0xffffffff81357030 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_mount_setattr> */
	jmp    0xffffffff81152b40 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_clock_adjtime> */
	jmp    0xffffffff8138ae30 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_eventfd2> */
	jmp    0xffffffff81388970 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_signalfd4> */
	jmp    0xffffffff8132f870 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_pipe2> */
	jmp    0xffffffff81b97fc0 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_recvmmsg> */
	jmp    0xffffffff81321c50 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_pwritev> */
	jmp    0xffffffff81321aa0 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_preadv> */
	jmp    0xffffffff8134cec0 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_dup3> */
	jmp    0xffffffff810ae750 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_prlimit64> */
	jmp    0xffffffff81384870 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_fanotify_mark> */
	jmp    0xffffffff81371dc0 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_fsconfig> */
	jmp    0xffffffff8136ac60 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_tee> */
	jmp    0xffffffff8131da40 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_openat2> */
	jmp    0xffffffff810bb460 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_pidfd_open> */
	jmp    0xffffffff81371aa0 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_fspick> */
	jmp    0xffffffff81329ca0 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_newfstatat> */
	jmp    0xffffffff81338510 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_mknodat> */
	jmp    0xffffffff813806e0 - 0xffffffff810024b0 + x64_sys_call /* <__ia32_sys_inotify_init> */
	jmp    0xffffffff81169770 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_acct> */
	jmp    0xffffffff8136b1e0 - 0xffffffff810024b0 + x64_sys_call /* <__ia32_sys_sync> */
	jmp    0xffffffff8113b920 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_finit_module> */
	jmp    0xffffffff8113e8f0 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_kcmp> */
	jmp    0xffffffff8153fc50 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_landlock_add_rule> */
	jmp    0xffffffff8153fbf0 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_landlock_create_ruleset> */
	jmp    0xffffffff81312f00 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_move_pages> */
	jmp    0xffffffff8136a580 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_vmsplice> */
	jmp    0xffffffff8131dfe0 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_close> */
	jmp    0xffffffff8131d780 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_open> */
	jmp    0xffffffff81329c50 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_newlstat> */
	jmp    0xffffffff812c8660 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_brk> */
	jmp    0xffffffff8103b8d0 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_mmap> */
	jmp    0xffffffff8131ff00 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_lseek> */
	jmp    0xffffffff81329d00 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_newfstat> */
	jmp    0xffffffff81032830 - 0xffffffff810024b0 + x64_sys_call /* <__ia32_sys_rt_sigreturn> */
	jmp    0xffffffff810a3110 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_rt_sigprocmask> */
	jmp    0xffffffff813407c0 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_select> */
	jmp    0xffffffff81321850 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_pwrite64> */
	jmp    0xffffffff812cf360 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_msync> */
	jmp    0xffffffff812ceff0 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_mremap> */
	jmp    0xffffffff810a93b0 - 0xffffffff810024b0 + x64_sys_call /* <__ia32_sys_pause> */
	jmp    0xffffffff810abbe0 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_setreuid> */
	jmp    0xffffffff81156b80 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_alarm> */
	jmp    0xffffffff811566d0 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_getitimer> */
	jmp    0xffffffff81500420 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_shmget> */
	jmp    0xffffffff81321a40 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_writev> */
	jmp    0xffffffff81321610 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_pread64> */
	jmp    0xffffffff812c7160 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_munmap> */
	jmp    0xffffffff81500540 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_shmctl> */
	jmp    0xffffffff812f2dc0 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_madvise> */
	jmp    0xffffffff8131c920 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_chmod> */
	jmp    0xffffffff81b96b10 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_recvfrom> */
	jmp    0xffffffff810ac810 - 0xffffffff810024b0 + x64_sys_call /* <__ia32_sys_getegid> */
	jmp    0xffffffff8131cf30 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_fchown> */
	jmp    0xffffffff8131ccd0 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_chown> */
	jmp    0xffffffff81140510 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_gettimeofday> */
	jmp    0xffffffff810ac750 - 0xffffffff810024b0 + x64_sys_call /* <__ia32_sys_getuid> */
	jmp    0xffffffff810afa70 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_sysinfo> */
	jmp    0xffffffff810aee50 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_getrusage> */
	jmp    0xffffffff810aeef0 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_umask> */
	jmp    0xffffffff810abd60 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_setuid> */
	jmp    0xffffffff810ac7d0 - 0xffffffff810024b0 + x64_sys_call /* <__ia32_sys_getgid> */
	jmp    0xffffffff813226a0 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_sendfile64> */
	jmp    0xffffffff810ca510 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_setgroups> */
	jmp    0xffffffff810ca380 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_getgroups> */
	jmp    0xffffffff81b96fc0 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_shutdown> */
	jmp    0xffffffff81b97a80 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_recvmsg> */
	jmp    0xffffffff81b96530 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_getsockname> */
	jmp    0xffffffff8108e160 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_clone> */
	jmp    0xffffffff81b95ba0 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_socketpair> */
	jmp    0xffffffff81b95ed0 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_listen> */
	jmp    0xffffffff8131c860 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_fchmodat2> */
	jmp    0xffffffff81387870 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_epoll_pwait2> */
	jmp    0xffffffff812ccee0 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_pkey_free> */
	jmp    0xffffffff81389f50 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_timerfd_settime> */
	jmp    0xffffffff8135ada0 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_setxattr> */
	jmp    0xffffffff813b7d30 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_quotactl> */
	jmp    0xffffffff810ad310 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_sethostname> */
	jmp    0xffffffff81140d00 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_adjtimex> */
	jmp    0xffffffff8108e900 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_personality> */
	jmp    0xffffffff81329dd0 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_readlink> */
	jmp    0xffffffff8135aea0 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_fsetxattr> */
	jmp    0xffffffff8132d4f0 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_execve> */
	jmp    0xffffffff8108e0e0 - 0xffffffff810024b0 + x64_sys_call /* <__ia32_sys_vfork> */
	jmp    0xffffffff810a7270 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_kill> */
	jmp    0xffffffff814f8d90 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_msgget> */
	jmp    0xffffffff81b96400 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_connect> */
	jmp    0xffffffff810ac6a0 - 0xffffffff810024b0 + x64_sys_call /* <__ia32_sys_getpid> */
	jmp    0xffffffff8134cf20 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_dup2> */
	jmp    0xffffffff8132f8d0 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_pipe> */
	jmp    0xffffffff814fdcb0 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_semop> */
	jmp    0xffffffff814fc270 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_semget> */
	jmp    0xffffffff81096120 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_wait4> */
	jmp    0xffffffff81b96e50 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_getsockopt> */
	jmp    0xffffffff814f8eb0 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_msgctl> */
	jmp    0xffffffff814f9220 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_msgrcv> */
	jmp    0xffffffff8136b3d0 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_fsync> */
	jmp    0xffffffff8136d3b0 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_getcwd> */
	jmp    0xffffffff8131b740 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_truncate> */
	jmp    0xffffffff813993b0 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_flock> */
	jmp    0xffffffff81339f50 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_rename> */
	jmp    0xffffffff8131c0c0 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_fchdir> */
	jmp    0xffffffff810acd60 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_getsid> */
	jmp    0xffffffff8131dee0 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_creat> */
	jmp    0xffffffff810a3490 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_rt_sigpending> */
	jmp    0xffffffff8109d1f0 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_capset> */
	jmp    0xffffffff810ac320 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_setresgid> */
	jmp    0xffffffff810ac700 - 0xffffffff810024b0 + x64_sys_call /* <__ia32_sys_getppid> */
	jmp    0xffffffff810ac790 - 0xffffffff810024b0 + x64_sys_call /* <__ia32_sys_geteuid> */
	jmp    0xffffffff8109ef50 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_ptrace> */
	jmp    0xffffffff810accb0 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_getpgid> */
	jmp    0xffffffff810ac030 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_getresuid> */
	jmp    0xffffffff810a9410 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_rt_sigsuspend> */
	jmp    0xffffffff81338ff0 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_unlink> */
	jmp    0xffffffff81338b20 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_rmdir> */
	jmp    0xffffffff8133dcb0 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_getdents> */
	jmp    0xffffffff81501090 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_shmdt> */
	jmp    0xffffffff81b968f0 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_sendto> */
	jmp    0xffffffff8136c130 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_utime> */
	jmp    0xffffffff810a7790 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_rt_sigqueueinfo> */
	jmp    0xffffffff810ac660 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_setfsgid> */
	jmp    0xffffffff810acfb0 - 0xffffffff810024b0 + x64_sys_call /* <__ia32_sys_setsid> */
	jmp    0xffffffff81353560 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_umount> */
	jmp    0xffffffff810af910 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_prctl> */
	jmp    0xffffffff8131e160 - 0xffffffff810024b0 + x64_sys_call /* <__ia32_sys_vhangup> */
	jmp    0xffffffff810ee410 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_sched_get_priority_min> */
	jmp    0xffffffff812fae70 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_swapoff> */
	jmp    0xffffffff813563b0 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_mount> */
	jmp    0xffffffff811f2320 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_bpf> */
	jmp    0xffffffff81388a90 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_signalfd> */
	jmp    0xffffffff810f6970 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_membarrier> */
	jmp    0xffffffff8138ef10 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_userfaultfd> */
	jmp    0xffffffff81339db0 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_renameat2> */
	jmp    0xffffffff81b97920 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_sendmmsg> */
	jmp    0xffffffff813a6a30 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_open_by_handle_at> */
	jmp    0xffffffff81267190 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_perf_event_open> */
	jmp    0xffffffff816f8620 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_getrandom> */
	jmp    0xffffffff810ed8b0 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_sched_getattr> */
	jmp    0xffffffff81321bd0 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_preadv2> */
	jmp    0xffffffff8138ae90 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_eventfd> */
	jmp    0xffffffff813875f0 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_epoll_pwait> */
	jmp    0xffffffff8136a5e0 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_splice> */
	jmp    0xffffffff81339e90 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_renameat> */
	jmp    0xffffffff81504230 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_mq_unlink> */
	jmp    0xffffffff812cce30 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_pkey_mprotect> */
	jmp    0xffffffff81323480 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_copy_file_range> */
	jmp    0xffffffff8116de80 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_kexec_file_load> */
	jmp    0xffffffff810af970 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_getcpu> */
	jmp    0xffffffff8127ed80 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_process_mrelease> */
	jmp    0xffffffff8131be20 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_faccessat2> */
	jmp    0xffffffff8131e100 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_close_range> */
	jmp    0xffffffff81371800 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_fsopen> */
	jmp    0xffffffff8130ca50 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_set_mempolicy_home_node> */
	jmp    0xffffffff81315860 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_memfd_secret> */
	jmp    0xffffffff810783f0 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_map_shadow_stack> */
	jmp    0xffffffff810ad990 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_setdomainname> */
	jmp    0xffffffff81161cf0 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_futex_requeue> */
	jmp    0xffffffff81161a90 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_futex_wait> */
	jmp    0xffffffff81511200 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_lsm_get_self_attr> */
	jmp    0xffffffff8113b8c0 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_init_module> */
	jmp    0xffffffff81037090 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_ioperm> */
	jmp    0xffffffff810ac6d0 - 0xffffffff810024b0 + x64_sys_call /* <__ia32_sys_gettid> */
	call   0xffffffff810954a0 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_exit_group> */
	call   0xffffffff810953b0 - 0xffffffff810024b0 + x64_sys_call /* <__x64_sys_exit> */

.size x64_sys_call, . - x64_sys_call

.globl x32_sys_call
.type x32_sys_call @function
x32_sys_call:
	endbr64
	cmp    $0xd0,%esi
	je     0xffffffff810082ce - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x179e> */
	ja     0xffffffff81006bbc - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x8c> */
	cmp    $0x64,%esi
	je     0xffffffff810082c9 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x1799> */
	jbe    0xffffffff8100704e - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x51e> */
	cmp    $0x97,%esi
	je     0xffffffff810082c4 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x1794> */
	jbe    0xffffffff81006ffc - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x4cc> */
	cmp    $0xb0,%esi
	je     0xffffffff810082bf - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x178f> */
	jbe    0xffffffff81006f98 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x468> */
	cmp    $0xc3,%esi
	je     0xffffffff810082ba - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x178a> */
	jbe    0xffffffff81006f67 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x437> */
	cmp    $0xc9,%esi
	je     0xffffffff810082b5 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x1785> */
	jbe    0xffffffff81006c4e - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x11e> */
	cmp    $0xcc,%esi
	je     0xffffffff810082b0 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x1780> */
	jbe    0xffffffff81006c31 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x101> */
	cmp    $0xcf,%esi
	je     0xffffffff810082ab - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x177b> */
	jmp    0xffffffff81003d20 - 0xffffffff81006b30 + x32_sys_call /* <__ia32_sys_ni_syscall> */
	cmp    $0x13f,%esi
	je     0xffffffff810082a6 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x1776> */
	jbe    0xffffffff81006de5 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x2b5> */
	cmp    $0x1c7,%esi
	je     0xffffffff810082a1 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x1771> */
	jbe    0xffffffff81006d90 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x260> */
	cmp    $0x20e,%esi
	je     0xffffffff8100829c - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x176c> */
	jbe    0xffffffff81006d2c - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x1fc> */
	cmp    $0x219,%esi
	je     0xffffffff81008297 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x1767> */
	jbe    0xffffffff81006cfb - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x1cb> */
	cmp    $0x21f,%esi
	je     0xffffffff81008292 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x1762> */
	jbe    0xffffffff81006c96 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x166> */
	cmp    $0x222,%esi
	je     0xffffffff81008003 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x14d3> */
	jbe    0xffffffff81006c79 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x149> */
	cmp    $0x223,%esi
	jne    0xffffffff81006bb7 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x87> */
	jmp    0xffffffff81322430 - 0xffffffff81006b30 + x32_sys_call /* <__x64_compat_sys_pwritev64v2> */
	cmp    $0xca,%esi
	je     0xffffffff8100828d - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x175d> */
	cmp    $0xcb,%esi
	jne    0xffffffff81006bb7 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x87> */
	jmp    0xffffffff810edfe0 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_sched_setaffinity> */
	cmp    $0xc6,%esi
	je     0xffffffff81008288 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x1758> */
	jbe    0xffffffff81006cc1 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x191> */
	cmp    $0xc7,%esi
	je     0xffffffff81008369 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x1839> */
	cmp    $0xc8,%esi
	jne    0xffffffff81006bb7 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x87> */
	jmp    0xffffffff810a75f0 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_tkill> */
	cmp    $0x220,%esi
	je     0xffffffff81008364 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x1834> */
	cmp    $0x221,%esi
	jne    0xffffffff81006bb7 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x87> */
	jmp    0xffffffff8132d7c0 - 0xffffffff81006b30 + x32_sys_call /* <__x64_compat_sys_execveat> */
	cmp    $0x21c,%esi
	je     0xffffffff8100835f - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x182f> */
	jbe    0xffffffff81006cde - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x1ae> */
	cmp    $0x21d,%esi
	je     0xffffffff8100835a - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x182a> */
	cmp    $0x21e,%esi
	jne    0xffffffff81006bb7 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x87> */
	jmp    0xffffffff81b96e50 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_getsockopt> */
	cmp    $0xc4,%esi
	je     0xffffffff81008355 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x1825> */
	cmp    $0xc5,%esi
	jne    0xffffffff81006bb7 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x87> */
	jmp    0xffffffff8135b690 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_removexattr> */
	cmp    $0x21a,%esi
	je     0xffffffff81008350 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x1820> */
	cmp    $0x21b,%esi
	jne    0xffffffff81006bb7 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x87> */
	jmp    0xffffffff812de280 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_process_vm_readv> */
	cmp    $0x214,%esi
	je     0xffffffff8100834b - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x181b> */
	jbe    0xffffffff810076ae - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0xb7e> */
	cmp    $0x217,%esi
	je     0xffffffff81008346 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x1816> */
	jbe    0xffffffff81006d73 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x243> */
	cmp    $0x218,%esi
	jne    0xffffffff81006bb7 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x87> */
	jmp    0xffffffff810a7d00 - 0xffffffff81006b30 + x32_sys_call /* <__x64_compat_sys_rt_tgsigqueueinfo> */
	cmp    $0x203,%esi
	je     0xffffffff81007ffe - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x14ce> */
	jbe    0xffffffff81007da3 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x1273> */
	cmp    $0x209,%esi
	je     0xffffffff8100832d - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x17fd> */
	jbe    0xffffffff81007782 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0xc52> */
	cmp    $0x20c,%esi
	je     0xffffffff81008328 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x17f8> */
	jbe    0xffffffff810077ad - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0xc7d> */
	cmp    $0x20d,%esi
	jne    0xffffffff81006bb7 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x87> */
	jmp    0xffffffff810a83a0 - 0xffffffff81006b30 + x32_sys_call /* <__x64_compat_sys_sigaltstack> */
	cmp    $0x215,%esi
	je     0xffffffff81008337 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x1807> */
	cmp    $0x216,%esi
	jne    0xffffffff81006bb7 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x87> */
	jmp    0xffffffff81321ef0 - 0xffffffff81006b30 + x32_sys_call /* <__x64_compat_sys_preadv64> */
	cmp    $0x1b1,%esi
	je     0xffffffff81008341 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x1811> */
	jbe    0xffffffff81006e9e - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x36e> */
	cmp    $0x1bc,%esi
	je     0xffffffff8100833c - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x180c> */
	jbe    0xffffffff81006e6d - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x33d> */
	cmp    $0x1c2,%esi
	je     0xffffffff81008323 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x17f3> */
	jbe    0xffffffff81006f02 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x3d2> */
	cmp    $0x1c5,%esi
	je     0xffffffff8100831e - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x17ee> */
	jbe    0xffffffff81006e50 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x320> */
	cmp    $0x1c6,%esi
	jne    0xffffffff81006bb7 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x87> */
	jmp    0xffffffff81161930 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_futex_wake> */
	cmp    $0x107,%esi
	je     0xffffffff81008332 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x1802> */
	jbe    0xffffffff810079b3 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0xe83> */
	cmp    $0x122,%esi
	je     0xffffffff81008391 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x1861> */
	jbe    0xffffffff8100773b - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0xc0b> */
	cmp    $0x131,%esi
	je     0xffffffff8100838c - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x185c> */
	jbe    0xffffffff81007924 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0xdf4> */
	cmp    $0x13a,%esi
	je     0xffffffff81008387 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x1857> */
	jbe    0xffffffff8100767f - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0xb4f> */
	cmp    $0x13d,%esi
	je     0xffffffff81008382 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x1852> */
	jbe    0xffffffff81006f2d - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x3fd> */
	cmp    $0x13e,%esi
	jne    0xffffffff81006bb7 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x87> */
	jmp    0xffffffff816f8620 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_getrandom> */
	cmp    $0x1c3,%esi
	je     0xffffffff8100839b - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x186b> */
	cmp    $0x1c4,%esi
	jne    0xffffffff81006bb7 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x87> */
	jmp    0xffffffff8131c860 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_fchmodat2> */
	cmp    $0x1b7,%esi
	je     0xffffffff810083a5 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x1875> */
	jbe    0xffffffff810076dd - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0xbad> */
	cmp    $0x1ba,%esi
	je     0xffffffff810083a0 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x1870> */
	jbe    0xffffffff81006ee5 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x3b5> */
	cmp    $0x1bb,%esi
	jne    0xffffffff81006bb7 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x87> */
	jmp    0xffffffff813b80d0 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_quotactl_fd> */
	cmp    $0x14e,%esi
	je     0xffffffff81008396 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x1866> */
	jbe    0xffffffff8100782f - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0xcff> */
	cmp    $0x1ac,%esi
	je     0xffffffff810083b9 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x1889> */
	jbe    0xffffffff81007804 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0xcd4> */
	cmp    $0x1af,%esi
	je     0xffffffff810083b4 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x1884> */
	jbe    0xffffffff810078cd - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0xd9d> */
	cmp    $0x1b0,%esi
	jne    0xffffffff81006bb7 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x87> */
	jmp    0xffffffff81356650 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_fsmount> */
	cmp    $0x1b8,%esi
	je     0xffffffff810080a3 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x1573> */
	cmp    $0x1b9,%esi
	jne    0xffffffff81006bb7 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x87> */
	jmp    0xffffffff81387870 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_epoll_pwait2> */
	cmp    $0x1bf,%esi
	je     0xffffffff81007f45 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x1415> */
	jbe    0xffffffff81006f4a - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x41a> */
	cmp    $0x1c0,%esi
	je     0xffffffff81007f40 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x1410> */
	cmp    $0x1c1,%esi
	jne    0xffffffff81006bb7 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x87> */
	jmp    0xffffffff81161650 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_futex_waitv> */
	cmp    $0x13b,%esi
	je     0xffffffff81007f59 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x1429> */
	cmp    $0x13c,%esi
	jne    0xffffffff81006bb7 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x87> */
	jmp    0xffffffff81339db0 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_renameat2> */
	cmp    $0x1bd,%esi
	je     0xffffffff81007f54 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x1424> */
	cmp    $0x1be,%esi
	jne    0xffffffff81006bb7 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x87> */
	jmp    0xffffffff8153fdf0 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_landlock_restrict_self> */
	cmp    $0xbe,%esi
	je     0xffffffff81007f4f - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x141f> */
	jbe    0xffffffff8100770c - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0xbdc> */
	cmp    $0xc1,%esi
	je     0xffffffff81007f4a - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x141a> */
	jbe    0xffffffff81006fdf - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x4af> */
	cmp    $0xc2,%esi
	jne    0xffffffff81006bb7 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x87> */
	jmp    0xffffffff8135b470 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_listxattr> */
	cmp    $0xa4,%esi
	je     0xffffffff8100809e - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x156e> */
	jbe    0xffffffff81007cae - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x117e> */
	cmp    $0xaa,%esi
	je     0xffffffff810083af - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x187f> */
	jbe    0xffffffff81007c83 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x1153> */
	cmp    $0xad,%esi
	je     0xffffffff810083aa - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x187a> */
	jbe    0xffffffff81007d4c - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x121c> */
	cmp    $0xaf,%esi
	jne    0xffffffff81006bb7 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x87> */
	jmp    0xffffffff8113b8c0 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_init_module> */
	cmp    $0xbf,%esi
	je     0xffffffff81008373 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x1843> */
	cmp    $0xc0,%esi
	jne    0xffffffff81006bb7 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x87> */
	jmp    0xffffffff8135b270 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_lgetxattr> */
	cmp    $0x7c,%esi
	je     0xffffffff8100837d - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x184d> */
	jbe    0xffffffff810070f5 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x5c5> */
	cmp    $0x8c,%esi
	je     0xffffffff81008378 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x1848> */
	jbe    0xffffffff810070c4 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x594> */
	cmp    $0x92,%esi
	je     0xffffffff8100823d - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x170d> */
	jbe    0xffffffff8100714d - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x61d> */
	cmp    $0x95,%esi
	je     0xffffffff81008238 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x1708> */
	jbe    0xffffffff810070a7 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x577> */
	cmp    $0x96,%esi
	jne    0xffffffff81006bb7 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x87> */
	jmp    0xffffffff812c25b0 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_munlock> */
	cmp    $0x34,%esi
	je     0xffffffff8100836e - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x183e> */
	jbe    0xffffffff8100727d - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x74d> */
	cmp    $0x4e,%esi
	je     0xffffffff81008251 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x1721> */
	jbe    0xffffffff81007246 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x716> */
	cmp    $0x59,%esi
	je     0xffffffff8100824c - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x171c> */
	jbe    0xffffffff810071ce - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x69e> */
	cmp    $0x5f,%esi
	je     0xffffffff81008247 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x1717> */
	jbe    0xffffffff810071ac - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x67c> */
	cmp    $0x62,%esi
	je     0xffffffff81008242 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x1712> */
	jbe    0xffffffff81007178 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x648> */
	cmp    $0x63,%esi
	jne    0xffffffff81006bb7 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x87> */
	jmp    0xffffffff810afa70 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_sysinfo> */
	cmp    $0x93,%esi
	je     0xffffffff8100825b - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x172b> */
	cmp    $0x94,%esi
	jne    0xffffffff81006bb7 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x87> */
	jmp    0xffffffff810ee4d0 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_sched_rr_get_interval> */
	cmp    $0x87,%esi
	je     0xffffffff81008265 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x1735> */
	jbe    0xffffffff81007398 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x868> */
	cmp    $0x8a,%esi
	je     0xffffffff81008260 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x1730> */
	jbe    0xffffffff81007130 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x600> */
	cmp    $0x8b,%esi
	jne    0xffffffff81006bb7 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x87> */
	jmp    0xffffffff8134d910 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_sysfs> */
	cmp    $0x71,%esi
	je     0xffffffff81008256 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x1726> */
	jbe    0xffffffff81007400 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x8d0> */
	cmp    $0x77,%esi
	je     0xffffffff81008233 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x1703> */
	jbe    0xffffffff810073de - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x8ae> */
	cmp    $0x7a,%esi
	je     0xffffffff8100822e - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x16fe> */
	jbe    0xffffffff8100747d - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x94d> */
	cmp    $0x7b,%esi
	jne    0xffffffff81006bb7 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x87> */
	jmp    0xffffffff810ac660 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_setfsgid> */
	cmp    $0x88,%esi
	je     0xffffffff8100816b - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x163b> */
	cmp    $0x89,%esi
	jne    0xffffffff81006bb7 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x87> */
	jmp    0xffffffff8136e710 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_statfs> */
	cmp    $0x8f,%esi
	je     0xffffffff810080ad - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x157d> */
	jbe    0xffffffff8100718f - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x65f> */
	cmp    $0x90,%esi
	je     0xffffffff810080a8 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x1578> */
	cmp    $0x91,%esi
	jne    0xffffffff81006bb7 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x87> */
	jmp    0xffffffff810ed590 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_sched_getscheduler> */
	cmp    $0x60,%esi
	je     0xffffffff810080c1 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x1591> */
	cmp    $0x61,%esi
	jne    0xffffffff81006bb7 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x87> */
	jmp    0xffffffff810ade30 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_getrlimit> */
	cmp    $0x8d,%esi
	je     0xffffffff810080bc - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x158c> */
	cmp    $0x8e,%esi
	jne    0xffffffff81006bb7 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x87> */
	jmp    0xffffffff810ed0f0 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_sched_setparam> */
	cmp    $0x5c,%esi
	je     0xffffffff810080b7 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x1587> */
	jbe    0xffffffff810071f2 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x6c2> */
	cmp    $0x5d,%esi
	je     0xffffffff810080b2 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x1582> */
	cmp    $0x5e,%esi
	jne    0xffffffff81006bb7 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x87> */
	jmp    0xffffffff8131cd50 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_lchown> */
	cmp    $0x54,%esi
	je     0xffffffff810080d5 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x15a5> */
	jbe    0xffffffff81007220 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x6f0> */
	cmp    $0x57,%esi
	je     0xffffffff810080d0 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x15a0> */
	jbe    0xffffffff81007209 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x6d9> */
	cmp    $0x58,%esi
	jne    0xffffffff81006bb7 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x87> */
	jmp    0xffffffff813392b0 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_symlink> */
	cmp    $0x5a,%esi
	je     0xffffffff81008166 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x1636> */
	cmp    $0x5b,%esi
	jne    0xffffffff81006bb7 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x87> */
	jmp    0xffffffff8131c740 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_fchmod> */
	cmp    $0x55,%esi
	je     0xffffffff810080e9 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x15b9> */
	cmp    $0x56,%esi
	jne    0xffffffff81006bb7 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x87> */
	jmp    0xffffffff81339740 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_link> */
	cmp    $0x51,%esi
	je     0xffffffff810080e4 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x15b4> */
	jbe    0xffffffff810072c7 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x797> */
	cmp    $0x52,%esi
	je     0xffffffff810080df - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x15af> */
	cmp    $0x53,%esi
	jne    0xffffffff81006bb7 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x87> */
	jmp    0xffffffff81338860 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_mkdir> */
	cmp    $0x43,%esi
	je     0xffffffff810080da - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x15aa> */
	jbe    0xffffffff81007317 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x7e7> */
	cmp    $0x49,%esi
	je     0xffffffff81008279 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x1749> */
	jbe    0xffffffff810072f5 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x7c5> */
	cmp    $0x4c,%esi
	je     0xffffffff81008274 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x1744> */
	jbe    0xffffffff810072de - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x7ae> */
	cmp    $0x4d,%esi
	jne    0xffffffff81006bb7 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x87> */
	jmp    0xffffffff8131ba30 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_ftruncate> */
	cmp    $0x1b,%esi
	je     0xffffffff8100826f - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x173f> */
	jbe    0xffffffff810074ea - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x9ba> */
	cmp    $0x26,%esi
	je     0xffffffff810080cb - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x159b> */
	jbe    0xffffffff810074c2 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x992> */
	cmp    $0x2c,%esi
	je     0xffffffff810080c6 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x1596> */
	jbe    0xffffffff8100753c - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0xa0c> */
	cmp    $0x32,%esi
	je     0xffffffff8100826a - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x173a> */
	jbe    0xffffffff810073c7 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x897> */
	cmp    $0x33,%esi
	jne    0xffffffff81006bb7 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x87> */
	jmp    0xffffffff81b96530 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_getsockname> */
	cmp    $0x4f,%esi
	je     0xffffffff81008189 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x1659> */
	cmp    $0x50,%esi
	jne    0xffffffff81006bb7 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x87> */
	jmp    0xffffffff8131bee0 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_chdir> */
	cmp    $0x4a,%esi
	je     0xffffffff81008184 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x1654> */
	cmp    $0x4b,%esi
	jne    0xffffffff81006bb7 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x87> */
	jmp    0xffffffff8136b4b0 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_fdatasync> */
	cmp    $0x46,%esi
	je     0xffffffff8100817f - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x164f> */
	jbe    0xffffffff81007344 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x814> */
	cmp    $0x47,%esi
	je     0xffffffff8100817a - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x164a> */
	cmp    $0x48,%esi
	jne    0xffffffff81006bb7 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x87> */
	jmp    0xffffffff8133b120 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_fcntl> */
	cmp    $0x3d,%esi
	je     0xffffffff81008175 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x1645> */
	jbe    0xffffffff81007372 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x842> */
	cmp    $0x40,%esi
	je     0xffffffff81008170 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x1640> */
	jbe    0xffffffff8100735b - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x82b> */
	cmp    $0x41,%esi
	je     0xffffffff81008283 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x1753> */
	cmp    $0x42,%esi
	jne    0xffffffff81006bb7 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x87> */
	jmp    0xffffffff814fc3b0 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_semctl> */
	cmp    $0x44,%esi
	je     0xffffffff8100827e - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x174e> */
	cmp    $0x45,%esi
	jne    0xffffffff81006bb7 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x87> */
	jmp    0xffffffff814f9070 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_msgsnd> */
	cmp    $0x3e,%esi
	je     0xffffffff81008102 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x15d2> */
	cmp    $0x3f,%esi
	jne    0xffffffff81006bb7 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x87> */
	jmp    0xffffffff810acfd0 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_newuname> */
	cmp    $0x39,%esi
	je     0xffffffff810080fd - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x15cd> */
	jbe    0xffffffff81007494 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x964> */
	cmp    $0x3a,%esi
	je     0xffffffff810080f8 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x15c8> */
	cmp    $0x3c,%esi
	jne    0xffffffff81006bb7 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x87> */
	call   0xffffffff810953b0 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_exit> */
	cmp    $0x82,%esi
	je     0xffffffff81008116 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x15e6> */
	jbe    0xffffffff8100755e - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0xa2e> */
	cmp    $0x84,%esi
	je     0xffffffff81008111 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x15e1> */
	cmp    $0x85,%esi
	jne    0xffffffff81006bb7 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x87> */
	jmp    0xffffffff813385b0 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_mknod> */
	cmp    $0x30,%esi
	je     0xffffffff8100810c - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x15dc> */
	cmp    $0x31,%esi
	jne    0xffffffff81006bb7 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x87> */
	jmp    0xffffffff81b95d60 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_bind> */
	cmp    $0x74,%esi
	je     0xffffffff81008107 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x15d7> */
	jbe    0xffffffff8100742d - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x8fd> */
	cmp    $0x75,%esi
	je     0xffffffff81008161 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x1631> */
	cmp    $0x76,%esi
	jne    0xffffffff81006bb7 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x87> */
	jmp    0xffffffff810ac030 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_getresuid> */
	cmp    $0x6b,%esi
	je     0xffffffff8100815c - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x162c> */
	jbe    0xffffffff8100745b - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x92b> */
	cmp    $0x6e,%esi
	je     0xffffffff81008157 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x1627> */
	jbe    0xffffffff81007444 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x914> */
	cmp    $0x6f,%esi
	je     0xffffffff81008152 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x1622> */
	cmp    $0x70,%esi
	jne    0xffffffff81006bb7 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x87> */
	jmp    0xffffffff810acfb0 - 0xffffffff81006b30 + x32_sys_call /* <__ia32_sys_setsid> */
	cmp    $0x72,%esi
	je     0xffffffff8100814d - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x161d> */
	cmp    $0x73,%esi
	jne    0xffffffff81006bb7 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x87> */
	jmp    0xffffffff810ca380 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_getgroups> */
	cmp    $0x6c,%esi
	je     0xffffffff81008148 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x1618> */
	cmp    $0x6d,%esi
	jne    0xffffffff81006bb7 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x87> */
	jmp    0xffffffff810acc50 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_setpgid> */
	cmp    $0x68,%esi
	je     0xffffffff81008143 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x1613> */
	jbe    0xffffffff810074ab - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x97b> */
	cmp    $0x69,%esi
	je     0xffffffff8100813e - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x160e> */
	cmp    $0x6a,%esi
	jne    0xffffffff81006bb7 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x87> */
	jmp    0xffffffff810aba10 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_setgid> */
	cmp    $0x78,%esi
	je     0xffffffff810081b1 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x1681> */
	cmp    $0x79,%esi
	jne    0xffffffff81006bb7 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x87> */
	jmp    0xffffffff810accb0 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_getpgid> */
	cmp    $0x35,%esi
	je     0xffffffff810081ac - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x167c> */
	cmp    $0x38,%esi
	jne    0xffffffff81006bb7 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x87> */
	jmp    0xffffffff8108e160 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_clone> */
	cmp    $0x66,%esi
	je     0xffffffff810081a7 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x1677> */
	cmp    $0x67,%esi
	jne    0xffffffff81006bb7 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x87> */
	jmp    0xffffffff81106d40 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_syslog> */
	cmp    $0x21,%esi
	je     0xffffffff810081a2 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x1672> */
	jbe    0xffffffff8100758c - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0xa5c> */
	cmp    $0x24,%esi
	je     0xffffffff81008193 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x1663> */
	jbe    0xffffffff81007525 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x9f5> */
	cmp    $0x25,%esi
	jne    0xffffffff81006bb7 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x87> */
	jmp    0xffffffff81156b80 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_alarm> */
	cmp    $0xb,%esi
	je     0xffffffff8100819d - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x166d> */
	jbe    0xffffffff810075fe - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0xace> */
	cmp    $0x16,%esi
	je     0xffffffff81008198 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x1668> */
	jbe    0xffffffff810075dc - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0xaac> */
	cmp    $0x19,%esi
	je     0xffffffff8100818e - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x165e> */
	jbe    0xffffffff810075ae - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0xa7e> */
	cmp    $0x1a,%esi
	jne    0xffffffff81006bb7 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x87> */
	jmp    0xffffffff812cf360 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_msync> */
	cmp    $0x22,%esi
	je     0xffffffff810081c5 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x1695> */
	cmp    $0x23,%esi
	jne    0xffffffff81006bb7 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x87> */
	jmp    0xffffffff81146f40 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_nanosleep> */
	cmp    $0x29,%esi
	je     0xffffffff810081c0 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x1690> */
	jbe    0xffffffff81007575 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0xa45> */
	cmp    $0x2a,%esi
	je     0xffffffff810081d9 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x16a9> */
	cmp    $0x2b,%esi
	jne    0xffffffff81006bb7 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x87> */
	jmp    0xffffffff81b96230 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_accept> */
	cmp    $0x7d,%esi
	je     0xffffffff810081d4 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x16a4> */
	cmp    $0x7e,%esi
	jne    0xffffffff81006bb7 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x87> */
	jmp    0xffffffff8109d1f0 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_capset> */
	cmp    $0x27,%esi
	je     0xffffffff810081cf - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x169f> */
	cmp    $0x28,%esi
	jne    0xffffffff81006bb7 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x87> */
	jmp    0xffffffff813226a0 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_sendfile64> */
	cmp    $0x1e,%esi
	je     0xffffffff810081ca - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x169a> */
	jbe    0xffffffff810075c5 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0xa95> */
	cmp    $0x1f,%esi
	je     0xffffffff81007ff9 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x14c9> */
	cmp    $0x20,%esi
	jne    0xffffffff81006bb7 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x87> */
	jmp    0xffffffff8134d100 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_dup> */
	cmp    $0x17,%esi
	je     0xffffffff81007ff4 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x14c4> */
	cmp    $0x18,%esi
	jne    0xffffffff81006bb7 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x87> */
	jmp    0xffffffff810ee330 - 0xffffffff81006b30 + x32_sys_call /* <__ia32_sys_sched_yield> */
	cmp    $0x1c,%esi
	je     0xffffffff81007fef - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x14bf> */
	cmp    $0x1d,%esi
	jne    0xffffffff81006bb7 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x87> */
	jmp    0xffffffff81500420 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_shmget> */
	cmp    $0x11,%esi
	je     0xffffffff81007fea - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x14ba> */
	jbe    0xffffffff8100762b - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0xafb> */
	cmp    $0x12,%esi
	je     0xffffffff81007fe5 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x14b5> */
	cmp    $0x15,%esi
	jne    0xffffffff81006bb7 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x87> */
	jmp    0xffffffff8131be80 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_access> */
	cmp    $0x5,%esi
	je     0xffffffff81007fe0 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x14b0> */
	jbe    0xffffffff81007659 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0xb29> */
	cmp    $0x8,%esi
	je     0xffffffff81007fdb - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x14ab> */
	jbe    0xffffffff81007642 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0xb12> */
	cmp    $0x9,%esi
	je     0xffffffff81007fd6 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x14a6> */
	cmp    $0xa,%esi
	jne    0xffffffff81006bb7 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x87> */
	jmp    0xffffffff812ccdc0 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_mprotect> */
	cmp    $0xc,%esi
	je     0xffffffff81007fd1 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x14a1> */
	cmp    $0xe,%esi
	jne    0xffffffff81006bb7 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x87> */
	jmp    0xffffffff810a3110 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_rt_sigprocmask> */
	cmp    $0x6,%esi
	je     0xffffffff81007fcc - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x149c> */
	cmp    $0x7,%esi
	jne    0xffffffff81006bb7 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x87> */
	jmp    0xffffffff813409b0 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_poll> */
	cmp    $0x2,%esi
	je     0xffffffff81007fc7 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x1497> */
	jbe    0xffffffff81007951 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0xe21> */
	cmp    $0x3,%esi
	je     0xffffffff81007fc2 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x1492> */
	cmp    $0x4,%esi
	jne    0xffffffff81006bb7 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x87> */
	jmp    0xffffffff81329c00 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_newstat> */
	cmp    $0x135,%esi
	je     0xffffffff81007fbd - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x148d> */
	jbe    0xffffffff810077ca - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0xc9a> */
	cmp    $0x138,%esi
	je     0xffffffff81007fb8 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x1488> */
	cmp    $0x139,%esi
	jne    0xffffffff81006bb7 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x87> */
	jmp    0xffffffff8113b920 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_finit_module> */
	cmp    $0x211,%esi
	je     0xffffffff81007fb3 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x1483> */
	jbe    0xffffffff810078ea - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0xdba> */
	cmp    $0x212,%esi
	je     0xffffffff81007fae - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x147e> */
	cmp    $0x213,%esi
	jne    0xffffffff81006bb7 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x87> */
	jmp    0xffffffff81161e90 - 0xffffffff81006b30 + x32_sys_call /* <__x64_compat_sys_get_robust_list> */
	cmp    $0x1b4,%esi
	je     0xffffffff81007f81 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x1451> */
	jbe    0xffffffff81007d69 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x1239> */
	cmp    $0x1b5,%esi
	je     0xffffffff81007f7c - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x144c> */
	cmp    $0x1b6,%esi
	jne    0xffffffff81006bb7 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x87> */
	jmp    0xffffffff810bb6a0 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_pidfd_getfd> */
	cmp    $0xbb,%esi
	je     0xffffffff81007f77 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x1447> */
	jbe    0xffffffff81007a04 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0xed4> */
	cmp    $0xbc,%esi
	je     0xffffffff81007f72 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x1442> */
	cmp    $0xbd,%esi
	jne    0xffffffff81006bb7 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x87> */
	jmp    0xffffffff8135ae20 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_lsetxattr> */
	cmp    $0x115,%esi
	je     0xffffffff81007f6d - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x143d> */
	jbe    0xffffffff81007e64 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x1334> */
	cmp    $0x11d,%esi
	je     0xffffffff81007f68 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x1438> */
	jbe    0xffffffff81007e39 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x1309> */
	cmp    $0x120,%esi
	je     0xffffffff81007f63 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x1433> */
	jbe    0xffffffff81007dd0 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x12a0> */
	cmp    $0x121,%esi
	jne    0xffffffff81006bb7 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x87> */
	jmp    0xffffffff81388970 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_signalfd4> */
	cmp    $0x206,%esi
	je     0xffffffff81007fa9 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x1479> */
	jbe    0xffffffff810077e7 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0xcb7> */
	cmp    $0x207,%esi
	je     0xffffffff81007fa4 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x1474> */
	cmp    $0x208,%esi
	jne    0xffffffff81006bb7 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x87> */
	jmp    0xffffffff8132d6f0 - 0xffffffff81006b30 + x32_sys_call /* <__x64_compat_sys_execve> */
	cmp    $0x20a,%esi
	je     0xffffffff81007f9f - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x146f> */
	cmp    $0x20b,%esi
	jne    0xffffffff81006bb7 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x87> */
	jmp    0xffffffff810a7000 - 0xffffffff81006b30 + x32_sys_call /* <__x64_compat_sys_rt_sigtimedwait_time64> */
	cmp    $0x132,%esi
	je     0xffffffff81007f9a - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x146a> */
	cmp    $0x134,%esi
	jne    0xffffffff81006bb7 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x87> */
	jmp    0xffffffff810c4860 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_setns> */
	cmp    $0x204,%esi
	je     0xffffffff81007f95 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x1465> */
	cmp    $0x205,%esi
	jne    0xffffffff81006bb7 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x87> */
	jmp    0xffffffff81c24420 - 0xffffffff81006b30 + x32_sys_call /* <__x64_compat_sys_recvfrom> */
	cmp    $0x1a9,%esi
	je     0xffffffff81007f90 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x1460> */
	jbe    0xffffffff81007868 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0xd38> */
	cmp    $0x1aa,%esi
	je     0xffffffff81007f8b - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x145b> */
	cmp    $0x1ab,%esi
	jne    0xffffffff81006bb7 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x87> */
	jmp    0xffffffff815bb5a0 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_io_uring_register> */
	cmp    $0x146,%esi
	je     0xffffffff81007f86 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x1456> */
	jbe    0xffffffff810078a2 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0xd72> */
	cmp    $0x14b,%esi
	je     0xffffffff8100804e - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x151e> */
	jbe    0xffffffff81007885 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0xd55> */
	cmp    $0x14c,%esi
	je     0xffffffff81008049 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x1519> */
	cmp    $0x14d,%esi
	jne    0xffffffff81006bb7 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x87> */
	jmp    0xffffffff81392f30 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_io_pgetevents> */
	cmp    $0x14f,%esi
	je     0xffffffff81008044 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x1514> */
	cmp    $0x1a8,%esi
	jne    0xffffffff81006bb7 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x87> */
	jmp    0xffffffff810a73d0 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_pidfd_send_signal> */
	cmp    $0x149,%esi
	je     0xffffffff8100803f - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x150f> */
	cmp    $0x14a,%esi
	jne    0xffffffff81006bb7 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x87> */
	jmp    0xffffffff812cce90 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_pkey_alloc> */
	cmp    $0x143,%esi
	je     0xffffffff8100803a - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x150a> */
	jbe    0xffffffff81007907 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0xdd7> */
	cmp    $0x144,%esi
	je     0xffffffff81008035 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x1505> */
	cmp    $0x145,%esi
	jne    0xffffffff81006bb7 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x87> */
	jmp    0xffffffff812c24f0 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_mlock2> */
	cmp    $0x1ad,%esi
	je     0xffffffff81008030 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x1500> */
	cmp    $0x1ae,%esi
	jne    0xffffffff81006bb7 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x87> */
	jmp    0xffffffff81371800 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_fsopen> */
	cmp    $0x20f,%esi
	je     0xffffffff8100802b - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x14fb> */
	cmp    $0x210,%esi
	jne    0xffffffff81006bb7 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x87> */
	jmp    0xffffffff8116c910 - 0xffffffff81006b30 + x32_sys_call /* <__x64_compat_sys_kexec_load> */
	cmp    $0x140,%esi
	je     0xffffffff810081bb - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x168b> */
	cmp    $0x141,%esi
	jne    0xffffffff81006bb7 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x87> */
	jmp    0xffffffff811f2320 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_bpf> */
	cmp    $0x12c,%esi
	je     0xffffffff810081b6 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x1686> */
	jbe    0xffffffff81007984 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0xe54> */
	cmp    $0x12f,%esi
	je     0xffffffff81007f5e - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x142e> */
	jbe    0xffffffff81007967 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0xe37> */
	cmp    $0x130,%esi
	jne    0xffffffff81006bb7 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x87> */
	jmp    0xffffffff813a6a30 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_open_by_handle_at> */
	test   %esi,%esi
	je     0xffffffff81008026 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x14f6> */
	cmp    $0x1,%esi
	jne    0xffffffff81006bb7 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x87> */
	jmp    0xffffffff81321500 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_write> */
	cmp    $0x12d,%esi
	je     0xffffffff81008021 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x14f1> */
	cmp    $0x12e,%esi
	jne    0xffffffff81006bb7 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x87> */
	jmp    0xffffffff810ae750 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_prlimit64> */
	cmp    $0x125,%esi
	je     0xffffffff8100801c - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x14ec> */
	jbe    0xffffffff81007a21 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0xef1> */
	cmp    $0x126,%esi
	je     0xffffffff81008017 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x14e7> */
	cmp    $0x12a,%esi
	jne    0xffffffff81006bb7 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x87> */
	jmp    0xffffffff81267190 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_perf_event_open> */
	cmp    $0xee,%esi
	je     0xffffffff81008076 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x1546> */
	jbe    0xffffffff81007abf - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0xf8f> */
	cmp    $0xfc,%esi
	je     0xffffffff81008071 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x1541> */
	jbe    0xffffffff81007a8a - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0xf5a> */
	cmp    $0x102,%esi
	je     0xffffffff8100806c - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x153c> */
	jbe    0xffffffff81007a5b - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0xf2b> */
	cmp    $0x105,%esi
	je     0xffffffff81008067 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x1537> */
	jbe    0xffffffff81007a3e - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0xf0e> */
	cmp    $0x106,%esi
	jne    0xffffffff81006bb7 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x87> */
	jmp    0xffffffff81329ca0 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_newfstatat> */
	cmp    $0xb3,%esi
	je     0xffffffff81008058 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x1528> */
	cmp    $0xba,%esi
	jne    0xffffffff81006bb7 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x87> */
	jmp    0xffffffff810ac6d0 - 0xffffffff81006b30 + x32_sys_call /* <__ia32_sys_gettid> */
	cmp    $0x123,%esi
	je     0xffffffff81008062 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x1532> */
	cmp    $0x124,%esi
	jne    0xffffffff81006bb7 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x87> */
	jmp    0xffffffff8134cec0 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_dup3> */
	cmp    $0x103,%esi
	je     0xffffffff8100805d - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x152d> */
	cmp    $0x104,%esi
	jne    0xffffffff81006bb7 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x87> */
	jmp    0xffffffff8131cc50 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_fchownat> */
	cmp    $0xff,%esi
	je     0xffffffff81008099 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x1569> */
	jbe    0xffffffff81007b0a - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0xfda> */
	cmp    $0x100,%esi
	je     0xffffffff81008094 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x1564> */
	cmp    $0x101,%esi
	jne    0xffffffff81006bb7 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x87> */
	jmp    0xffffffff8131d8e0 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_openat> */
	cmp    $0xf5,%esi
	je     0xffffffff8100808f - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x155f> */
	jbe    0xffffffff81007c1e - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x10ee> */
	cmp    $0xfa,%esi
	je     0xffffffff8100808a - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x155a> */
	jbe    0xffffffff81007c01 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x10d1> */
	cmp    $0xfb,%esi
	jne    0xffffffff81006bb7 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x87> */
	jmp    0xffffffff81585ee0 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_ioprio_set> */
	cmp    $0xe1,%esi
	je     0xffffffff81008053 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x1523> */
	jbe    0xffffffff81007b6f - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x103f> */
	cmp    $0xe7,%esi
	je     0xffffffff810083be - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x188e> */
	jbe    0xffffffff81007b44 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x1014> */
	cmp    $0xea,%esi
	je     0xffffffff81008085 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x1555> */
	jbe    0xffffffff81007b27 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0xff7> */
	cmp    $0xeb,%esi
	je     0xffffffff81008201 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x16d1> */
	cmp    $0xed,%esi
	jne    0xffffffff81006bb7 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x87> */
	jmp    0xffffffff8130d160 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_mbind> */
	cmp    $0xfd,%esi
	je     0xffffffff810081fc - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x16cc> */
	cmp    $0xfe,%esi
	jne    0xffffffff81006bb7 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x87> */
	jmp    0xffffffff81380750 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_inotify_add_watch> */
	cmp    $0xe8,%esi
	je     0xffffffff810081f7 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x16c7> */
	cmp    $0xe9,%esi
	jne    0xffffffff81006bb7 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x87> */
	jmp    0xffffffff81387270 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_epoll_ctl> */
	cmp    $0xe4,%esi
	je     0xffffffff810081f2 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x16c2> */
	jbe    0xffffffff81007b9c - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x106c> */
	cmp    $0xe5,%esi
	je     0xffffffff810081ed - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x16bd> */
	cmp    $0xe6,%esi
	jne    0xffffffff81006bb7 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x87> */
	jmp    0xffffffff81153260 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_clock_nanosleep> */
	cmp    $0xdb,%esi
	je     0xffffffff810081e8 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x16b8> */
	jbe    0xffffffff81007bd6 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x10a6> */
	cmp    $0xdf,%esi
	je     0xffffffff810081e3 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x16b3> */
	jbe    0xffffffff81007bb9 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x1089> */
	cmp    $0xe0,%esi
	jne    0xffffffff81006bb7 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x87> */
	jmp    0xffffffff81151ca0 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_timer_gettime> */
	cmp    $0xe2,%esi
	je     0xffffffff81008229 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x16f9> */
	cmp    $0xe3,%esi
	jne    0xffffffff81006bb7 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x87> */
	jmp    0xffffffff81152780 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_clock_settime> */
	cmp    $0xdc,%esi
	je     0xffffffff81008224 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x16f4> */
	cmp    $0xdd,%esi
	jne    0xffffffff81006bb7 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x87> */
	jmp    0xffffffff8127f200 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_fadvise64> */
	cmp    $0xd8,%esi
	je     0xffffffff8100821f - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x16ef> */
	jbe    0xffffffff81007c49 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x1119> */
	cmp    $0xd9,%esi
	je     0xffffffff8100821a - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x16ea> */
	cmp    $0xda,%esi
	jne    0xffffffff81006bb7 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x87> */
	jmp    0xffffffff8108b310 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_set_tid_address> */
	cmp    $0xf8,%esi
	je     0xffffffff81008215 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x16e5> */
	cmp    $0xf9,%esi
	jne    0xffffffff81006bb7 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x87> */
	jmp    0xffffffff8150a450 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_request_key> */
	cmp    $0xf1,%esi
	je     0xffffffff81008210 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x16e0> */
	jbe    0xffffffff81007c66 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x1136> */
	cmp    $0xf2,%esi
	je     0xffffffff8100820b - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x16db> */
	cmp    $0xf3,%esi
	jne    0xffffffff81006bb7 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x87> */
	jmp    0xffffffff81504670 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_mq_timedreceive> */
	cmp    $0xd2,%esi
	je     0xffffffff81008206 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x16d6> */
	cmp    $0xd5,%esi
	jne    0xffffffff81006bb7 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x87> */
	jmp    0xffffffff81386520 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_epoll_create> */
	cmp    $0xef,%esi
	je     0xffffffff81008139 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x1609> */
	cmp    $0xf0,%esi
	jne    0xffffffff81006bb7 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x87> */
	jmp    0xffffffff815040f0 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_mq_open> */
	cmp    $0xa7,%esi
	je     0xffffffff81008134 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x1604> */
	jbe    0xffffffff81007ce7 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x11b7> */
	cmp    $0xa8,%esi
	je     0xffffffff8100812f - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x15ff> */
	cmp    $0xa9,%esi
	jne    0xffffffff81006bb7 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x87> */
	jmp    0xffffffff810c7f10 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_reboot> */
	cmp    $0x9e,%esi
	je     0xffffffff8100812a - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x15fa> */
	jbe    0xffffffff81007d21 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x11f1> */
	cmp    $0xa1,%esi
	je     0xffffffff81008125 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x15f5> */
	jbe    0xffffffff81007d04 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x11d4> */
	cmp    $0xa2,%esi
	je     0xffffffff81008120 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x15f0> */
	cmp    $0xa3,%esi
	jne    0xffffffff81006bb7 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x87> */
	jmp    0xffffffff81169770 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_acct> */
	cmp    $0xa5,%esi
	je     0xffffffff810080f3 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x15c3> */
	cmp    $0xa6,%esi
	jne    0xffffffff81006bb7 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x87> */
	jmp    0xffffffff81353560 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_umount> */
	cmp    $0x9f,%esi
	je     0xffffffff810080ee - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x15be> */
	cmp    $0xa0,%esi
	jne    0xffffffff81006bb7 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x87> */
	jmp    0xffffffff810ae7b0 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_setrlimit> */
	cmp    $0x9a,%esi
	je     0xffffffff81008012 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x14e2> */
	jbe    0xffffffff81007d86 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x1256> */
	cmp    $0x9b,%esi
	je     0xffffffff8100800d - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x14dd> */
	cmp    $0x9d,%esi
	jne    0xffffffff81006bb7 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x87> */
	jmp    0xffffffff810af910 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_prctl> */
	cmp    $0xab,%esi
	je     0xffffffff81008008 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x14d8> */
	cmp    $0xac,%esi
	jne    0xffffffff81006bb7 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x87> */
	jmp    0xffffffff810370f0 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_iopl> */
	cmp    $0x1b2,%esi
	je     0xffffffff8100811b - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x15eb> */
	cmp    $0x1b3,%esi
	jne    0xffffffff81006bb7 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x87> */
	jmp    0xffffffff8108e1c0 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_clone3> */
	cmp    $0x98,%esi
	je     0xffffffff81008080 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x1550> */
	cmp    $0x99,%esi
	jne    0xffffffff81006bb7 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x87> */
	jmp    0xffffffff8131e160 - 0xffffffff81006b30 + x32_sys_call /* <__ia32_sys_vhangup> */
	cmp    $0x1cd,%esi
	je     0xffffffff8100807b - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x154b> */
	jbe    0xffffffff81007e0a - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x12da> */
	cmp    $0x201,%esi
	je     0xffffffff810081de - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x16ae> */
	jbe    0xffffffff81007ded - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x12bd> */
	cmp    $0x202,%esi
	jne    0xffffffff81006bb7 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x87> */
	jmp    0xffffffff8133d130 - 0xffffffff81006b30 + x32_sys_call /* <__x64_compat_sys_ioctl> */
	cmp    $0x11e,%esi
	je     0xffffffff81008319 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x17e9> */
	cmp    $0x11f,%esi
	jne    0xffffffff81006bb7 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x87> */
	jmp    0xffffffff8138a0b0 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_timerfd_gettime> */
	cmp    $0x1ce,%esi
	je     0xffffffff81008314 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x17e4> */
	cmp    $0x200,%esi
	jne    0xffffffff81006bb7 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x87> */
	jmp    0xffffffff810a8ce0 - 0xffffffff81006b30 + x32_sys_call /* <__x64_compat_sys_rt_sigaction> */
	cmp    $0x1ca,%esi
	je     0xffffffff8100830f - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x17df> */
	jbe    0xffffffff81007ea1 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x1371> */
	cmp    $0x1cb,%esi
	je     0xffffffff8100830a - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x17da> */
	cmp    $0x1cc,%esi
	jne    0xffffffff81006bb7 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x87> */
	jmp    0xffffffff815111a0 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_lsm_set_self_attr> */
	cmp    $0x11a,%esi
	je     0xffffffff81008305 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x17d5> */
	jbe    0xffffffff81007ebe - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x138e> */
	cmp    $0x11b,%esi
	je     0xffffffff81008300 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x17d0> */
	cmp    $0x11c,%esi
	jne    0xffffffff81006bb7 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x87> */
	jmp    0xffffffff8138ae90 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_eventfd> */
	cmp    $0x10d,%esi
	je     0xffffffff810082fb - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x17cb> */
	jbe    0xffffffff81007ef8 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x13c8> */
	cmp    $0x110,%esi
	je     0xffffffff810082f6 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x17c6> */
	jbe    0xffffffff81007edb - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x13ab> */
	cmp    $0x113,%esi
	je     0xffffffff810082f1 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x17c1> */
	cmp    $0x114,%esi
	jne    0xffffffff81006bb7 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x87> */
	jmp    0xffffffff8136ac60 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_tee> */
	cmp    $0x1c8,%esi
	je     0xffffffff810082ec - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x17bc> */
	cmp    $0x1c9,%esi
	jne    0xffffffff81006bb7 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x87> */
	jmp    0xffffffff813570d0 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_statmount> */
	cmp    $0x118,%esi
	je     0xffffffff810082e7 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x17b7> */
	cmp    $0x119,%esi
	jne    0xffffffff81006bb7 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x87> */
	jmp    0xffffffff813875f0 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_epoll_pwait> */
	cmp    $0x10e,%esi
	je     0xffffffff810082e2 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x17b2> */
	cmp    $0x10f,%esi
	jne    0xffffffff81006bb7 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x87> */
	jmp    0xffffffff81340c30 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_ppoll> */
	cmp    $0x10a,%esi
	je     0xffffffff810082dd - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x17ad> */
	jbe    0xffffffff81007f23 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x13f3> */
	cmp    $0x10b,%esi
	je     0xffffffff810082d8 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x17a8> */
	cmp    $0x10c,%esi
	jne    0xffffffff81006bb7 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x87> */
	jmp    0xffffffff8131c8c0 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_fchmodat> */
	cmp    $0x108,%esi
	je     0xffffffff810082d3 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x17a3> */
	cmp    $0x109,%esi
	jne    0xffffffff81006bb7 - 0xffffffff81006b30 + x32_sys_call /* <x32_sys_call+0x87> */
	jmp    0xffffffff81339650 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_linkat> */
	jmp    0xffffffff8127ed80 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_process_mrelease> */
	jmp    0xffffffff81315860 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_memfd_secret> */
	jmp    0xffffffff8135b2d0 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_fgetxattr> */
	jmp    0xffffffff8135aea0 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_fsetxattr> */
	jmp    0xffffffff8153fc50 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_landlock_add_rule> */
	jmp    0xffffffff810ed8b0 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_sched_getattr> */
	jmp    0xffffffff813a6890 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_name_to_handle_at> */
	jmp    0xffffffff81b961d0 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_accept4> */
	jmp    0xffffffff8131bcc0 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_fallocate> */
	jmp    0xffffffff8136b780 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_sync_file_range> */
	jmp    0xffffffff8135ada0 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_setxattr> */
	jmp    0xffffffff81284070 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_readahead> */
	jmp    0xffffffff8131da40 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_openat2> */
	jmp    0xffffffff8131e100 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_close_range> */
	jmp    0xffffffff81323480 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_copy_file_range> */
	jmp    0xffffffff815a7ff0 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_io_uring_enter> */
	jmp    0xffffffff815a80a0 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_io_uring_setup> */
	jmp    0xffffffff81321a40 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_writev> */
	jmp    0xffffffff8136b270 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_syncfs> */
	jmp    0xffffffff810a3720 - 0xffffffff81006b30 + x32_sys_call /* <__x64_compat_sys_rt_sigpending> */
	jmp    0xffffffff81c24330 - 0xffffffff81006b30 + x32_sys_call /* <__x64_compat_sys_recvmsg> */
	jmp    0xffffffff81c24250 - 0xffffffff81006b30 + x32_sys_call /* <__x64_compat_sys_sendmsg> */
	jmp    0xffffffff81161d90 - 0xffffffff81006b30 + x32_sys_call /* <__x64_compat_sys_set_robust_list> */
	jmp    0xffffffff81096270 - 0xffffffff81006b30 + x32_sys_call /* <__x64_compat_sys_waitid> */
	jmp    0xffffffff8113e8f0 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_kcmp> */
	jmp    0xffffffff810af970 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_getcpu> */
	jmp    0xffffffff8131dfe0 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_close> */
	jmp    0xffffffff8131d780 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_open> */
	jmp    0xffffffff81329c50 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_newlstat> */
	jmp    0xffffffff812c8660 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_brk> */
	jmp    0xffffffff8103b8d0 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_mmap> */
	jmp    0xffffffff8131ff00 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_lseek> */
	jmp    0xffffffff81329d00 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_newfstat> */
	jmp    0xffffffff81321850 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_pwrite64> */
	jmp    0xffffffff81321610 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_pread64> */
	jmp    0xffffffff812f2dc0 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_madvise> */
	jmp    0xffffffff813407c0 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_select> */
	jmp    0xffffffff81500540 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_shmctl> */
	jmp    0xffffffff813219e0 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_readv> */
	jmp    0xffffffff813220a0 - 0xffffffff81006b30 + x32_sys_call /* <__x64_compat_sys_preadv64v2> */
	jmp    0xffffffff810ad990 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_setdomainname> */
	jmp    0xffffffff81356fe0 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_pivot_root> */
	jmp    0xffffffff81039330 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_modify_ldt> */
	jmp    0xffffffff81380680 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_inotify_init1> */
	jmp    0xffffffff8132f870 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_pipe2> */
	jmp    0xffffffff81384870 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_fanotify_mark> */
	jmp    0xffffffff813213b0 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_read> */
	jmp    0xffffffff81504bd0 - 0xffffffff81006b30 + x32_sys_call /* <__x64_compat_sys_mq_notify> */
	jmp    0xffffffff813566b0 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_move_mount> */
	jmp    0xffffffff810f6970 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_membarrier> */
	jmp    0xffffffff8138ef10 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_userfaultfd> */
	jmp    0xffffffff812cce30 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_pkey_mprotect> */
	jmp    0xffffffff810750c0 - 0xffffffff81006b30 + x32_sys_call /* <__ia32_sys_uretprobe> */
	jmp    0xffffffff81329ff0 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_statx> */
	jmp    0xffffffff812ccee0 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_pkey_free> */
	jmp    0xffffffff81151ea0 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_timer_getoverrun> */
	jmp    0xffffffff813b7d30 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_quotactl> */
	jmp    0xffffffff81338510 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_mknodat> */
	jmp    0xffffffff813864c0 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_epoll_create1> */
	jmp    0xffffffff8136c070 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_futimesat> */
	jmp    0xffffffff813387c0 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_mkdirat> */
	jmp    0xffffffff81585f40 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_ioprio_get> */
	jmp    0xffffffff8130a9a0 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_set_mempolicy> */
	jmp    0xffffffff81511260 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_lsm_list_modules> */
	jmp    0xffffffff812c2810 - 0xffffffff81006b30 + x32_sys_call /* <__ia32_sys_munlockall> */
	jmp    0xffffffff810a7430 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_tgkill> */
	jmp    0xffffffff8150be50 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_keyctl> */
	jmp    0xffffffff815048f0 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_mq_getsetattr> */
	jmp    0xffffffff8130aa00 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_migrate_pages> */
	jmp    0xffffffff813809e0 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_inotify_rm_watch> */
	jmp    0xffffffff81140790 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_settimeofday> */
	jmp    0xffffffff812f2ea0 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_process_madvise> */
	jmp    0xffffffff810ed070 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_sched_setscheduler> */
	jmp    0xffffffff810ed6b0 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_sched_getparam> */
	jmp    0xffffffff8131cf30 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_fchown> */
	jmp    0xffffffff8131ccd0 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_chown> */
	jmp    0xffffffff810ab6d0 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_setpriority> */
	jmp    0xffffffff81140510 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_gettimeofday> */
	jmp    0xffffffff81b968f0 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_sendto> */
	jmp    0xffffffff81156ce0 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_setitimer> */
	jmp    0xffffffff81338ff0 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_unlink> */
	jmp    0xffffffff81338b20 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_rmdir> */
	jmp    0xffffffff81501090 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_shmdt> */
	jmp    0xffffffff81339f50 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_rename> */
	jmp    0xffffffff8131c0c0 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_fchdir> */
	jmp    0xffffffff8131dee0 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_creat> */
	jmp    0xffffffff81140d00 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_adjtimex> */
	jmp    0xffffffff813563b0 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_mount> */
	jmp    0xffffffff8108e0e0 - 0xffffffff81006b30 + x32_sys_call /* <__ia32_sys_vfork> */
	jmp    0xffffffff8108e070 - 0xffffffff81006b30 + x32_sys_call /* <__ia32_sys_fork> */
	jmp    0xffffffff810a7270 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_kill> */
	jmp    0xffffffff810ca510 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_setgroups> */
	jmp    0xffffffff81b96fc0 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_shutdown> */
	jmp    0xffffffff8136c130 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_utime> */
	jmp    0xffffffff810a9410 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_rt_sigsuspend> */
	jmp    0xffffffff810bb460 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_pidfd_open> */
	jmp    0xffffffff8136b1e0 - 0xffffffff81006b30 + x32_sys_call /* <__ia32_sys_sync> */
	jmp    0xffffffff8131c260 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_chroot> */
	jmp    0xffffffff81031bc0 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_arch_prctl> */
	jmp    0xffffffff812fae70 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_swapoff> */
	jmp    0xffffffff812faf10 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_swapon> */
	jmp    0xffffffff8130aa60 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_get_mempolicy> */
	jmp    0xffffffff810abd60 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_setuid> */
	jmp    0xffffffff810ac7d0 - 0xffffffff81006b30 + x32_sys_call /* <__ia32_sys_getgid> */
	jmp    0xffffffff810ac810 - 0xffffffff81006b30 + x32_sys_call /* <__ia32_sys_getegid> */
	jmp    0xffffffff810ab8d0 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_setregid> */
	jmp    0xffffffff810acd10 - 0xffffffff81006b30 + x32_sys_call /* <__ia32_sys_getpgrp> */
	jmp    0xffffffff810ac700 - 0xffffffff81006b30 + x32_sys_call /* <__ia32_sys_getppid> */
	jmp    0xffffffff810ac790 - 0xffffffff81006b30 + x32_sys_call /* <__ia32_sys_geteuid> */
	jmp    0xffffffff810abfd0 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_setresuid> */
	jmp    0xffffffff8131c920 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_chmod> */
	jmp    0xffffffff8136e870 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_ustat> */
	jmp    0xffffffff814fc270 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_semget> */
	jmp    0xffffffff81096120 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_wait4> */
	jmp    0xffffffff814f8eb0 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_msgctl> */
	jmp    0xffffffff814f9220 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_msgrcv> */
	jmp    0xffffffff8136b3d0 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_fsync> */
	jmp    0xffffffff8136d3b0 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_getcwd> */
	jmp    0xffffffff812ceff0 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_mremap> */
	jmp    0xffffffff811566d0 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_getitimer> */
	jmp    0xffffffff8132f8d0 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_pipe> */
	jmp    0xffffffff812c7160 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_munmap> */
	jmp    0xffffffff8134cf20 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_dup2> */
	jmp    0xffffffff810ac750 - 0xffffffff81006b30 + x32_sys_call /* <__ia32_sys_getuid> */
	jmp    0xffffffff81b95ba0 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_socketpair> */
	jmp    0xffffffff810ac380 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_getresgid> */
	jmp    0xffffffff81384810 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_fanotify_init> */
	jmp    0xffffffff8116de80 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_kexec_file_load> */
	jmp    0xffffffff81b958c0 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_socket> */
	jmp    0xffffffff810a93b0 - 0xffffffff81006b30 + x32_sys_call /* <__ia32_sys_pause> */
	jmp    0xffffffff81500c90 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_shmat> */
	jmp    0xffffffff810ac6a0 - 0xffffffff81006b30 + x32_sys_call /* <__ia32_sys_getpid> */
	jmp    0xffffffff8109d1a0 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_capget> */
	jmp    0xffffffff81b96400 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_connect> */
	jmp    0xffffffff81032c40 - 0xffffffff81006b30 + x32_sys_call /* <__ia32_compat_sys_x32_rt_sigreturn> */
	jmp    0xffffffff81151fc0 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_timer_settime> */
	jmp    0xffffffff810a2e20 - 0xffffffff81006b30 + x32_sys_call /* <__ia32_sys_restart_syscall> */
	jmp    0xffffffff81152b90 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_clock_getres> */
	jmp    0xffffffff81152920 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_clock_gettime> */
	jmp    0xffffffff813873d0 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_epoll_wait> */
	jmp    0xffffffff813806e0 - 0xffffffff81006b30 + x32_sys_call /* <__ia32_sys_inotify_init> */
	jmp    0xffffffff8136c0d0 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_utimes> */
	jmp    0xffffffff81392ab0 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_io_cancel> */
	jmp    0xffffffff815044f0 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_mq_timedsend> */
	jmp    0xffffffff81504230 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_mq_unlink> */
	jmp    0xffffffff8150a3f0 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_add_key> */
	jmp    0xffffffff8133def0 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_getdents64> */
	jmp    0xffffffff812ca0b0 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_remap_file_pages> */
	jmp    0xffffffff814fd900 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_semtimedop> */
	jmp    0xffffffff811523c0 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_timer_delete> */
	jmp    0xffffffff810ac560 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_setfsuid> */
	jmp    0xffffffff810ac320 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_setresgid> */
	jmp    0xffffffff812c2490 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_mlock> */
	jmp    0xffffffff810ee350 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_sched_get_priority_max> */
	jmp    0xffffffff810aee50 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_getrusage> */
	jmp    0xffffffff810aeef0 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_umask> */
	jmp    0xffffffff81329dd0 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_readlink> */
	jmp    0xffffffff8133dcb0 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_getdents> */
	jmp    0xffffffff810abbe0 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_setreuid> */
	jmp    0xffffffff810ee410 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_sched_get_priority_min> */
	jmp    0xffffffff8136e7c0 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_fstatfs> */
	jmp    0xffffffff8108e900 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_personality> */
	jmp    0xffffffff81b95ed0 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_listen> */
	jmp    0xffffffff812c0920 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_mincore> */
	jmp    0xffffffff8131b740 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_truncate> */
	jmp    0xffffffff813993b0 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_flock> */
	jmp    0xffffffff814f8d90 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_msgget> */
	jmp    0xffffffff814fdcb0 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_semop> */
	jmp    0xffffffff8135b6f0 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_lremovexattr> */
	jmp    0xffffffff81160ff0 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_futex> */
	jmp    0xffffffff813922e0 - 0xffffffff81006b30 + x32_sys_call /* <__x64_compat_sys_io_setup> */
	jmp    0xffffffff81c244a0 - 0xffffffff81006b30 + x32_sys_call /* <__x64_compat_sys_recvmmsg_time64> */
	jmp    0xffffffff81151c00 - 0xffffffff81006b30 + x32_sys_call /* <__x64_compat_sys_timer_create> */
	jmp    0xffffffff81161a90 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_futex_wait> */
	jmp    0xffffffff81319ee0 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_memfd_create> */
	jmp    0xffffffff813923b0 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_io_destroy> */
	jmp    0xffffffff810ee1b0 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_sched_getaffinity> */
	jmp    0xffffffff811401b0 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_time> */
	jmp    0xffffffff8135b4d0 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_llistxattr> */
	jmp    0xffffffff8113bdc0 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_delete_module> */
	jmp    0xffffffff812c27d0 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_mlockall> */
	jmp    0xffffffff810ac850 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_times> */
	jmp    0xffffffff81392d90 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_io_getevents> */
	jmp    0xffffffff81339e90 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_renameat> */
	jmp    0xffffffff81329d50 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_readlinkat> */
	jmp    0xffffffff81339210 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_symlinkat> */
	jmp    0xffffffff81340840 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_pselect6> */
	jmp    0xffffffff8136bef0 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_utimensat> */
	jmp    0xffffffff81161cf0 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_futex_requeue> */
	jmp    0xffffffff8136a5e0 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_splice> */
	jmp    0xffffffff8108e6d0 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_unshare> */
	jmp    0xffffffff8131bdc0 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_faccessat> */
	jmp    0xffffffff81389ef0 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_timerfd_create> */
	jmp    0xffffffff81388a90 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_signalfd> */
	jmp    0xffffffff81511200 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_lsm_get_self_attr> */
	jmp    0xffffffff81357130 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_listmount> */
	jmp    0xffffffff812de850 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_mseal> */
	jmp    0xffffffff81389f50 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_timerfd_settime> */
	jmp    0xffffffff810783f0 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_map_shadow_stack> */
	jmp    0xffffffff8130ca50 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_set_mempolicy_home_node> */
	jmp    0xffffffff810a7a00 - 0xffffffff81006b30 + x32_sys_call /* <__x64_compat_sys_rt_sigqueueinfo> */
	jmp    0xffffffff8109f7b0 - 0xffffffff81006b30 + x32_sys_call /* <__x64_compat_sys_ptrace> */
	jmp    0xffffffff81338f10 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_unlinkat> */
	jmp    0xffffffff81312f00 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_move_pages> */
	jmp    0xffffffff8153fbf0 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_landlock_create_ruleset> */
	jmp    0xffffffff81371aa0 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_fspick> */
	jmp    0xffffffff81322280 - 0xffffffff81006b30 + x32_sys_call /* <__x64_compat_sys_pwritev64> */
	jmp    0xffffffff8136a580 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_vmsplice> */
	jmp    0xffffffff81c242c0 - 0xffffffff81006b30 + x32_sys_call /* <__x64_compat_sys_sendmmsg> */
	jmp    0xffffffff8135b530 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_flistxattr> */
	jmp    0xffffffff81b96cf0 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_setsockopt> */
	jmp    0xffffffff812de300 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_process_vm_writev> */
	jmp    0xffffffff81392970 - 0xffffffff81006b30 + x32_sys_call /* <__x64_compat_sys_io_submit> */
	jmp    0xffffffff8135b750 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_fremovexattr> */
	jmp    0xffffffff81b96670 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_getpeername> */
	jmp    0xffffffff8135b210 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_getxattr> */
	jmp    0xffffffff810ab730 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_getpriority> */
	jmp    0xffffffff810acd60 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_getsid> */
	jmp    0xffffffff8119e490 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_seccomp> */
	jmp    0xffffffff810ed150 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_sched_setattr> */
	jmp    0xffffffff81152b40 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_clock_adjtime> */
	jmp    0xffffffff8138ae30 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_eventfd2> */
	jmp    0xffffffff81272810 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_rseq> */
	jmp    0xffffffff8127a6d0 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_cachestat> */
	jmp    0xffffffff81357030 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_mount_setattr> */
	jmp    0xffffffff8131be20 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_faccessat2> */
	jmp    0xffffffff81037090 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_ioperm> */
	jmp    0xffffffff810ad310 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_sethostname> */
	jmp    0xffffffff81371dc0 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_fsconfig> */
	jmp    0xffffffff81354f90 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_open_tree> */
	call   0xffffffff810954a0 - 0xffffffff81006b30 + x32_sys_call /* <__x64_sys_exit_group> */

.size x32_sys_call, . - x32_sys_call

.globl ia32_sys_call
.type ia32_sys_call @function
ia32_sys_call:
	endbr64
	cmp    $0xed,%esi
	je     0xffffffff81006662 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x1802> */
	ja     0xffffffff81004eec - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x8c> */
	cmp    $0x76,%esi
	je     0xffffffff8100665d - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x17fd> */
	jbe    0xffffffff81005e1e - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0xfbe> */
	cmp    $0xb4,%esi
	je     0xffffffff81006658 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x17f8> */
	jbe    0xffffffff810054b9 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x659> */
	cmp    $0xd1,%esi
	je     0xffffffff81006653 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x17f3> */
	jbe    0xffffffff81005afe - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0xc9e> */
	cmp    $0xe0,%esi
	je     0xffffffff8100664e - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x17ee> */
	jbe    0xffffffff8100531a - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x4ba> */
	cmp    $0xe7,%esi
	je     0xffffffff81006649 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x17e9> */
	jbe    0xffffffff81004f8e - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x12e> */
	cmp    $0xea,%esi
	je     0xffffffff81006644 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x17e4> */
	jbe    0xffffffff81004f71 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x111> */
	cmp    $0xeb,%esi
	je     0xffffffff8100663f - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x17df> */
	jmp    0xffffffff8135b720 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_lremovexattr> */
	cmp    $0x15d,%esi
	je     0xffffffff8100663a - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x17da> */
	jbe    0xffffffff81005167 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x307> */
	cmp    $0x199,%esi
	je     0xffffffff81006635 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x17d5> */
	jbe    0xffffffff81005102 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x2a2> */
	cmp    $0x1b5,%esi
	je     0xffffffff81006630 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x17d0> */
	jbe    0xffffffff81005092 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x232> */
	cmp    $0x1c2,%esi
	je     0xffffffff8100662b - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x17cb> */
	jbe    0xffffffff81005055 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x1f5> */
	cmp    $0x1c9,%esi
	je     0xffffffff81006626 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x17c6> */
	jbe    0xffffffff81004fd6 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x176> */
	cmp    $0x1cc,%esi
	je     0xffffffff81006621 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x17c1> */
	jbe    0xffffffff81004fb9 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x159> */
	cmp    $0x1cd,%esi
	je     0xffffffff8100661c - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x17bc> */
	cmp    $0x1ce,%esi
	jne    0xffffffff8100606e - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x120e> */
	jmp    0xffffffff812de880 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_mseal> */
	cmp    $0xe8,%esi
	je     0xffffffff81006617 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x17b7> */
	cmp    $0xe9,%esi
	jne    0xffffffff8100606e - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x120e> */
	jmp    0xffffffff8135b500 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_llistxattr> */
	cmp    $0xe4,%esi
	je     0xffffffff81006b08 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x1ca8> */
	jbe    0xffffffff81005001 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x1a1> */
	cmp    $0xe5,%esi
	je     0xffffffff81006b03 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x1ca3> */
	cmp    $0xe6,%esi
	jne    0xffffffff8100606e - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x120e> */
	jmp    0xffffffff8135b2a0 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_lgetxattr> */
	cmp    $0x1ca,%esi
	je     0xffffffff81006afe - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x1c9e> */
	cmp    $0x1cb,%esi
	jne    0xffffffff8100606e - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x120e> */
	jmp    0xffffffff81511230 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_lsm_get_self_attr> */
	cmp    $0x1c6,%esi
	je     0xffffffff81006af9 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x1c99> */
	jbe    0xffffffff8100501a - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x1ba> */
	cmp    $0x1c7,%esi
	je     0xffffffff81006af4 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x1c94> */
	cmp    $0x1c8,%esi
	jne    0xffffffff8100606e - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x120e> */
	jmp    0xffffffff81161d20 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_futex_requeue> */
	cmp    $0xe2,%esi
	je     0xffffffff81006aef - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x1c8f> */
	cmp    $0xe3,%esi
	jne    0xffffffff81005033 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x1d3> */
	jmp    0xffffffff8135ae60 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_lsetxattr> */
	cmp    $0x1c4,%esi
	je     0xffffffff81006aea - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x1c8a> */
	cmp    $0x1c5,%esi
	jne    0xffffffff81005044 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x1e4> */
	jmp    0xffffffff81078490 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_map_shadow_stack> */
	cmp    $0xe1,%esi
	jne    0xffffffff8100606e - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x120e> */
	jmp    0xffffffff8103aba0 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_ia32_readahead> */
	cmp    $0x1c3,%esi
	jne    0xffffffff8100606e - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x120e> */
	jmp    0xffffffff8127a860 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_cachestat> */
	cmp    $0x1bc,%esi
	je     0xffffffff81006ae5 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x1c85> */
	jbe    0xffffffff8100545b - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x5fb> */
	cmp    $0x1bf,%esi
	je     0xffffffff81006ae0 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x1c80> */
	jbe    0xffffffff810050e5 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x285> */
	cmp    $0x1c0,%esi
	je     0xffffffff81006adb - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x1c7b> */
	cmp    $0x1c1,%esi
	jne    0xffffffff8100606e - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x120e> */
	jmp    0xffffffff811617c0 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_futex_waitv> */
	cmp    $0x1a8,%esi
	je     0xffffffff81006ad6 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x1c76> */
	jbe    0xffffffff81005a58 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0xbf8> */
	cmp    $0x1af,%esi
	je     0xffffffff81006ad1 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x1c71> */
	jbe    0xffffffff81005a2d - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0xbcd> */
	cmp    $0x1b2,%esi
	je     0xffffffff81006acc - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x1c6c> */
	jbe    0xffffffff81005d97 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0xf37> */
	cmp    $0x1b3,%esi
	je     0xffffffff81006ac7 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x1c67> */
	cmp    $0x1b4,%esi
	jne    0xffffffff8100606e - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x120e> */
	jmp    0xffffffff8131e130 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_close_range> */
	cmp    $0x1bd,%esi
	je     0xffffffff81006ac2 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x1c62> */
	cmp    $0x1be,%esi
	jne    0xffffffff8100606e - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x120e> */
	jmp    0xffffffff8153ff40 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_landlock_restrict_self> */
	cmp    $0x178,%esi
	je     0xffffffff81006abd - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x1c5d> */
	jbe    0xffffffff81005238 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x3d8> */
	cmp    $0x18c,%esi
	je     0xffffffff81006ab8 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x1c58> */
	jbe    0xffffffff810051fb - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x39b> */
	cmp    $0x193,%esi
	je     0xffffffff81006ab3 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x1c53> */
	jbe    0xffffffff810052a4 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x444> */
	cmp    $0x196,%esi
	je     0xffffffff81006aae - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x1c4e> */
	jbe    0xffffffff810051de - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x37e> */
	cmp    $0x197,%esi
	je     0xffffffff81006aa9 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x1c49> */
	cmp    $0x198,%esi
	jne    0xffffffff8100606e - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x120e> */
	jmp    0xffffffff81151d20 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_timer_gettime> */
	cmp    $0x127,%esi
	je     0xffffffff81006aa4 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x1c44> */
	jbe    0xffffffff8100556d - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x70d> */
	cmp    $0x142,%esi
	je     0xffffffff81006a9f - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x1c3f> */
	jbe    0xffffffff8100551e - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x6be> */
	cmp    $0x150,%esi
	je     0xffffffff81006a9a - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x1c3a> */
	jbe    0xffffffff81005386 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x526> */
	cmp    $0x157,%esi
	je     0xffffffff81006a95 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x1c35> */
	jbe    0xffffffff8100535b - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x4fb> */
	cmp    $0x15a,%esi
	je     0xffffffff81006a90 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x1c30> */
	jbe    0xffffffff810052cf - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x46f> */
	cmp    $0x15b,%esi
	je     0xffffffff81006a8b - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x1c2b> */
	cmp    $0x15c,%esi
	jne    0xffffffff8100606e - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x120e> */
	jmp    0xffffffff812de340 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_process_vm_writev> */
	cmp    $0x194,%esi
	je     0xffffffff81006a86 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x1c26> */
	cmp    $0x195,%esi
	jne    0xffffffff8100606e - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x120e> */
	jmp    0xffffffff81152b70 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_clock_adjtime> */
	cmp    $0x17f,%esi
	je     0xffffffff81006a81 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x1c21> */
	jbe    0xffffffff8100548a - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x62a> */
	cmp    $0x189,%esi
	je     0xffffffff81006a7c - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x1c1c> */
	jbe    0xffffffff8100528b - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x42b> */
	cmp    $0x18a,%esi
	je     0xffffffff81006a77 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x1c17> */
	cmp    $0x18b,%esi
	jne    0xffffffff8100606e - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x120e> */
	jmp    0xffffffff815004b0 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_shmget> */
	cmp    $0x16b,%esi
	je     0xffffffff81006a72 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x1c12> */
	jbe    0xffffffff810060a5 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x1245> */
	cmp    $0x172,%esi
	je     0xffffffff81006a6d - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x1c0d> */
	jbe    0xffffffff81005acf - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0xc6f> */
	cmp    $0x175,%esi
	je     0xffffffff81006a68 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x1c08> */
	jbe    0xffffffff81006073 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x1213> */
	cmp    $0x176,%esi
	je     0xffffffff81006a63 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x1c03> */
	cmp    $0x177,%esi
	jne    0xffffffff8100606e - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x120e> */
	jmp    0xffffffff810f6ad0 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_membarrier> */
	cmp    $0x181,%esi
	je     0xffffffff81006a5e - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x1bfe> */
	cmp    $0x182,%esi
	jne    0xffffffff810052ec - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x48c> */
	jmp    0xffffffff812729a0 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_rseq> */
	cmp    $0x190,%esi
	je     0xffffffff81006a59 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x1bf9> */
	jbe    0xffffffff810052fd - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x49d> */
	cmp    $0x191,%esi
	je     0xffffffff81006a54 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x1bf4> */
	cmp    $0x192,%esi
	jne    0xffffffff8100606e - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x120e> */
	jmp    0xffffffff814f8f10 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_compat_sys_msgctl> */
	cmp    $0x158,%esi
	je     0xffffffff81006a4f - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x1bef> */
	cmp    $0x159,%esi
	jne    0xffffffff8100606e - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x120e> */
	jmp    0xffffffff81c24280 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_compat_sys_sendmmsg> */
	cmp    $0x180,%esi
	jne    0xffffffff8100606e - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x120e> */
	jmp    0xffffffff81031c60 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_compat_sys_arch_prctl> */
	cmp    $0x18e,%esi
	je     0xffffffff81006a4a - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x1bea> */
	cmp    $0x18f,%esi
	jne    0xffffffff81005e7c - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x101c> */
	jmp    0xffffffff814f8e20 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_msgget> */
	cmp    $0xd8,%esi
	je     0xffffffff81006a45 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x1be5> */
	jbe    0xffffffff8100597b - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0xb1b> */
	cmp    $0xdb,%esi
	je     0xffffffff81006a40 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x1be0> */
	jbe    0xffffffff81005874 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0xa14> */
	cmp    $0xdc,%esi
	je     0xffffffff81006a3b - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x1bdb> */
	cmp    $0xdd,%esi
	jne    0xffffffff8100606e - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x120e> */
	jmp    0xffffffff8133b2d0 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_compat_sys_fcntl64> */
	cmp    $0x154,%esi
	je     0xffffffff81006a36 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x1bd6> */
	jbe    0xffffffff810053bf - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x55f> */
	cmp    $0x155,%esi
	je     0xffffffff81006a31 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x1bd1> */
	cmp    $0x156,%esi
	jne    0xffffffff8100606e - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x120e> */
	jmp    0xffffffff813a6a90 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_compat_sys_open_by_handle_at> */
	cmp    $0x149,%esi
	je     0xffffffff81006a2c - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x1bcc> */
	jbe    0xffffffff810053f1 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x591> */
	cmp    $0x14d,%esi
	je     0xffffffff81006a27 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x1bc7> */
	jbe    0xffffffff810053d8 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x578> */
	cmp    $0x14e,%esi
	je     0xffffffff81006a22 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x1bc2> */
	cmp    $0x14f,%esi
	jne    0xffffffff8100606e - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x120e> */
	jmp    0xffffffff810a7c80 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_compat_sys_rt_tgsigqueueinfo> */
	cmp    $0x152,%esi
	je     0xffffffff81006a1d - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x1bbd> */
	cmp    $0x153,%esi
	jne    0xffffffff8100541c - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x5bc> */
	jmp    0xffffffff813848f0 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_compat_sys_fanotify_mark> */
	cmp    $0x14b,%esi
	je     0xffffffff81006a18 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x1bb8> */
	cmp    $0x14c,%esi
	jne    0xffffffff8100542d - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x5cd> */
	jmp    0xffffffff813806b0 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_inotify_init1> */
	cmp    $0x146,%esi
	je     0xffffffff81006a13 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x1bb3> */
	jbe    0xffffffff8100543e - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x5de> */
	cmp    $0x147,%esi
	je     0xffffffff81006a0e - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x1bae> */
	cmp    $0x148,%esi
	jne    0xffffffff8100606e - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x120e> */
	jmp    0xffffffff8138ae60 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_eventfd2> */
	cmp    $0x151,%esi
	jne    0xffffffff8100606e - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x120e> */
	jmp    0xffffffff81c244e0 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_compat_sys_recvmmsg_time32> */
	cmp    $0x14a,%esi
	jne    0xffffffff8100606e - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x120e> */
	jmp    0xffffffff8134cef0 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_dup3> */
	cmp    $0x144,%esi
	je     0xffffffff81006a09 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x1ba9> */
	cmp    $0x145,%esi
	jne    0xffffffff81005db4 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0xf54> */
	jmp    0xffffffff8138a260 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_timerfd_settime32> */
	cmp    $0x1b9,%esi
	je     0xffffffff81006a04 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x1ba4> */
	jbe    0xffffffff8100608c - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x122c> */
	cmp    $0x1ba,%esi
	je     0xffffffff810069ff - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x1b9f> */
	cmp    $0x1bb,%esi
	jne    0xffffffff8100606e - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x120e> */
	jmp    0xffffffff813b82e0 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_quotactl_fd> */
	cmp    $0x17c,%esi
	je     0xffffffff810069fa - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x1b9a> */
	jbe    0xffffffff81005e8d - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x102d> */
	cmp    $0x17d,%esi
	je     0xffffffff810069f5 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x1b95> */
	cmp    $0x17e,%esi
	jne    0xffffffff8100606e - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x120e> */
	jmp    0xffffffff812cd020 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_pkey_free> */
	cmp    $0x96,%esi
	je     0xffffffff810069f0 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x1b90> */
	jbe    0xffffffff81005bab - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0xd4b> */
	cmp    $0xa4,%esi
	je     0xffffffff810069eb - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x1b8b> */
	jbe    0xffffffff81005b6e - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0xd0e> */
	cmp    $0xae,%esi
	je     0xffffffff810069e6 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x1b86> */
	jbe    0xffffffff8100616a - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x130a> */
	cmp    $0xb1,%esi
	je     0xffffffff810069e1 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x1b81> */
	jbe    0xffffffff81005b51 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0xcf1> */
	cmp    $0xb2,%esi
	je     0xffffffff810069dc - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x1b7c> */
	cmp    $0xb3,%esi
	jne    0xffffffff8100606e - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x120e> */
	jmp    0xffffffff810a9510 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_compat_sys_rt_sigsuspend> */
	cmp    $0x135,%esi
	je     0xffffffff810069d7 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x1b77> */
	jbe    0xffffffff810057e0 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x980> */
	cmp    $0x13c,%esi
	je     0xffffffff810069d2 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x1b72> */
	jbe    0xffffffff810057b5 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x955> */
	cmp    $0x13f,%esi
	je     0xffffffff810069cd - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x1b6d> */
	jbe    0xffffffff810055ca - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x76a> */
	cmp    $0x140,%esi
	je     0xffffffff810069c8 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x1b68> */
	cmp    $0x141,%esi
	jne    0xffffffff8100606e - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x120e> */
	jmp    0xffffffff81388cd0 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_compat_sys_signalfd> */
	cmp    $0x10a,%esi
	je     0xffffffff810069c3 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x1b63> */
	jbe    0xffffffff81005674 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x814> */
	cmp    $0x119,%esi
	je     0xffffffff810069be - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x1b5e> */
	jbe    0xffffffff81005633 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x7d3> */
	cmp    $0x121,%esi
	je     0xffffffff810069b9 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x1b59> */
	jbe    0xffffffff81005604 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x7a4> */
	cmp    $0x124,%esi
	je     0xffffffff810069b4 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x1b54> */
	jbe    0xffffffff810055e7 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x787> */
	cmp    $0x125,%esi
	je     0xffffffff810069af - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x1b4f> */
	cmp    $0x126,%esi
	jne    0xffffffff8100606e - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x120e> */
	jmp    0xffffffff8130aa30 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_migrate_pages> */
	cmp    $0x13d,%esi
	je     0xffffffff810069aa - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x1b4a> */
	cmp    $0x13e,%esi
	jne    0xffffffff8100606e - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x120e> */
	jmp    0xffffffff810af9f0 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_getcpu> */
	cmp    $0x122,%esi
	je     0xffffffff810069a5 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x1b45> */
	cmp    $0x123,%esi
	jne    0xffffffff8100606e - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x120e> */
	jmp    0xffffffff813806e0 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_inotify_init> */
	cmp    $0x11e,%esi
	je     0xffffffff810069a0 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x1b40> */
	jbe    0xffffffff810056bf - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x85f> */
	cmp    $0x11f,%esi
	je     0xffffffff8100699b - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x1b3b> */
	cmp    $0x120,%esi
	jne    0xffffffff8100606e - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x120e> */
	jmp    0xffffffff8150edb0 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_compat_sys_keyctl> */
	cmp    $0x112,%esi
	je     0xffffffff81006996 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x1b36> */
	jbe    0xffffffff810058e6 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0xa86> */
	cmp    $0x116,%esi
	je     0xffffffff81006991 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x1b31> */
	jbe    0xffffffff81005857 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x9f7> */
	cmp    $0x117,%esi
	je     0xffffffff8100698c - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x1b2c> */
	cmp    $0x118,%esi
	jne    0xffffffff8100606e - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x120e> */
	jmp    0xffffffff81504f00 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_mq_timedreceive_time32> */
	cmp    $0xfa,%esi
	je     0xffffffff81006987 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x1b27> */
	jbe    0xffffffff8100573e - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x8de> */
	cmp    $0x103,%esi
	je     0xffffffff81006982 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x1b22> */
	jbe    0xffffffff81005713 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x8b3> */
	cmp    $0x107,%esi
	je     0xffffffff8100697d - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x1b1d> */
	jbe    0xffffffff810056d8 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x878> */
	cmp    $0x108,%esi
	je     0xffffffff81006978 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x1b18> */
	cmp    $0x109,%esi
	jne    0xffffffff8100606e - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x120e> */
	jmp    0xffffffff81152fa0 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_clock_gettime32> */
	cmp    $0x11b,%esi
	je     0xffffffff81006973 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x1b13> */
	cmp    $0x11c,%esi
	jne    0xffffffff810056f1 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x891> */
	jmp    0xffffffff81096240 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_compat_sys_waitid> */
	cmp    $0x105,%esi
	je     0xffffffff8100696e - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x1b0e> */
	cmp    $0x106,%esi
	jne    0xffffffff81005702 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x8a2> */
	jmp    0xffffffff81151f30 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_timer_getoverrun> */
	cmp    $0x11a,%esi
	jne    0xffffffff8100606e - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x120e> */
	jmp    0xffffffff81504c60 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_compat_sys_mq_getsetattr> */
	cmp    $0x104,%esi
	jne    0xffffffff8100606e - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x120e> */
	jmp    0xffffffff811522c0 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_timer_settime32> */
	cmp    $0x100,%esi
	je     0xffffffff81006969 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x1b09> */
	jbe    0xffffffff8100577b - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x91b> */
	cmp    $0x101,%esi
	je     0xffffffff81006964 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x1b04> */
	cmp    $0x102,%esi
	jne    0xffffffff8100606e - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x120e> */
	jmp    0xffffffff8108b350 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_set_tid_address> */
	cmp    $0xf4,%esi
	je     0xffffffff8100695f - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x1aff> */
	jbe    0xffffffff81005891 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0xa31> */
	cmp    $0xf7,%esi
	je     0xffffffff8100695a - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x1afa> */
	jbe    0xffffffff81005798 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x938> */
	cmp    $0xf8,%esi
	je     0xffffffff81006955 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x1af5> */
	cmp    $0xf9,%esi
	jne    0xffffffff8100606e - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x120e> */
	jmp    0xffffffff81392c20 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_io_cancel> */
	cmp    $0xfe,%esi
	je     0xffffffff81006950 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x1af0> */
	cmp    $0xff,%esi
	jne    0xffffffff810058bc - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0xa5c> */
	jmp    0xffffffff81387320 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_epoll_ctl> */
	cmp    $0xf5,%esi
	je     0xffffffff8100694b - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x1aeb> */
	cmp    $0xf6,%esi
	jne    0xffffffff8100606e - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x120e> */
	jmp    0xffffffff813924a0 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_io_destroy> */
	cmp    $0x139,%esi
	je     0xffffffff81006946 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x1ae6> */
	jbe    0xffffffff8100581d - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x9bd> */
	cmp    $0x13a,%esi
	je     0xffffffff81006941 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x1ae1> */
	cmp    $0x13b,%esi
	jne    0xffffffff8100606e - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x120e> */
	jmp    0xffffffff8136ad40 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_tee> */
	cmp    $0x12e,%esi
	je     0xffffffff8100693c - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x1adc> */
	jbe    0xffffffff81005950 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0xaf0> */
	cmp    $0x132,%esi
	je     0xffffffff81006937 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x1ad7> */
	jbe    0xffffffff8100583a - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x9da> */
	cmp    $0x133,%esi
	je     0xffffffff81006932 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x1ad2> */
	cmp    $0x134,%esi
	jne    0xffffffff8100606e - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x120e> */
	jmp    0xffffffff81341200 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_compat_sys_pselect6_time32> */
	cmp    $0x137,%esi
	je     0xffffffff8100692d - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x1acd> */
	cmp    $0x138,%esi
	jne    0xffffffff810059a6 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0xb46> */
	jmp    0xffffffff81161dd0 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_compat_sys_get_robust_list> */
	cmp    $0x130,%esi
	je     0xffffffff81006928 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x1ac8> */
	cmp    $0x131,%esi
	jne    0xffffffff81005911 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0xab1> */
	jmp    0xffffffff81329d90 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_readlinkat> */
	cmp    $0x114,%esi
	je     0xffffffff81006923 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x1ac3> */
	cmp    $0x115,%esi
	jne    0xffffffff810059b7 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0xb57> */
	jmp    0xffffffff81504950 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_compat_sys_mq_open> */
	cmp    $0xd9,%esi
	je     0xffffffff8100691e - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x1abe> */
	cmp    $0xda,%esi
	jne    0xffffffff8100606e - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x120e> */
	jmp    0xffffffff812c0950 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_mincore> */
	cmp    $0xf1,%esi
	je     0xffffffff81006919 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x1ab9> */
	jbe    0xffffffff810058cd - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0xa6d> */
	cmp    $0xf2,%esi
	je     0xffffffff81006914 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x1ab4> */
	cmp    $0xf3,%esi
	jne    0xffffffff8100606e - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x120e> */
	jmp    0xffffffff8104a070 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_set_thread_area> */
	cmp    $0xfc,%esi
	jne    0xffffffff8100606e - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x120e> */
	call   0xffffffff810954d0 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_exit_group> */
	cmp    $0xef,%esi
	je     0xffffffff8100690f - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x1aaf> */
	cmp    $0xf0,%esi
	jne    0xffffffff81005922 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0xac2> */
	jmp    0xffffffff81162120 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_futex_time32> */
	cmp    $0x10e,%esi
	je     0xffffffff8100690a - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x1aaa> */
	jbe    0xffffffff81005933 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0xad3> */
	cmp    $0x10f,%esi
	je     0xffffffff81006905 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x1aa5> */
	cmp    $0x110,%esi
	jne    0xffffffff8100606e - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x120e> */
	jmp    0xffffffff8103ab20 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_ia32_fadvise64_64> */
	cmp    $0x12f,%esi
	jne    0xffffffff8100606e - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x120e> */
	jmp    0xffffffff813396d0 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_linkat> */
	cmp    $0xee,%esi
	jne    0xffffffff8100606e - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x120e> */
	jmp    0xffffffff810a76c0 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_tkill> */
	cmp    $0x10c,%esi
	je     0xffffffff81006900 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x1aa0> */
	cmp    $0x10d,%esi
	jne    0xffffffff810059e1 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0xb81> */
	jmp    0xffffffff8136eaa0 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_compat_sys_fstatfs64> */
	cmp    $0x12b,%esi
	je     0xffffffff810068fb - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x1a9b> */
	jbe    0xffffffff810059c8 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0xb68> */
	cmp    $0x12c,%esi
	je     0xffffffff810068f6 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x1a96> */
	cmp    $0x12d,%esi
	jne    0xffffffff8100606e - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x120e> */
	jmp    0xffffffff81338f80 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_unlinkat> */
	cmp    $0xd5,%esi
	je     0xffffffff810068f1 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x1a91> */
	jbe    0xffffffff810059f2 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0xb92> */
	cmp    $0xd6,%esi
	je     0xffffffff810068ec - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x1a8c> */
	cmp    $0xd7,%esi
	jne    0xffffffff8100606e - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x120e> */
	jmp    0xffffffff810ac580 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_setfsuid> */
	cmp    $0x136,%esi
	jne    0xffffffff8100606e - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x120e> */
	jmp    0xffffffff8108e700 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_unshare> */
	cmp    $0x113,%esi
	jne    0xffffffff8100606e - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x120e> */
	jmp    0xffffffff8130ab30 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_get_mempolicy> */
	cmp    $0x129,%esi
	je     0xffffffff810068e7 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x1a87> */
	cmp    $0x12a,%esi
	jne    0xffffffff81005a0b - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0xbab> */
	jmp    0xffffffff8131cc90 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_fchownat> */
	cmp    $0x10b,%esi
	jne    0xffffffff8100606e - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x120e> */
	jmp    0xffffffff81153650 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_clock_nanosleep_time32> */
	cmp    $0xd3,%esi
	je     0xffffffff810068e2 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x1a82> */
	cmp    $0xd4,%esi
	jne    0xffffffff81005a1c - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0xbbc> */
	jmp    0xffffffff8131cd10 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_chown> */
	cmp    $0x128,%esi
	jne    0xffffffff8100606e - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x120e> */
	jmp    0xffffffff81338810 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_mkdirat> */
	cmp    $0xd2,%esi
	jne    0xffffffff8100606e - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x120e> */
	jmp    0xffffffff810ac350 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_setresgid> */
	cmp    $0x1ac,%esi
	je     0xffffffff810068dd - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x1a7d> */
	jbe    0xffffffff81005a95 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0xc35> */
	cmp    $0x1ad,%esi
	je     0xffffffff810068d8 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x1a78> */
	cmp    $0x1ae,%esi
	jne    0xffffffff8100606e - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x120e> */
	jmp    0xffffffff81371950 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_fsopen> */
	cmp    $0x1a1,%esi
	je     0xffffffff810068d3 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x1a73> */
	jbe    0xffffffff81005dc5 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0xf65> */
	cmp    $0x1a5,%esi
	je     0xffffffff810068ce - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x1a6e> */
	jbe    0xffffffff81005ab2 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0xc52> */
	cmp    $0x1a6,%esi
	je     0xffffffff810068c9 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x1a69> */
	cmp    $0x1a7,%esi
	jne    0xffffffff8100606e - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x120e> */
	jmp    0xffffffff810ee560 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_sched_rr_get_interval> */
	cmp    $0x1aa,%esi
	je     0xffffffff810068c4 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x1a64> */
	cmp    $0x1ab,%esi
	jne    0xffffffff81005df0 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0xf90> */
	jmp    0xffffffff815bb5d0 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_io_uring_register> */
	cmp    $0x1a3,%esi
	je     0xffffffff810068bf - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x1a5f> */
	cmp    $0x1a4,%esi
	jne    0xffffffff810060da - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x127a> */
	jmp    0xffffffff814fd9c0 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_semtimedop> */
	cmp    $0x16f,%esi
	je     0xffffffff810068ba - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x1a5a> */
	jbe    0xffffffff81005ec8 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x1068> */
	cmp    $0x170,%esi
	je     0xffffffff810068b5 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x1a55> */
	cmp    $0x171,%esi
	jne    0xffffffff8100606e - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x120e> */
	jmp    0xffffffff81b96930 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_sendto> */
	cmp    $0xc4,%esi
	je     0xffffffff810068b0 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x1a50> */
	jbe    0xffffffff810061e5 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x1385> */
	cmp    $0xcb,%esi
	je     0xffffffff810068ab - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x1a4b> */
	jbe    0xffffffff81006199 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x1339> */
	cmp    $0xce,%esi
	je     0xffffffff810068a6 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x1a46> */
	jbe    0xffffffff810061c8 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x1368> */
	cmp    $0xcf,%esi
	je     0xffffffff810068a1 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x1a41> */
	cmp    $0xd0,%esi
	jne    0xffffffff8100606e - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x120e> */
	jmp    0xffffffff810ac000 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_setresuid> */
	cmp    $0xaf,%esi
	je     0xffffffff8100689c - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x1a3c> */
	cmp    $0xb0,%esi
	jne    0xffffffff8100606e - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x120e> */
	jmp    0xffffffff810a3630 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_compat_sys_rt_sigpending> */
	cmp    $0x9d,%esi
	je     0xffffffff81006897 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x1a37> */
	jbe    0xffffffff81005c17 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0xdb7> */
	cmp    $0xa1,%esi
	je     0xffffffff81006892 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x1a32> */
	jbe    0xffffffff81005bfa - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0xd9a> */
	cmp    $0xa2,%esi
	je     0xffffffff8100688d - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x1a2d> */
	cmp    $0xa3,%esi
	jne    0xffffffff8100606e - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x120e> */
	jmp    0xffffffff812cf020 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_mremap> */
	cmp    $0x87,%esi
	je     0xffffffff81006888 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x1a28> */
	jbe    0xffffffff81005c92 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0xe32> */
	cmp    $0x8f,%esi
	je     0xffffffff81006883 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x1a23> */
	jbe    0xffffffff81005c46 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0xde6> */
	cmp    $0x92,%esi
	je     0xffffffff8100687e - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x1a1e> */
	jbe    0xffffffff81005c75 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0xe15> */
	cmp    $0x93,%esi
	je     0xffffffff81006879 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x1a19> */
	cmp    $0x94,%esi
	jne    0xffffffff8100606e - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x120e> */
	jmp    0xffffffff8136b550 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_fdatasync> */
	cmp    $0x9f,%esi
	je     0xffffffff81006874 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x1a14> */
	cmp    $0xa0,%esi
	jne    0xffffffff81005cfa - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0xe9a> */
	jmp    0xffffffff810ee470 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_sched_get_priority_min> */
	cmp    $0x9a,%esi
	je     0xffffffff8100686f - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x1a0f> */
	jbe    0xffffffff81005cc8 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0xe68> */
	cmp    $0x9b,%esi
	je     0xffffffff8100686a - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x1a0a> */
	cmp    $0x9c,%esi
	jne    0xffffffff8100606e - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x120e> */
	jmp    0xffffffff810ed0b0 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_sched_setscheduler> */
	cmp    $0x8c,%esi
	je     0xffffffff81006865 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x1a05> */
	jbe    0xffffffff81005d51 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0xef1> */
	cmp    $0x8d,%esi
	je     0xffffffff81006860 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x1a00> */
	cmp    $0x8e,%esi
	jne    0xffffffff8100606e - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x120e> */
	jmp    0xffffffff81340ee0 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_compat_sys_select> */
	cmp    $0x90,%esi
	je     0xffffffff8100685b - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x19fb> */
	cmp    $0x91,%esi
	jne    0xffffffff8100606e - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x120e> */
	jmp    0xffffffff81321a10 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_readv> */
	cmp    $0x7d,%esi
	je     0xffffffff81006856 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x19f6> */
	jbe    0xffffffff81005d0b - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0xeab> */
	cmp    $0x83,%esi
	je     0xffffffff81006851 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x19f1> */
	jbe    0xffffffff81005ce1 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0xe81> */
	cmp    $0x84,%esi
	je     0xffffffff8100684c - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x19ec> */
	cmp    $0x85,%esi
	jne    0xffffffff8100606e - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x120e> */
	jmp    0xffffffff8131c190 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_fchdir> */
	cmp    $0x98,%esi
	je     0xffffffff81006847 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x19e7> */
	cmp    $0x99,%esi
	jne    0xffffffff81005d2d - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0xecd> */
	jmp    0xffffffff812c2810 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_munlockall> */
	cmp    $0x80,%esi
	je     0xffffffff81006842 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x19e2> */
	cmp    $0x81,%esi
	jne    0xffffffff81005d6a - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0xf0a> */
	jmp    0xffffffff8113bdf0 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_delete_module> */
	cmp    $0x9e,%esi
	jne    0xffffffff8100606e - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x120e> */
	jmp    0xffffffff810ee330 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_sched_yield> */
	cmp    $0x7a,%esi
	je     0xffffffff8100683d - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x19dd> */
	jbe    0xffffffff81005d3e - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0xede> */
	cmp    $0x7b,%esi
	je     0xffffffff81006838 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x19d8> */
	cmp    $0x7c,%esi
	jne    0xffffffff8100606e - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x120e> */
	jmp    0xffffffff81141090 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_adjtimex_time32> */
	cmp    $0x97,%esi
	jne    0xffffffff8100606e - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x120e> */
	jmp    0xffffffff812c26c0 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_munlock> */
	cmp    $0x78,%esi
	je     0xffffffff81006833 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x19d3> */
	cmp    $0x79,%esi
	jne    0xffffffff81005d78 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0xf18> */
	jmp    0xffffffff810adbe0 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_setdomainname> */
	cmp    $0x8a,%esi
	je     0xffffffff8100682e - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x19ce> */
	cmp    $0x8b,%esi
	jne    0xffffffff81005d86 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0xf26> */
	jmp    0xffffffff81167810 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_setfsgid16> */
	cmp    $0x7e,%esi
	jne    0xffffffff8100606e - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x120e> */
	jmp    0xffffffff8116df10 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_compat_sys_sigprocmask> */
	cmp    $0x77,%esi
	jne    0xffffffff8100606e - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x120e> */
	jmp    0xffffffff8103b210 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_compat_sys_sigreturn> */
	cmp    $0x88,%esi
	jne    0xffffffff8100606e - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x120e> */
	jmp    0xffffffff8108e940 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_personality> */
	cmp    $0x1b0,%esi
	je     0xffffffff81006829 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x19c9> */
	cmp    $0x1b1,%esi
	jne    0xffffffff8100606e - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x120e> */
	jmp    0xffffffff81371c30 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_fspick> */
	cmp    $0x143,%esi
	jne    0xffffffff8100606e - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x120e> */
	jmp    0xffffffff8138aec0 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_eventfd> */
	cmp    $0x19d,%esi
	je     0xffffffff81006824 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x19c4> */
	jbe    0xffffffff81005e01 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0xfa1> */
	cmp    $0x19e,%esi
	je     0xffffffff8100681f - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x19bf> */
	cmp    $0x1a0,%esi
	jne    0xffffffff8100606e - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x120e> */
	jmp    0xffffffff81393650 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_compat_sys_io_pgetevents_time64> */
	cmp    $0x1a9,%esi
	jne    0xffffffff8100606e - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x120e> */
	jmp    0xffffffff815a8110 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_io_uring_setup> */
	cmp    $0x19b,%esi
	je     0xffffffff8100681a - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x19ba> */
	cmp    $0x19c,%esi
	jne    0xffffffff81005ea6 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x1046> */
	jmp    0xffffffff8136bfb0 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_utimensat> */
	cmp    $0x3d,%esi
	je     0xffffffff81006815 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x19b5> */
	jbe    0xffffffff81005ff0 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x1190> */
	cmp    $0x58,%esi
	je     0xffffffff81006810 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x19b0> */
	jbe    0xffffffff81005f8a - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x112a> */
	cmp    $0x67,%esi
	je     0xffffffff8100680b - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x19ab> */
	jbe    0xffffffff81005f2b - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x10cb> */
	cmp    $0x6e,%esi
	je     0xffffffff81006806 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x19a6> */
	jbe    0xffffffff81005f09 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x10a9> */
	cmp    $0x73,%esi
	je     0xffffffff81006801 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x19a1> */
	jbe    0xffffffff81005ee1 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x1081> */
	cmp    $0x74,%esi
	je     0xffffffff810067fc - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x199c> */
	cmp    $0x75,%esi
	jne    0xffffffff8100606e - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x120e> */
	jmp    0xffffffff81501330 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_compat_sys_ipc> */
	cmp    $0x18d,%esi
	jne    0xffffffff8100606e - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x120e> */
	jmp    0xffffffff81500d70 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_compat_sys_shmat> */
	cmp    $0x17a,%esi
	je     0xffffffff810067f7 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x1997> */
	cmp    $0x17b,%esi
	jne    0xffffffff81005eb7 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x1057> */
	jmp    0xffffffff81322480 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_compat_sys_pwritev2> */
	cmp    $0x19a,%esi
	jne    0xffffffff8100606e - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x120e> */
	jmp    0xffffffff8138a130 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_timerfd_gettime> */
	cmp    $0x179,%esi
	jne    0xffffffff8100606e - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x120e> */
	jmp    0xffffffff813234c0 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_copy_file_range> */
	cmp    $0x16d,%esi
	je     0xffffffff810067f2 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x1992> */
	cmp    $0x16e,%esi
	jne    0xffffffff81005ef8 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x1098> */
	jmp    0xffffffff81b96d30 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_setsockopt> */
	cmp    $0x6f,%esi
	je     0xffffffff810067ed - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x198d> */
	cmp    $0x72,%esi
	jne    0xffffffff8100606e - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x120e> */
	jmp    0xffffffff810961e0 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_compat_sys_wait4> */
	cmp    $0x16c,%esi
	jne    0xffffffff8100606e - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x120e> */
	jmp    0xffffffff81b96200 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_accept4> */
	cmp    $0x6b,%esi
	je     0xffffffff810067e8 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x1988> */
	jbe    0xffffffff81005f5c - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x10fc> */
	cmp    $0x6c,%esi
	je     0xffffffff810067e3 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x1983> */
	cmp    $0x6d,%esi
	jne    0xffffffff8100606e - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x120e> */
	jmp    0xffffffff810ad030 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_uname> */
	cmp    $0x5f,%esi
	je     0xffffffff810067de - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x197e> */
	jbe    0xffffffff81005fce - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x116e> */
	cmp    $0x64,%esi
	je     0xffffffff810067d9 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x1979> */
	jbe    0xffffffff81005f73 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x1113> */
	cmp    $0x65,%esi
	je     0xffffffff810067d4 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x1974> */
	cmp    $0x66,%esi
	jne    0xffffffff8100606e - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x120e> */
	jmp    0xffffffff81c24560 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_compat_sys_socketcall> */
	cmp    $0x69,%esi
	je     0xffffffff810067cf - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x196f> */
	cmp    $0x6a,%esi
	jne    0xffffffff81006306 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x14a6> */
	jmp    0xffffffff8132a1b0 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_compat_sys_newstat> */
	cmp    $0x61,%esi
	je     0xffffffff810067ca - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x196a> */
	cmp    $0x63,%esi
	jne    0xffffffff8100603b - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x11db> */
	jmp    0xffffffff8136e8c0 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_compat_sys_statfs> */
	cmp    $0x4b,%esi
	je     0xffffffff810067c5 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x1965> */
	jbe    0xffffffff8100634d - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x14ed> */
	cmp    $0x52,%esi
	je     0xffffffff810067c0 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x1960> */
	jbe    0xffffffff8100632b - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x14cb> */
	cmp    $0x55,%esi
	je     0xffffffff810067bb - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x195b> */
	jbe    0xffffffff81006314 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x14b4> */
	cmp    $0x56,%esi
	je     0xffffffff810067b6 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x1956> */
	cmp    $0x57,%esi
	jne    0xffffffff8100606e - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x120e> */
	jmp    0xffffffff812faf40 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_swapon> */
	cmp    $0x5c,%esi
	je     0xffffffff810067b1 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x1951> */
	jbe    0xffffffff81006045 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x11e5> */
	cmp    $0x5d,%esi
	je     0xffffffff810067ac - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x194c> */
	cmp    $0x5e,%esi
	jne    0xffffffff8100606e - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x120e> */
	jmp    0xffffffff8131c7d0 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_fchmod> */
	cmp    $0x1b,%esi
	je     0xffffffff810067a7 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x1947> */
	jbe    0xffffffff8100646d - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x160d> */
	cmp    $0x2d,%esi
	je     0xffffffff810067a2 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x1942> */
	jbe    0xffffffff810063f5 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x1595> */
	cmp    $0x34,%esi
	je     0xffffffff8100679d - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x193d> */
	jbe    0xffffffff8100642a - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x15ca> */
	cmp    $0x39,%esi
	je     0xffffffff81006798 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x1938> */
	jbe    0xffffffff8100605c - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x11fc> */
	cmp    $0x3b,%esi
	je     0xffffffff81006793 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x1933> */
	cmp    $0x3c,%esi
	jne    0xffffffff8100606e - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x120e> */
	jmp    0xffffffff810aef30 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_umask> */
	cmp    $0x60,%esi
	jne    0xffffffff8100606e - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x120e> */
	jmp    0xffffffff810ab760 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_getpriority> */
	cmp    $0x5a,%esi
	je     0xffffffff8100678e - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x192e> */
	cmp    $0x5b,%esi
	jne    0xffffffff8100644c - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x15ec> */
	jmp    0xffffffff812c7190 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_munmap> */
	cmp    $0x36,%esi
	je     0xffffffff81006789 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x1929> */
	cmp    $0x37,%esi
	je     0xffffffff81005356 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x4f6> */
	jmp    0xffffffff81003d20 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_ni_syscall> */
	cmp    $0x173,%esi
	je     0xffffffff81006784 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x1924> */
	cmp    $0x174,%esi
	jne    0xffffffff8100606e - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x120e> */
	jmp    0xffffffff81c24300 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_compat_sys_recvmsg> */
	cmp    $0x1b7,%esi
	je     0xffffffff8100677f - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x191f> */
	cmp    $0x1b8,%esi
	jne    0xffffffff810060e7 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x1287> */
	jmp    0xffffffff812f2ed0 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_process_madvise> */
	cmp    $0x164,%esi
	je     0xffffffff8100677a - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x191a> */
	jbe    0xffffffff81006111 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x12b1> */
	cmp    $0x168,%esi
	je     0xffffffff81006775 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x1915> */
	jbe    0xffffffff810060f8 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x1298> */
	cmp    $0x169,%esi
	je     0xffffffff81006770 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x1910> */
	cmp    $0x16a,%esi
	jne    0xffffffff8100606e - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x120e> */
	jmp    0xffffffff81b96430 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_connect> */
	cmp    $0x1a2,%esi
	jne    0xffffffff8100606e - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x120e> */
	jmp    0xffffffff815045b0 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_mq_timedsend> */
	cmp    $0x1b6,%esi
	jne    0xffffffff8100606e - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x120e> */
	jmp    0xffffffff810bb730 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_pidfd_getfd> */
	cmp    $0x166,%esi
	je     0xffffffff8100676b - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x190b> */
	cmp    $0x167,%esi
	jne    0xffffffff8100613c - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x12dc> */
	jmp    0xffffffff81b958f0 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_socket> */
	cmp    $0x161,%esi
	je     0xffffffff81006766 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x1906> */
	jbe    0xffffffff8100614d - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x12ed> */
	cmp    $0x162,%esi
	je     0xffffffff81006761 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x1901> */
	cmp    $0x163,%esi
	jne    0xffffffff8100606e - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x120e> */
	jmp    0xffffffff816f86f0 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_getrandom> */
	cmp    $0x165,%esi
	jne    0xffffffff8100606e - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x120e> */
	jmp    0xffffffff811f2360 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_bpf> */
	cmp    $0x15f,%esi
	je     0xffffffff8100675c - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x18fc> */
	cmp    $0x160,%esi
	jne    0xffffffff81006254 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x13f4> */
	jmp    0xffffffff810eda70 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_sched_getattr> */
	cmp    $0xab,%esi
	je     0xffffffff81006757 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x18f7> */
	jbe    0xffffffff8100621e - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x13be> */
	cmp    $0xac,%esi
	je     0xffffffff81006752 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x18f2> */
	cmp    $0xad,%esi
	jne    0xffffffff8100606e - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x120e> */
	jmp    0xffffffff8103b2e0 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_compat_sys_rt_sigreturn> */
	cmp    $0xc8,%esi
	je     0xffffffff8100674d - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x18ed> */
	jbe    0xffffffff810062ba - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x145a> */
	cmp    $0xc9,%esi
	je     0xffffffff81006748 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x18e8> */
	cmp    $0xca,%esi
	jne    0xffffffff8100606e - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x120e> */
	jmp    0xffffffff810ac810 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_getegid> */
	cmp    $0xcc,%esi
	je     0xffffffff81006743 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x18e3> */
	cmp    $0xcd,%esi
	jne    0xffffffff8100606e - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x120e> */
	jmp    0xffffffff810ca430 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_getgroups> */
	cmp    $0xbb,%esi
	je     0xffffffff8100673e - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x18de> */
	jbe    0xffffffff81006265 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x1405> */
	cmp    $0xc1,%esi
	je     0xffffffff81006739 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x18d9> */
	jbe    0xffffffff81006237 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x13d7> */
	cmp    $0xc2,%esi
	je     0xffffffff81006734 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x18d4> */
	cmp    $0xc3,%esi
	jne    0xffffffff8100606e - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x120e> */
	jmp    0xffffffff8103ad90 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_compat_sys_ia32_stat64> */
	cmp    $0xa8,%esi
	je     0xffffffff8100672f - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x18cf> */
	cmp    $0xaa,%esi
	jne    0xffffffff81006290 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x1430> */
	jmp    0xffffffff811675b0 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_setresgid16> */
	cmp    $0xbf,%esi
	je     0xffffffff8100672a - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x18ca> */
	cmp    $0xc0,%esi
	jne    0xffffffff810062d3 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x1473> */
	jmp    0xffffffff812c6080 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_mmap_pgoff> */
	cmp    $0x15e,%esi
	jne    0xffffffff8100606e - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x120e> */
	jmp    0xffffffff8113b9c0 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_finit_module> */
	cmp    $0xb8,%esi
	je     0xffffffff81006725 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x18c5> */
	jbe    0xffffffff810062a1 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x1441> */
	cmp    $0xb9,%esi
	je     0xffffffff81006720 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x18c0> */
	cmp    $0xba,%esi
	jne    0xffffffff8100606e - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x120e> */
	jmp    0xffffffff810a8370 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_compat_sys_sigaltstack> */
	cmp    $0xa5,%esi
	jne    0xffffffff8100606e - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x120e> */
	jmp    0xffffffff811674a0 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_getresuid16> */
	cmp    $0xb6,%esi
	je     0xffffffff8100671b - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x18bb> */
	cmp    $0xb7,%esi
	jne    0xffffffff810062e4 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x1484> */
	jmp    0xffffffff8136d3e0 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_getcwd> */
	cmp    $0xc6,%esi
	je     0xffffffff81006716 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x18b6> */
	cmp    $0xc7,%esi
	jne    0xffffffff810062f5 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x1495> */
	jmp    0xffffffff810ac750 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_getuid> */
	cmp    $0xbe,%esi
	jne    0xffffffff8100606e - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x120e> */
	jmp    0xffffffff8108e0e0 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_vfork> */
	cmp    $0xb5,%esi
	jne    0xffffffff8100606e - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x120e> */
	jmp    0xffffffff8103aa90 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_ia32_pwrite64> */
	cmp    $0xc5,%esi
	jne    0xffffffff8100606e - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x120e> */
	jmp    0xffffffff8103ae30 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_compat_sys_ia32_fstat64> */
	cmp    $0x68,%esi
	jne    0xffffffff8100606e - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x120e> */
	jmp    0xffffffff81156fe0 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_compat_sys_setitimer> */
	cmp    $0x53,%esi
	je     0xffffffff81006711 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x18b1> */
	cmp    $0x54,%esi
	jne    0xffffffff8100606e - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x120e> */
	jmp    0xffffffff81329b90 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_lstat> */
	cmp    $0x4f,%esi
	je     0xffffffff8100670c - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x18ac> */
	jbe    0xffffffff8100637a - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x151a> */
	cmp    $0x50,%esi
	je     0xffffffff81006707 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x18a7> */
	cmp    $0x51,%esi
	jne    0xffffffff8100606e - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x120e> */
	jmp    0xffffffff811679f0 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_setgroups16> */
	cmp    $0x44,%esi
	je     0xffffffff81006702 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x18a2> */
	jbe    0xffffffff810063a0 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x1540> */
	cmp    $0x48,%esi
	je     0xffffffff810066fd - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x189d> */
	jbe    0xffffffff8100638d - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x152d> */
	cmp    $0x49,%esi
	je     0xffffffff810066f8 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x1898> */
	cmp    $0x4a,%esi
	jne    0xffffffff8100606e - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x120e> */
	jmp    0xffffffff810ad550 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_sethostname> */
	cmp    $0x4d,%esi
	je     0xffffffff810066f3 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x1893> */
	cmp    $0x4e,%esi
	jne    0xffffffff810063c2 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x1562> */
	jmp    0xffffffff81140970 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_compat_sys_gettimeofday> */
	cmp    $0x46,%esi
	je     0xffffffff810066ee - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x188e> */
	cmp    $0x47,%esi
	jne    0xffffffff810063d0 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x1570> */
	jmp    0xffffffff811671c0 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_setregid16> */
	cmp    $0x41,%esi
	je     0xffffffff810066e9 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x1889> */
	jbe    0xffffffff810063de - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x157e> */
	cmp    $0x42,%esi
	je     0xffffffff810066e4 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x1884> */
	cmp    $0x43,%esi
	jne    0xffffffff8100606e - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x120e> */
	jmp    0xffffffff810a8e60 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_compat_sys_sigaction> */
	cmp    $0x4c,%esi
	jne    0xffffffff8100606e - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x120e> */
	jmp    0xffffffff810ae590 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_compat_sys_old_getrlimit> */
	cmp    $0x45,%esi
	jne    0xffffffff8100606e - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x120e> */
	jmp    0xffffffff810a91f0 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_ssetmask> */
	cmp    $0x3f,%esi
	je     0xffffffff810066df - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x187f> */
	cmp    $0x40,%esi
	jne    0xffffffff810064c0 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x1660> */
	jmp    0xffffffff810ac700 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_getppid> */
	cmp    $0x25,%esi
	je     0xffffffff810066da - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x187a> */
	jbe    0xffffffff810064ea - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x168a> */
	cmp    $0x29,%esi
	je     0xffffffff810066d5 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x1875> */
	jbe    0xffffffff810064ad - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x164d> */
	cmp    $0x2a,%esi
	je     0xffffffff810066d0 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x1870> */
	cmp    $0x2b,%esi
	jne    0xffffffff8100606e - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x120e> */
	jmp    0xffffffff810ac990 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_compat_sys_times> */
	cmp    $0x31,%esi
	je     0xffffffff810066cb - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x186b> */
	jbe    0xffffffff8100645a - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x15fa> */
	cmp    $0x32,%esi
	je     0xffffffff810066c6 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x1866> */
	cmp    $0x33,%esi
	jne    0xffffffff8100606e - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x120e> */
	jmp    0xffffffff81169820 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_acct> */
	cmp    $0x59,%esi
	jne    0xffffffff8100606e - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x120e> */
	jmp    0xffffffff8133e130 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_compat_sys_old_readdir> */
	cmp    $0x2f,%esi
	je     0xffffffff810066c1 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x1861> */
	cmp    $0x30,%esi
	jne    0xffffffff810064ce - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x166e> */
	jmp    0xffffffff810a9320 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_signal> */
	cmp    $0xd,%esi
	je     0xffffffff810066bc - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x185c> */
	jbe    0xffffffff81006558 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x16f8> */
	cmp    $0x15,%esi
	je     0xffffffff810066b7 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x1857> */
	jbe    0xffffffff81006536 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x16d6> */
	cmp    $0x18,%esi
	je     0xffffffff810066b2 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x1852> */
	jbe    0xffffffff8100650c - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x16ac> */
	cmp    $0x19,%esi
	je     0xffffffff810066ad - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x184d> */
	cmp    $0x1a,%esi
	jne    0xffffffff8100606e - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x120e> */
	jmp    0xffffffff8109f670 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_compat_sys_ptrace> */
	cmp    $0x27,%esi
	je     0xffffffff810066a8 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x1848> */
	cmp    $0x28,%esi
	jne    0xffffffff810064dc - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x167c> */
	jmp    0xffffffff81338b90 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_rmdir> */
	cmp    $0x3e,%esi
	jne    0xffffffff8100606e - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x120e> */
	jmp    0xffffffff8136eb00 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_compat_sys_ustat> */
	cmp    $0x2e,%esi
	jne    0xffffffff8100606e - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x120e> */
	jmp    0xffffffff81167230 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_setgid16> */
	cmp    $0x26,%esi
	jne    0xffffffff8100606e - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x120e> */
	jmp    0xffffffff81339fb0 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_rename> */
	cmp    $0x21,%esi
	je     0xffffffff810066a3 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x1843> */
	jbe    0xffffffff81006523 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x16c3> */
	cmp    $0x22,%esi
	je     0xffffffff8100669e - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x183e> */
	cmp    $0x24,%esi
	jne    0xffffffff8100606e - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x120e> */
	jmp    0xffffffff8136b1e0 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_sync> */
	cmp    $0x16,%esi
	je     0xffffffff81006699 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x1839> */
	cmp    $0x17,%esi
	jne    0xffffffff8100606e - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x120e> */
	jmp    0xffffffff81167310 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_setuid16> */
	cmp    $0x1d,%esi
	je     0xffffffff81006694 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x1834> */
	cmp    $0x1e,%esi
	jne    0xffffffff81006585 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x1725> */
	jmp    0xffffffff8136c340 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_utime32> */
	cmp    $0x12,%esi
	je     0xffffffff8100668f - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x182f> */
	jbe    0xffffffff81006593 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x1733> */
	cmp    $0x13,%esi
	je     0xffffffff8100668a - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x182a> */
	cmp    $0x14,%esi
	jne    0xffffffff8100606e - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x120e> */
	jmp    0xffffffff810ac6a0 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_getpid> */
	cmp    $0x6,%esi
	je     0xffffffff81006685 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x1825> */
	jbe    0xffffffff810065b9 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x1759> */
	cmp    $0xa,%esi
	je     0xffffffff81006680 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x1820> */
	jbe    0xffffffff810065a6 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x1746> */
	cmp    $0xb,%esi
	je     0xffffffff8100667b - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x181b> */
	cmp    $0xc,%esi
	jne    0xffffffff8100606e - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x120e> */
	jmp    0xffffffff8131bfd0 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_chdir> */
	cmp    $0x1c,%esi
	jne    0xffffffff8100606e - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x120e> */
	jmp    0xffffffff81329be0 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_fstat> */
	cmp    $0xf,%esi
	je     0xffffffff81006676 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x1816> */
	cmp    $0x10,%esi
	jne    0xffffffff810065db - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x177b> */
	jmp    0xffffffff81167080 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_lchown16> */
	cmp    $0x8,%esi
	je     0xffffffff81006671 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x1811> */
	cmp    $0x9,%esi
	jne    0xffffffff810065e9 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x1789> */
	jmp    0xffffffff813397a0 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_link> */
	cmp    $0x3,%esi
	je     0xffffffff8100666c - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x180c> */
	jbe    0xffffffff810065f7 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x1797> */
	cmp    $0x4,%esi
	je     0xffffffff81006667 - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x1807> */
	cmp    $0x5,%esi
	jne    0xffffffff8100606e - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x120e> */
	jmp    0xffffffff8131dc60 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_compat_sys_open> */
	cmp    $0xe,%esi
	jne    0xffffffff8100606e - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x120e> */
	jmp    0xffffffff81338600 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_mknod> */
	cmp    $0x7,%esi
	jne    0xffffffff8100606e - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x120e> */
	jmp    0xffffffff810961b0 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_waitpid> */
	cmp    $0x1,%esi
	je     0xffffffff81006b0d - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x1cad> */
	cmp    $0x2,%esi
	jne    0xffffffff8100660a - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x17aa> */
	jmp    0xffffffff8108e070 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_fork> */
	test   %esi,%esi
	jne    0xffffffff8100606e - 0xffffffff81004e60 + ia32_sys_call /* <ia32_sys_call+0x120e> */
	jmp    0xffffffff810a2e20 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_restart_syscall> */
	jmp    0xffffffff8135b4a0 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_listxattr> */
	jmp    0xffffffff81511320 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_lsm_list_modules> */
	jmp    0xffffffff815111d0 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_lsm_set_self_attr> */
	jmp    0xffffffff81357100 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_statmount> */
	jmp    0xffffffff8130ca80 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_set_mempolicy_home_node> */
	jmp    0xffffffff8131db50 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_openat2> */
	jmp    0xffffffff811520c0 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_timer_settime> */
	jmp    0xffffffff8113e920 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_kcmp> */
	jmp    0xffffffff8135b6c0 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_removexattr> */
	jmp    0xffffffff8135b5e0 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_flistxattr> */
	jmp    0xffffffff8135b3a0 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_fgetxattr> */
	jmp    0xffffffff810ac6d0 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_gettid> */
	jmp    0xffffffff810ac0c0 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_getresuid> */
	jmp    0xffffffff8103aa10 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_ia32_pread64> */
	jmp    0xffffffff8136b440 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_fsync> */
	jmp    0xffffffff8135b780 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_fremovexattr> */
	jmp    0xffffffff81321530 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_write> */
	jmp    0xffffffff813213e0 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_read> */
	jmp    0xffffffff8131df60 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_creat> */
	jmp    0xffffffff8131c950 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_chmod> */
	jmp    0xffffffff8132d690 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_compat_sys_execve> */
	jmp    0xffffffff81339060 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_unlink> */
	jmp    0xffffffff8131e070 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_close> */
	jmp    0xffffffff8131ff60 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_compat_sys_lseek> */
	jmp    0xffffffff81329b40 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_stat> */
	jmp    0xffffffff810a93b0 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_pause> */
	jmp    0xffffffff813536f0 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_oldumount> */
	jmp    0xffffffff810ebfa0 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_nice> */
	jmp    0xffffffff8131beb0 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_access> */
	jmp    0xffffffff813388e0 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_mkdir> */
	jmp    0xffffffff81140480 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_stime32> */
	jmp    0xffffffff81167a10 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_getuid16> */
	jmp    0xffffffff81356500 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_mount> */
	jmp    0xffffffff811403a0 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_time32> */
	jmp    0xffffffff81167ab0 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_getgid16> */
	jmp    0xffffffff81167b00 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_getegid16> */
	jmp    0xffffffff81167a60 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_geteuid16> */
	jmp    0xffffffff8132f900 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_pipe> */
	jmp    0xffffffff8134d220 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_dup> */
	jmp    0xffffffff810a7320 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_kill> */
	jmp    0xffffffff8134d010 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_dup2> */
	jmp    0xffffffff810acfb0 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_setsid> */
	jmp    0xffffffff810acd10 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_getpgrp> */
	jmp    0xffffffff811672a0 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_setreuid16> */
	jmp    0xffffffff810aeea0 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_compat_sys_getrusage> */
	jmp    0xffffffff810a85c0 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_compat_sys_sigpending> */
	jmp    0xffffffff810a9670 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_sigsuspend> */
	jmp    0xffffffff810a9120 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_sgetmask> */
	jmp    0xffffffff81167900 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_getgroups16> */
	jmp    0xffffffff81140b10 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_compat_sys_settimeofday> */
	jmp    0xffffffff81339300 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_symlink> */
	jmp    0xffffffff8131cd90 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_lchown> */
	jmp    0xffffffff81166fd0 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_chown16> */
	jmp    0xffffffff8109d220 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_capset> */
	jmp    0xffffffff8109d1d0 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_capget> */
	jmp    0xffffffff810ae170 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_compat_sys_getrlimit> */
	jmp    0xffffffff81340af0 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_poll> */
	jmp    0xffffffff8103a9a0 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_ia32_ftruncate64> */
	jmp    0xffffffff8103a940 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_ia32_truncate64> */
	jmp    0xffffffff81322860 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_compat_sys_sendfile> */
	jmp    0xffffffff810ab900 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_setregid> */
	jmp    0xffffffff810ac790 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_geteuid> */
	jmp    0xffffffff810ac7d0 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_getgid> */
	jmp    0xffffffff810af940 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_prctl> */
	jmp    0xffffffff811676c0 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_getresgid16> */
	jmp    0xffffffff810ed370 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_sched_setattr> */
	jmp    0xffffffff8119e4c0 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_seccomp> */
	jmp    0xffffffff81339e20 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_renameat2> */
	jmp    0xffffffff8132d750 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_compat_sys_execveat> */
	jmp    0xffffffff81b95d90 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_bind> */
	jmp    0xffffffff81b95bd0 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_socketpair> */
	jmp    0xffffffff81319f10 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_memfd_create> */
	jmp    0xffffffff8131be50 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_faccessat2> */
	jmp    0xffffffff81c243e0 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_compat_sys_recvfrom> */
	jmp    0xffffffff8133d100 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_compat_sys_ioctl> */
	jmp    0xffffffff8103aee0 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_compat_sys_ia32_mmap> */
	jmp    0xffffffff810ad1b0 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_olduname> */
	jmp    0xffffffff810acc80 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_setpgid> */
	jmp    0xffffffff813535f0 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_umount> */
	jmp    0xffffffff812c8680 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_brk> */
	jmp    0xffffffff81156c30 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_alarm> */
	jmp    0xffffffff8131bb30 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_compat_sys_ftruncate> */
	jmp    0xffffffff8131b7c0 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_compat_sys_truncate> */
	jmp    0xffffffff8132c6c0 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_uselib> */
	jmp    0xffffffff81329e20 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_readlink> */
	jmp    0xffffffff81340f60 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_compat_sys_old_select> */
	jmp    0xffffffff810ae010 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_compat_sys_setrlimit> */
	jmp    0xffffffff810ab700 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_setpriority> */
	jmp    0xffffffff81156890 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_compat_sys_getitimer> */
	jmp    0xffffffff810370c0 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_ioperm> */
	jmp    0xffffffff8136e910 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_compat_sys_fstatfs> */
	jmp    0xffffffff81167130 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_fchown16> */
	jmp    0xffffffff8132a2b0 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_compat_sys_newfstat> */
	jmp    0xffffffff8132a200 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_compat_sys_newlstat> */
	jmp    0xffffffff8131e160 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_vhangup> */
	jmp    0xffffffff81b96e90 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_getsockopt> */
	jmp    0xffffffff813220f0 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_compat_sys_preadv2> */
	jmp    0xffffffff810afab0 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_compat_sys_sysinfo> */
	jmp    0xffffffff812fae90 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_swapoff> */
	jmp    0xffffffff81037170 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_iopl> */
	jmp    0xffffffff81106d70 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_syslog> */
	jmp    0xffffffff810c7f40 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_reboot> */
	jmp    0xffffffff8131c380 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_chroot> */
	jmp    0xffffffff8138a000 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_timerfd_settime> */
	jmp    0xffffffff81341630 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_compat_sys_ppoll_time64> */
	jmp    0xffffffff81341080 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_compat_sys_pselect6_time64> */
	jmp    0xffffffff81356680 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_fsmount> */
	jmp    0xffffffff811677b0 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_setfsuid16> */
	jmp    0xffffffff8103b020 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_compat_sys_ia32_clone> */
	jmp    0xffffffff810393c0 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_modify_ldt> */
	jmp    0xffffffff810acff0 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_newuname> */
	jmp    0xffffffff8113b8f0 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_init_module> */
	jmp    0xffffffff812c27f0 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_mlockall> */
	jmp    0xffffffff810acce0 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_getpgid> */
	jmp    0xffffffff813b7f00 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_quotactl> */
	jmp    0xffffffff812cce00 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_mprotect> */
	jmp    0xffffffff812cf390 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_msync> */
	jmp    0xffffffff8133e2d0 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_compat_sys_getdents> */
	jmp    0xffffffff81320110 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_llseek> */
	jmp    0xffffffff810ed7b0 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_sched_getparam> */
	jmp    0xffffffff810ed120 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_sched_setparam> */
	jmp    0xffffffff810ee3b0 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_sched_get_priority_max> */
	jmp    0xffffffff810ace00 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_getsid> */
	jmp    0xffffffff81321a70 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_writev> */
	jmp    0xffffffff813993e0 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_flock> */
	jmp    0xffffffff8134d9c0 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_sysfs> */
	jmp    0xffffffff81147210 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_nanosleep_time32> */
	jmp    0xffffffff810ee670 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_sched_rr_get_interval_time32> */
	jmp    0xffffffff810ed620 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_sched_getscheduler> */
	jmp    0xffffffff810a32d0 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_compat_sys_rt_sigprocmask> */
	jmp    0xffffffff8131cf60 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_fchown> */
	jmp    0xffffffff810ca540 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_setgroups> */
	jmp    0xffffffff810abc10 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_setreuid> */
	jmp    0xffffffff8103ade0 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_compat_sys_ia32_lstat64> */
	jmp    0xffffffff81b966a0 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_getpeername> */
	jmp    0xffffffff81b96560 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_getsockname> */
	jmp    0xffffffff81504730 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_mq_timedreceive> */
	jmp    0xffffffff815a8030 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_io_uring_enter> */
	jmp    0xffffffff811611c0 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_futex> */
	jmp    0xffffffff810a6f30 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_compat_sys_rt_sigtimedwait_time64> */
	jmp    0xffffffff81c24460 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_compat_sys_recvmmsg_time64> */
	jmp    0xffffffff81356850 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_move_mount> */
	jmp    0xffffffff81355130 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_open_tree> */
	jmp    0xffffffff810ac410 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_getresgid> */
	jmp    0xffffffff81338560 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_mknodat> */
	jmp    0xffffffff810aba30 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_setgid> */
	jmp    0xffffffff810abd80 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_setuid> */
	jmp    0xffffffff8103ae80 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_compat_sys_ia32_fstatat64> */
	jmp    0xffffffff8136c5a0 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_futimesat_time32> */
	jmp    0xffffffff8136e9d0 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_compat_sys_statfs64> */
	jmp    0xffffffff8136c600 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_utimes_time32> */
	jmp    0xffffffff810a7510 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_tgkill> */
	jmp    0xffffffff81322780 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_sendfile64> */
	jmp    0xffffffff8116e4d0 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_compat_sys_sched_getaffinity> */
	jmp    0xffffffff8116e310 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_compat_sys_sched_setaffinity> */
	jmp    0xffffffff81357010 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_pivot_root> */
	jmp    0xffffffff8130a9d0 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_set_mempolicy> */
	jmp    0xffffffff81339260 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_symlinkat> */
	jmp    0xffffffff81161d50 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_compat_sys_set_robust_list> */
	jmp    0xffffffff8131bdf0 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_faccessat> */
	jmp    0xffffffff8131c8f0 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_fchmodat> */
	jmp    0xffffffff81339ef0 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_renameat> */
	jmp    0xffffffff8103ac20 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_ia32_sync_file_range> */
	jmp    0xffffffff8136a700 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_splice> */
	jmp    0xffffffff81392210 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_compat_sys_io_setup> */
	jmp    0xffffffff81386560 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_epoll_create> */
	jmp    0xffffffff81392830 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_compat_sys_io_submit> */
	jmp    0xffffffff813932c0 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_io_getevents_time32> */
	jmp    0xffffffff8104a210 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_get_thread_area> */
	jmp    0xffffffff812ca0e0 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_remap_file_pages> */
	jmp    0xffffffff813874e0 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_epoll_wait> */
	jmp    0xffffffff81151e20 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_timer_gettime32> */
	jmp    0xffffffff8116c770 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_compat_sys_kexec_load> */
	jmp    0xffffffff81152e00 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_clock_settime32> */
	jmp    0xffffffff811524e0 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_timer_delete> */
	jmp    0xffffffff81151b60 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_compat_sys_timer_create> */
	jmp    0xffffffff8103acb0 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_ia32_fadvise64> */
	jmp    0xffffffff81504d80 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_mq_timedsend_time32> */
	jmp    0xffffffff81504390 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_mq_unlink> */
	jmp    0xffffffff8130d1a0 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_mbind> */
	jmp    0xffffffff8150a480 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_request_key> */
	jmp    0xffffffff8150a420 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_add_key> */
	jmp    0xffffffff81585f70 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_ioprio_get> */
	jmp    0xffffffff81312f40 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_move_pages> */
	jmp    0xffffffff81380ac0 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_inotify_rm_watch> */
	jmp    0xffffffff813808a0 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_inotify_add_watch> */
	jmp    0xffffffff81585f10 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_ioprio_set> */
	jmp    0xffffffff81504b40 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_compat_sys_mq_notify> */
	jmp    0xffffffff81153190 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_clock_getres_time32> */
	jmp    0xffffffff8136c4b0 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_utimensat_time32> */
	jmp    0xffffffff81387730 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_epoll_pwait> */
	jmp    0xffffffff8136a5b0 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_vmsplice> */
	jmp    0xffffffff81341380 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_compat_sys_ppoll_time32> */
	jmp    0xffffffff810a7980 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_compat_sys_rt_sigqueueinfo> */
	jmp    0xffffffff810a70d0 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_compat_sys_rt_sigtimedwait_time32> */
	jmp    0xffffffff810a8b60 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_compat_sys_rt_sigaction> */
	jmp    0xffffffff81167390 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_setresuid16> */
	jmp    0xffffffff812c24c0 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_mlock> */
	jmp    0xffffffff812ccec0 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_pkey_alloc> */
	jmp    0xffffffff812cce60 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_pkey_mprotect> */
	jmp    0xffffffff81357060 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_mount_setattr> */
	jmp    0xffffffff81387cb0 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_compat_sys_epoll_pwait2> */
	jmp    0xffffffff8103ad40 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_ia32_fallocate> */
	jmp    0xffffffff81388bb0 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_compat_sys_signalfd4> */
	jmp    0xffffffff8138a390 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_timerfd_gettime32> */
	jmp    0xffffffff8132f8a0 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_pipe2> */
	jmp    0xffffffff81384840 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_fanotify_init> */
	jmp    0xffffffff81322380 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_compat_sys_pwritev> */
	jmp    0xffffffff81321ff0 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_compat_sys_preadv> */
	jmp    0xffffffff813864f0 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_epoll_create1> */
	jmp    0xffffffff813a6960 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_name_to_handle_at> */
	jmp    0xffffffff810ae780 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_prlimit64> */
	jmp    0xffffffff8133e010 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_getdents64> */
	jmp    0xffffffff812f2e30 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_madvise> */
	jmp    0xffffffff810ac680 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_setfsgid> */
	jmp    0xffffffff815010b0 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_shmdt> */
	jmp    0xffffffff8136b320 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_syncfs> */
	jmp    0xffffffff814f92d0 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_compat_sys_msgrcv> */
	jmp    0xffffffff814f9160 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_compat_sys_msgsnd> */
	jmp    0xffffffff81393390 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_compat_sys_io_pgetevents> */
	jmp    0xffffffff8138ef70 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_userfaultfd> */
	jmp    0xffffffff81b96ff0 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_shutdown> */
	jmp    0xffffffff81c24220 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_compat_sys_sendmsg> */
	jmp    0xffffffff81b95f00 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_listen> */
	jmp    0xffffffff814fc410 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_compat_sys_semctl> */
	jmp    0xffffffff814fc310 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_semget> */
	jmp    0xffffffff8132a0d0 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_statx> */
	jmp    0xffffffff81152850 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_clock_settime> */
	jmp    0xffffffff812de2c0 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_process_vm_readv> */
	jmp    0xffffffff810c4890 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_setns> */
	jmp    0xffffffff811530a0 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_clock_adjtime32> */
	jmp    0xffffffff812671c0 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_perf_event_open> */
	jmp    0xffffffff81389f20 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_timerfd_create> */
	jmp    0xffffffff8131dda0 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_compat_sys_openat> */
	jmp    0xffffffff811533b0 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_clock_nanosleep> */
	jmp    0xffffffff81152c60 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_clock_getres> */
	jmp    0xffffffff811529f0 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_clock_gettime> */
	jmp    0xffffffff815005a0 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_compat_sys_shmctl> */
	jmp    0xffffffff812c2550 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_mlock2> */
	jmp    0xffffffff8153fd20 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_landlock_add_rule> */
	jmp    0xffffffff8108e1f0 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_clone3> */
	jmp    0xffffffff810bb580 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_pidfd_open> */
	jmp    0xffffffff81371df0 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_fsconfig> */
	jmp    0xffffffff810a7400 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_pidfd_send_signal> */
	jmp    0xffffffff8127edb0 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_process_mrelease> */
	jmp    0xffffffff81315920 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_memfd_secret> */
	jmp    0xffffffff8153fc20 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_landlock_create_ruleset> */
	jmp    0xffffffff8131c890 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_fchmodat2> */
	jmp    0xffffffff8135ade0 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_setxattr> */
	jmp    0xffffffff81161bd0 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_futex_wait> */
	jmp    0xffffffff811619e0 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_futex_wake> */
	jmp    0xffffffff81357160 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_listmount> */
	jmp    0xffffffff8135b240 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_getxattr> */
	jmp    0xffffffff8135aed0 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_fsetxattr> */
	call   0xffffffff810953e0 - 0xffffffff81004e60 + ia32_sys_call /* <__ia32_sys_exit> */

.size ia32_sys_call, . - ia32_sys_call
