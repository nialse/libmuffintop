; POSIX API surface for libmuffintop.
; Pure LLVM IR runtime layer that resolves host libc/libSystem entry points
; through the selected host bridge in src/host/.

target triple = "x86_64-unknown-linux-gnu"

%struct.timespec = type { i64, i64 }

@mtrt_errno = global i32 0, align 4
@.sym__exit = private unnamed_addr constant [6 x i8] c"_exit\00"
@.sym_access = private unnamed_addr constant [7 x i8] c"access\00"
@.sym_alarm = private unnamed_addr constant [6 x i8] c"alarm\00"
@.sym_brk = private unnamed_addr constant [4 x i8] c"brk\00"
@.sym_chdir = private unnamed_addr constant [6 x i8] c"chdir\00"
@.sym_chmod = private unnamed_addr constant [6 x i8] c"chmod\00"
@.sym_chown = private unnamed_addr constant [6 x i8] c"chown\00"
@.sym_clock_getres = private unnamed_addr constant [13 x i8] c"clock_getres\00"
@.sym_clock_gettime = private unnamed_addr constant [14 x i8] c"clock_gettime\00"
@.sym_clock_settime = private unnamed_addr constant [14 x i8] c"clock_settime\00"
@.sym_close = private unnamed_addr constant [6 x i8] c"close\00"
@.sym_closedir = private unnamed_addr constant [9 x i8] c"closedir\00"
@.sym_dup = private unnamed_addr constant [4 x i8] c"dup\00"
@.sym_dup2 = private unnamed_addr constant [5 x i8] c"dup2\00"
@.sym_execl = private unnamed_addr constant [6 x i8] c"execl\00"
@.sym_execlp = private unnamed_addr constant [7 x i8] c"execlp\00"
@.sym_execv = private unnamed_addr constant [6 x i8] c"execv\00"
@.sym_execve = private unnamed_addr constant [7 x i8] c"execve\00"
@.sym_execvp = private unnamed_addr constant [7 x i8] c"execvp\00"
@.sym_faccessat = private unnamed_addr constant [10 x i8] c"faccessat\00"
@.sym_fchdir = private unnamed_addr constant [7 x i8] c"fchdir\00"
@.sym_fchmod = private unnamed_addr constant [7 x i8] c"fchmod\00"
@.sym_fchmodat = private unnamed_addr constant [9 x i8] c"fchmodat\00"
@.sym_fchown = private unnamed_addr constant [7 x i8] c"fchown\00"
@.sym_fchownat = private unnamed_addr constant [9 x i8] c"fchownat\00"
@.sym_fcntl = private unnamed_addr constant [6 x i8] c"fcntl\00"
@.sym_fdatasync = private unnamed_addr constant [10 x i8] c"fdatasync\00"
@.sym_fdopendir = private unnamed_addr constant [10 x i8] c"fdopendir\00"
@.sym_fork = private unnamed_addr constant [5 x i8] c"fork\00"
@.sym_fstat = private unnamed_addr constant [6 x i8] c"fstat\00"
@.sym_fstatat = private unnamed_addr constant [8 x i8] c"fstatat\00"
@.sym_fsync = private unnamed_addr constant [6 x i8] c"fsync\00"
@.sym_getcwd = private unnamed_addr constant [7 x i8] c"getcwd\00"
@.sym_getpgid = private unnamed_addr constant [8 x i8] c"getpgid\00"
@.sym_getpgrp = private unnamed_addr constant [8 x i8] c"getpgrp\00"
@.sym_getpid = private unnamed_addr constant [7 x i8] c"getpid\00"
@.sym_getppid = private unnamed_addr constant [8 x i8] c"getppid\00"
@.sym_getsid = private unnamed_addr constant [7 x i8] c"getsid\00"
@.sym_gettimeofday = private unnamed_addr constant [13 x i8] c"gettimeofday\00"
@.sym_gmtime_r = private unnamed_addr constant [9 x i8] c"gmtime_r\00"
@.sym_kill = private unnamed_addr constant [5 x i8] c"kill\00"
@.sym_lchown = private unnamed_addr constant [7 x i8] c"lchown\00"
@.sym_link = private unnamed_addr constant [5 x i8] c"link\00"
@.sym_linkat = private unnamed_addr constant [7 x i8] c"linkat\00"
@.sym_localtime_r = private unnamed_addr constant [12 x i8] c"localtime_r\00"
@.sym_lseek = private unnamed_addr constant [6 x i8] c"lseek\00"
@.sym_lstat = private unnamed_addr constant [6 x i8] c"lstat\00"
@.sym_madvise = private unnamed_addr constant [8 x i8] c"madvise\00"
@.sym_mkdir = private unnamed_addr constant [6 x i8] c"mkdir\00"
@.sym_mkdirat = private unnamed_addr constant [8 x i8] c"mkdirat\00"
@.sym_mkstemp = private unnamed_addr constant [8 x i8] c"mkstemp\00"
@.sym_mktime = private unnamed_addr constant [7 x i8] c"mktime\00"
@.sym_mlock = private unnamed_addr constant [6 x i8] c"mlock\00"
@.sym_mlockall = private unnamed_addr constant [9 x i8] c"mlockall\00"
@.sym_mmap = private unnamed_addr constant [5 x i8] c"mmap\00"
@.sym_mprotect = private unnamed_addr constant [9 x i8] c"mprotect\00"
@.sym_msync = private unnamed_addr constant [6 x i8] c"msync\00"
@.sym_munlock = private unnamed_addr constant [8 x i8] c"munlock\00"
@.sym_munlockall = private unnamed_addr constant [11 x i8] c"munlockall\00"
@.sym_munmap = private unnamed_addr constant [7 x i8] c"munmap\00"
@.sym_nanosleep = private unnamed_addr constant [10 x i8] c"nanosleep\00"
@.sym_open = private unnamed_addr constant [5 x i8] c"open\00"
@.sym_openat = private unnamed_addr constant [7 x i8] c"openat\00"
@.sym_opendir = private unnamed_addr constant [8 x i8] c"opendir\00"
@.sym_pause = private unnamed_addr constant [6 x i8] c"pause\00"
@.sym_pipe = private unnamed_addr constant [5 x i8] c"pipe\00"
@.sym_pipe2 = private unnamed_addr constant [6 x i8] c"pipe2\00"
@.sym_posix_memalign = private unnamed_addr constant [15 x i8] c"posix_memalign\00"
@.sym_pread = private unnamed_addr constant [6 x i8] c"pread\00"
@.sym_pthread_atfork = private unnamed_addr constant [15 x i8] c"pthread_atfork\00"
@.sym_pthread_create = private unnamed_addr constant [15 x i8] c"pthread_create\00"
@.sym_pthread_detach = private unnamed_addr constant [15 x i8] c"pthread_detach\00"
@.sym_pthread_exit = private unnamed_addr constant [13 x i8] c"pthread_exit\00"
@.sym_pthread_getspecific = private unnamed_addr constant [20 x i8] c"pthread_getspecific\00"
@.sym_pthread_join = private unnamed_addr constant [13 x i8] c"pthread_join\00"
@.sym_pthread_key_create = private unnamed_addr constant [19 x i8] c"pthread_key_create\00"
@.sym_pthread_key_delete = private unnamed_addr constant [19 x i8] c"pthread_key_delete\00"
@.sym_pthread_kill = private unnamed_addr constant [13 x i8] c"pthread_kill\00"
@.sym_pthread_once = private unnamed_addr constant [13 x i8] c"pthread_once\00"
@.sym_pthread_self = private unnamed_addr constant [13 x i8] c"pthread_self\00"
@.sym_pthread_setspecific = private unnamed_addr constant [20 x i8] c"pthread_setspecific\00"
@.sym_pthread_sigmask = private unnamed_addr constant [16 x i8] c"pthread_sigmask\00"
@.sym_pwrite = private unnamed_addr constant [7 x i8] c"pwrite\00"
@.sym_raise = private unnamed_addr constant [6 x i8] c"raise\00"
@.sym_read = private unnamed_addr constant [5 x i8] c"read\00"
@.sym_readdir = private unnamed_addr constant [8 x i8] c"readdir\00"
@.sym_readlink = private unnamed_addr constant [9 x i8] c"readlink\00"
@.sym_readlinkat = private unnamed_addr constant [11 x i8] c"readlinkat\00"
@.sym_readv = private unnamed_addr constant [6 x i8] c"readv\00"
@.sym_rename = private unnamed_addr constant [7 x i8] c"rename\00"
@.sym_renameat = private unnamed_addr constant [9 x i8] c"renameat\00"
@.sym_rewinddir = private unnamed_addr constant [10 x i8] c"rewinddir\00"
@.sym_rmdir = private unnamed_addr constant [6 x i8] c"rmdir\00"
@.sym_sbrk = private unnamed_addr constant [5 x i8] c"sbrk\00"
@.sym_sched_yield = private unnamed_addr constant [12 x i8] c"sched_yield\00"
@.sym_setpgid = private unnamed_addr constant [8 x i8] c"setpgid\00"
@.sym_setsid = private unnamed_addr constant [7 x i8] c"setsid\00"
@.sym_sigaction = private unnamed_addr constant [10 x i8] c"sigaction\00"
@.sym_sigaltstack = private unnamed_addr constant [12 x i8] c"sigaltstack\00"
@.sym_signal = private unnamed_addr constant [7 x i8] c"signal\00"
@.sym_sigpending = private unnamed_addr constant [11 x i8] c"sigpending\00"
@.sym_sigprocmask = private unnamed_addr constant [12 x i8] c"sigprocmask\00"
@.sym_sigsuspend = private unnamed_addr constant [11 x i8] c"sigsuspend\00"
@.sym_sigtimedwait = private unnamed_addr constant [13 x i8] c"sigtimedwait\00"
@.sym_sigwait = private unnamed_addr constant [8 x i8] c"sigwait\00"
@.sym_sigwaitinfo = private unnamed_addr constant [12 x i8] c"sigwaitinfo\00"
@.sym_stat = private unnamed_addr constant [5 x i8] c"stat\00"
@.sym_strftime = private unnamed_addr constant [9 x i8] c"strftime\00"
@.sym_symlink = private unnamed_addr constant [8 x i8] c"symlink\00"
@.sym_symlinkat = private unnamed_addr constant [10 x i8] c"symlinkat\00"
@.sym_times = private unnamed_addr constant [6 x i8] c"times\00"
@.sym_umask = private unnamed_addr constant [6 x i8] c"umask\00"
@.sym_unlink = private unnamed_addr constant [7 x i8] c"unlink\00"
@.sym_unlinkat = private unnamed_addr constant [9 x i8] c"unlinkat\00"
@.sym_vfork = private unnamed_addr constant [6 x i8] c"vfork\00"
@.sym_wait = private unnamed_addr constant [5 x i8] c"wait\00"
@.sym_waitpid = private unnamed_addr constant [8 x i8] c"waitpid\00"
@.sym_write = private unnamed_addr constant [6 x i8] c"write\00"
@.sym_writev = private unnamed_addr constant [7 x i8] c"writev\00"

