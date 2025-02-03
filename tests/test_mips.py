from systrack.arch import ArchMips

from .utils import *


def test_dummy_syscall_64():
	for abi in ('n64', 'n32', 'o32'):
		# Big-endian
		assert arch_is_dummy_syscall(ArchMips((6,9), abi, False), True,
			bytes.fromhex(
				'03e00008' # jr  ra
				'2402ffa7' # li  v0,-89 (-ENOSYS)
			)
		)

		# Little-endian
		assert arch_is_dummy_syscall(ArchMips((6,9), abi, False), False,
			bytes.fromhex(
				'0800e003' # jr  ra
				'eaff0224' # li  v0,-22 (-EINVAL)
			)
		)
