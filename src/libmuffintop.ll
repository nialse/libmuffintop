; POSIX API surface for libmuffintop.
; Exposes POSIX signatures and translates kernel-style return conventions.
; This file is the single cross-platform POSIX API layer.

target triple = "x86_64-unknown-linux-gnu"

%struct.timespec = type { i64, i64 }

@mtrt_errno = global i32 0, align 4

declare i64 @__mtrt_host_getpid()
declare i64 @__mtrt_host_getppid()
declare i64 @__mtrt_host_fork()
declare i64 @__mtrt_host_wait4(i64, ptr, i64)
declare void @__mtrt_host_exit(i64)
declare i64 @__mtrt_host_write(i64, ptr, i64)
declare i64 @__mtrt_host_read(i64, ptr, i64)
declare i64 @__mtrt_host_close(i64)
declare i64 @__mtrt_host_nanosleep(ptr, ptr)
declare i64 @__mtrt_host_clock_gettime(i64, ptr)
declare i64 @__mtrt_host_kill(i64, i64)

define ptr @__errno_location() {
entry:
  ret ptr @mtrt_errno
}

define internal i64 @__mtrt_raw_to_posix_i64(i64 %raw) {
entry:
  %is_neg = icmp slt i64 %raw, 0
  br i1 %is_neg, label %neg, label %ok

neg:
  %err64 = sub i64 0, %raw
  %err = trunc i64 %err64 to i32
  store i32 %err, ptr @mtrt_errno, align 4
  ret i64 -1

ok:
  ret i64 %raw
}

define internal i32 @__mtrt_raw_to_posix_i32(i64 %raw) {
entry:
  %mapped = call i64 @__mtrt_raw_to_posix_i64(i64 %raw)
  %ret = trunc i64 %mapped to i32
  ret i32 %ret
}

define i32 @getpid() {
entry:
  %raw = call i64 @__mtrt_host_getpid()
  %ret = call i32 @__mtrt_raw_to_posix_i32(i64 %raw)
  ret i32 %ret
}

define i32 @getppid() {
entry:
  %raw = call i64 @__mtrt_host_getppid()
  %ret = call i32 @__mtrt_raw_to_posix_i32(i64 %raw)
  ret i32 %ret
}

define i32 @fork() {
entry:
  %raw = call i64 @__mtrt_host_fork()
  %ret = call i32 @__mtrt_raw_to_posix_i32(i64 %raw)
  ret i32 %ret
}

define i32 @waitpid(i32 %pid, ptr %status, i32 %options) {
entry:
  %pid64 = sext i32 %pid to i64
  %opt64 = sext i32 %options to i64
  %raw = call i64 @__mtrt_host_wait4(i64 %pid64, ptr %status, i64 %opt64)
  %ret = call i32 @__mtrt_raw_to_posix_i32(i64 %raw)
  ret i32 %ret
}

define void @_exit(i32 %status) {
entry:
  %st64 = sext i32 %status to i64
  call void @__mtrt_host_exit(i64 %st64)
  unreachable
}

define i64 @write(i32 %fd, ptr %buf, i64 %count) {
entry:
  %fd64 = sext i32 %fd to i64
  %raw = call i64 @__mtrt_host_write(i64 %fd64, ptr %buf, i64 %count)
  %ret = call i64 @__mtrt_raw_to_posix_i64(i64 %raw)
  ret i64 %ret
}

define i64 @read(i32 %fd, ptr %buf, i64 %count) {
entry:
  %fd64 = sext i32 %fd to i64
  %raw = call i64 @__mtrt_host_read(i64 %fd64, ptr %buf, i64 %count)
  %ret = call i64 @__mtrt_raw_to_posix_i64(i64 %raw)
  ret i64 %ret
}

define i32 @close(i32 %fd) {
entry:
  %fd64 = sext i32 %fd to i64
  %raw = call i64 @__mtrt_host_close(i64 %fd64)
  %ret = call i32 @__mtrt_raw_to_posix_i32(i64 %raw)
  ret i32 %ret
}

define i32 @nanosleep(ptr %req, ptr %rem) {
entry:
  %raw = call i64 @__mtrt_host_nanosleep(ptr %req, ptr %rem)
  %ret = call i32 @__mtrt_raw_to_posix_i32(i64 %raw)
  ret i32 %ret
}

