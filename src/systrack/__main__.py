import argparse
import logging
import os
import signal
import sys

from pathlib import Path
from textwrap import TextWrapper

from .arch import SUPPORTED_ARCHS, SUPPORTED_ARCHS_HELP
from .kernel import Kernel, KernelError, KernelArchError, KernelMultiABIError
from .kernel import KernelVersionError, KernelWithoutSymbolsError
from .log import log_setup, eprint
from .output import output_syscalls
from .utils import command_argv_to_string, command_available
from .utils import gcc_version, git_checkout, maybe_rel, format_duration
from .version import VERSION, VERSION_HELP

def sigint_handler(_, __):
	sys.stderr.write('Caught SIGINT, stopping\n')
	sys.exit(1)

def wrap_help(body: str) -> str:
	'''Wrap a string to 65 columns without breaking words for a nice --help
	output of the tool.
	'''
	tx = TextWrapper(65, break_long_words=False, replace_whitespace=False)
	return '\n'.join(tx.fill(line) for line in body.splitlines() if line.strip())

def parse_args() -> argparse.Namespace:
	'''Parse and partially validate command line arguments through argparse.
	'''
	ap = argparse.ArgumentParser(
		prog='systrack',
		usage='systrack [OPTIONS...] [VMLINUX]',
		description='Analyze a Linux kernel image and extract information about implemented syscalls',
		formatter_class=argparse.RawTextHelpFormatter
	)

	ap.add_argument('vmlinux', metavar='VMLINUX', nargs='?',
		help=wrap_help('path to vmlinux, if not inside KDIR or no KDIR supplied'))
	ap.add_argument('-k', '--kdir', metavar='KDIR',
		help=wrap_help('kernel source directory'))
	ap.add_argument('-a', '--arch', metavar='ARCH',
		help=wrap_help('kernel architecture/ABI combination; pass "help" for a '
			'list (default: autodetect)'))
	ap.add_argument('-b', '--build', action='store_true',
		help=wrap_help('configure and build kernel and exit'))
	ap.add_argument('-c', '--config', action='store_true',
		help=wrap_help('configure kernel and exit'))
	ap.add_argument('-C', '--clean', action='store_true',
		help=wrap_help('clean kernel sources (make distclean) and exit'))
	ap.add_argument('-x', '--cross', metavar='PREFIX',
		help=wrap_help('toolchain prefix for cross-compilation; use with -b/-c/-C'))
	ap.add_argument('-o', '--out', metavar='OUTDIR',
		help=wrap_help('output directory for out-of-tree kernel build (make '
			'O=...); only meaningful with -b/-c/-C'))
	ap.add_argument('-f', '--format', metavar='FMT',
		choices=('text', 'json', 'html'), default='text',
		help=wrap_help('output format: text, json or html (default: text)'))
	ap.add_argument('--absolute-paths', action='store_true',
		help=wrap_help('output absolute paths instead of paths relative to KDIR'))
	ap.add_argument('--remap', metavar='ORIG_KDIR',
		help=wrap_help('replace ORIG_KDIR with the KDIR provided with '
			'-k/--kdir for paths obtained from ELF debug information; needed '
			'if the kernel was built with ORIG_KDIR as source directory '
			'instead of KDIR, and debug info contains absolute paths to '
			'ORIG_KDIR'))
	ap.add_argument('--checkout', metavar='REF',
		help=wrap_help('git checkout to REF inside KDIR before doing anything; '
			'the special value "auto" can be used to checkout to the tag '
			'corresponding to the detected kernel version from VMLINUX'))
	ap.add_argument('--disable-opt', action='store_true',
		help=wrap_help('try building kernel with reduced/disabled '
		'optimizations for more reliable location results; only meaningful '
		'with -b'))
	ap.add_argument('-q', '--quiet', action='count', default=0,
		help=wrap_help('quietness level:\n'
		'  -q: no info; -qq: no warnings; -qqq: no errors;\n'
		'  -qqqq: no standard error output whatsoever'))
	ap.add_argument('-v', '--verbose', action='count', default=0,
		help=wrap_help('verbosity level:\n'
			'  -v: info; -vv: debug; -vvv: more debug;\n'
			'  -vvvv: also pass V=1 to make when building'))
	ap.add_argument('-V', '--version', action='version', version=VERSION_HELP,
		help=wrap_help('show version information and exit'))

	return ap.parse_args()

def instantiate_kernel(*a, **kwa) -> Kernel:
	'''Instantiate the Kernel class with the given parameters, handling and
	printing possible errors.
	'''
	try:
		return Kernel(*a, **kwa)
	except KernelArchError as e:
		eprint(str(e))
		sys.exit(f"See '{sys.argv[0]} --arch help' for more information")
	except KernelMultiABIError as e:
		arch_class, abis = e.args[1:]
		sys.exit(
			f'Detected architecture: {arch_class.name}\n'
			f'Detected ABIs: {", ".join(abis)}\n'
			'This kernel was built with support for multiple syscall ABIs.\n'
			'Select one using --arch NAME (see --arch HELP for more info).'
		)
	except KernelVersionError:
		sys.exit(
			'Unable to determine kernel version!\n',
			'Did you specify a valid kernel source directory (--kdir) or vmlinux path?'
		)
	except KernelWithoutSymbolsError:
		sys.exit(
			'The provided kernel image has no symbols, which are necessary for Systrack to work.\n',
			'You can try unstripping the image with tools such as "vmlinux-to-elf".'
		)
	except KernelError as e:
		eprint(str(e))
		sys.exit(1)