declare ptr @__mtrt_host_resolve(ptr)
declare ptr @__mtrt_host_errno_ptr()
declare i32 @__mtrt_host_platform()

define ptr @__errno_location() {
entry:
  ret ptr @mtrt_errno
}

define internal void @__mtrt_set_errno(i32 %err) {
entry:
  store i32 %err, ptr @mtrt_errno, align 4
  ret void
}

define internal void @__mtrt_copy_errno_from_host() {
entry:
  %ep = call ptr @__mtrt_host_errno_ptr()
  %ev = load i32, ptr %ep, align 4
  store i32 %ev, ptr @mtrt_errno, align 4
  ret void
}

define internal i32 @__mtrt_fail_i32(i32 %err) {
entry:
  call void @__mtrt_set_errno(i32 %err)
  ret i32 -1
}

define internal i64 @__mtrt_fail_i64(i32 %err) {
entry:
  call void @__mtrt_set_errno(i32 %err)
  ret i64 -1
}

define internal ptr @__mtrt_fail_null_ptr(i32 %err) {
entry:
  call void @__mtrt_set_errno(i32 %err)
  ret ptr null
}

define internal ptr @__mtrt_fail_map_ptr(i32 %err) {
entry:
  call void @__mtrt_set_errno(i32 %err)
  ret ptr inttoptr (i64 -1 to ptr)
}

define internal i32 @__mtrt_posix_i32(i32 %ret) {
entry:
  %is_fail = icmp eq i32 %ret, -1
  br i1 %is_fail, label %fail, label %ok

fail:
  call void @__mtrt_copy_errno_from_host()
  ret i32 -1

ok:
  ret i32 %ret
}

define internal i64 @__mtrt_posix_i64(i64 %ret) {
entry:
  %is_fail = icmp eq i64 %ret, -1
  br i1 %is_fail, label %fail, label %ok

fail:
  call void @__mtrt_copy_errno_from_host()
  ret i64 -1

ok:
  ret i64 %ret
}

define internal ptr @__mtrt_posix_null_ptr(ptr %ret) {
entry:
  %is_fail = icmp eq ptr %ret, null
  br i1 %is_fail, label %fail, label %ok

fail:
  call void @__mtrt_copy_errno_from_host()
  ret ptr null

ok:
  ret ptr %ret
}

define internal ptr @__mtrt_posix_map_ptr(ptr %ret) {
entry:
  %ret_i = ptrtoint ptr %ret to i64
  %is_fail = icmp eq i64 %ret_i, -1
  br i1 %is_fail, label %fail, label %ok

fail:
  call void @__mtrt_copy_errno_from_host()
  ret ptr inttoptr (i64 -1 to ptr)

ok:
  ret ptr %ret
}

define internal ptr @__mtrt_signal_ptr(ptr %ret) {
entry:
  %ret_i = ptrtoint ptr %ret to i64
  %is_fail = icmp eq i64 %ret_i, -1
  br i1 %is_fail, label %fail, label %ok

fail:
  call void @__mtrt_copy_errno_from_host()
  ret ptr inttoptr (i64 -1 to ptr)

ok:
  ret ptr %ret
}

define internal i32 @__mtrt_direct_i32(i32 %ret) {
entry:
  %is_err = icmp ne i32 %ret, 0
  br i1 %is_err, label %err, label %ok

err:
  call void @__mtrt_set_errno(i32 %ret)
  ret i32 %ret

ok:
  call void @__mtrt_set_errno(i32 0)
  ret i32 0
}

define internal i32 @__mtrt_translate_mmap_flags(i32 %flags) {
entry:
  %platform = call i32 @__mtrt_host_platform()
  %is_macos = icmp eq i32 %platform, 2
  br i1 %is_macos, label %macos, label %linux

macos:
  %anon = and i32 %flags, 32
  %has_anon = icmp ne i32 %anon, 0
  br i1 %has_anon, label %macos_fix, label %done

macos_fix:
  %cleared = and i32 %flags, -33
  %mapped = or i32 %cleared, 4096
  ret i32 %mapped

linux:
  ret i32 %flags

done:
  ret i32 %flags
}

define i32 @access(ptr %path, i32 %mode) {
entry:
  %sym = call ptr @__mtrt_host_resolve(ptr @.sym_access)
  %missing = icmp eq ptr %sym, null
  br i1 %missing, label %enosys, label %call

enosys:
  %eno = call i32 @__mtrt_fail_i32(i32 38)
  ret i32 %eno

call:
  %ret = call i32 %sym(ptr %path, i32 %mode)
  %mapped = call i32 @__mtrt_posix_i32(i32 %ret)
  ret i32 %mapped
}

define i32 @alarm(i32 %seconds) {
entry:
  %sym = call ptr @__mtrt_host_resolve(ptr @.sym_alarm)
  %missing = icmp eq ptr %sym, null
  br i1 %missing, label %enosys, label %call

enosys:
  %eno = call i32 @__mtrt_fail_i32(i32 38)
  ret i32 %eno

call:
  %ret = call i32 %sym(i32 %seconds)
  %mapped = call i32 @__mtrt_posix_i32(i32 %ret)
  ret i32 %mapped
}

define i32 @chdir(ptr %path) {
entry:
  %sym = call ptr @__mtrt_host_resolve(ptr @.sym_chdir)
  %missing = icmp eq ptr %sym, null
  br i1 %missing, label %enosys, label %call

enosys:
  %eno = call i32 @__mtrt_fail_i32(i32 38)
  ret i32 %eno

call:
  %ret = call i32 %sym(ptr %path)
  %mapped = call i32 @__mtrt_posix_i32(i32 %ret)
  ret i32 %mapped
}

define i32 @chmod(ptr %path, i32 %mode) {
entry:
  %sym = call ptr @__mtrt_host_resolve(ptr @.sym_chmod)
  %missing = icmp eq ptr %sym, null
  br i1 %missing, label %enosys, label %call

enosys:
  %eno = call i32 @__mtrt_fail_i32(i32 38)
  ret i32 %eno

call:
  %ret = call i32 %sym(ptr %path, i32 %mode)
  %mapped = call i32 @__mtrt_posix_i32(i32 %ret)
  ret i32 %mapped
}

define i32 @chown(ptr %path, i32 %owner, i32 %group) {
entry:
  %sym = call ptr @__mtrt_host_resolve(ptr @.sym_chown)
  %missing = icmp eq ptr %sym, null
  br i1 %missing, label %enosys, label %call

enosys:
  %eno = call i32 @__mtrt_fail_i32(i32 38)
  ret i32 %eno

call:
  %ret = call i32 %sym(ptr %path, i32 %owner, i32 %group)
  %mapped = call i32 @__mtrt_posix_i32(i32 %ret)
  ret i32 %mapped
}

define i32 @clock_getres(i32 %clockid, ptr %tp) {
entry:
  %sym = call ptr @__mtrt_host_resolve(ptr @.sym_clock_getres)
  %missing = icmp eq ptr %sym, null
  br i1 %missing, label %enosys, label %call

enosys:
  %eno = call i32 @__mtrt_fail_i32(i32 38)
  ret i32 %eno

call:
  %ret = call i32 %sym(i32 %clockid, ptr %tp)
  %mapped = call i32 @__mtrt_posix_i32(i32 %ret)
  ret i32 %mapped
}

define i32 @clock_gettime(i32 %clockid, ptr %tp) {
entry:
  %sym = call ptr @__mtrt_host_resolve(ptr @.sym_clock_gettime)
  %missing = icmp eq ptr %sym, null
  br i1 %missing, label %enosys, label %call

enosys:
  %eno = call i32 @__mtrt_fail_i32(i32 38)
  ret i32 %eno

call:
  %ret = call i32 %sym(i32 %clockid, ptr %tp)
  %mapped = call i32 @__mtrt_posix_i32(i32 %ret)
  ret i32 %mapped
}

define i32 @clock_settime(i32 %clockid, ptr %tp) {
entry:
  %sym = call ptr @__mtrt_host_resolve(ptr @.sym_clock_settime)
  %missing = icmp eq ptr %sym, null
  br i1 %missing, label %enosys, label %call

enosys:
  %eno = call i32 @__mtrt_fail_i32(i32 38)
  ret i32 %eno

call:
  %ret = call i32 %sym(i32 %clockid, ptr %tp)
  %mapped = call i32 @__mtrt_posix_i32(i32 %ret)
  ret i32 %mapped
}

define i32 @close(i32 %fd) {
entry:
  %sym = call ptr @__mtrt_host_resolve(ptr @.sym_close)
  %missing = icmp eq ptr %sym, null
  br i1 %missing, label %enosys, label %call

enosys:
  %eno = call i32 @__mtrt_fail_i32(i32 38)
  ret i32 %eno

call:
  %ret = call i32 %sym(i32 %fd)
  %mapped = call i32 @__mtrt_posix_i32(i32 %ret)
  ret i32 %mapped
}

define i32 @closedir(ptr %dirp) {
entry:
  %sym = call ptr @__mtrt_host_resolve(ptr @.sym_closedir)
  %missing = icmp eq ptr %sym, null
  br i1 %missing, label %enosys, label %call

enosys:
  %eno = call i32 @__mtrt_fail_i32(i32 38)
  ret i32 %eno

call:
  %ret = call i32 %sym(ptr %dirp)
  %mapped = call i32 @__mtrt_posix_i32(i32 %ret)
  ret i32 %mapped
}

define i32 @dup(i32 %fd) {
entry:
  %sym = call ptr @__mtrt_host_resolve(ptr @.sym_dup)
  %missing = icmp eq ptr %sym, null
  br i1 %missing, label %enosys, label %call

enosys:
  %eno = call i32 @__mtrt_fail_i32(i32 38)
  ret i32 %eno

call:
  %ret = call i32 %sym(i32 %fd)
  %mapped = call i32 @__mtrt_posix_i32(i32 %ret)
  ret i32 %mapped
}