define i32 @clock_gettime(i32 %clockid, ptr %tp) {
entry:
  %cid64 = sext i32 %clockid to i64
  %raw = call i64 @__mtrt_host_clock_gettime(i64 %cid64, ptr %tp)
  %ret = call i32 @__mtrt_raw_to_posix_i32(i64 %raw)
  ret i32 %ret
}

define i32 @kill(i32 %pid, i32 %sig) {
entry:
  %pid64 = sext i32 %pid to i64
  %sig64 = sext i32 %sig to i64
  %raw = call i64 @__mtrt_host_kill(i64 %pid64, i64 %sig64)
  %ret = call i32 @__mtrt_raw_to_posix_i32(i64 %raw)
  ret i32 %ret
}
; Auto-generated POSIX API stubs for symbols not yet host-wired.
define internal i64 @__muffintop_enosys_i64() {
entry:
  store i32 38, ptr @mtrt_errno, align 4
  ret i64 -1
}

define i64 @access(...) {
entry:
  %r = call i64 @__muffintop_enosys_i64()
  ret i64 %r
}

define i64 @alarm(...) {
entry:
  %r = call i64 @__muffintop_enosys_i64()
  ret i64 %r
}

define i64 @brk(...) {
entry:
  %r = call i64 @__muffintop_enosys_i64()
  ret i64 %r
}

define i64 @chdir(...) {
entry:
  %r = call i64 @__muffintop_enosys_i64()
  ret i64 %r
}

define i64 @chmod(...) {
entry:
  %r = call i64 @__muffintop_enosys_i64()
  ret i64 %r
}

define i64 @chown(...) {
entry:
  %r = call i64 @__muffintop_enosys_i64()
  ret i64 %r
}

define i64 @clock_getres(...) {
entry:
  %r = call i64 @__muffintop_enosys_i64()
  ret i64 %r
}

define i64 @clock_settime(...) {
entry:
  %r = call i64 @__muffintop_enosys_i64()
  ret i64 %r
}

define i64 @closedir(...) {
entry:
  %r = call i64 @__muffintop_enosys_i64()
  ret i64 %r
}

define i64 @dup(...) {
entry:
  %r = call i64 @__muffintop_enosys_i64()
  ret i64 %r
}

define i64 @dup2(...) {
entry:
  %r = call i64 @__muffintop_enosys_i64()
  ret i64 %r
}

define i64 @execl(...) {
entry:
  %r = call i64 @__muffintop_enosys_i64()
  ret i64 %r
}

define i64 @execlp(...) {
entry:
  %r = call i64 @__muffintop_enosys_i64()
  ret i64 %r
}

define i64 @execv(...) {
entry:
  %r = call i64 @__muffintop_enosys_i64()
  ret i64 %r
}

define i64 @execve(...) {
entry:
  %r = call i64 @__muffintop_enosys_i64()
  ret i64 %r
}

define i64 @execvp(...) {
entry:
  %r = call i64 @__muffintop_enosys_i64()
  ret i64 %r
}

define void @exit(...) {
entry:
  call void @_exit(i32 38)
  unreachable
}

define i64 @faccessat(...) {
entry:
  %r = call i64 @__muffintop_enosys_i64()
  ret i64 %r
}

define i64 @fchdir(...) {
entry:
  %r = call i64 @__muffintop_enosys_i64()
  ret i64 %r
}

define i64 @fchmod(...) {
entry:
  %r = call i64 @__muffintop_enosys_i64()
  ret i64 %r
}

define i64 @fchmodat(...) {
entry:
  %r = call i64 @__muffintop_enosys_i64()
  ret i64 %r
}

define i64 @fchown(...) {
entry:
  %r = call i64 @__muffintop_enosys_i64()
  ret i64 %r
}

define i64 @fchownat(...) {
entry:
  %r = call i64 @__muffintop_enosys_i64()
  ret i64 %r
}

define i64 @fcntl(...) {
entry:
  %r = call i64 @__muffintop_enosys_i64()
  ret i64 %r
}

define i64 @fdatasync(...) {
entry:
  %r = call i64 @__muffintop_enosys_i64()
  ret i64 %r
}

define i64 @fdopendir(...) {
entry:
  %r = call i64 @__muffintop_enosys_i64()
  ret i64 %r
}

