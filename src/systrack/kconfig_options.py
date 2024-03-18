#
# Kernels built by Systrack need to be configured with debug information (for
# file/line info) and with the most complete syscall table possible. In order to
# do this a lot of Kconfig options need to be set to the right value depending
# on the kernel version.
#
# Only arch-agnostic Kconfig options are present here. Arch-specific Kconfig
# options are defined separately in each `Arch` subclass in `arch/`.
#
# Versions for Kconfig options can be looked up using the online LKDDB:
# https://cateee.net/lkddb/web-lkddb/ - seriously a godsend for this job.
#

from .utils import VersionedList, VersionedDict

__all__ = [
	'VERSION_ZERO', 'VERSION_INF',
	'KCONFIG_DEBUGGING', 'KCONFIG_COMPATIBILITY',
	'KCONFIG_MORE_SYSCALLS', 'KCONFIG_SYSCALL_DEPS'
]

# We will probably never get even close to v2.6.12 (first tag in the main repo)
VERSION_ZERO = (2,6,12,)
VERSION_INF  = (9999999999,)

# Kconfig options that help Systrack do its job. We don't check dependencies on
# other Kconfig options for these as they are all global and dependency-free.
# We can add another different VersionedDict in the future if the need arises.
#
# Motivations behind these:
#
# - DEBUG_INFO=y is obviously essential to have file and line number information
#   in the vmlinux ELF. In v5.12 a multiple choice menu for the DWARF version
#   was added, and in v5.18 the choice DEBUG_INFO_NONE was added, making
#   DEBUG_INFO no longer selectable by hand, but only automatically enabled when
#   the choice is not DEBUG_INFO_NONE.
# - RELOCATABLE=n is essential to avoid relocations, which could result in the
#   entire syscall table being relocatable, making it significantly more
#   annoying to recover syscall symbols (don't really want to parse and apply
#   relocations to be honest).
# - EXPERT=y is needed for various stuff incl. some arch-specific kconfigs
# - EXPERIMENTAL=y might also be useful for arch-specific stuff, though it's old
#   so I haven't really *experimented* with it yet (lol)
# - FTRACE_SYSCALLS=y adds `__syscall_meta_xxx` structs for each syscall, which
#   are very useful to extract signature info.
# - FTRACE=y is needed for FTRACE_SYSCALLS
#
# TODO: version for RELOCATABLE and RANDOMIZE_BASE depends on arch
# TODO: is optimizing for size and not performance useful?
#       Enable CC_OPTIMIZE_FOR_SIZE (since 2.6.1) and disable
#       CC_OPTIMIZE_FOR_PERFORMANCE (since 4.7) for that.
# TODO: Enable DEBUG_INFO_BTF? It generates BTF typeinfo, which may be useful.
# TODO: Enable NO_AUTO_INLINE?
#
KCONFIG_DEBUGGING = VersionedList((
	# since        removed in   list of name=value
	(VERSION_ZERO, (3,8)      , ['EXPERIMENTAL=y']),
	(VERSION_ZERO, VERSION_INF, ['DEBUG_KERNEL=y', 'DEBUG_INFO=y']),
	(VERSION_ZERO, VERSION_INF, ['RELOCATABLE=n', 'RANDOMIZE_BASE=n']),
	((2, 6, 30)  , VERSION_INF, ['FTRACE_SYSCALLS=y']),
	((2, 6, 31)  , VERSION_INF, ['FTRACE=y']),
	((2, 6, 36)  , VERSION_INF, ['DEBUG_INFO_REDUCED=n']),
	((2, 6, 38)  , VERSION_INF, ['EXPERT=y']),
	((5, 12)     , VERSION_INF, ['DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y']),
	((5, 18)     , VERSION_INF, ['DEBUG_INFO_NONE=n']),
))