define i32 @dup2(i32 %oldfd, i32 %newfd) {
entry:
  %sym = call ptr @__mtrt_host_resolve(ptr @.sym_dup2)
  %missing = icmp eq ptr %sym, null
  br i1 %missing, label %enosys, label %call

enosys:
  %eno = call i32 @__mtrt_fail_i32(i32 38)
  ret i32 %eno

call:
  %ret = call i32 %sym(i32 %oldfd, i32 %newfd)
  %mapped = call i32 @__mtrt_posix_i32(i32 %ret)
  ret i32 %mapped
}

define i32 @execv(ptr %path, ptr %argv) {
entry:
  %sym = call ptr @__mtrt_host_resolve(ptr @.sym_execv)
  %missing = icmp eq ptr %sym, null
  br i1 %missing, label %enosys, label %call

enosys:
  %eno = call i32 @__mtrt_fail_i32(i32 38)
  ret i32 %eno

call:
  %ret = call i32 %sym(ptr %path, ptr %argv)
  %mapped = call i32 @__mtrt_posix_i32(i32 %ret)
  ret i32 %mapped
}

define i32 @execve(ptr %path, ptr %argv, ptr %envp) {
entry:
  %sym = call ptr @__mtrt_host_resolve(ptr @.sym_execve)
  %missing = icmp eq ptr %sym, null
  br i1 %missing, label %enosys, label %call

enosys:
  %eno = call i32 @__mtrt_fail_i32(i32 38)
  ret i32 %eno

call:
  %ret = call i32 %sym(ptr %path, ptr %argv, ptr %envp)
  %mapped = call i32 @__mtrt_posix_i32(i32 %ret)
  ret i32 %mapped
}

define i32 @execvp(ptr %file, ptr %argv) {
entry:
  %sym = call ptr @__mtrt_host_resolve(ptr @.sym_execvp)
  %missing = icmp eq ptr %sym, null
  br i1 %missing, label %enosys, label %call

enosys:
  %eno = call i32 @__mtrt_fail_i32(i32 38)
  ret i32 %eno

call:
  %ret = call i32 %sym(ptr %file, ptr %argv)
  %mapped = call i32 @__mtrt_posix_i32(i32 %ret)
  ret i32 %mapped
}

define i32 @execl(ptr %path, ptr %arg0, ...) {
entry:
  %sym = call ptr @__mtrt_host_resolve(ptr @.sym_execl)
  %missing = icmp eq ptr %sym, null
  br i1 %missing, label %enosys, label %call

enosys:
  %eno = call i32 @__mtrt_fail_i32(i32 38)
  ret i32 %eno

call:
  %ret = call i32 (ptr, ptr, ...) %sym(ptr %path, ptr %arg0, ptr null)
  %mapped = call i32 @__mtrt_posix_i32(i32 %ret)
  ret i32 %mapped
}

define i32 @execlp(ptr %file, ptr %arg0, ...) {
entry:
  %sym = call ptr @__mtrt_host_resolve(ptr @.sym_execlp)
  %missing = icmp eq ptr %sym, null
  br i1 %missing, label %enosys, label %call

enosys:
  %eno = call i32 @__mtrt_fail_i32(i32 38)
  ret i32 %eno

call:
  %ret = call i32 (ptr, ptr, ...) %sym(ptr %file, ptr %arg0, ptr null)
  %mapped = call i32 @__mtrt_posix_i32(i32 %ret)
  ret i32 %mapped
}

define void @_exit(i32 %status) {
entry:
  %sym = call ptr @__mtrt_host_resolve(ptr @.sym__exit)
  %missing = icmp eq ptr %sym, null
  br i1 %missing, label %panic, label %call

panic:
  unreachable

call:
  call void %sym(i32 %status)
  unreachable
}

define void @exit(i32 %status) {
entry:
  call void @_exit(i32 %status)
  unreachable
}

define i32 @faccessat(i32 %dirfd, ptr %path, i32 %mode, i32 %flags) {
entry:
  %sym = call ptr @__mtrt_host_resolve(ptr @.sym_faccessat)
  %missing = icmp eq ptr %sym, null
  br i1 %missing, label %enosys, label %call

enosys:
  %eno = call i32 @__mtrt_fail_i32(i32 38)
  ret i32 %eno

call:
  %ret = call i32 %sym(i32 %dirfd, ptr %path, i32 %mode, i32 %flags)
  %mapped = call i32 @__mtrt_posix_i32(i32 %ret)
  ret i32 %mapped
}

define i32 @fchdir(i32 %fd) {
entry:
  %sym = call ptr @__mtrt_host_resolve(ptr @.sym_fchdir)
  %missing = icmp eq ptr %sym, null
  br i1 %missing, label %enosys, label %call

enosys:
  %eno = call i32 @__mtrt_fail_i32(i32 38)
  ret i32 %eno

call:
  %ret = call i32 %sym(i32 %fd)
  %mapped = call i32 @__mtrt_posix_i32(i32 %ret)
  ret i32 %mapped
}

define i32 @fchmod(i32 %fd, i32 %mode) {
entry:
  %sym = call ptr @__mtrt_host_resolve(ptr @.sym_fchmod)
  %missing = icmp eq ptr %sym, null
  br i1 %missing, label %enosys, label %call

enosys:
  %eno = call i32 @__mtrt_fail_i32(i32 38)
  ret i32 %eno

call:
  %ret = call i32 %sym(i32 %fd, i32 %mode)
  %mapped = call i32 @__mtrt_posix_i32(i32 %ret)
  ret i32 %mapped
}

define i32 @fchmodat(i32 %dirfd, ptr %path, i32 %mode, i32 %flags) {
entry:
  %sym = call ptr @__mtrt_host_resolve(ptr @.sym_fchmodat)
  %missing = icmp eq ptr %sym, null
  br i1 %missing, label %enosys, label %call

enosys:
  %eno = call i32 @__mtrt_fail_i32(i32 38)
  ret i32 %eno

call:
  %ret = call i32 %sym(i32 %dirfd, ptr %path, i32 %mode, i32 %flags)
  %mapped = call i32 @__mtrt_posix_i32(i32 %ret)
  ret i32 %mapped
}

define i32 @fchown(i32 %fd, i32 %owner, i32 %group) {
entry:
  %sym = call ptr @__mtrt_host_resolve(ptr @.sym_fchown)
  %missing = icmp eq ptr %sym, null
  br i1 %missing, label %enosys, label %call

enosys:
  %eno = call i32 @__mtrt_fail_i32(i32 38)
  ret i32 %eno

call:
  %ret = call i32 %sym(i32 %fd, i32 %owner, i32 %group)
  %mapped = call i32 @__mtrt_posix_i32(i32 %ret)
  ret i32 %mapped
}

define i32 @fchownat(i32 %dirfd, ptr %path, i32 %owner, i32 %group, i32 %flags) {
entry:
  %sym = call ptr @__mtrt_host_resolve(ptr @.sym_fchownat)
  %missing = icmp eq ptr %sym, null
  br i1 %missing, label %enosys, label %call

enosys:
  %eno = call i32 @__mtrt_fail_i32(i32 38)
  ret i32 %eno

call:
  %ret = call i32 %sym(i32 %dirfd, ptr %path, i32 %owner, i32 %group, i32 %flags)
  %mapped = call i32 @__mtrt_posix_i32(i32 %ret)
  ret i32 %mapped
}

define i32 @fcntl(i32 %fd, i32 %cmd, ...) {
entry:
  %sym = call ptr @__mtrt_host_resolve(ptr @.sym_fcntl)
  %missing = icmp eq ptr %sym, null
  br i1 %missing, label %enosys, label %call

enosys:
  %eno = call i32 @__mtrt_fail_i32(i32 38)
  ret i32 %eno

call:
  %ret = call i32 %sym(i32 %fd, i32 %cmd, i64 0)
  %mapped = call i32 @__mtrt_posix_i32(i32 %ret)
  ret i32 %mapped
}

define i32 @fdatasync(i32 %fd) {
entry:
  %sym = call ptr @__mtrt_host_resolve(ptr @.sym_fdatasync)
  %missing = icmp eq ptr %sym, null
  br i1 %missing, label %enosys, label %call

enosys:
  %eno = call i32 @__mtrt_fail_i32(i32 38)
  ret i32 %eno

call:
  %ret = call i32 %sym(i32 %fd)
  %mapped = call i32 @__mtrt_posix_i32(i32 %ret)
  ret i32 %mapped
}

define ptr @fdopendir(i32 %fd) {
entry:
  %sym = call ptr @__mtrt_host_resolve(ptr @.sym_fdopendir)
  %missing = icmp eq ptr %sym, null
  br i1 %missing, label %enosys, label %call

enosys:
  %eno = call ptr @__mtrt_fail_null_ptr(i32 38)
  ret ptr %eno

call:
  %ret = call ptr %sym(i32 %fd)
  %mapped = call ptr @__mtrt_posix_null_ptr(ptr %ret)
  ret ptr %mapped
}

define i32 @fork() {
entry:
  %sym = call ptr @__mtrt_host_resolve(ptr @.sym_fork)
  %missing = icmp eq ptr %sym, null
  br i1 %missing, label %enosys, label %call

enosys:
  %eno = call i32 @__mtrt_fail_i32(i32 38)
  ret i32 %eno

call:
  %ret = call i32 %sym()
  %mapped = call i32 @__mtrt_posix_i32(i32 %ret)
  ret i32 %mapped
}

define i32 @fstat(i32 %fd, ptr %buf) {
entry:
  %sym = call ptr @__mtrt_host_resolve(ptr @.sym_fstat)
  %missing = icmp eq ptr %sym, null
  br i1 %missing, label %enosys, label %call

enosys:
  %eno = call i32 @__mtrt_fail_i32(i32 38)
  ret i32 %eno

call:
  %ret = call i32 %sym(i32 %fd, ptr %buf)
  %mapped = call i32 @__mtrt_posix_i32(i32 %ret)
  ret i32 %mapped
}

define i32 @fstatat(i32 %dirfd, ptr %path, ptr %buf, i32 %flags) {
entry:
  %sym = call ptr @__mtrt_host_resolve(ptr @.sym_fstatat)
  %missing = icmp eq ptr %sym, null
  br i1 %missing, label %enosys, label %call

enosys:
  %eno = call i32 @__mtrt_fail_i32(i32 38)
  ret i32 %eno

call:
  %ret = call i32 %sym(i32 %dirfd, ptr %path, ptr %buf, i32 %flags)
  %mapped = call i32 @__mtrt_posix_i32(i32 %ret)
  ret i32 %mapped
}

