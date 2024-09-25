from systrack.arch import ArchX86
from systrack.elf import ELF

from .utils import *


def test_x86_no_table_extract_syscall_vaddrs():
	elf = ELF(make_test_elf('x86_no_table_syscall_handlers'))

	arch = ArchX86((6,11), 'x64')
	vaddrs = arch.extract_syscall_vaddrs(elf)
	assert len(vaddrs) == 358

	arch = ArchX86((6,11), 'x32')
	vaddrs = arch.extract_syscall_vaddrs(elf)
	assert len(vaddrs) == 358

	arch = ArchX86((6,11), 'ia32')
	vaddrs = arch.extract_syscall_vaddrs(elf)
	assert len(vaddrs) == 429
