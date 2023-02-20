Systrack
========

A tool to analyze Linux kernel images (`vmlinux`) and extract information about
implemented syscalls. Given a `vmlinux` image, Systrack can extract syscall
numbers, names, symbol names, definition locations within kernel sources,
function signatures, and more.

Systrack can configure and build kernels for all its supported architectures,
and works best at analyzing kernels that it has configured and built by itself.

Installation
------------

Install through Pip with `pip install systrack`. For HTML output support,
install `systrack[html]`, this will also install the needed dependencies.

Runtime dependencies
--------------------

- **Required**: `readelf` (from GNU binutils) is used to parse and extract ELF
  metadata such as symbols and sections. This is currently the only *compulsory*
  dependency for Systrack to work.
- Optional: `addr2line` (from GNU binutils) is used to extract location
  information from DWARF debug info (if available). Without this program,
  Systrack will not output any information about syscall definition locations.
- Optional: the `jinja2` Python package, which can be either installed
  separately or automatically (`pip install systrack[html]`) is used to output
  interactive HTML pages with a sortable table, links and more. This is the
  richest output format (selectable with `--format html`).
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
- Relocatable kernel support: Systrack does not currently parse and apply ELF
  relocations. This means that Systrack does not support kernels using
  relocation entries for the syscall table. On some architectures (notably MIPS)
  if the kernel is relocatable the syscall table is relocated at startup and
  does not contain valid virtual addresses: Systrack will currently fail to
  analyze such kernels.