define i32 @fsync(i32 %fd) {
entry:
  %sym = call ptr @__mtrt_host_resolve(ptr @.sym_fsync)
  %missing = icmp eq ptr %sym, null
  br i1 %missing, label %enosys, label %call

enosys:
  %eno = call i32 @__mtrt_fail_i32(i32 38)
  ret i32 %eno

call:
  %ret = call i32 %sym(i32 %fd)
  %mapped = call i32 @__mtrt_posix_i32(i32 %ret)
  ret i32 %mapped
}

define ptr @getcwd(ptr %buf, i64 %size) {
entry:
  %sym = call ptr @__mtrt_host_resolve(ptr @.sym_getcwd)
  %missing = icmp eq ptr %sym, null
  br i1 %missing, label %enosys, label %call

enosys:
  %eno = call ptr @__mtrt_fail_null_ptr(i32 38)
  ret ptr %eno

call:
  %ret = call ptr %sym(ptr %buf, i64 %size)
  %mapped = call ptr @__mtrt_posix_null_ptr(ptr %ret)
  ret ptr %mapped
}

define i32 @getpgid(i32 %pid) {
entry:
  %sym = call ptr @__mtrt_host_resolve(ptr @.sym_getpgid)
  %missing = icmp eq ptr %sym, null
  br i1 %missing, label %enosys, label %call

enosys:
  %eno = call i32 @__mtrt_fail_i32(i32 38)
  ret i32 %eno

call:
  %ret = call i32 %sym(i32 %pid)
  %mapped = call i32 @__mtrt_posix_i32(i32 %ret)
  ret i32 %mapped
}

define i32 @getpgrp() {
entry:
  %sym = call ptr @__mtrt_host_resolve(ptr @.sym_getpgrp)
  %missing = icmp eq ptr %sym, null
  br i1 %missing, label %enosys, label %call

enosys:
  %eno = call i32 @__mtrt_fail_i32(i32 38)
  ret i32 %eno

call:
  %ret = call i32 %sym()
  %mapped = call i32 @__mtrt_posix_i32(i32 %ret)
  ret i32 %mapped
}

define i32 @getpid() {
entry:
  %sym = call ptr @__mtrt_host_resolve(ptr @.sym_getpid)
  %missing = icmp eq ptr %sym, null
  br i1 %missing, label %enosys, label %call

enosys:
  %eno = call i32 @__mtrt_fail_i32(i32 38)
  ret i32 %eno

call:
  %ret = call i32 %sym()
  %mapped = call i32 @__mtrt_posix_i32(i32 %ret)
  ret i32 %mapped
}

define i32 @getppid() {
entry:
  %sym = call ptr @__mtrt_host_resolve(ptr @.sym_getppid)
  %missing = icmp eq ptr %sym, null
  br i1 %missing, label %enosys, label %call

enosys:
  %eno = call i32 @__mtrt_fail_i32(i32 38)
  ret i32 %eno

call:
  %ret = call i32 %sym()
  %mapped = call i32 @__mtrt_posix_i32(i32 %ret)
  ret i32 %mapped
}

define i32 @getsid(i32 %pid) {
entry:
  %sym = call ptr @__mtrt_host_resolve(ptr @.sym_getsid)
  %missing = icmp eq ptr %sym, null
  br i1 %missing, label %enosys, label %call

enosys:
  %eno = call i32 @__mtrt_fail_i32(i32 38)
  ret i32 %eno

call:
  %ret = call i32 %sym(i32 %pid)
  %mapped = call i32 @__mtrt_posix_i32(i32 %ret)
  ret i32 %mapped
}

define i32 @gettimeofday(ptr %tv, ptr %tz) {
entry:
  %sym = call ptr @__mtrt_host_resolve(ptr @.sym_gettimeofday)
  %missing = icmp eq ptr %sym, null
  br i1 %missing, label %enosys, label %call

enosys:
  %eno = call i32 @__mtrt_fail_i32(i32 38)
  ret i32 %eno

call:
  %ret = call i32 %sym(ptr %tv, ptr %tz)
  %mapped = call i32 @__mtrt_posix_i32(i32 %ret)
  ret i32 %mapped
}

define ptr @gmtime_r(ptr %timer, ptr %result) {
entry:
  %sym = call ptr @__mtrt_host_resolve(ptr @.sym_gmtime_r)
  %missing = icmp eq ptr %sym, null
  br i1 %missing, label %enosys, label %call

enosys:
  %eno = call ptr @__mtrt_fail_null_ptr(i32 38)
  ret ptr %eno

call:
  %ret = call ptr %sym(ptr %timer, ptr %result)
  %mapped = call ptr @__mtrt_posix_null_ptr(ptr %ret)
  ret ptr %mapped
}

define i32 @kill(i32 %pid, i32 %sig) {
entry:
  %sym = call ptr @__mtrt_host_resolve(ptr @.sym_kill)
  %missing = icmp eq ptr %sym, null
  br i1 %missing, label %enosys, label %call

enosys:
  %eno = call i32 @__mtrt_fail_i32(i32 38)
  ret i32 %eno

call:
  %ret = call i32 %sym(i32 %pid, i32 %sig)
  %mapped = call i32 @__mtrt_posix_i32(i32 %ret)
  ret i32 %mapped
}

define i32 @lchown(ptr %path, i32 %owner, i32 %group) {
entry:
  %sym = call ptr @__mtrt_host_resolve(ptr @.sym_lchown)
  %missing = icmp eq ptr %sym, null
  br i1 %missing, label %enosys, label %call

enosys:
  %eno = call i32 @__mtrt_fail_i32(i32 38)
  ret i32 %eno

call:
  %ret = call i32 %sym(ptr %path, i32 %owner, i32 %group)
  %mapped = call i32 @__mtrt_posix_i32(i32 %ret)
  ret i32 %mapped
}

define i32 @link(ptr %oldpath, ptr %newpath) {
entry:
  %sym = call ptr @__mtrt_host_resolve(ptr @.sym_link)
  %missing = icmp eq ptr %sym, null
  br i1 %missing, label %enosys, label %call

enosys:
  %eno = call i32 @__mtrt_fail_i32(i32 38)
  ret i32 %eno

call:
  %ret = call i32 %sym(ptr %oldpath, ptr %newpath)
  %mapped = call i32 @__mtrt_posix_i32(i32 %ret)
  ret i32 %mapped
}

define i32 @linkat(i32 %olddirfd, ptr %oldpath, i32 %newdirfd, ptr %newpath, i32 %flags) {
entry:
  %sym = call ptr @__mtrt_host_resolve(ptr @.sym_linkat)
  %missing = icmp eq ptr %sym, null
  br i1 %missing, label %enosys, label %call

enosys:
  %eno = call i32 @__mtrt_fail_i32(i32 38)
  ret i32 %eno

call:
  %ret = call i32 %sym(i32 %olddirfd, ptr %oldpath, i32 %newdirfd, ptr %newpath, i32 %flags)
  %mapped = call i32 @__mtrt_posix_i32(i32 %ret)
  ret i32 %mapped
}

define ptr @localtime_r(ptr %timer, ptr %result) {
entry:
  %sym = call ptr @__mtrt_host_resolve(ptr @.sym_localtime_r)
  %missing = icmp eq ptr %sym, null
  br i1 %missing, label %enosys, label %call

enosys:
  %eno = call ptr @__mtrt_fail_null_ptr(i32 38)
  ret ptr %eno

call:
  %ret = call ptr %sym(ptr %timer, ptr %result)
  %mapped = call ptr @__mtrt_posix_null_ptr(ptr %ret)
  ret ptr %mapped
}

define i64 @lseek(i32 %fd, i64 %offset, i32 %whence) {
entry:
  %sym = call ptr @__mtrt_host_resolve(ptr @.sym_lseek)
  %missing = icmp eq ptr %sym, null
  br i1 %missing, label %enosys, label %call

enosys:
  %eno = call i64 @__mtrt_fail_i64(i32 38)
  ret i64 %eno

call:
  %ret = call i64 %sym(i32 %fd, i64 %offset, i32 %whence)
  %mapped = call i64 @__mtrt_posix_i64(i64 %ret)
  ret i64 %mapped
}

define i32 @lstat(ptr %path, ptr %buf) {
entry:
  %sym = call ptr @__mtrt_host_resolve(ptr @.sym_lstat)
  %missing = icmp eq ptr %sym, null
  br i1 %missing, label %enosys, label %call

enosys:
  %eno = call i32 @__mtrt_fail_i32(i32 38)
  ret i32 %eno

call:
  %ret = call i32 %sym(ptr %path, ptr %buf)
  %mapped = call i32 @__mtrt_posix_i32(i32 %ret)
  ret i32 %mapped
}

define i32 @madvise(ptr %addr, i64 %length, i32 %advice) {
entry:
  %sym = call ptr @__mtrt_host_resolve(ptr @.sym_madvise)
  %missing = icmp eq ptr %sym, null
  br i1 %missing, label %enosys, label %call

enosys:
  %eno = call i32 @__mtrt_fail_i32(i32 38)
  ret i32 %eno

call:
  %ret = call i32 %sym(ptr %addr, i64 %length, i32 %advice)
  %mapped = call i32 @__mtrt_posix_i32(i32 %ret)
  ret i32 %mapped
}

define i32 @mkdir(ptr %path, i32 %mode) {
entry:
  %sym = call ptr @__mtrt_host_resolve(ptr @.sym_mkdir)
  %missing = icmp eq ptr %sym, null
  br i1 %missing, label %enosys, label %call

enosys:
  %eno = call i32 @__mtrt_fail_i32(i32 38)
  ret i32 %eno

call:
  %ret = call i32 %sym(ptr %path, i32 %mode)
  %mapped = call i32 @__mtrt_posix_i32(i32 %ret)
  ret i32 %mapped
}

define i32 @mkdirat(i32 %dirfd, ptr %path, i32 %mode) {
entry:
  %sym = call ptr @__mtrt_host_resolve(ptr @.sym_mkdirat)
  %missing = icmp eq ptr %sym, null
  br i1 %missing, label %enosys, label %call

enosys:
  %eno = call i32 @__mtrt_fail_i32(i32 38)
  ret i32 %eno

call:
  %ret = call i32 %sym(i32 %dirfd, ptr %path, i32 %mode)
  %mapped = call i32 @__mtrt_posix_i32(i32 %ret)
  ret i32 %mapped
}