define i64 @fstat(...) {
entry:
  %r = call i64 @__muffintop_enosys_i64()
  ret i64 %r
}

define i64 @fstatat(...) {
entry:
  %r = call i64 @__muffintop_enosys_i64()
  ret i64 %r
}

define i64 @fsync(...) {
entry:
  %r = call i64 @__muffintop_enosys_i64()
  ret i64 %r
}

define i64 @getcwd(...) {
entry:
  %r = call i64 @__muffintop_enosys_i64()
  ret i64 %r
}

define i64 @getpgid(...) {
entry:
  %r = call i64 @__muffintop_enosys_i64()
  ret i64 %r
}

define i64 @getpgrp(...) {
entry:
  %r = call i64 @__muffintop_enosys_i64()
  ret i64 %r
}

define i64 @getsid(...) {
entry:
  %r = call i64 @__muffintop_enosys_i64()
  ret i64 %r
}

define i64 @gettimeofday(...) {
entry:
  %r = call i64 @__muffintop_enosys_i64()
  ret i64 %r
}

define i64 @gmtime_r(...) {
entry:
  %r = call i64 @__muffintop_enosys_i64()
  ret i64 %r
}

define i64 @lchown(...) {
entry:
  %r = call i64 @__muffintop_enosys_i64()
  ret i64 %r
}

define i64 @link(...) {
entry:
  %r = call i64 @__muffintop_enosys_i64()
  ret i64 %r
}

define i64 @linkat(...) {
entry:
  %r = call i64 @__muffintop_enosys_i64()
  ret i64 %r
}

define i64 @localtime_r(...) {
entry:
  %r = call i64 @__muffintop_enosys_i64()
  ret i64 %r
}

define i64 @lseek(...) {
entry:
  %r = call i64 @__muffintop_enosys_i64()
  ret i64 %r
}

define i64 @lstat(...) {
entry:
  %r = call i64 @__muffintop_enosys_i64()
  ret i64 %r
}

define i64 @madvise(...) {
entry:
  %r = call i64 @__muffintop_enosys_i64()
  ret i64 %r
}

define i64 @mkdir(...) {
entry:
  %r = call i64 @__muffintop_enosys_i64()
  ret i64 %r
}

define i64 @mkdirat(...) {
entry:
  %r = call i64 @__muffintop_enosys_i64()
  ret i64 %r
}

define i64 @mkstemp(...) {
entry:
  %r = call i64 @__muffintop_enosys_i64()
  ret i64 %r
}

define i64 @mktime(...) {
entry:
  %r = call i64 @__muffintop_enosys_i64()
  ret i64 %r
}

define i64 @mlock(...) {
entry:
  %r = call i64 @__muffintop_enosys_i64()
  ret i64 %r
}

define i64 @mlockall(...) {
entry:
  %r = call i64 @__muffintop_enosys_i64()
  ret i64 %r
}

define i64 @mmap(...) {
entry:
  %r = call i64 @__muffintop_enosys_i64()
  ret i64 %r
}

define i64 @mprotect(...) {
entry:
  %r = call i64 @__muffintop_enosys_i64()
  ret i64 %r
}

define i64 @msync(...) {
entry:
  %r = call i64 @__muffintop_enosys_i64()
  ret i64 %r
}

define i64 @munlock(...) {
entry:
  %r = call i64 @__muffintop_enosys_i64()
  ret i64 %r
}

define i64 @munlockall(...) {
entry:
  %r = call i64 @__muffintop_enosys_i64()
  ret i64 %r
}

define i64 @munmap(...) {
entry:
  %r = call i64 @__muffintop_enosys_i64()
  ret i64 %r
}

define i64 @open(...) {
entry:
  %r = call i64 @__muffintop_enosys_i64()
  ret i64 %r
}

define i64 @openat(...) {
entry:
  %r = call i64 @__muffintop_enosys_i64()
  ret i64 %r
}

define i64 @opendir(...) {
entry:
  %r = call i64 @__muffintop_enosys_i64()
  ret i64 %r
}

define i64 @pause(...) {
entry:
  %r = call i64 @__muffintop_enosys_i64()
  ret i64 %r
}

define i64 @pipe(...) {
entry:
  %r = call i64 @__muffintop_enosys_i64()
  ret i64 %r
}

