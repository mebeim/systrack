Systrack
========

[![License][license-badge]](./LICENSE)
[![GitHub actions workflow status][actions-badge]][actions-link]
[![PyPI version][pypi-badge]][pypi-systrack]
[![PyPI downloads][pypi-badge2]][pypistats-systrack]

<img align="left" width="150" height="150" src="https://raw.githubusercontent.com/mebeim/systrack/master/assets/logo.png" alt="Systrack logo"></img>

**See [mebeim/linux-syscalls](https://github.com/mebeim/linux-syscalls) for live syscall tables powered by Systrack**.

Systrack is a tool to analyze Linux kernel images (`vmlinux`) and extract
information about implemented syscalls. Given a `vmlinux` image, Systrack can
extract syscall numbers, names, symbol names, definition locations within kernel
sources, function signatures, and more.

Systrack can configure and build kernels for all its supported architectures,
and works best at analyzing kernels that it has configured and built by itself.


Installation
------------

Systrack is [available on PyPI][pypi-systrack], it requires Python 3.8+ and is
installable through Pip:

```bash
pip install systrack
```

Building and installaing from source requires [`hatch`][pypi-hatch]:

```bash
hatch build
pip install dist/systrack-XXX.whl
```

Usage
-----

Systrack can mainly be used for two purposes: analyzing or building Linux
kernels. For more information, see [`systrack --help`](#command-line-help). For
information about supported architecture/ABI combinations, see
[`systrack --arch help`](#archabi-selection-help).

- **Analyzing** a kernel image can be done given a `vmlinux` ELF with symbols,
  and optionally also a kernel source directory (`--kdir`). Systrack will
  extract information about implemented syscalls from the symbol table present
  in the given `vmlinux` ELF, and if debugging information is present, it will
  also extract file and line number information for syscall definitions.
  Supplying `--kdir` will help refine and/or correct the location of the
  definitions, pointing Systrack to the checked-out sources for the right kernel
  version (the same as the one to analyze).

  Systrack can guess the architecture and ABI to analyze, but if the given
  kernel was built for support for multiple ABIs, the right one can be selected
  through `--arch`.

  ```none
  systrack path/to/vmlinux
  systrack --format json path/to/vmlinux
  systrack --format html path/to/vmlinux
  systrack --kdir path/to/linux_git_repo path/to/vmlinux
  systrack --kdir path/to/linux_git_repo --arch x86-64-ia32 path/to/vmlinux
  ```

- **Building** can be done through the `--build` option. You will need to
  provide a kernel source directory (`--kdir`) and an architecture/ABI
  combination to build for (`--arch`).

  ```none
  systrack --build --kdir path/to/linux_git_repo --arch x86-64
  ```

  Cross-compilation is possible specifying the correct toolchain prefix with
  the `--cross` option, which will set the `CROSS_COMPILE` variable for the
  kernel's `Makefile`.

  ```none
  systrack --build --kdir path/to/linux_git_repo --arch arm64 --cross aarch64-linux-gnu-
  ```

Runtime dependencies
--------------------

External (non-Python) runtime dependencies are:

- **Required**: `readelf` (from GNU binutils) is used to parse and extract ELF
  metadata such as symbols and sections. This is currently the only *compulsory*
  external dependency of Systrack.
- Optional: `addr2line` (from GNU binutils) is used to extract location
  information from DWARF debug info. Without this program, Systrack will not
  output any information about syscall definition locations.
- Optional: `rg` ([ripgrep][ripgrep]) is used for much faster recursive
  grepping of syscall definition locations within kernel sources when needed.
  Otherwise, a slower pure-Python implementation is used.
- Optional: a working compiler toolchain and
  [kernel build dependencies](https://www.kernel.org/doc/html/latest/process/changes.html)
  are obviously needed if you want Systrack to *build* kernels from source.


Limitations
-----------

- Supported kernel images: Systrack works with regular *uncompressed* `vmlinux`
  ELF images and *needs* ELF symbols. Compressed and stripped kernel images are
  not supported. Tools such as
  [`vmlinux-to-elf`](https://github.com/marin-m/vmlinux-to-elf) can be used to
  uncompress and unstrip kernel images, after which Systrack will be able to
  analyze them.
- Old kernel versions: Systrack was mainly designed for and tested on modern
  kernels (>= v4.0) and has not been tested on older kernels. It should still
  *somewhat* work on older kernels, but without the same level of guarantee on
  the correctness of the output. Support for old kernels may come gradually in
  the future.
- Relocatable kernels: Systrack does not currently parse and apply ELF
  relocations. This means that Systrack does not support kernels using
  relocation entries for the syscall table. On some architectures (notably MIPS)
  if the kernel is relocatable the syscall table is relocated at startup and
  does not contain valid virtual addresses: Systrack will currently fail to
  analyze such kernels.


Command line help
-----------------

```none
$ systrack --help

usage: systrack [OPTIONS...] [VMLINUX]

Analyze a Linux kernel image and extract information about implemented syscalls

positional arguments:
  VMLINUX               path to vmlinux, if not inside KDIR or no KDIR supplied

options:
  -h, --help            show this help message and exit
  -k KDIR, --kdir KDIR  kernel source directory
  -a ARCH, --arch ARCH  kernel architecture/ABI combination; pass "help" for a list
                        (default: autodetect)
  -b, --build           configure and build kernel and exit
  -c, --config          configure kernel and exit
  -C, --clean           clean kernel sources (make distclean) and exit
  -x PREFIX, --cross PREFIX
                        toolchain prefix for cross-compilation; use with -b/-c/-C
  -o OUTDIR, --out OUTDIR
                        output directory for out-of-tree kernel build (make O=...); only
                        meaningful with -b/-c/-C
  -f FMT, --format FMT  output format: text, json or html (default: text)
  --absolute-paths      output absolute paths instead of paths relative to KDIR
  --remap ORIG_KDIR     replace ORIG_KDIR with the KDIR provided with -k/--kdir for paths
                        obtained from ELF debug information; needed if the kernel was
                        built with ORIG_KDIR as source directory instead of KDIR, and
                        debug info contains absolute paths to ORIG_KDIR
  --checkout REF        git checkout to REF inside KDIR before doing anything; the
                        special value "auto" can be used to checkout to the tag
                        corresponding to the detected kernel version from VMLINUX
  --disable-opt         try building kernel with reduced/disabled optimizations for more
                        reliable location results; only meaningful with -b
  -q, --quiet           quietness level:
                          -q = no info, -qq = no warnings, -qqq = no errors
                          -qqqq = no standard error output whatsoever
  -v, --verbose         verbosity level:
                          -v = info, -vv = debug, -vvv = more debug
  -V, --version         show version information and exit
```


Arch/ABI selection help
-----------------------

```none
$ systrack-dev --arch help

Supported architectures and ABIs (values are case-insensitive):

    Value          Aliases         Arch     Kernel  ABI             Build based on      Notes
    -----------------------------------------------------------------------------------------
    x86            i386, ia32      x86      32-bit  32-bit IA32     i386_defconfig
    x86-64         x64             x86      64-bit  64-bit x86-64   x86_64_defconfig    [1]
    x86-64-x32     x32             x86      64-bit  64-bit x32      x86_64_defconfig    [1]
    x86-64-ia32    ia32-64         x86      64-bit  32-bit IA32     x86_64_defconfig    [1]
    -----------------------------------------------------------------------------------------
    arm            arm-eabi, eabi  ARM      32-bit  32-bit EABI     multi_v7_defconfig  [2]
    arm-oabi       oabi            ARM      32-bit  32-bit OABI     multi_v7_defconfig  [2,3]
    -----------------------------------------------------------------------------------------
    arm64          aarch64         ARM      64-bit  64-bit AArch64  defconfig
    arm64-aarch32  aarch32         ARM      64-bit  32-bit AArch32  defconfig           [4]
    -----------------------------------------------------------------------------------------
    mips           mips32, o32     MIPS     32-bit  32-bit O32      defconfig
    mips64         n64             MIPS     64-bit  64-bit N64      ip27_defconfig      [1]
    mips64-n32     n32             MIPS     64-bit  64-bit N32      ip27_defconfig      [1]
    mips64-o32     o32-64          MIPS     64-bit  32-bit O32      ip27_defconfig      [1]
    -----------------------------------------------------------------------------------------
    powerpc        ppc, ppc32      PowerPC  32-bit  32-bit PPC32    ppc64_defconfig
    powerpc64      ppc64           PowerPC  64-bit  64-bit PPC64    ppc64_defconfig     [1]
    powerpc64-32   ppc64-32        PowerPC  64-bit  32-bit PPC32    ppc64_defconfig     [1]
    powerpc64-spu  ppc64-spu, spu  PowerPC  64-bit  64-bit "SPU"    ppc64_defconfig     [1,5]

    [1] Building creates a kernel supporting all ABIs for this architecture.
    [2] Building for Linux <= v3.7 will use "defconfig" instead.
    [3] Building creates an EABI kernel with compat OABI support. Building an OABI-only
        kernel is NOT supported. The seccomp filter system will be missing.
    [4] AArch64 kernel with compat AArch32 support.
    [5] "SPU" is not a real ABI. It indicates a Cell processor SPU (Synergistic Processing
        Unit). The ABI is really PPC64, but SPUs can only use a subset of syscalls.
```

---

*Copyright &copy; 2023-2025 Marco Bonelli. Licensed under the GNU General Public License v3.0.*

[license-badge]:      https://img.shields.io/github/license/mebeim/systrack?color=blue
[actions-badge]:      https://img.shields.io/github/actions/workflow/status/mebeim/systrack/publish.yml?event=release&label=publish
[actions-link]:       https://github.com/mebeim/systrack/actions/workflows/publish.yml
[pypi-badge]:         https://img.shields.io/pypi/v/systrack
[pypi-badge2]:        https://img.shields.io/pypi/dm/systrack
[pypi-systrack]:      https://pypi.org/project/systrack/
[pypistats-systrack]: https://pypistats.org/packages/systrack
[pypi-hatch]:         https://pypi.org/project/hatch
[ripgrep]:            https://github.com/BurntSushi/ripgrep