define i32 @mkstemp(ptr %template) {
entry:
  %sym = call ptr @__mtrt_host_resolve(ptr @.sym_mkstemp)
  %missing = icmp eq ptr %sym, null
  br i1 %missing, label %enosys, label %call

enosys:
  %eno = call i32 @__mtrt_fail_i32(i32 38)
  ret i32 %eno

call:
  %ret = call i32 %sym(ptr %template)
  %mapped = call i32 @__mtrt_posix_i32(i32 %ret)
  ret i32 %mapped
}

define i64 @mktime(ptr %tm) {
entry:
  %sym = call ptr @__mtrt_host_resolve(ptr @.sym_mktime)
  %missing = icmp eq ptr %sym, null
  br i1 %missing, label %enosys, label %call

enosys:
  %eno = call i64 @__mtrt_fail_i64(i32 38)
  ret i64 %eno

call:
  %ret = call i64 %sym(ptr %tm)
  %mapped = call i64 @__mtrt_posix_i64(i64 %ret)
  ret i64 %mapped
}

define i32 @mlock(ptr %addr, i64 %length) {
entry:
  %sym = call ptr @__mtrt_host_resolve(ptr @.sym_mlock)
  %missing = icmp eq ptr %sym, null
  br i1 %missing, label %enosys, label %call

enosys:
  %eno = call i32 @__mtrt_fail_i32(i32 38)
  ret i32 %eno

call:
  %ret = call i32 %sym(ptr %addr, i64 %length)
  %mapped = call i32 @__mtrt_posix_i32(i32 %ret)
  ret i32 %mapped
}

define i32 @mlockall(i32 %flags) {
entry:
  %sym = call ptr @__mtrt_host_resolve(ptr @.sym_mlockall)
  %missing = icmp eq ptr %sym, null
  br i1 %missing, label %enosys, label %call

enosys:
  %eno = call i32 @__mtrt_fail_i32(i32 38)
  ret i32 %eno

call:
  %ret = call i32 %sym(i32 %flags)
  %mapped = call i32 @__mtrt_posix_i32(i32 %ret)
  ret i32 %mapped
}

define ptr @mmap(ptr %addr, i64 %length, i32 %prot, i32 %flags, i32 %fd, i64 %offset) {
entry:
  %sym = call ptr @__mtrt_host_resolve(ptr @.sym_mmap)
  %missing = icmp eq ptr %sym, null
  br i1 %missing, label %enosys, label %call

enosys:
  %eno = call ptr @__mtrt_fail_map_ptr(i32 38)
  ret ptr %eno

call:
  %xflags = call i32 @__mtrt_translate_mmap_flags(i32 %flags)
  %ret = call ptr %sym(ptr %addr, i64 %length, i32 %prot, i32 %xflags, i32 %fd, i64 %offset)
  %mapped = call ptr @__mtrt_posix_map_ptr(ptr %ret)
  ret ptr %mapped
}

define i32 @mprotect(ptr %addr, i64 %length, i32 %prot) {
entry:
  %sym = call ptr @__mtrt_host_resolve(ptr @.sym_mprotect)
  %missing = icmp eq ptr %sym, null
  br i1 %missing, label %enosys, label %call

enosys:
  %eno = call i32 @__mtrt_fail_i32(i32 38)
  ret i32 %eno

call:
  %ret = call i32 %sym(ptr %addr, i64 %length, i32 %prot)
  %mapped = call i32 @__mtrt_posix_i32(i32 %ret)
  ret i32 %mapped
}

define i32 @msync(ptr %addr, i64 %length, i32 %flags) {
entry:
  %sym = call ptr @__mtrt_host_resolve(ptr @.sym_msync)
  %missing = icmp eq ptr %sym, null
  br i1 %missing, label %enosys, label %call

enosys:
  %eno = call i32 @__mtrt_fail_i32(i32 38)
  ret i32 %eno

call:
  %ret = call i32 %sym(ptr %addr, i64 %length, i32 %flags)
  %mapped = call i32 @__mtrt_posix_i32(i32 %ret)
  ret i32 %mapped
}

define i32 @munlock(ptr %addr, i64 %length) {
entry:
  %sym = call ptr @__mtrt_host_resolve(ptr @.sym_munlock)
  %missing = icmp eq ptr %sym, null
  br i1 %missing, label %enosys, label %call

enosys:
  %eno = call i32 @__mtrt_fail_i32(i32 38)
  ret i32 %eno

call:
  %ret = call i32 %sym(ptr %addr, i64 %length)
  %mapped = call i32 @__mtrt_posix_i32(i32 %ret)
  ret i32 %mapped
}

define i32 @munlockall() {
entry:
  %sym = call ptr @__mtrt_host_resolve(ptr @.sym_munlockall)
  %missing = icmp eq ptr %sym, null
  br i1 %missing, label %enosys, label %call

enosys:
  %eno = call i32 @__mtrt_fail_i32(i32 38)
  ret i32 %eno

call:
  %ret = call i32 %sym()
  %mapped = call i32 @__mtrt_posix_i32(i32 %ret)
  ret i32 %mapped
}

define i32 @munmap(ptr %addr, i64 %length) {
entry:
  %sym = call ptr @__mtrt_host_resolve(ptr @.sym_munmap)
  %missing = icmp eq ptr %sym, null
  br i1 %missing, label %enosys, label %call

enosys:
  %eno = call i32 @__mtrt_fail_i32(i32 38)
  ret i32 %eno

call:
  %ret = call i32 %sym(ptr %addr, i64 %length)
  %mapped = call i32 @__mtrt_posix_i32(i32 %ret)
  ret i32 %mapped
}

define i32 @nanosleep(ptr %req, ptr %rem) {
entry:
  %sym = call ptr @__mtrt_host_resolve(ptr @.sym_nanosleep)
  %missing = icmp eq ptr %sym, null
  br i1 %missing, label %enosys, label %call

enosys:
  %eno = call i32 @__mtrt_fail_i32(i32 38)
  ret i32 %eno

call:
  %ret = call i32 %sym(ptr %req, ptr %rem)
  %mapped = call i32 @__mtrt_posix_i32(i32 %ret)
  ret i32 %mapped
}

define i32 @open(ptr %path, i32 %flags, ...) {
entry:
  %sym = call ptr @__mtrt_host_resolve(ptr @.sym_open)
  %missing = icmp eq ptr %sym, null
  br i1 %missing, label %enosys, label %call

enosys:
  %eno = call i32 @__mtrt_fail_i32(i32 38)
  ret i32 %eno

call:
  %ret = call i32 %sym(ptr %path, i32 %flags, i32 0)
  %mapped = call i32 @__mtrt_posix_i32(i32 %ret)
  ret i32 %mapped
}

define i32 @openat(i32 %dirfd, ptr %path, i32 %flags, ...) {
entry:
  %sym = call ptr @__mtrt_host_resolve(ptr @.sym_openat)
  %missing = icmp eq ptr %sym, null
  br i1 %missing, label %enosys, label %call

enosys:
  %eno = call i32 @__mtrt_fail_i32(i32 38)
  ret i32 %eno

call:
  %ret = call i32 %sym(i32 %dirfd, ptr %path, i32 %flags, i32 0)
  %mapped = call i32 @__mtrt_posix_i32(i32 %ret)
  ret i32 %mapped
}

define ptr @opendir(ptr %path) {
entry:
  %sym = call ptr @__mtrt_host_resolve(ptr @.sym_opendir)
  %missing = icmp eq ptr %sym, null
  br i1 %missing, label %enosys, label %call

enosys:
  %eno = call ptr @__mtrt_fail_null_ptr(i32 38)
  ret ptr %eno

call:
  %ret = call ptr %sym(ptr %path)
  %mapped = call ptr @__mtrt_posix_null_ptr(ptr %ret)
  ret ptr %mapped
}

define i32 @pause() {
entry:
  %sym = call ptr @__mtrt_host_resolve(ptr @.sym_pause)
  %missing = icmp eq ptr %sym, null
  br i1 %missing, label %enosys, label %call

enosys:
  %eno = call i32 @__mtrt_fail_i32(i32 38)
  ret i32 %eno

call:
  %ret = call i32 %sym()
  %mapped = call i32 @__mtrt_posix_i32(i32 %ret)
  ret i32 %mapped
}

define i32 @pipe(ptr %fds) {
entry:
  %sym = call ptr @__mtrt_host_resolve(ptr @.sym_pipe)
  %missing = icmp eq ptr %sym, null
  br i1 %missing, label %enosys, label %call

enosys:
  %eno = call i32 @__mtrt_fail_i32(i32 38)
  ret i32 %eno

call:
  %ret = call i32 %sym(ptr %fds)
  %mapped = call i32 @__mtrt_posix_i32(i32 %ret)
  ret i32 %mapped
}

define i32 @pipe2(ptr %fds, i32 %flags) {
entry:
  %sym = call ptr @__mtrt_host_resolve(ptr @.sym_pipe2)
  %has_pipe2 = icmp ne ptr %sym, null
  br i1 %has_pipe2, label %call_pipe2, label %fallback

call_pipe2:
  %ret = call i32 %sym(ptr %fds, i32 %flags)
  %mapped = call i32 @__mtrt_posix_i32(i32 %ret)
  ret i32 %mapped

fallback:
  %zero = icmp eq i32 %flags, 0
  br i1 %zero, label %call_pipe, label %enosys

call_pipe:
  %psym = call ptr @__mtrt_host_resolve(ptr @.sym_pipe)
  %pmiss = icmp eq ptr %psym, null
  br i1 %pmiss, label %enosys, label %do_pipe

do_pipe:
  %pret = call i32 %psym(ptr %fds)
  %pmapped = call i32 @__mtrt_posix_i32(i32 %pret)
  ret i32 %pmapped

enosys:
  %eno = call i32 @__mtrt_fail_i32(i32 38)
  ret i32 %eno
}

define i32 @posix_memalign(ptr %memptr, i64 %alignment, i64 %size) {
entry:
  %sym = call ptr @__mtrt_host_resolve(ptr @.sym_posix_memalign)
  %missing = icmp eq ptr %sym, null
  br i1 %missing, label %enosys, label %call

enosys:
  call void @__mtrt_set_errno(i32 38)
  ret i32 38

call:
  %ret = call i32 %sym(ptr %memptr, i64 %alignment, i64 %size)
  %mapped = call i32 @__mtrt_direct_i32(i32 %ret)
  ret i32 %mapped
}

define i64 @pread(i32 %fd, ptr %buf, i64 %count, i64 %offset) {
entry:
  %sym = call ptr @__mtrt_host_resolve(ptr @.sym_pread)
  %missing = icmp eq ptr %sym, null
  br i1 %missing, label %enosys, label %call

enosys:
  %eno = call i64 @__mtrt_fail_i64(i32 38)
  ret i64 %eno

call:
  %ret = call i64 %sym(i32 %fd, ptr %buf, i64 %count, i64 %offset)
  %mapped = call i64 @__mtrt_posix_i64(i64 %ret)
  ret i64 %mapped
}