define i64 @pipe2(...) {
entry:
  %r = call i64 @__muffintop_enosys_i64()
  ret i64 %r
}

define i64 @posix_memalign(...) {
entry:
  %r = call i64 @__muffintop_enosys_i64()
  ret i64 %r
}

define i64 @pread(...) {
entry:
  %r = call i64 @__muffintop_enosys_i64()
  ret i64 %r
}

define i64 @pthread_atfork(...) {
entry:
  %r = call i64 @__muffintop_enosys_i64()
  ret i64 %r
}

define i64 @pthread_barrier_family(...) {
entry:
  %r = call i64 @__muffintop_enosys_i64()
  ret i64 %r
}

define i64 @pthread_cond_family(...) {
entry:
  %r = call i64 @__muffintop_enosys_i64()
  ret i64 %r
}

define i64 @pthread_create(...) {
entry:
  %r = call i64 @__muffintop_enosys_i64()
  ret i64 %r
}

define i64 @pthread_detach(...) {
entry:
  %r = call i64 @__muffintop_enosys_i64()
  ret i64 %r
}

define void @pthread_exit(...) {
entry:
  call void @_exit(i32 38)
  unreachable
}

define i64 @pthread_getspecific(...) {
entry:
  %r = call i64 @__muffintop_enosys_i64()
  ret i64 %r
}

define i64 @pthread_join(...) {
entry:
  %r = call i64 @__muffintop_enosys_i64()
  ret i64 %r
}

define i64 @pthread_key_create(...) {
entry:
  %r = call i64 @__muffintop_enosys_i64()
  ret i64 %r
}

define i64 @pthread_key_delete(...) {
entry:
  %r = call i64 @__muffintop_enosys_i64()
  ret i64 %r
}

define i64 @pthread_kill(...) {
entry:
  %r = call i64 @__muffintop_enosys_i64()
  ret i64 %r
}

define i64 @pthread_mutex_family(...) {
entry:
  %r = call i64 @__muffintop_enosys_i64()
  ret i64 %r
}

define i64 @pthread_once(...) {
entry:
  %r = call i64 @__muffintop_enosys_i64()
  ret i64 %r
}

define i64 @pthread_rwlock_family(...) {
entry:
  %r = call i64 @__muffintop_enosys_i64()
  ret i64 %r
}

define i64 @pthread_self(...) {
entry:
  %r = call i64 @__muffintop_enosys_i64()
  ret i64 %r
}

define i64 @pthread_setspecific(...) {
entry:
  %r = call i64 @__muffintop_enosys_i64()
  ret i64 %r
}

define i64 @pthread_sigmask(...) {
entry:
  %r = call i64 @__muffintop_enosys_i64()
  ret i64 %r
}

define i64 @pthread_spin_family(...) {
entry:
  %r = call i64 @__muffintop_enosys_i64()
  ret i64 %r
}

define i64 @pwrite(...) {
entry:
  %r = call i64 @__muffintop_enosys_i64()
  ret i64 %r
}

define i64 @raise(...) {
entry:
  %r = call i64 @__muffintop_enosys_i64()
  ret i64 %r
}

define i64 @readdir(...) {
entry:
  %r = call i64 @__muffintop_enosys_i64()
  ret i64 %r
}

define i64 @readlink(...) {
entry:
  %r = call i64 @__muffintop_enosys_i64()
  ret i64 %r
}

define i64 @readlinkat(...) {
entry:
  %r = call i64 @__muffintop_enosys_i64()
  ret i64 %r
}

define i64 @readv(...) {
entry:
  %r = call i64 @__muffintop_enosys_i64()
  ret i64 %r
}

define i64 @rename(...) {
entry:
  %r = call i64 @__muffintop_enosys_i64()
  ret i64 %r
}

define i64 @renameat(...) {
entry:
  %r = call i64 @__muffintop_enosys_i64()
  ret i64 %r
}

define i64 @rewinddir(...) {
entry:
  %r = call i64 @__muffintop_enosys_i64()
  ret i64 %r
}

define i64 @rmdir(...) {
entry:
  %r = call i64 @__muffintop_enosys_i64()
  ret i64 %r
}

define i64 @sbrk(...) {
entry:
  %r = call i64 @__muffintop_enosys_i64()
  ret i64 %r
}

