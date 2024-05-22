Systrack
========

[![License][license-badge]](./LICENSE)
[![GitHub actions workflow status][actions-badge]][actions-link]
[![PyPI version][pypi-badge]][pypi-systrack]
[![PyPI downloads][pypi-badge2]][pypi-systrack]

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
kernels. For more detailed information, see `systrack --help`. For information
about supported architecture/ABI combinations, see `systrack --arch help`.

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
  dependency for Systrack to work.
- Optional: `addr2line` (from GNU binutils) is used to extract location
  information from DWARF debug info (if available). Without this program,
  Systrack will not output any information about syscall definition locations.
- Optional: if available, the `rg` ([ripgrep][ripgrep]) command is used for much
  faster recursive grepping of syscall definition locations within kernel
  sources when needed. Otherwise, slower pure-Python code is used.
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

---

*Copyright &copy; 2023-2024 Marco Bonelli. Licensed under the GNU General Public License v3.0.*

[license-badge]: https://img.shields.io/github/license/mebeim/systrack?color=blue
[actions-badge]: https://img.shields.io/github/actions/workflow/status/mebeim/systrack/publish.yml?event=release&label=publish
[actions-link]:  https://github.com/mebeim/systrack/actions/workflows/publish.yml
[pypi-badge]:    https://img.shields.io/pypi/v/systrack
[pypi-badge2]:   https://img.shields.io/pypi/dm/systrack
[pypi-systrack]: https://pypi.org/project/systrack/
[pypi-hatch]:    https://pypi.org/project/hatch
[ripgrep]:       https://github.com/BurntSushi/ripgrep