define i32 @pthread_atfork(ptr %prepare, ptr %parent, ptr %child) {
entry:
  %sym = call ptr @__mtrt_host_resolve(ptr @.sym_pthread_atfork)
  %missing = icmp eq ptr %sym, null
  br i1 %missing, label %fallback, label %call

fallback:
  call void @__mtrt_set_errno(i32 0)
  ret i32 0

call:
  %ret = call i32 %sym(ptr %prepare, ptr %parent, ptr %child)
  %mapped = call i32 @__mtrt_direct_i32(i32 %ret)
  ret i32 %mapped
}

define i64 @pthread_barrier_family() {
entry:
  ret i64 0
}

define i64 @pthread_cond_family() {
entry:
  ret i64 0
}

define i32 @pthread_create(ptr %thread, ptr %attr, ptr %start_routine, ptr %arg) {
entry:
  %sym = call ptr @__mtrt_host_resolve(ptr @.sym_pthread_create)
  %missing = icmp eq ptr %sym, null
  br i1 %missing, label %enosys, label %call

enosys:
  call void @__mtrt_set_errno(i32 38)
  ret i32 38

call:
  %ret = call i32 %sym(ptr %thread, ptr %attr, ptr %start_routine, ptr %arg)
  %mapped = call i32 @__mtrt_direct_i32(i32 %ret)
  ret i32 %mapped
}

define i32 @pthread_detach(i64 %thread) {
entry:
  %sym = call ptr @__mtrt_host_resolve(ptr @.sym_pthread_detach)
  %missing = icmp eq ptr %sym, null
  br i1 %missing, label %enosys, label %call

enosys:
  call void @__mtrt_set_errno(i32 38)
  ret i32 38

call:
  %ret = call i32 %sym(i64 %thread)
  %mapped = call i32 @__mtrt_direct_i32(i32 %ret)
  ret i32 %mapped
}

define void @pthread_exit(ptr %value) {
entry:
  %sym = call ptr @__mtrt_host_resolve(ptr @.sym_pthread_exit)
  %missing = icmp eq ptr %sym, null
  br i1 %missing, label %panic, label %call

panic:
  call void @_exit(i32 127)
  unreachable

call:
  call void %sym(ptr %value)
  unreachable
}

define ptr @pthread_getspecific(i32 %key) {
entry:
  %sym = call ptr @__mtrt_host_resolve(ptr @.sym_pthread_getspecific)
  %missing = icmp eq ptr %sym, null
  br i1 %missing, label %enosys, label %call

enosys:
  %eno = call ptr @__mtrt_fail_null_ptr(i32 38)
  ret ptr %eno

call:
  %ret = call ptr %sym(i32 %key)
  ret ptr %ret
}

define i32 @pthread_join(i64 %thread, ptr %retval) {
entry:
  %sym = call ptr @__mtrt_host_resolve(ptr @.sym_pthread_join)
  %missing = icmp eq ptr %sym, null
  br i1 %missing, label %enosys, label %call

enosys:
  call void @__mtrt_set_errno(i32 38)
  ret i32 38

call:
  %ret = call i32 %sym(i64 %thread, ptr %retval)
  %mapped = call i32 @__mtrt_direct_i32(i32 %ret)
  ret i32 %mapped
}

define i32 @pthread_key_create(ptr %key, ptr %destructor) {
entry:
  %sym = call ptr @__mtrt_host_resolve(ptr @.sym_pthread_key_create)
  %missing = icmp eq ptr %sym, null
  br i1 %missing, label %enosys, label %call

enosys:
  call void @__mtrt_set_errno(i32 38)
  ret i32 38

call:
  %ret = call i32 %sym(ptr %key, ptr %destructor)
  %mapped = call i32 @__mtrt_direct_i32(i32 %ret)
  ret i32 %mapped
}

define i32 @pthread_key_delete(i32 %key) {
entry:
  %sym = call ptr @__mtrt_host_resolve(ptr @.sym_pthread_key_delete)
  %missing = icmp eq ptr %sym, null
  br i1 %missing, label %enosys, label %call

enosys:
  call void @__mtrt_set_errno(i32 38)
  ret i32 38

call:
  %ret = call i32 %sym(i32 %key)
  %mapped = call i32 @__mtrt_direct_i32(i32 %ret)
  ret i32 %mapped
}

define i32 @pthread_kill(i64 %thread, i32 %sig) {
entry:
  %sym = call ptr @__mtrt_host_resolve(ptr @.sym_pthread_kill)
  %missing = icmp eq ptr %sym, null
  br i1 %missing, label %enosys, label %call

enosys:
  call void @__mtrt_set_errno(i32 38)
  ret i32 38

call:
  %ret = call i32 %sym(i64 %thread, i32 %sig)
  %mapped = call i32 @__mtrt_direct_i32(i32 %ret)
  ret i32 %mapped
}

define i64 @pthread_mutex_family() {
entry:
  ret i64 0
}

define i32 @pthread_once(ptr %once_control, ptr %init_routine) {
entry:
  %sym = call ptr @__mtrt_host_resolve(ptr @.sym_pthread_once)
  %missing = icmp eq ptr %sym, null
  br i1 %missing, label %enosys, label %call

enosys:
  call void @__mtrt_set_errno(i32 38)
  ret i32 38

call:
  %ret = call i32 %sym(ptr %once_control, ptr %init_routine)
  %mapped = call i32 @__mtrt_direct_i32(i32 %ret)
  ret i32 %mapped
}

define i64 @pthread_rwlock_family() {
entry:
  ret i64 0
}

define i64 @pthread_self() {
entry:
  %sym = call ptr @__mtrt_host_resolve(ptr @.sym_pthread_self)
  %missing = icmp eq ptr %sym, null
  br i1 %missing, label %enosys, label %call

enosys:
  call void @__mtrt_set_errno(i32 38)
  ret i64 0

call:
  %ret = call i64 %sym()
  ret i64 %ret
}

define i32 @pthread_setspecific(i32 %key, ptr %value) {
entry:
  %sym = call ptr @__mtrt_host_resolve(ptr @.sym_pthread_setspecific)
  %missing = icmp eq ptr %sym, null
  br i1 %missing, label %enosys, label %call

enosys:
  call void @__mtrt_set_errno(i32 38)
  ret i32 38

call:
  %ret = call i32 %sym(i32 %key, ptr %value)
  %mapped = call i32 @__mtrt_direct_i32(i32 %ret)
  ret i32 %mapped
}

define i32 @pthread_sigmask(i32 %how, ptr %set, ptr %oldset) {
entry:
  %sym = call ptr @__mtrt_host_resolve(ptr @.sym_pthread_sigmask)
  %missing = icmp eq ptr %sym, null
  br i1 %missing, label %enosys, label %call

enosys:
  call void @__mtrt_set_errno(i32 38)
  ret i32 38

call:
  %ret = call i32 %sym(i32 %how, ptr %set, ptr %oldset)
  %mapped = call i32 @__mtrt_direct_i32(i32 %ret)
  ret i32 %mapped
}

define i64 @pthread_spin_family() {
entry:
  ret i64 0
}

define i64 @pwrite(i32 %fd, ptr %buf, i64 %count, i64 %offset) {
entry:
  %sym = call ptr @__mtrt_host_resolve(ptr @.sym_pwrite)
  %missing = icmp eq ptr %sym, null
  br i1 %missing, label %enosys, label %call

enosys:
  %eno = call i64 @__mtrt_fail_i64(i32 38)
  ret i64 %eno

call:
  %ret = call i64 %sym(i32 %fd, ptr %buf, i64 %count, i64 %offset)
  %mapped = call i64 @__mtrt_posix_i64(i64 %ret)
  ret i64 %mapped
}

define i32 @raise(i32 %sig) {
entry:
  %sym = call ptr @__mtrt_host_resolve(ptr @.sym_raise)
  %missing = icmp eq ptr %sym, null
  br i1 %missing, label %enosys, label %call

enosys:
  %eno = call i32 @__mtrt_fail_i32(i32 38)
  ret i32 %eno

call:
  %ret = call i32 %sym(i32 %sig)
  %mapped = call i32 @__mtrt_posix_i32(i32 %ret)
  ret i32 %mapped
}

define i64 @read(i32 %fd, ptr %buf, i64 %count) {
entry:
  %sym = call ptr @__mtrt_host_resolve(ptr @.sym_read)
  %missing = icmp eq ptr %sym, null
  br i1 %missing, label %enosys, label %call

enosys:
  %eno = call i64 @__mtrt_fail_i64(i32 38)
  ret i64 %eno

call:
  %ret = call i64 %sym(i32 %fd, ptr %buf, i64 %count)
  %mapped = call i64 @__mtrt_posix_i64(i64 %ret)
  ret i64 %mapped
}

define ptr @readdir(ptr %dirp) {
entry:
  %sym = call ptr @__mtrt_host_resolve(ptr @.sym_readdir)
  %missing = icmp eq ptr %sym, null
  br i1 %missing, label %enosys, label %call

enosys:
  %eno = call ptr @__mtrt_fail_null_ptr(i32 38)
  ret ptr %eno

call:
  %ret = call ptr %sym(ptr %dirp)
  ret ptr %ret
}

define i64 @readlink(ptr %path, ptr %buf, i64 %bufsize) {
entry:
  %sym = call ptr @__mtrt_host_resolve(ptr @.sym_readlink)
  %missing = icmp eq ptr %sym, null
  br i1 %missing, label %enosys, label %call

enosys:
  %eno = call i64 @__mtrt_fail_i64(i32 38)
  ret i64 %eno

call:
  %ret = call i64 %sym(ptr %path, ptr %buf, i64 %bufsize)
  %mapped = call i64 @__mtrt_posix_i64(i64 %ret)
  ret i64 %mapped
}

define i64 @readlinkat(i32 %dirfd, ptr %path, ptr %buf, i64 %bufsize) {
entry:
  %sym = call ptr @__mtrt_host_resolve(ptr @.sym_readlinkat)
  %missing = icmp eq ptr %sym, null
  br i1 %missing, label %enosys, label %call

enosys:
  %eno = call i64 @__mtrt_fail_i64(i32 38)
  ret i64 %eno

call:
  %ret = call i64 %sym(i32 %dirfd, ptr %path, ptr %buf, i64 %bufsize)
  %mapped = call i64 @__mtrt_posix_i64(i64 %ret)
  ret i64 %mapped
}

