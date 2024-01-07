Systrack changelog
==================

v0.3.2
------

**Improvement**:

- Correctly report `futex_{wait,wake,requeue}` depending on `CONFIG_FUTEX=y`.
- Use unicorn emoji (cuter) instead of test tube for esoteric syscalls in HTML
  output.

v0.3.1
------

**Improvements**:

- x86: Add build support for `map_shadow_stack`.
- Prefer `compat_sys_` over `__se_compat_sys_` and other longer symbol synonyms;
  same for `.compat_sys_` on PowerPC.

**Bug fixes**:

- Fix broken naive grepping of syscall definitions when no ripgrep is available.
- Correctly report `cachestat` depending on `CACHESTAT_SYSCALL=y`.

**Internal changes**:

- Sort stderr logs for reproducible output and easier diffing.
- Skip `lib/` directory in kernel sources to improve grepping performance.

v0.3
----

New arch support: PowerPC 64-bit, all ABIs, tested on v5.0+ kernels.

**Improvements:**

- Add ABI `bits` (integer) and `compat` (boolean) fields to JSON output.
- Support ELF symbols with weird names (special chars in the name).
- Support function descriptors for syscall table entries (useful for PowerPC64
  and Itanium 64).
- Support weird arch-specific `SYSCALL_DEFINEn` macros.
- Building kernels now generates relative paths in DWARF debug symbols through
  `-fdebug-prefix-map`.
- Improve stdout output and add a table header.
- Use `null` instead of `??`/`?` for unknown file/line info in JSON output.
- x86: improve dummy syscall implementation detection (handling endbr64/32
  instructions).
- ARM OABI: output syscall number location for the calling convention
  (`swi <NR>`).

**Bug fixes**:

- Correctly report `socketcall` depending on `CONFIG_NET=y`.
- Correctly strip more syscall symbol prefixes for more accurate syscall names.
- Fix bad symbol prefix detection in some weird edge cases, leading to wrong
  syscall names.
- x86: fix wrong register names for x86-64 compat 32-bit ABI (IA-32).

**Internal changes**:

- Reorganize arch-specific code.
- Handle SIGINT for more graceful termination.
- Auto-remap definition locations relative to KDIR for ease of use.

v0.2.1
------

**Improvements**:

- Make syscall symbol preference more consistent (in particular, stop mixing
  `__se_sys_xxx` and `sys_xxx` when possible).
- Achieve W3C compliance for HTML output format.

**Bug fixes**:

- x86: correct wrong syscall numbers for x32 ABI, they should all be ORed with
  `0x40000000` (`__X32_SYSCALL_BIT`).

v0.2
----

**Improvements**:

- Improve existing MIPS build and analysis support: use `ip27_defconfig` for
  64-bit for NUMA support and strip more symbol prefixes.
- Improve dummy syscall implementation detection (x86-64, ARM).

**Bug fixes**:

- Fix help text for `--arch`: building with `--arch arm` creates an
  EABI-only kernel.
- Fix a logging bug that caused not loging syscalls' `.origname` for not-found
  locations after grepping.
- x86: use the right Kconfig option for vm86 and vm86old

v0.1
----

First release.