def main() -> int:
	signal.signal(signal.SIGINT, sigint_handler)

	args = parse_args()
	log_setup(args.quiet, args.verbose, os.isatty(sys.stderr.fileno()))

	logging.debug('Systrack v%s', VERSION)
	logging.debug('Command line: systrack %s', command_argv_to_string(sys.argv[1:]))

	arch_name = args.arch

	if arch_name is not None:
		arch_name = arch_name.lower()

		if arch_name not in SUPPORTED_ARCHS:
			if arch_name not in ('help', '?'):
				eprint(f'Unsupported architecture/ABI combination: {arch_name}')
				eprint('See --arch HELP for a list')
				return 1

			eprint(SUPPORTED_ARCHS_HELP)
			return 0

	if not args.kdir and not args.vmlinux:
		eprint('Need to specify a kernel source direcory and/or path to vmlinux')
		eprint('See --help for more information')
		return 1

	if not args.kdir and (args.checkout or args.config or args.build):
		eprint('Need to specify a kernel source direcory (--kdir)')
		return 1

	if not arch_name and (args.config or args.build):
		eprint('Need to specify an architecture/ABI combination (--arch)')
		eprint('See --arch HELP for a list')
		return 1

	cross   = args.cross or ''
	vmlinux = Path(args.vmlinux) if args.vmlinux else None
	kdir    = Path(args.kdir)    if args.kdir    else None
	outdir  = Path(args.out)     if args.out     else None
	rdir    = Path(args.remap)   if args.remap   else None

	# Checkout before building only if not set to auto
	if args.checkout and args.checkout != 'auto':
		eprint('Checking out to', args.checkout)
		git_checkout(kdir, args.checkout)

	if args.clean or args.config or args.build:
		if args.out:
			out = Path(args.out)

			try:
				if out.exists() and not out.is_dir():
					eprint(f'Output directory "{args.out}" already exists and is not a directory')
					return 1

				out.mkdir(exist_ok=True)
			except Exception as e:
				eprint(f'Failed to create output directory "{args.out}": {str(e)}')
				return 1

		# Check that GCC is available and log its version for our own sanity to
		# avoid mixing up toolchains
		gcc_cmd = cross + 'gcc'

		if not command_available(gcc_cmd):
			eprint(f'Command "{gcc_cmd}" not found')
			eprint('Make sure your cross-compilation toolchain is in $PATH')
			return 127

		if args.config or args.build:
			eprint('Compiler:', gcc_version(gcc_cmd))

		kernel = instantiate_kernel(arch_name, kdir=kdir, outdir=outdir, toolchain_prefix=cross)

		if args.build:
			eprint('Cleaning kernel sources')
			kernel.clean()
			eprint('Detected kernel version:', kernel.version_str)
			eprint('Configuring kernel')
			kernel.configure()
			eprint('Building kernel (might take a while)')
			elapsed = kernel.build(args.disable_opt)
			eprint('Build took', format_duration(elapsed))
		elif args.config:
			eprint('Cleaning kernel sources')
			kernel.clean()
			eprint('Detected kernel version:', kernel.version_str)
			eprint('Configuring kernel')
			kernel.configure()
			eprint('Done')
		elif args.clean:
			eprint('Cleaning kernel sources')
			kernel.clean()
			eprint('Done')

		return 0

	# Auto-checkout to the correct tag is only possible if we already have a
	# vmlinux to extract the version from
	if args.checkout == 'auto' and not vmlinux:
		eprint('Cannot perform auto-checkout without a vmlinux image!')
		return 1

	if not vmlinux:
		vmlinux = kdir / 'vmlinux'

	if not vmlinux.is_file():
		eprint(f'Unable to find vmlinux at "{vmlinux}".')
		eprint('Build the kernel or provide a valid path.')
		return 1

	if not command_available('readelf'):
		eprint('Command "readelf" unavailable, can\'t do much without it!')
		return 127

	kernel = instantiate_kernel(arch_name, vmlinux, kdir, outdir, rdir)
	eprint('Detected kernel version:', kernel.version_str)

	if args.checkout == 'auto':
		assert kernel.version_source == 'vmlinux'
		eprint('Checking out to', kernel.version_tag)
		git_checkout(kdir, kernel.version_tag)

	if not kernel.syscalls:
		return 1

	# Apply a couple of transformations that are independent of the chosen
	# output format, and also check how many syscalls do not have location or
	# signature information.

	syscalls  = kernel.syscalls
	kdir      = kernel.kdir
	abs_paths = args.absolute_paths
	n_no_loc  = 0
	n_no_sig  = 0
	n_grepped = 0

	for sc in kernel.syscalls:
		if sc.file is None:
			n_no_loc += 1
		else:
			if kdir and not abs_paths:
				sc.file = maybe_rel(sc.file, kdir)

		if kdir and sc.signature is None:
			n_no_sig += 1

		if sc.grepped_location:
			n_grepped += 1

	eprint('Found', len(syscalls), 'implemented syscalls')

	if n_grepped:
		eprint('Found', n_grepped, 'definition location' + ('s' if n_grepped > 1 else ''), 'through grepping')
	if n_no_loc:
		eprint('Could not find definition location for', n_no_loc, 'syscall' + ('s' if n_no_loc > 1 else ''))
	if n_no_sig:
		eprint('Could not extract signature for', n_no_sig, 'syscall' + ('s' if n_no_sig > 1 else ''))

	eprint()
	output_syscalls(kernel, args.format)
	return 0

# NOTE: this is NOT executed in a normal install, because the `systrack` command
# will point to a script that imports and directly calls the main() function
# above.
if __name__ == '__main__':
	sys.exit(main())
