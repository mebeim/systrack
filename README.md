Systrack
========

A tool to analyze Linux kernel images (`vmlinux`) and extract information about
implemented syscalls, written in Python 3 with `readelf` and `addr2line` as the
only necessary dependencies. Given a `vmlinux` image, Systrack can extract
syscall numbers, names, symbol names, definition locations within kernel
sources, function signatures, and more.

Systrack can configure and build kernels for all its supported architectures,
and works best at analyzing kernels that it has configured and built by itself.

Installation
------------

Install through Pip with `pip install systrack`. For HTML output support,
install `systrack[html]`, this will also install the needed dependencies.

Limitations
-----------

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