define i64 @readv(i32 %fd, ptr %iov, i32 %iovcnt) {
entry:
  %sym = call ptr @__mtrt_host_resolve(ptr @.sym_readv)
  %missing = icmp eq ptr %sym, null
  br i1 %missing, label %enosys, label %call

enosys:
  %eno = call i64 @__mtrt_fail_i64(i32 38)
  ret i64 %eno

call:
  %ret = call i64 %sym(i32 %fd, ptr %iov, i32 %iovcnt)
  %mapped = call i64 @__mtrt_posix_i64(i64 %ret)
  ret i64 %mapped
}

define i32 @rename(ptr %oldpath, ptr %newpath) {
entry:
  %sym = call ptr @__mtrt_host_resolve(ptr @.sym_rename)
  %missing = icmp eq ptr %sym, null
  br i1 %missing, label %enosys, label %call

enosys:
  %eno = call i32 @__mtrt_fail_i32(i32 38)
  ret i32 %eno

call:
  %ret = call i32 %sym(ptr %oldpath, ptr %newpath)
  %mapped = call i32 @__mtrt_posix_i32(i32 %ret)
  ret i32 %mapped
}

define i32 @renameat(i32 %olddirfd, ptr %oldpath, i32 %newdirfd, ptr %newpath) {
entry:
  %sym = call ptr @__mtrt_host_resolve(ptr @.sym_renameat)
  %missing = icmp eq ptr %sym, null
  br i1 %missing, label %enosys, label %call

enosys:
  %eno = call i32 @__mtrt_fail_i32(i32 38)
  ret i32 %eno

call:
  %ret = call i32 %sym(i32 %olddirfd, ptr %oldpath, i32 %newdirfd, ptr %newpath)
  %mapped = call i32 @__mtrt_posix_i32(i32 %ret)
  ret i32 %mapped
}

define void @rewinddir(ptr %dirp) {
entry:
  %sym = call ptr @__mtrt_host_resolve(ptr @.sym_rewinddir)
  %missing = icmp eq ptr %sym, null
  br i1 %missing, label %done, label %call

done:
  ret void

call:
  call void %sym(ptr %dirp)
  ret void
}

define i32 @rmdir(ptr %path) {
entry:
  %sym = call ptr @__mtrt_host_resolve(ptr @.sym_rmdir)
  %missing = icmp eq ptr %sym, null
  br i1 %missing, label %enosys, label %call

enosys:
  %eno = call i32 @__mtrt_fail_i32(i32 38)
  ret i32 %eno

call:
  %ret = call i32 %sym(ptr %path)
  %mapped = call i32 @__mtrt_posix_i32(i32 %ret)
  ret i32 %mapped
}

define ptr @sbrk(i64 %increment) {
entry:
  %sym = call ptr @__mtrt_host_resolve(ptr @.sym_sbrk)
  %missing = icmp eq ptr %sym, null
  br i1 %missing, label %enosys, label %call

enosys:
  %eno = call ptr @__mtrt_fail_map_ptr(i32 38)
  ret ptr %eno

call:
  %ret = call ptr %sym(i64 %increment)
  %mapped = call ptr @__mtrt_posix_map_ptr(ptr %ret)
  ret ptr %mapped
}

define i32 @sched_yield() {
entry:
  %sym = call ptr @__mtrt_host_resolve(ptr @.sym_sched_yield)
  %missing = icmp eq ptr %sym, null
  br i1 %missing, label %enosys, label %call

enosys:
  %eno = call i32 @__mtrt_fail_i32(i32 38)
  ret i32 %eno

call:
  %ret = call i32 %sym()
  %mapped = call i32 @__mtrt_posix_i32(i32 %ret)
  ret i32 %mapped
}

define i32 @setpgid(i32 %pid, i32 %pgid) {
entry:
  %sym = call ptr @__mtrt_host_resolve(ptr @.sym_setpgid)
  %missing = icmp eq ptr %sym, null
  br i1 %missing, label %enosys, label %call

enosys:
  %eno = call i32 @__mtrt_fail_i32(i32 38)
  ret i32 %eno

call:
  %ret = call i32 %sym(i32 %pid, i32 %pgid)
  %mapped = call i32 @__mtrt_posix_i32(i32 %ret)
  ret i32 %mapped
}

define i32 @setsid() {
entry:
  %sym = call ptr @__mtrt_host_resolve(ptr @.sym_setsid)
  %missing = icmp eq ptr %sym, null
  br i1 %missing, label %enosys, label %call

enosys:
  %eno = call i32 @__mtrt_fail_i32(i32 38)
  ret i32 %eno

call:
  %ret = call i32 %sym()
  %mapped = call i32 @__mtrt_posix_i32(i32 %ret)
  ret i32 %mapped
}

define i32 @sigaction(i32 %signum, ptr %act, ptr %oldact) {
entry:
  %sym = call ptr @__mtrt_host_resolve(ptr @.sym_sigaction)
  %missing = icmp eq ptr %sym, null
  br i1 %missing, label %enosys, label %call

enosys:
  %eno = call i32 @__mtrt_fail_i32(i32 38)
  ret i32 %eno

call:
  %ret = call i32 %sym(i32 %signum, ptr %act, ptr %oldact)
  %mapped = call i32 @__mtrt_posix_i32(i32 %ret)
  ret i32 %mapped
}

define i32 @sigaltstack(ptr %ss, ptr %old_ss) {
entry:
  %sym = call ptr @__mtrt_host_resolve(ptr @.sym_sigaltstack)
  %missing = icmp eq ptr %sym, null
  br i1 %missing, label %enosys, label %call

enosys:
  %eno = call i32 @__mtrt_fail_i32(i32 38)
  ret i32 %eno

call:
  %ret = call i32 %sym(ptr %ss, ptr %old_ss)
  %mapped = call i32 @__mtrt_posix_i32(i32 %ret)
  ret i32 %mapped
}

define ptr @signal(i32 %signum, ptr %handler) {
entry:
  %sym = call ptr @__mtrt_host_resolve(ptr @.sym_signal)
  %missing = icmp eq ptr %sym, null
  br i1 %missing, label %enosys, label %call

enosys:
  %eno = call ptr @__mtrt_fail_map_ptr(i32 38)
  ret ptr %eno

call:
  %ret = call ptr %sym(i32 %signum, ptr %handler)
  %mapped = call ptr @__mtrt_signal_ptr(ptr %ret)
  ret ptr %mapped
}

define i32 @sigpending(ptr %set) {
entry:
  %sym = call ptr @__mtrt_host_resolve(ptr @.sym_sigpending)
  %missing = icmp eq ptr %sym, null
  br i1 %missing, label %enosys, label %call

enosys:
  %eno = call i32 @__mtrt_fail_i32(i32 38)
  ret i32 %eno

call:
  %ret = call i32 %sym(ptr %set)
  %mapped = call i32 @__mtrt_posix_i32(i32 %ret)
  ret i32 %mapped
}

define i32 @sigprocmask(i32 %how, ptr %set, ptr %oldset) {
entry:
  %sym = call ptr @__mtrt_host_resolve(ptr @.sym_sigprocmask)
  %missing = icmp eq ptr %sym, null
  br i1 %missing, label %enosys, label %call

enosys:
  %eno = call i32 @__mtrt_fail_i32(i32 38)
  ret i32 %eno

call:
  %ret = call i32 %sym(i32 %how, ptr %set, ptr %oldset)
  %mapped = call i32 @__mtrt_posix_i32(i32 %ret)
  ret i32 %mapped
}

define i32 @sigsuspend(ptr %mask) {
entry:
  %sym = call ptr @__mtrt_host_resolve(ptr @.sym_sigsuspend)
  %missing = icmp eq ptr %sym, null
  br i1 %missing, label %enosys, label %call

enosys:
  %eno = call i32 @__mtrt_fail_i32(i32 38)
  ret i32 %eno

call:
  %ret = call i32 %sym(ptr %mask)
  %mapped = call i32 @__mtrt_posix_i32(i32 %ret)
  ret i32 %mapped
}

define i32 @sigtimedwait(ptr %set, ptr %info, ptr %timeout) {
entry:
  %sym = call ptr @__mtrt_host_resolve(ptr @.sym_sigtimedwait)
  %missing = icmp eq ptr %sym, null
  br i1 %missing, label %enosys, label %call

enosys:
  %eno = call i32 @__mtrt_fail_i32(i32 38)
  ret i32 %eno

call:
  %ret = call i32 %sym(ptr %set, ptr %info, ptr %timeout)
  %mapped = call i32 @__mtrt_posix_i32(i32 %ret)
  ret i32 %mapped
}

define i32 @sigwait(ptr %set, ptr %sig) {
entry:
  %sym = call ptr @__mtrt_host_resolve(ptr @.sym_sigwait)
  %missing = icmp eq ptr %sym, null
  br i1 %missing, label %enosys, label %call

enosys:
  call void @__mtrt_set_errno(i32 38)
  ret i32 38

call:
  %ret = call i32 %sym(ptr %set, ptr %sig)
  %mapped = call i32 @__mtrt_direct_i32(i32 %ret)
  ret i32 %mapped
}

define i32 @sigwaitinfo(ptr %set, ptr %info) {
entry:
  %sym = call ptr @__mtrt_host_resolve(ptr @.sym_sigwaitinfo)
  %missing = icmp eq ptr %sym, null
  br i1 %missing, label %enosys, label %call

enosys:
  %eno = call i32 @__mtrt_fail_i32(i32 38)
  ret i32 %eno

call:
  %ret = call i32 %sym(ptr %set, ptr %info)
  %mapped = call i32 @__mtrt_posix_i32(i32 %ret)
  ret i32 %mapped
}

define i64 @sleep(i64 %seconds) {
entry:
  %req = alloca %struct.timespec, align 8
  %rem = alloca %struct.timespec, align 8
  %req_sec = getelementptr inbounds %struct.timespec, ptr %req, i32 0, i32 0
  %req_nsec = getelementptr inbounds %struct.timespec, ptr %req, i32 0, i32 1
  store i64 %seconds, ptr %req_sec, align 8
  store i64 0, ptr %req_nsec, align 8
  br label %loop

loop:
  %rc = call i32 @nanosleep(ptr %req, ptr %rem)
  %ok = icmp eq i32 %rc, 0
  br i1 %ok, label %done_zero, label %check_intr

check_intr:
  %ep = call ptr @__errno_location()
  %ev = load i32, ptr %ep, align 4
  %is_eintr = icmp eq i32 %ev, 4
  br i1 %is_eintr, label %resume, label %done_orig

resume:
  %rem_sec = getelementptr inbounds %struct.timespec, ptr %rem, i32 0, i32 0
  %rem_nsec = getelementptr inbounds %struct.timespec, ptr %rem, i32 0, i32 1
  %next_sec = load i64, ptr %rem_sec, align 8
  %next_nsec = load i64, ptr %rem_nsec, align 8
  store i64 %next_sec, ptr %req_sec, align 8
  store i64 %next_nsec, ptr %req_nsec, align 8
  br label %loop

done_zero:
  ret i64 0

done_orig:
  ret i64 %seconds
}

