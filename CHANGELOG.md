Systrack changelog
==================

v0.2.1
------

Improvements:

- Make syscall symbol preference more consistent (in particular, stop mixing
  `__se_sys_xxx` and `sys_xxx` when possible).
- Achieve W3C compliance for HTML output format.

Bug fixes:

- x86: correct wrong syscall numbers for x32 ABI, they should all be ORed with
  `0x40000000` (`__X32_SYSCALL_BIT`).

v0.2
----

Improvements:

- Improve existing MIPS build and analysis support: use `ip27_defconfig` for
  64-bit for NUMA support and strip more symbol prefixes.
- Improve dummy syscall implementation detection (x86-64, ARM).

Bug fixes:

- Fix help text for `--arch`: building with `--arch arm` creates an
  EABI-only kernel.
- Fix a logging bug that caused not loging syscalls' `.origname` for not-found
  locations after grepping.
- x86: use the right Kconfig option for vm86 and vm86old

v0.1
----

First release.