# Kconfig options that are not strictly needed for building or improving
# Systrack analysis, but which ease the build process by improving
# compiler/toolchain compatibility, removing unneeded build dependencies and
# disabling unneeded pieces of kernel code.
#
KCONFIG_COMPATIBILITY = VersionedList((
	# since        removed in   list of name=value
	((2,6,32)    , VERSION_INF, ['WLAN=n', 'NETDEVICES=n']),
	((2,6,28)    , VERSION_INF, ['WIRELESS=n']),
	((3,7)       , VERSION_INF, ['MODULE_SIG=n']),
	((3,13)      , VERSION_INF, ['SYSTEM_TRUSTED_KEYRING=n']),
	((4,6)       , VERSION_INF, ['STACK_VALIDATION=n']),
	((4,14)      , (4,15)     , ['GUESS_UNWINDER=y', 'ORC_UNWINDER=n', 'FRAME_POINTER_UNWINDER=n']),
	((4,15)      , VERSION_INF, ['UNWINDER_GUESS=y', 'UNWINDER_ORC=n', 'UNWINDER_FRAME_POINTER=n']),
))

# Kconfig options to enable optional syscalls. We want to build a kernel with as
# many syscalls as possible. These are some arch-agnostic config options to set
# in order to enable more syscalls. Arch-specific configs (or configs that are
# present in different kernel versions depending on the arch) are uner `arch/`.
#
# Notes on some of these:
#
# - CRYPTO_SHA256=y is needed for KEXEC_FILE
# - INOTIFY=y is needed for INOTIFY_USER (only from v2.6.18 to v2.6.28)
# - PROFILING=y is needed for PERF_EVENTS
# - QUOTA=y is needed for QUOTACTL, which should be auto-selected by QUOTA=y
# - SECCOMP was arch-specific before v5.10, then became arch-agnostic
# - SECURITY=y is needed for SECURITY_LANDLOCK
# - UID16 is technically arch-dependent before v2.6.16, but it's practically
#   useless to differentiate between archs for this, the kernel Makefile will
#   just remove it if unneeded
#
KCONFIG_MORE_SYSCALLS = VersionedDict((
	# since        removed in   name=value               dependencies
	((3,18)      , VERSION_INF, 'ADVISE_SYSCALLS=y'    , []),
	((2,6,28)    , VERSION_INF, 'AIO=y'                , []),
	((2,6,19)    , VERSION_INF, 'BLOCK=y'              , ['EXPERT=y']),
	((3,18)      , VERSION_INF, 'BPF_SYSCALL=y'        , []),
	(VERSION_ZERO, (4,1)      , 'BSD_PROCESS_ACCT=y'   , []),
	((4,1)       , VERSION_INF, 'BSD_PROCESS_ACCT=y'   , ['MULTIUSER=y']),
	((3,3)       , VERSION_INF, 'CHECKPOINT_RESTORE=y' , []),
	((3,15)      , VERSION_INF, 'CROSS_MEMORY_ATTACH=y', ['MMU=y']),
	(VERSION_ZERO, VERSION_INF, 'CRYPTO_SHA256=y'      , []),
	((2,6,36)    , VERSION_INF, 'FANOTIFY=y'           , []),
	((2,6,39)    , VERSION_INF, 'FHANDLE=y'            , []),
	# TODO: FUTEX depends on !(SPARC32 && SMP), but we do not support
	# expressions to check kconfig dependencies :(
	(VERSION_ZERO, VERSION_INF, 'FUTEX=y'              , []),
	(VERSION_ZERO, VERSION_INF, 'INET=y'               , []),
	((2,6,13)    , (2,6,29)   , 'INOTIFY=y'            , []),
	((2,6,18)    , VERSION_INF, 'INOTIFY_USER=y'       , []),
	((5,1)       , VERSION_INF, 'IO_URING=y'           , ['EXPERT=y']),
	((5,12)      , VERSION_INF, 'KCMP=y'               , ['EXPERT=y']),
	(VERSION_ZERO, VERSION_INF, 'KEYS=y'               , []),
	((4,3)       , VERSION_INF, 'MEMBARRIER=y'         , []),
	((4,18)      , (6,6)      , 'MEMFD_CREATE=y'       , []),
	((6,6)       , VERSION_INF, 'MEMFD_CREATE=y'       , ['EXPERT=y']),
	# TODO: MIGRATION depends on (NUMA || ARCH_ENABLE_MEMORY_HOTREMOVE || COMPACTION || CMA) && MMU
	# but we do not support expressions to check kconfig dependencies :(
	((2,6,16)    , VERSION_INF, 'MIGRATION=y'          , ['MMU=y']),
	(VERSION_ZERO, VERSION_INF, 'MODULE_UNLOAD=y'      , []),
	(VERSION_ZERO, VERSION_INF, 'MODULES=y'            , []),
	(VERSION_ZERO, VERSION_INF, 'NET=y'                , []),
	(VERSION_ZERO, (2,6,29)   , 'NFSD=y'               , ['INET=y']),
	# Though NSFD still exists, nfsservctl was removed in 3.1, so it's pointless
	# to enable it past that
	((2,6,29)    , (3,1)      , 'NFSD=y'               , ['INET=y', 'FILE_LOCKING=y', 'FSNOTIFY=y']),
	((2,6,32)    , VERSION_INF, 'PROFILING=y'          , []),
	(VERSION_ZERO, VERSION_INF, 'PERF_EVENTS=y'        , ['HAVE_PERF_EVENTS=y']),
	(VERSION_ZERO, VERSION_INF, 'PCI_SYSCALL=y'        , ['PCI=y']),
	(VERSION_ZERO, VERSION_INF, 'POSIX_MQUEUE=y'       , ['NET=y']),
	((4,10)      , VERSION_INF, 'POSIX_TIMERS=y'       , ['EXPERT=y']),
	((2,6,30)    , VERSION_INF, 'QUOTA=y'              , []),
	((4,18)      , VERSION_INF, 'RSEQ=y'               , ['HAVE_RSEQ=y']),
	((5,10)      , VERSION_INF, 'SECCOMP=y'            , ['HAVE_ARCH_SECCOMP=y']),
	((5,14)      , VERSION_INF, 'SECRETMEM=y'          , ['ARCH_HAS_SET_DIRECT_MAP=y']),
	(VERSION_ZERO, (4,1)      , 'SECURITY=y'           , ['SYSFS=y']),
	((4,1)       , VERSION_INF, 'SECURITY=y'           , ['SYSFS=y', 'MULTIUSER=y']),
	((5,13)      , VERSION_INF, 'SECURITY_LANDLOCK=y'  , ['ARCH_EPHEMERAL_INODES=n']),
	((3,16)      , VERSION_INF, 'SGETMASK_SYSCALL=y'   , []),
	((2,6,22)    , VERSION_INF, 'SIGNALFD=y'           , ['EXPERT=y']),
	(VERSION_ZERO, (5,5)      , 'SYSCTL_SYSCALL=y'     , ['PROC_SYSCTL=y']),
	((3,15)      , VERSION_INF, 'SYSFS_SYSCALL=y'      , []),
	(VERSION_ZERO, VERSION_INF, 'SYSVIPC=y'            , []),
	(VERSION_ZERO, (2,6,16)   , 'UID16=y'              , []),
	((2,6,16)    , (4,1)      , 'UID16=y'              , ['EXPERT=y', 'HAVE_UID16=y']),
	((4,1)       , VERSION_INF, 'UID16=y'              , ['EXPERT=y', 'HAVE_UID16=y', 'MULTIUSER=y']),
	((4,3)       , VERSION_INF, 'USERFAULTFD=y'        , ['MMU=y']),
	((3,15)      , VERSION_INF, 'USELIB=y'             , []),
))

