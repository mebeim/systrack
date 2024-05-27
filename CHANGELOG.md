Systrack changelog
==================

v0.5
----

We tried so hard, and got so far, but in the end, we need a disassembler! x86
mitigations have defeated us, we no longer have syscall tables to rely on.
Kernel developers were kind enough to write very simple ABI-specific
switch-based handlers to dispach syscalls, so analysis is still possible... just
significantly more complicated.

**Breaking changes**:

- Drop support for Python 3.6 and 3.7. Systrack now requires Python 3.8+. This
  is because of the new dependency on
  [`iced-x86`](https://pypi.org/project/iced-x86/).

**Improvements**:

- x86: support new kernels (6.9+) with no syscall tables.
- Remove unnecessary spaces between asterisks for double pointers in function
  signatures.
- Avoid KFCI `__{cfi,pfx}_` symbols when looking for `ni_syscall` symbols.

**Internal changes**:

- Depend on [`iced-x86`](https://pypi.org/project/iced-x86/) for disassembling
  x86 instructions and on [`jinja2`](https://pypi.org/project/jinja2/) for HTML
  output directly. Remove optional dependencies and only build one package.
- Rename `test` folder to `tests` to use the `hatch test` as test commnad
- Improve logging reproducibility by sorting more debugging log output.
- Improve broken Python package metadata (Python packaging moment).

v0.4
----

New arch support: PowerPC 32-bit, tested on v5.0+ kernels.

**Improvements**:

- Improve kconfig dependency checking logic for better warning/error messages.
- PowerPC PPC64: improve esoteric fast switch_endian syscall detection.
- Better (narrower) emoji spacing in HTML output.

**Bug fixes**:

- Correctly report `delete_module` depending on `CONFIG_MODULE_UNLOAD=y`.
- Fix incorrectly handled shared syscall table in x86-64 x32 ABI resulting in
  duplicated and unwanted entries in the output for kernels older than v5.4.
- Fix chance of building kernels without `memfd_create`, `memfd_secret`,
  `delete_module` (and possibly others) by always enabling `MEMFD_CREATE`,
  `MODULE_UNLOAD`, `NET` and `SECRETMEM` when available.
- Fix wrong handling of relative `--kdir` path (e.g., `.`) in some cases.
- Fix missed detection of non-implemented syscalls pointing to `kernel/sys_ni.c`
  when DWARF debug info contains relative paths.
- x86 x32: fix some x64 syscalls reported twice because both the x64 number and
  the historycally misnumbered x32 numbers (512-547) were being considered
  valid.

**Internal changes**:

- Ignore `sound/` and `user/` dirs to speed up grepping syscall definitions.
- Implement some basic unit tests for powerpc dummy/esoteric syscall detection.


v0.3.3
------

**Improvements**:

- Correctly report `lsm_{list_modules,get_self_attr,set_self_attr}` depending on
  `CONFIG_SECURITY=y`.


v0.3.2
------

**Improvements**:

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
