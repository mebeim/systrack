from .arm import ArchArm
from .arm64 import ArchArm64
from .mips import ArchMips
from .powerpc import ArchPowerPC
from .x86 import ArchX86

ARCH_CLASSES = (
	ArchArm,
	ArchArm64,
	ArchMips,
	ArchPowerPC,
	ArchX86,
)