# Keep track of which syscall depends on which config option. Since syscalls are
# uniquely named there is no issue in keeping track of arch-specific syscalls
# here too. HOWEVER, for syscalls that are present on multiple archs but behind
# different configs, rely on the .kconfig_syscall_deps attr of Arch subclasses
# instead.
#
# This info is only to give a richer output (namely list the kconfig options
# needed to enable a certain syscall), it is not functional to the tool.
#
# 1. Most optional syscalls exist IF AND ONLY IF the corresponding config
#    exists, so just set "since" VERSION_ZERO and "removed in" VERSION_INF for
#    those.
# 2. If a certain syscall existed prior to it being put behind a config,
#    set "since" to the first appearence of the config.
# 3. If a certain syscall was behind a config, but then the config was removed
#    (while keeping the syscall), set "removed in" to the version the config was
#    removed in.
# 4. If both point 2 and 3 above apply, then add 2+ entries for such a syscall.
#
KCONFIG_SYSCALL_DEPS = VersionedDict((
	# since        removed in   syscall name               depends on
	(VERSION_ZERO, VERSION_INF, 'fadvise64'              , 'ADVISE_SYSCALLS'                 ),
	(VERSION_ZERO, VERSION_INF, 'fadvise64_64'           , 'ADVISE_SYSCALLS'                 ), # 32-bit only
	(VERSION_ZERO, VERSION_INF, 'madvise'                , 'ADVISE_SYSCALLS'                 ),
	(VERSION_ZERO, VERSION_INF, 'process_madvise'        , 'ADVISE_SYSCALLS'                 ),
	(VERSION_ZERO, VERSION_INF, 'io_setup'               , 'AIO'                             ),
	(VERSION_ZERO, VERSION_INF, 'io_destroy'             , 'AIO'                             ),
	(VERSION_ZERO, VERSION_INF, 'io_getevents'           , 'AIO'                             ),
	(VERSION_ZERO, VERSION_INF, 'io_submit'              , 'AIO'                             ),
	(VERSION_ZERO, VERSION_INF, 'io_cancel'              , 'AIO'                             ),
	(VERSION_ZERO, VERSION_INF, 'io_pgetevents'          , 'AIO'                             ),
	(VERSION_ZERO, VERSION_INF, 'ioprio_get'             , 'BLOCK'                           ),
	(VERSION_ZERO, VERSION_INF, 'ioprio_set'             , 'BLOCK'                           ),
	(VERSION_ZERO, VERSION_INF, 'bpf'                    , 'BPF_SYSCALL'                     ),
	(VERSION_ZERO, VERSION_INF, 'acct'                   , 'BSD_PROCESS_ACCT'                ),
	((6,5)       , VERSION_INF, 'cachestat'              , 'CACHESTAT_SYSCALL'               ),
	(VERSION_ZERO, (5,12)     , 'kcmp'                   , 'CHECKPOINT_RESTORE'              ),
	(VERSION_ZERO, VERSION_INF, 'process_vm_readv'       , 'CROSS_MEMORY_ATTACH'             ),
	(VERSION_ZERO, VERSION_INF, 'process_vm_writev'      , 'CROSS_MEMORY_ATTACH'             ),
	(VERSION_ZERO, VERSION_INF, 'epoll_create'           , 'EPOLL'                           ),
	(VERSION_ZERO, VERSION_INF, 'epoll_create1'          , 'EPOLL'                           ),
	(VERSION_ZERO, VERSION_INF, 'epoll_ctl'              , 'EPOLL'                           ),
	(VERSION_ZERO, VERSION_INF, 'epoll_pwait'            , 'EPOLL'                           ),
	(VERSION_ZERO, VERSION_INF, 'epoll_pwait2'           , 'EPOLL'                           ),
	(VERSION_ZERO, VERSION_INF, 'epoll_wait'             , 'EPOLL'                           ),
	(VERSION_ZERO, VERSION_INF, 'name_to_handle_at'      , 'FHANDLE'                         ),
	(VERSION_ZERO, VERSION_INF, 'open_by_handle_at'      , 'FHANDLE'                         ),
	(VERSION_ZERO, VERSION_INF, 'fanotify_init'          , 'FANOTIFY'                        ),
	(VERSION_ZERO, VERSION_INF, 'fanotify_mark'          , 'FANOTIFY'                        ),
	(VERSION_ZERO, VERSION_INF, 'fork'                   , 'MMU'                             ),
	(VERSION_ZERO, VERSION_INF, 'futex'                  , 'FUTEX'                           ),
	(VERSION_ZERO, VERSION_INF, 'futex_wait'             , 'FUTEX'                           ),
	(VERSION_ZERO, VERSION_INF, 'futex_waitv'            , 'FUTEX'                           ),
	(VERSION_ZERO, VERSION_INF, 'futex_wake'             , 'FUTEX'                           ),
	(VERSION_ZERO, VERSION_INF, 'futex_requeue'          , 'FUTEX'                           ),
	(VERSION_ZERO, VERSION_INF, 'get_robust_list'        , 'FUTEX'                           ),
	(VERSION_ZERO, VERSION_INF, 'set_robust_list'        , 'FUTEX'                           ),
	(VERSION_ZERO, VERSION_INF, 'inotify_add_watch'      , 'INOTIFY_USER'                    ),
	(VERSION_ZERO, VERSION_INF, 'inotify_init'           , 'INOTIFY_USER'                    ),
	(VERSION_ZERO, VERSION_INF, 'inotify_init1'          , 'INOTIFY_USER'                    ),
	(VERSION_ZERO, VERSION_INF, 'inotify_rm_watch'       , 'INOTIFY_USER'                    ),
	(VERSION_ZERO, VERSION_INF, 'io_uring_enter'         , 'IO_URING'                        ),
	(VERSION_ZERO, VERSION_INF, 'io_uring_setup'         , 'IO_URING'                        ),
	(VERSION_ZERO, VERSION_INF, 'io_uring_register'      , 'IO_URING'                        ),
	((5,12)      , VERSION_INF, 'kcmp'                   , 'KCMP'                            ),
	(VERSION_ZERO, VERSION_INF, 'kexec_load'             , 'KEXEC'                           ),
	(VERSION_ZERO, VERSION_INF, 'kexec_file_load'        , 'KEXEC_FILE'                      ),
	(VERSION_ZERO, VERSION_INF, 'add_key'                , 'KEYS'                            ),
	(VERSION_ZERO, VERSION_INF, 'keyctl'                 , 'KEYS'                            ),
	(VERSION_ZERO, VERSION_INF, 'request_key'            , 'KEYS'                            ),
	(VERSION_ZERO, VERSION_INF, 'membarrier'             , 'MEMBARRIER'                      ),
	((4,18)      , VERSION_INF, 'memfd_create'           , 'MEMFD_CREATE'                    ),
	(VERSION_ZERO, VERSION_INF, 'mincore'                , 'MMU'                             ),
	(VERSION_ZERO, VERSION_INF, 'mlock'                  , 'MMU'                             ),
	(VERSION_ZERO, VERSION_INF, 'mlock2'                 , 'MMU'                             ),
	(VERSION_ZERO, VERSION_INF, 'mlockall'               , 'MMU'                             ),
	(VERSION_ZERO, VERSION_INF, 'mprotect'               , 'MMU'                             ),
	(VERSION_ZERO, VERSION_INF, 'msync'                  , 'MMU'                             ),
	(VERSION_ZERO, VERSION_INF, 'munlock'                , 'MMU'                             ),
	(VERSION_ZERO, VERSION_INF, 'munlockall'             , 'MMU'                             ),
	(VERSION_ZERO, VERSION_INF, 'remap_file_pages'       , 'MMU'                             ),
	(VERSION_ZERO, VERSION_INF, 'process_mrelease'       , 'MMU'                             ),
	((4,3)       , VERSION_INF, 'modify_ldt'             , 'MODIFY_LDT_SYSCALL'              ), # x86 only
	(VERSION_ZERO, VERSION_INF, 'delete_module'          , 'MODULE_UNLOAD'                   ),
	(VERSION_ZERO, VERSION_INF, 'init_module'            , 'MODULES'                         ),
	(VERSION_ZERO, VERSION_INF, 'finit_module'           , 'MODULES'                         ),
	((4,1)       , VERSION_INF, 'capget'                 , 'MULTIUSER'                       ),
	((4,1)       , VERSION_INF, 'capset'                 , 'MULTIUSER'                       ),
	((4,1)       , VERSION_INF, 'setuid'                 , 'MULTIUSER'                       ),
	((4,1)       , VERSION_INF, 'setgid'                 , 'MULTIUSER'                       ),
	((4,1)       , VERSION_INF, 'setreuid'               , 'MULTIUSER'                       ),
	((4,1)       , VERSION_INF, 'setregid'               , 'MULTIUSER'                       ),
	((4,1)       , VERSION_INF, 'getresuid'              , 'MULTIUSER'                       ),
	((4,1)       , VERSION_INF, 'setresuid'              , 'MULTIUSER'                       ),
	((4,1)       , VERSION_INF, 'getresgid'              , 'MULTIUSER'                       ),
	((4,1)       , VERSION_INF, 'setresgid'              , 'MULTIUSER'                       ),
	((4,1)       , VERSION_INF, 'setfsuid'               , 'MULTIUSER'                       ),
	((4,1)       , VERSION_INF, 'setfsgid'               , 'MULTIUSER'                       ),
	((4,1)       , VERSION_INF, 'getgroups'              , 'MULTIUSER'                       ),
	((4,1)       , VERSION_INF, 'setgroups'              , 'MULTIUSER'                       ),
	(VERSION_ZERO, VERSION_INF, 'accept'                 , 'NET'                             ),
	(VERSION_ZERO, VERSION_INF, 'accept4'                , 'NET'                             ),
	(VERSION_ZERO, VERSION_INF, 'bind'                   , 'NET'                             ),
	(VERSION_ZERO, VERSION_INF, 'connect'                , 'NET'                             ),
	(VERSION_ZERO, VERSION_INF, 'listen'                 , 'NET'                             ),
	(VERSION_ZERO, VERSION_INF, 'getpeername'            , 'NET'                             ),
	(VERSION_ZERO, VERSION_INF, 'getsockname'            , 'NET'                             ),
	(VERSION_ZERO, VERSION_INF, 'getsockopt'             , 'NET'                             ),
	(VERSION_ZERO, VERSION_INF, 'recv'                   , 'NET'                             ),
	(VERSION_ZERO, VERSION_INF, 'recvfrom'               , 'NET'                             ),
	(VERSION_ZERO, VERSION_INF, 'recvmsg'                , 'NET'                             ),
	(VERSION_ZERO, VERSION_INF, 'recvmmsg'               , 'NET'                             ),
	(VERSION_ZERO, VERSION_INF, 'send'                   , 'NET'                             ),
	(VERSION_ZERO, VERSION_INF, 'sendmmsg'               , 'NET'                             ),
	(VERSION_ZERO, VERSION_INF, 'sendmsg'                , 'NET'                             ),
	(VERSION_ZERO, VERSION_INF, 'sendto'                 , 'NET'                             ),
	(VERSION_ZERO, VERSION_INF, 'setsockopt'             , 'NET'                             ),
	(VERSION_ZERO, VERSION_INF, 'shutdown'               , 'NET'                             ),
	(VERSION_ZERO, VERSION_INF, 'socket'                 , 'NET'                             ),
	(VERSION_ZERO, VERSION_INF, 'socketcall'             , 'NET'                             ),
	(VERSION_ZERO, VERSION_INF, 'socketpair'             , 'NET'                             ),
	(VERSION_ZERO, (3, 1)     , 'nfsservctl'             , 'NFSD'                            ), # dead
	(VERSION_ZERO, VERSION_INF, 'mbind'                  , 'NUMA'                            ),
	(VERSION_ZERO, VERSION_INF, 'migrate_pages'          , 'MIGRATION'                       ),
	(VERSION_ZERO, VERSION_INF, 'move_pages'             , 'MIGRATION'                       ),
	(VERSION_ZERO, VERSION_INF, 'get_mempolicy'          , 'NUMA'                            ),
	(VERSION_ZERO, VERSION_INF, 'set_mempolicy'          , 'NUMA'                            ),
	(VERSION_ZERO, VERSION_INF, 'set_mempolicy_home_node', 'NUMA'                            ),
	(VERSION_ZERO, VERSION_INF, 'pciconfig_read'         , 'PCI_SYSCALL'                     ),
	(VERSION_ZERO, VERSION_INF, 'pciconfig_write'        , 'PCI_SYSCALL'                     ),
	(VERSION_ZERO, VERSION_INF, 'perf_event_open'        , 'PERF_EVENTS'                     ),
	(VERSION_ZERO, VERSION_INF, 'mq_notify'              , 'POSIX_MQUEUE'                    ),
	(VERSION_ZERO, VERSION_INF, 'mq_open'                , 'POSIX_MQUEUE'                    ),
	(VERSION_ZERO, VERSION_INF, 'mq_timedreceive'        , 'POSIX_MQUEUE'                    ),
	(VERSION_ZERO, VERSION_INF, 'mq_timedsend'           , 'POSIX_MQUEUE'                    ),
	(VERSION_ZERO, VERSION_INF, 'mq_unlink'              , 'POSIX_MQUEUE'                    ),
	(VERSION_ZERO, VERSION_INF, 'mq_getsetattr'          , 'POSIX_MQUEUE'                    ),
	(VERSION_ZERO, VERSION_INF, 'timer_create'           , 'POSIX_TIMERS'                    ),
	(VERSION_ZERO, VERSION_INF, 'timer_delete'           , 'POSIX_TIMERS'                    ),
	(VERSION_ZERO, VERSION_INF, 'timer_getoverrun'       , 'POSIX_TIMERS'                    ),
	(VERSION_ZERO, VERSION_INF, 'timer_gettime'          , 'POSIX_TIMERS'                    ),
	(VERSION_ZERO, VERSION_INF, 'timer_settime'          , 'POSIX_TIMERS'                    ),
	(VERSION_ZERO, VERSION_INF, 'rtas'                   , 'PPC_RTAS'                        ), # powerpc only
	(VERSION_ZERO, VERSION_INF, 'subpage_prot'           , 'PPC_SUBPAGE_PROT'                ), # powerpc 64-bit only
	(VERSION_ZERO, VERSION_INF, 'quotactl'               , 'QUOTACTL'                        ),
	(VERSION_ZERO, VERSION_INF, 'quotactl_fd'            , 'QUOTACTL'                        ),
	(VERSION_ZERO, VERSION_INF, 'rseq'                   , 'RSEQ'                            ),
	(VERSION_ZERO, VERSION_INF, 'lsm_get_self_attr'      , 'SECURITY'                        ),
	(VERSION_ZERO, VERSION_INF, 'lsm_list_modules'       , 'SECURITY'                        ),
	(VERSION_ZERO, VERSION_INF, 'lsm_set_self_attr'      , 'SECURITY'                        ),
	(VERSION_ZERO, VERSION_INF, 'landlock_create_ruleset', 'SECURITY_LANDLOCK'               ),
	(VERSION_ZERO, VERSION_INF, 'landlock_add_rule'      , 'SECURITY_LANDLOCK'               ),
	(VERSION_ZERO, VERSION_INF, 'landlock_restrict_self' , 'SECURITY_LANDLOCK'               ),
	(VERSION_ZERO, VERSION_INF, 'seccomp'                , 'SECCOMP'                         ),
	(VERSION_ZERO, VERSION_INF, 'memfd_secret'           , 'SECRETMEM'                       ),
	(VERSION_ZERO, VERSION_INF, 'sgetmask'               , 'SGETMASK_SYSCALL'                ), # obsolete
	(VERSION_ZERO, VERSION_INF, 'ssetmask'               , 'SGETMASK_SYSCALL'                ), # obsolete
	(VERSION_ZERO, VERSION_INF, 'signalfd'               , 'SIGNALFD'                        ),
	(VERSION_ZERO, VERSION_INF, 'signalfd4'              , 'SIGNALFD'                        ),
	(VERSION_ZERO, VERSION_INF, 'spu_create'             , 'SPU_FS'                          ), # powerpc only
	(VERSION_ZERO, VERSION_INF, 'spu_run'                , 'SPU_FS'                          ), # powerpc only
	(VERSION_ZERO, VERSION_INF, 'swapon'                 , 'SWAP'                            ),
	(VERSION_ZERO, VERSION_INF, 'swapoff'                , 'SWAP'                            ),
	(VERSION_ZERO, (5, 5)     , 'sysctl'                 , 'SYSCTL_SYSCALL'                  ), # dead since v5.9
	(VERSION_ZERO, VERSION_INF, 'sysfs'                  , 'SYSFS_SYSCALL'                   ), # obsolete
	(VERSION_ZERO, VERSION_INF, 'ipc'                    , 'SYSVIPC'                         ),
	(VERSION_ZERO, VERSION_INF, 'msgctl'                 , 'SYSVIPC'                         ),
	(VERSION_ZERO, VERSION_INF, 'msgget'                 , 'SYSVIPC'                         ),
	(VERSION_ZERO, VERSION_INF, 'msgrcv'                 , 'SYSVIPC'                         ),
	(VERSION_ZERO, VERSION_INF, 'msgsnd'                 , 'SYSVIPC'                         ),
	(VERSION_ZERO, VERSION_INF, 'semctl'                 , 'SYSVIPC'                         ),
	(VERSION_ZERO, VERSION_INF, 'semget'                 , 'SYSVIPC'                         ),
	(VERSION_ZERO, VERSION_INF, 'semop'                  , 'SYSVIPC'                         ),
	(VERSION_ZERO, VERSION_INF, 'semtimedop'             , 'SYSVIPC'                         ),
	(VERSION_ZERO, VERSION_INF, 'shmat'                  , 'SYSVIPC'                         ),
	(VERSION_ZERO, VERSION_INF, 'shmctl'                 , 'SYSVIPC'                         ),
	(VERSION_ZERO, VERSION_INF, 'shmdt'                  , 'SYSVIPC'                         ),
	(VERSION_ZERO, VERSION_INF, 'shmget'                 , 'SYSVIPC'                         ),
	((3,17)      , (4,18)     , 'memfd_create'           , 'TMPFS'                           ),
	(VERSION_ZERO, VERSION_INF, 'chown16'                , 'UID16'                           ), # legacy
	(VERSION_ZERO, VERSION_INF, 'fchown16'               , 'UID16'                           ), # legacy
	(VERSION_ZERO, VERSION_INF, 'lchown16'               , 'UID16'                           ), # legacy
	(VERSION_ZERO, VERSION_INF, 'getuid16'               , 'UID16'                           ), # legacy
	(VERSION_ZERO, VERSION_INF, 'getgid16'               , 'UID16'                           ), # legacy
	(VERSION_ZERO, VERSION_INF, 'geteuid16'              , 'UID16'                           ), # legacy
	(VERSION_ZERO, VERSION_INF, 'getegid16'              , 'UID16'                           ), # legacy
	(VERSION_ZERO, VERSION_INF, 'getresuid16'            , 'UID16'                           ), # legacy
	(VERSION_ZERO, VERSION_INF, 'getresgid16'            , 'UID16'                           ), # legacy
	(VERSION_ZERO, VERSION_INF, 'getgroups16'            , 'UID16'                           ), # legacy
	(VERSION_ZERO, VERSION_INF, 'setuid16'               , 'UID16'                           ), # legacy
	(VERSION_ZERO, VERSION_INF, 'setgid16'               , 'UID16'                           ), # legacy
	(VERSION_ZERO, VERSION_INF, 'setreuid16'             , 'UID16'                           ), # legacy
	(VERSION_ZERO, VERSION_INF, 'setregid16'             , 'UID16'                           ), # legacy
	(VERSION_ZERO, VERSION_INF, 'setfsuid16'             , 'UID16'                           ), # legacy
	(VERSION_ZERO, VERSION_INF, 'setfsgid16'             , 'UID16'                           ), # legacy
	(VERSION_ZERO, VERSION_INF, 'setresuid16'            , 'UID16'                           ), # legacy
	(VERSION_ZERO, VERSION_INF, 'setresgid16'            , 'UID16'                           ), # legacy
	(VERSION_ZERO, VERSION_INF, 'setgroups16'            , 'UID16'                           ), # legacy
	(VERSION_ZERO, VERSION_INF, 'userfaultfd'            , 'USERFAULTFD'                     ),
	(VERSION_ZERO, VERSION_INF, 'uselib'                 , 'USELIB'                          ), # obsolete (32bit only?)
	(VERSION_ZERO, (4,3)      , 'vm86old'                , 'VM86'                            ), # x86 32-bit only
	(VERSION_ZERO, (4,3)      , 'vm86'                   , 'VM86'                            ), # x86 32-bit only
	((4,3)       , VERSION_INF, 'vm86old'                , 'X86_LEGACY_VM86'                 ), # x86 32-bit only, legacy
	((4,3)       , VERSION_INF, 'vm86'                   , 'X86_LEGACY_VM86'                 ), # x86 32-bit only, legacy
	((5,5)       , VERSION_INF, 'ioperm'                 , 'X86_IOPL_IOPERM'                 ), # x86 only
	((5,5)       , VERSION_INF, 'iopl'                   , 'X86_IOPL_IOPERM'                 ), # x86 only
	((6,6)       , VERSION_INF, 'map_shadow_stack'       , 'X86_USER_SHADOW_STACK'           ), # x86 64-bit only
))