define i64 @time(ptr %tloc) {
entry:
  %ts = alloca %struct.timespec, align 8
  %rc = call i32 @clock_gettime(i32 0, ptr %ts)
  %ok = icmp eq i32 %rc, 0
  br i1 %ok, label %extract, label %fail

extract:
  %sp = getelementptr inbounds %struct.timespec, ptr %ts, i32 0, i32 0
  %sec = load i64, ptr %sp, align 8
  %has_tloc = icmp ne ptr %tloc, null
  br i1 %has_tloc, label %store, label %ret

store:
  store i64 %sec, ptr %tloc, align 8
  br label %ret

ret:
  ret i64 %sec

fail:
  ret i64 -1
}

define i64 @usleep(i64 %usec) {
entry:
  %too_large = icmp uge i64 %usec, 1000000
  br i1 %too_large, label %einval, label %do_sleep

einval:
  call void @__mtrt_set_errno(i32 22)
  ret i64 -1

do_sleep:
  %req = alloca %struct.timespec, align 8
  %sp = getelementptr inbounds %struct.timespec, ptr %req, i32 0, i32 0
  %nsp = getelementptr inbounds %struct.timespec, ptr %req, i32 0, i32 1
  %nsec = mul i64 %usec, 1000
  store i64 0, ptr %sp, align 8
  store i64 %nsec, ptr %nsp, align 8
  %rc = call i32 @nanosleep(ptr %req, ptr null)
  %rc64 = sext i32 %rc to i64
  ret i64 %rc64
}

define i32 @stat(ptr %path, ptr %buf) {
entry:
  %sym = call ptr @__mtrt_host_resolve(ptr @.sym_stat)
  %missing = icmp eq ptr %sym, null
  br i1 %missing, label %enosys, label %call

enosys:
  %eno = call i32 @__mtrt_fail_i32(i32 38)
  ret i32 %eno

call:
  %ret = call i32 %sym(ptr %path, ptr %buf)
  %mapped = call i32 @__mtrt_posix_i32(i32 %ret)
  ret i32 %mapped
}

define i64 @strftime(ptr %s, i64 %max, ptr %format, ptr %tm) {
entry:
  %sym = call ptr @__mtrt_host_resolve(ptr @.sym_strftime)
  %missing = icmp eq ptr %sym, null
  br i1 %missing, label %enosys, label %call

enosys:
  %eno = call i64 @__mtrt_fail_i64(i32 38)
  ret i64 %eno

call:
  %ret = call i64 %sym(ptr %s, i64 %max, ptr %format, ptr %tm)
  %mapped = call i64 @__mtrt_posix_i64(i64 %ret)
  ret i64 %mapped
}

define i32 @symlink(ptr %target, ptr %linkpath) {
entry:
  %sym = call ptr @__mtrt_host_resolve(ptr @.sym_symlink)
  %missing = icmp eq ptr %sym, null
  br i1 %missing, label %enosys, label %call

enosys:
  %eno = call i32 @__mtrt_fail_i32(i32 38)
  ret i32 %eno

call:
  %ret = call i32 %sym(ptr %target, ptr %linkpath)
  %mapped = call i32 @__mtrt_posix_i32(i32 %ret)
  ret i32 %mapped
}

define i32 @symlinkat(ptr %target, i32 %newdirfd, ptr %linkpath) {
entry:
  %sym = call ptr @__mtrt_host_resolve(ptr @.sym_symlinkat)
  %missing = icmp eq ptr %sym, null
  br i1 %missing, label %enosys, label %call

enosys:
  %eno = call i32 @__mtrt_fail_i32(i32 38)
  ret i32 %eno

call:
  %ret = call i32 %sym(ptr %target, i32 %newdirfd, ptr %linkpath)
  %mapped = call i32 @__mtrt_posix_i32(i32 %ret)
  ret i32 %mapped
}

define i64 @times(ptr %buf) {
entry:
  %sym = call ptr @__mtrt_host_resolve(ptr @.sym_times)
  %missing = icmp eq ptr %sym, null
  br i1 %missing, label %enosys, label %call

enosys:
  %eno = call i64 @__mtrt_fail_i64(i32 38)
  ret i64 %eno

call:
  %ret = call i64 %sym(ptr %buf)
  %mapped = call i64 @__mtrt_posix_i64(i64 %ret)
  ret i64 %mapped
}

define i32 @umask(i32 %mask) {
entry:
  %sym = call ptr @__mtrt_host_resolve(ptr @.sym_umask)
  %missing = icmp eq ptr %sym, null
  br i1 %missing, label %enosys, label %call

enosys:
  %eno = call i32 @__mtrt_fail_i32(i32 38)
  ret i32 %eno

call:
  %ret = call i32 %sym(i32 %mask)
  %mapped = call i32 @__mtrt_posix_i32(i32 %ret)
  ret i32 %mapped
}

define i32 @unlink(ptr %path) {
entry:
  %sym = call ptr @__mtrt_host_resolve(ptr @.sym_unlink)
  %missing = icmp eq ptr %sym, null
  br i1 %missing, label %enosys, label %call

enosys:
  %eno = call i32 @__mtrt_fail_i32(i32 38)
  ret i32 %eno

call:
  %ret = call i32 %sym(ptr %path)
  %mapped = call i32 @__mtrt_posix_i32(i32 %ret)
  ret i32 %mapped
}

define i32 @unlinkat(i32 %dirfd, ptr %path, i32 %flags) {
entry:
  %sym = call ptr @__mtrt_host_resolve(ptr @.sym_unlinkat)
  %missing = icmp eq ptr %sym, null
  br i1 %missing, label %enosys, label %call

enosys:
  %eno = call i32 @__mtrt_fail_i32(i32 38)
  ret i32 %eno

call:
  %ret = call i32 %sym(i32 %dirfd, ptr %path, i32 %flags)
  %mapped = call i32 @__mtrt_posix_i32(i32 %ret)
  ret i32 %mapped
}

define i32 @brk(ptr %addr) {
entry:
  %sym = call ptr @__mtrt_host_resolve(ptr @.sym_brk)
  %has_brk = icmp ne ptr %sym, null
  br i1 %has_brk, label %call_brk, label %fallback

call_brk:
  %ret = call i32 %sym(ptr %addr)
  %mapped = call i32 @__mtrt_posix_i32(i32 %ret)
  ret i32 %mapped

fallback:
  %sbrk_sym = call ptr @__mtrt_host_resolve(ptr @.sym_sbrk)
  %missing = icmp eq ptr %sbrk_sym, null
  br i1 %missing, label %enosys, label %cur

cur:
  %cur_ptr = call ptr %sbrk_sym(i64 0)
  %cur_ok = call ptr @__mtrt_posix_map_ptr(ptr %cur_ptr)
  %cur_i = ptrtoint ptr %cur_ok to i64
  %bad_cur = icmp eq i64 %cur_i, -1
  br i1 %bad_cur, label %fail, label %delta

delta:
  %want_i = ptrtoint ptr %addr to i64
  %diff = sub i64 %want_i, %cur_i
  %ret_ptr = call ptr %sbrk_sym(i64 %diff)
  %mapped_ptr = call ptr @__mtrt_posix_map_ptr(ptr %ret_ptr)
  %mapped_i = ptrtoint ptr %mapped_ptr to i64
  %is_fail = icmp eq i64 %mapped_i, -1
  br i1 %is_fail, label %fail, label %ok

ok:
  ret i32 0

fail:
  ret i32 -1

enosys:
  %eno = call i32 @__mtrt_fail_i32(i32 38)
  ret i32 %eno
}

define i32 @vfork() {
entry:
  %sym = call ptr @__mtrt_host_resolve(ptr @.sym_vfork)
  %missing = icmp eq ptr %sym, null
  br i1 %missing, label %enosys, label %call

enosys:
  %eno = call i32 @__mtrt_fail_i32(i32 38)
  ret i32 %eno

call:
  %ret = call i32 %sym()
  %mapped = call i32 @__mtrt_posix_i32(i32 %ret)
  ret i32 %mapped
}

define i32 @wait(ptr %status) {
entry:
  %ret = call i32 @waitpid(i32 -1, ptr %status, i32 0)
  ret i32 %ret
}

define i32 @waitpid(i32 %pid, ptr %status, i32 %options) {
entry:
  %sym = call ptr @__mtrt_host_resolve(ptr @.sym_waitpid)
  %missing = icmp eq ptr %sym, null
  br i1 %missing, label %enosys, label %call

enosys:
  %eno = call i32 @__mtrt_fail_i32(i32 38)
  ret i32 %eno

call:
  %ret = call i32 %sym(i32 %pid, ptr %status, i32 %options)
  %mapped = call i32 @__mtrt_posix_i32(i32 %ret)
  ret i32 %mapped
}

define i64 @write(i32 %fd, ptr %buf, i64 %count) {
entry:
  %sym = call ptr @__mtrt_host_resolve(ptr @.sym_write)
  %missing = icmp eq ptr %sym, null
  br i1 %missing, label %enosys, label %call

enosys:
  %eno = call i64 @__mtrt_fail_i64(i32 38)
  ret i64 %eno

call:
  %ret = call i64 %sym(i32 %fd, ptr %buf, i64 %count)
  %mapped = call i64 @__mtrt_posix_i64(i64 %ret)
  ret i64 %mapped
}

define i64 @writev(i32 %fd, ptr %iov, i32 %iovcnt) {
entry:
  %sym = call ptr @__mtrt_host_resolve(ptr @.sym_writev)
  %missing = icmp eq ptr %sym, null
  br i1 %missing, label %enosys, label %call

enosys:
  %eno = call i64 @__mtrt_fail_i64(i32 38)
  ret i64 %eno

call:
  %ret = call i64 %sym(i32 %fd, ptr %iov, i32 %iovcnt)
  %mapped = call i64 @__mtrt_posix_i64(i64 %ret)
  ret i64 %mapped
}
