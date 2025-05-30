import logging
import sys


__all__ = ['log_setup', 'log_verbosity', 'eprint']

SETUP_DONE = False
VERBOSITY = 0
SILENT_EPRINT = False


def log_setup(quietness: int, verbosity: int, colors: bool = True):
	'''Setup logging verbosity on the root logger based on the given quietness
	and verbosity levels from command line arguments (number of -q and -v
	options given). Enable colored logs with ANSI escape codes if color=True.
	'''
	global SETUP_DONE, VERBOSITY, SILENT_EPRINT

	assert not SETUP_DONE, 'log_setup() called multiple times'
	SETUP_DONE = True

	VERBOSITY = verbosity
	orig_factory = logging.getLogRecordFactory()

	if verbosity > 0:
		quietness = 0

	if quietness >= 1:
		quietness -= 1
		SILENT_EPRINT = True

	if colors:
		fmt = '%(color)s[%(levelname)s] %(message)s\x1b[0m'
		level_colors = {
			logging.CRITICAL: '\x1b[1;31m',
			logging.ERROR   : '\x1b[31m',
			logging.WARNING : '\x1b[33m',
			logging.INFO    : '\x1b[32m',
			logging.DEBUG   : '\x1b[34m',
		}

		def record_factory(*args, **kwargs):
			record = orig_factory(*args, **kwargs)
			lvl = record.levelno
			record.color = level_colors.get(lvl, '')
			record.levelname = 'FATAL' if lvl == logging.CRITICAL else record.levelname[0]
			return record
	else:
		fmt = '[%(levelname)s] %(message)s'

		def record_factory(*args, **kwargs):
			record = orig_factory(*args, **kwargs)
			record.levelname = 'FATAL' if record.levelno == logging.CRITICAL else record.levelname[0]
			return record

	adj = quietness - verbosity
	logging.basicConfig(level=max(30 + 10 * adj, 0), format=fmt)
	logging.setLogRecordFactory(record_factory)

def log_verbosity() -> bool:
	'''Return whether high verbosity is enabled (True if a lot of -v are given).
	'''
	return VERBOSITY

def eprint(*a, **kwa):
	'''print() wrapper that prints on standard error and flushes after printing,
	only if not in silent mode.
	'''
	if not SILENT_EPRINT:
		print(*a, **kwa, file=sys.stderr, flush=True)