define i64 @sched_yield(...) {
entry:
  %r = call i64 @__muffintop_enosys_i64()
  ret i64 %r
}

define i64 @setpgid(...) {
entry:
  %r = call i64 @__muffintop_enosys_i64()
  ret i64 %r
}

define i64 @setsid(...) {
entry:
  %r = call i64 @__muffintop_enosys_i64()
  ret i64 %r
}

define i64 @sigaction(...) {
entry:
  %r = call i64 @__muffintop_enosys_i64()
  ret i64 %r
}

define i64 @sigaltstack(...) {
entry:
  %r = call i64 @__muffintop_enosys_i64()
  ret i64 %r
}

define i64 @signal(...) {
entry:
  %r = call i64 @__muffintop_enosys_i64()
  ret i64 %r
}

define i64 @sigpending(...) {
entry:
  %r = call i64 @__muffintop_enosys_i64()
  ret i64 %r
}

define i64 @sigprocmask(...) {
entry:
  %r = call i64 @__muffintop_enosys_i64()
  ret i64 %r
}

define i64 @sigsuspend(...) {
entry:
  %r = call i64 @__muffintop_enosys_i64()
  ret i64 %r
}

define i64 @sigtimedwait(...) {
entry:
  %r = call i64 @__muffintop_enosys_i64()
  ret i64 %r
}

define i64 @sigwait(...) {
entry:
  %r = call i64 @__muffintop_enosys_i64()
  ret i64 %r
}

define i64 @sigwaitinfo(...) {
entry:
  %r = call i64 @__muffintop_enosys_i64()
  ret i64 %r
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
  br i1 %is_eintr, label %continue, label %done_orig

continue:
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

define i64 @stat(...) {
entry:
  %r = call i64 @__muffintop_enosys_i64()
  ret i64 %r
}

define i64 @strftime(...) {
entry:
  %r = call i64 @__muffintop_enosys_i64()
  ret i64 %r
}

define i64 @symlink(...) {
entry:
  %r = call i64 @__muffintop_enosys_i64()
  ret i64 %r
}

define i64 @symlinkat(...) {
entry:
  %r = call i64 @__muffintop_enosys_i64()
  ret i64 %r
}

define i64 @time(ptr %tloc) {
entry:
  %ts = alloca %struct.timespec, align 8
  %rc = call i32 @clock_gettime(i32 0, ptr %ts)
  %ok = icmp eq i32 %rc, 0
  br i1 %ok, label %extract, label %fail

extract:
  %secp = getelementptr inbounds %struct.timespec, ptr %ts, i32 0, i32 0
  %sec = load i64, ptr %secp, align 8
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

define i64 @times(...) {
entry:
  %r = call i64 @__muffintop_enosys_i64()
  ret i64 %r
}

define i64 @umask(...) {
entry:
  %r = call i64 @__muffintop_enosys_i64()
  ret i64 %r
}

define i64 @unlink(...) {
entry:
  %r = call i64 @__muffintop_enosys_i64()
  ret i64 %r
}

define i64 @unlinkat(...) {
entry:
  %r = call i64 @__muffintop_enosys_i64()
  ret i64 %r
}

define i64 @usleep(i64 %usec) {
entry:
  %too_large = icmp uge i64 %usec, 1000000
  br i1 %too_large, label %einval, label %do_sleep

einval:
  store i32 22, ptr @mtrt_errno, align 4
  ret i64 -1

do_sleep:
  %req = alloca %struct.timespec, align 8
  %secp = getelementptr inbounds %struct.timespec, ptr %req, i32 0, i32 0
  %nsecp = getelementptr inbounds %struct.timespec, ptr %req, i32 0, i32 1
  %nsec = mul i64 %usec, 1000
  store i64 0, ptr %secp, align 8
  store i64 %nsec, ptr %nsecp, align 8
  %rc = call i32 @nanosleep(ptr %req, ptr null)
  %ret = sext i32 %rc to i64
  ret i64 %ret
}

define i64 @vfork(...) {
entry:
  %r = call i64 @__muffintop_enosys_i64()
  ret i64 %r
}

define i64 @wait(...) {
entry:
  %r = call i64 @__muffintop_enosys_i64()
  ret i64 %r
}

define i64 @writev(...) {
entry:
  %r = call i64 @__muffintop_enosys_i64()
  ret i64 %r
}
