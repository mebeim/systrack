import logging
from typing import Optional, Type, Tuple, List

from ..elf import ELF
from ..type_hints import KernelVersion

from .arch_base import Arch
from .arm import ArchArm
from .arm64 import ArchArm64
from .mips import ArchMips
from .powerpc import ArchPowerPC
from .riscv import ArchRiscV
from .s390 import ArchS390
from .x86 import ArchX86

ARCH_CLASSES = (
	ArchArm,
	ArchArm64,
	ArchMips,
	ArchPowerPC,
	ArchRiscV,
	ArchS390,
	ArchX86,
)

# NOTE: For the sake of mental sanity, try keeping abi= the same name as the one
# in the *.tbl files in the kernel sources.
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
	'powerpc'      : lambda v: ArchPowerPC(v, abi='ppc32', bits32=True), # "32" ABI
	'powerpc64'    : lambda v: ArchPowerPC(v, abi='ppc64'),              # "64" ABI
	'powerpc64-32' : lambda v: ArchPowerPC(v, abi='ppc32'),              # "32" ABI
	'powerpc64-spu': lambda v: ArchPowerPC(v, abi='spu'),
	'riscv'        : lambda v: ArchRiscV(v, abi='rv32', bits32=True),
	'riscv64'      : lambda v: ArchRiscV(v, abi='rv64'),
	'riscv64-32'   : lambda v: ArchRiscV(v, abi='rv32'),
	's390x'        : lambda v: ArchS390(v, abi='s390x'),
	's390'         : lambda v: ArchS390(v, abi='s390'),
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
	('arm64-aarch32', 'aarch32'   ),
	('mips'         , 'mips32'    ),
	('mips'         , 'o32'       ),
	('mips64'       , 'n64'       ),
	('mips64-n32'   , 'n32'       ),
	('mips64-o32'   , 'o32-64'    ),
	('powerpc'      , 'ppc'       ),
	('powerpc'      , 'ppc32'     ),
	('powerpc64'    , 'ppc64'     ),
	('powerpc64-32' , 'ppc64-32'  ),
	('powerpc64-spu', 'ppc64-spu' ),
	('powerpc64-spu', 'spu'       ),
	('riscv'        , 'riscv32'   ),
	('riscv'        , 'rv32'      ),
	('riscv64'      , 'rv64'      ),
	('riscv64-32'   , 'rv64-32'   ),
)

SUPPORTED_ARCHS.update({alias: SUPPORTED_ARCHS[arch] for arch, alias in ARCH_ALIASES})

SUPPORTED_ARCHS_HELP = '''\
Supported architectures and ABIs (values are case-insensitive):

    Value          Aliases         Arch     Kernel  Syscall ABI     Build based on             Notes
    ------------------------------------------------------------------------------------------------
    arm            arm-eabi, eabi  ARM      32-bit  32-bit EABI     multi_v7_defconfig         [2]
    arm-oabi       oabi            ARM      32-bit  32-bit OABI     multi_v7_defconfig         [2,4]
    ------------------------------------------------------------------------------------------------
    arm64          aarch64         ARM      64-bit  64-bit AArch64  defconfig
    arm64-aarch32  aarch32         ARM      64-bit  32-bit AArch32  defconfig                  [1]
    ------------------------------------------------------------------------------------------------
    mips           mips32, o32     MIPS     32-bit  32-bit O32      defconfig
    mips64         n64             MIPS     64-bit  64-bit N64      ip27_defconfig             [1]
    mips64-n32     n32             MIPS     64-bit  64-bit N32      ip27_defconfig             [1]
    mips64-o32     o32-64          MIPS     64-bit  32-bit O32      ip27_defconfig             [1]
    ------------------------------------------------------------------------------------------------
    powerpc        ppc, ppc32      PowerPC  32-bit  32-bit PPC32    ppc64_defconfig
    powerpc64      ppc64           PowerPC  64-bit  64-bit PPC64    ppc64_defconfig            [1]
    powerpc64-32   ppc64-32        PowerPC  64-bit  32-bit PPC32    ppc64_defconfig            [1]
    powerpc64-spu  ppc64-spu, spu  PowerPC  64-bit  64-bit "SPU"    ppc64_defconfig            [1,5]
    ------------------------------------------------------------------------------------------------
    riscv          riscv32, rv32   RISC-V   32-bit  32-bit "RV32"   defconfig + 32-bit.config  [3,6]
    riscv64        rv64            RISC-V   64-bit  64-bit "RV64"   defconfig                  [1,6]
    riscv64-32     rv64-32         RISC-V   64-bit  32-bit "RV32"   defconfig                  [1,6]
    ------------------------------------------------------------------------------------------------
    s390x                          IBM Z    64-bit  64-bit s390x    defconfig                  [1]
    s390                           IBM Z    64-bit  32-bit s390     defconfig                  [1]
    ------------------------------------------------------------------------------------------------
    x86            i386, ia32      x86      32-bit  32-bit IA32     i386_defconfig
    x86-64         x64             x86      64-bit  64-bit x86-64   x86_64_defconfig           [1]
    x86-64-x32     x32             x86      64-bit  64-bit x32      x86_64_defconfig           [1]
    x86-64-ia32    ia32-64         x86      64-bit  32-bit IA32     x86_64_defconfig           [1]

    [1] Building creates a kernel supporting all ABIs for this architecture.
    [2] Build based on "defconfig" for Linux <= v3.7.
    [3] Build based on "rv32_defconfig" for Linux <= v6.7 and "defconfig" for Linux <= v5.0.
    [4] Building creates an EABI kernel with compat OABI support. Building an OABI-only kernel is
        NOT supported. The seccomp filter system will be missing.
    [5] "SPU" is not a real ABI. It indicates a Cell processor SPU (Synergistic Processing Unit).
        The ABI is really PPC64, but SPUs can only use a subset of syscalls.
    [6] "RV32" and "RV64" are not real ABIs, but rather ISAs. The RISC-V syscall ABI is the same
        for 32-bit and 64-bit (only register size differs). These names are only used for clarity.
'''

def arch_from_name(name: str, kernel_version: KernelVersion) -> Arch:
	'''Instantiate and return the right Arch subclass given a human-friendly
	name (--arch). The name should be already validated.
	'''
	return SUPPORTED_ARCHS[name](kernel_version)

def arch_from_vmlinux(vmlinux: ELF) -> Optional[Tuple[Type[Arch],bool,List[str]]]:
	'''Determine architecture and supported ABIs from vmlinux ELF. Returns the
	correct Arch subclass, the bitness and a list of detected ABIs.
	'''
	for klass in ARCH_CLASSES:
		match = klass.match(vmlinux)
		if match:
			return klass, *match

	logging.fatal('Unknown or unsupported architecture: e_machine = %d, '
		'e_flags = 0x%x', vmlinux.e_machine, vmlinux.e_flags)
	return None
