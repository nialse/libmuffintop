; libmuffintop public LLVM IR ABI surface.
; Public names are POSIX-derived, but the target ABI is not the C POSIX ABI.
; Target-aligned primitives return negative POSIX errno values directly.

target triple = "x86_64-unknown-linux-gnu"

%struct.timespec = type { i64, i64 }
%struct.mtrt_stat64 = type { i64, i64, i64, i32, i32, i32, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64 }

; Current compatibility scaffold only. Target ABI returns negative errno values.
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
declare i64 @__mtrt_host_dup(i64)
declare i64 @__mtrt_host_dup2(i64, i64)
declare i64 @__mtrt_host_chdir(ptr)
declare i64 @__mtrt_host_fchdir(i64)
declare i64 @__mtrt_host_getpgid(i64)
declare i64 @__mtrt_host_getpgrp()
declare i64 @__mtrt_host_getsid(i64)
declare i64 @__mtrt_host_setpgid(i64, i64)
declare i64 @__mtrt_host_setsid()
declare i64 @__mtrt_host_umask(i64)
declare i64 @__mtrt_host_pipe(ptr)
declare i64 @__mtrt_host_readv(i64, ptr, i64)
declare i64 @__mtrt_host_writev(i64, ptr, i64)
declare i64 @__mtrt_host_open(ptr, i64, i64)
declare i64 @__mtrt_host_openat(i64, ptr, i64, i64)
declare i64 @__mtrt_host_lseek(i64, i64, i64)
declare i64 @__mtrt_host_pread(i64, ptr, i64, i64)
declare i64 @__mtrt_host_pwrite(i64, ptr, i64, i64)
declare i64 @__mtrt_host_unlink(ptr)
declare i64 @__mtrt_host_unlinkat(i64, ptr, i64)
declare i64 @__mtrt_host_access(ptr, i64)
declare i64 @__mtrt_host_faccessat(i64, ptr, i64, i64)
declare i64 @__mtrt_host_chmod(ptr, i64)
declare i64 @__mtrt_host_fchmod(i64, i64)
declare i64 @__mtrt_host_fchmodat(i64, ptr, i64, i64)
declare i64 @__mtrt_host_link(ptr, ptr)
declare i64 @__mtrt_host_linkat(i64, ptr, i64, ptr, i64)
declare i64 @__mtrt_host_mkdir(ptr, i64)
declare i64 @__mtrt_host_mkdirat(i64, ptr, i64)
declare i64 @__mtrt_host_readlink(ptr, ptr, i64)
declare i64 @__mtrt_host_readlinkat(i64, ptr, ptr, i64)
declare i64 @__mtrt_host_rename(ptr, ptr)
declare i64 @__mtrt_host_renameat(i64, ptr, i64, ptr)
declare i64 @__mtrt_host_rmdir(ptr)
declare i64 @__mtrt_host_symlink(ptr, ptr)
declare i64 @__mtrt_host_symlinkat(ptr, i64, ptr)
declare i64 @__mtrt_host_stat(ptr, ptr)
declare i64 @__mtrt_host_fstat(i64, ptr)
declare i64 @__mtrt_host_lstat(ptr, ptr)
declare i64 @__mtrt_host_fstatat(i64, ptr, ptr, i64)

define ptr @__errno_location() {
entry:
  ret ptr @mtrt_errno
}

define i32 @getpid() {
entry:
  %raw = call i64 @__mtrt_host_getpid()
  %ret = trunc i64 %raw to i32
  ret i32 %ret
}

define i32 @getppid() {
entry:
  %raw = call i64 @__mtrt_host_getppid()
  %ret = trunc i64 %raw to i32
  ret i32 %ret
}

define i32 @fork() {
entry:
  %raw = call i64 @__mtrt_host_fork()
  %ret = trunc i64 %raw to i32
  ret i32 %ret
}

define i32 @waitpid(i32 %pid, ptr %status, i32 %options) {
entry:
  %pid64 = sext i32 %pid to i64
  %opt64 = sext i32 %options to i64
  %raw = call i64 @__mtrt_host_wait4(i64 %pid64, ptr %status, i64 %opt64)
  %ret = trunc i64 %raw to i32
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
  ret i64 %raw
}

define i64 @read(i32 %fd, ptr %buf, i64 %count) {
entry:
  %fd64 = sext i32 %fd to i64
  %raw = call i64 @__mtrt_host_read(i64 %fd64, ptr %buf, i64 %count)
  ret i64 %raw
}

define i32 @close(i32 %fd) {
entry:
  %fd64 = sext i32 %fd to i64
  %raw = call i64 @__mtrt_host_close(i64 %fd64)
  %ret = trunc i64 %raw to i32
  ret i32 %ret
}

define i32 @nanosleep(ptr %req, ptr %rem) {
entry:
  %raw = call i64 @__mtrt_host_nanosleep(ptr %req, ptr %rem)
  %ret = trunc i64 %raw to i32
  ret i32 %ret
}

define i32 @clock_gettime(i32 %clockid, ptr %tp) {
entry:
  %cid64 = sext i32 %clockid to i64
  %raw = call i64 @__mtrt_host_clock_gettime(i64 %cid64, ptr %tp)
  %ret = trunc i64 %raw to i32
  ret i32 %ret
}

define i32 @kill(i32 %pid, i32 %sig) {
entry:
  %pid64 = sext i32 %pid to i64
  %sig64 = sext i32 %sig to i64
  %raw = call i64 @__mtrt_host_kill(i64 %pid64, i64 %sig64)
  %ret = trunc i64 %raw to i32
  ret i32 %ret
}

define i32 @dup(i32 %oldfd) {
entry:
  %oldfd64 = sext i32 %oldfd to i64
  %raw = call i64 @__mtrt_host_dup(i64 %oldfd64)
  %ret = trunc i64 %raw to i32
  ret i32 %ret
}

define i32 @dup2(i32 %oldfd, i32 %newfd) {
entry:
  %oldfd64 = sext i32 %oldfd to i64
  %newfd64 = sext i32 %newfd to i64
  %raw = call i64 @__mtrt_host_dup2(i64 %oldfd64, i64 %newfd64)
  %ret = trunc i64 %raw to i32
  ret i32 %ret
}

define i32 @chdir(ptr %path) {
entry:
  %raw = call i64 @__mtrt_host_chdir(ptr %path)
  %ret = trunc i64 %raw to i32
  ret i32 %ret
}

define i32 @fchdir(i32 %fd) {
entry:
  %fd64 = sext i32 %fd to i64
  %raw = call i64 @__mtrt_host_fchdir(i64 %fd64)
  %ret = trunc i64 %raw to i32
  ret i32 %ret
}

define i32 @getpgid(i32 %pid) {
entry:
  %pid64 = sext i32 %pid to i64
  %raw = call i64 @__mtrt_host_getpgid(i64 %pid64)
  %ret = trunc i64 %raw to i32
  ret i32 %ret
}

define i32 @getpgrp() {
entry:
  %raw = call i64 @__mtrt_host_getpgrp()
  %ret = trunc i64 %raw to i32
  ret i32 %ret
}

define i32 @getsid(i32 %pid) {
entry:
  %pid64 = sext i32 %pid to i64
  %raw = call i64 @__mtrt_host_getsid(i64 %pid64)
  %ret = trunc i64 %raw to i32
  ret i32 %ret
}

define i32 @setpgid(i32 %pid, i32 %pgid) {
entry:
  %pid64 = sext i32 %pid to i64
  %pgid64 = sext i32 %pgid to i64
  %raw = call i64 @__mtrt_host_setpgid(i64 %pid64, i64 %pgid64)
  %ret = trunc i64 %raw to i32
  ret i32 %ret
}

define i32 @setsid() {
entry:
  %raw = call i64 @__mtrt_host_setsid()
  %ret = trunc i64 %raw to i32
  ret i32 %ret
}

define i32 @umask(i32 %mask) {
entry:
  %mask64 = sext i32 %mask to i64
  %raw = call i64 @__mtrt_host_umask(i64 %mask64)
  %ret = trunc i64 %raw to i32
  ret i32 %ret
}

define i32 @pipe(ptr %fds) {
entry:
  %raw = call i64 @__mtrt_host_pipe(ptr %fds)
  %ret = trunc i64 %raw to i32
  ret i32 %ret
}

define i64 @readv(i32 %fd, ptr %iov, i32 %iovcnt) {
entry:
  %fd64 = sext i32 %fd to i64
  %iovcnt64 = sext i32 %iovcnt to i64
  %raw = call i64 @__mtrt_host_readv(i64 %fd64, ptr %iov, i64 %iovcnt64)
  ret i64 %raw
}

define i64 @writev(i32 %fd, ptr %iov, i32 %iovcnt) {
entry:
  %fd64 = sext i32 %fd to i64
  %iovcnt64 = sext i32 %iovcnt to i64
  %raw = call i64 @__mtrt_host_writev(i64 %fd64, ptr %iov, i64 %iovcnt64)
  ret i64 %raw
}

define i32 @open(ptr %path, i32 %flags, i32 %mode) {
entry:
  %flags64 = sext i32 %flags to i64
  %mode64 = sext i32 %mode to i64
  %raw = call i64 @__mtrt_host_open(ptr %path, i64 %flags64, i64 %mode64)
  %ret = trunc i64 %raw to i32
  ret i32 %ret
}

define i32 @openat(i32 %dirfd, ptr %path, i32 %flags, i32 %mode) {
entry:
  %dirfd64 = sext i32 %dirfd to i64
  %flags64 = sext i32 %flags to i64
  %mode64 = sext i32 %mode to i64
  %raw = call i64 @__mtrt_host_openat(i64 %dirfd64, ptr %path, i64 %flags64, i64 %mode64)
  %ret = trunc i64 %raw to i32
  ret i32 %ret
}

define i64 @lseek(i32 %fd, i64 %offset, i32 %whence) {
entry:
  %fd64 = sext i32 %fd to i64
  %whence64 = sext i32 %whence to i64
  %raw = call i64 @__mtrt_host_lseek(i64 %fd64, i64 %offset, i64 %whence64)
  ret i64 %raw
}

define i64 @pread(i32 %fd, ptr %buf, i64 %count, i64 %offset) {
entry:
  %fd64 = sext i32 %fd to i64
  %raw = call i64 @__mtrt_host_pread(i64 %fd64, ptr %buf, i64 %count, i64 %offset)
  ret i64 %raw
}

define i64 @pwrite(i32 %fd, ptr %buf, i64 %count, i64 %offset) {
entry:
  %fd64 = sext i32 %fd to i64
  %raw = call i64 @__mtrt_host_pwrite(i64 %fd64, ptr %buf, i64 %count, i64 %offset)
  ret i64 %raw
}

define i32 @unlink(ptr %path) {
entry:
  %raw = call i64 @__mtrt_host_unlink(ptr %path)
  %ret = trunc i64 %raw to i32
  ret i32 %ret
}

define i32 @unlinkat(i32 %dirfd, ptr %path, i32 %flags) {
entry:
  %dirfd64 = sext i32 %dirfd to i64
  %flags64 = sext i32 %flags to i64
  %raw = call i64 @__mtrt_host_unlinkat(i64 %dirfd64, ptr %path, i64 %flags64)
  %ret = trunc i64 %raw to i32
  ret i32 %ret
}

define i32 @access(ptr %path, i32 %mode) {
entry:
  %mode64 = sext i32 %mode to i64
  %raw = call i64 @__mtrt_host_access(ptr %path, i64 %mode64)
  %ret = trunc i64 %raw to i32
  ret i32 %ret
}

define i32 @faccessat(i32 %dirfd, ptr %path, i32 %mode, i32 %flags) {
entry:
  %dirfd64 = sext i32 %dirfd to i64
  %mode64 = sext i32 %mode to i64
  %flags64 = sext i32 %flags to i64
  %raw = call i64 @__mtrt_host_faccessat(i64 %dirfd64, ptr %path, i64 %mode64, i64 %flags64)
  %ret = trunc i64 %raw to i32
  ret i32 %ret
}

define i32 @chmod(ptr %path, i32 %mode) {
entry:
  %mode64 = sext i32 %mode to i64
  %raw = call i64 @__mtrt_host_chmod(ptr %path, i64 %mode64)
  %ret = trunc i64 %raw to i32
  ret i32 %ret
}

define i32 @fchmod(i32 %fd, i32 %mode) {
entry:
  %fd64 = sext i32 %fd to i64
  %mode64 = sext i32 %mode to i64
  %raw = call i64 @__mtrt_host_fchmod(i64 %fd64, i64 %mode64)
  %ret = trunc i64 %raw to i32
  ret i32 %ret
}

define i32 @fchmodat(i32 %dirfd, ptr %path, i32 %mode, i32 %flags) {
entry:
  %dirfd64 = sext i32 %dirfd to i64
  %mode64 = sext i32 %mode to i64
  %flags64 = sext i32 %flags to i64
  %raw = call i64 @__mtrt_host_fchmodat(i64 %dirfd64, ptr %path, i64 %mode64, i64 %flags64)
  %ret = trunc i64 %raw to i32
  ret i32 %ret
}
; Current ENOSYS stubs for exported symbols not yet classified or host-wired.
define internal i64 @__muffintop_enosys_i64() {
entry:
  store i32 38, ptr @mtrt_errno, align 4
  ret i64 -1
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

define void @exit(i32 %status) {
entry:
  call void @_exit(i32 %status)
  unreachable
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

define i32 @fstat(i32 %fd, ptr %buf) {
entry:
  %fd64 = sext i32 %fd to i64
  %raw = call i64 @__mtrt_host_fstat(i64 %fd64, ptr %buf)
  %ret = trunc i64 %raw to i32
  ret i32 %ret
}

define i32 @fstatat(i32 %dirfd, ptr %path, ptr %buf, i32 %flags) {
entry:
  %dirfd64 = sext i32 %dirfd to i64
  %flags64 = sext i32 %flags to i64
  %raw = call i64 @__mtrt_host_fstatat(i64 %dirfd64, ptr %path, ptr %buf, i64 %flags64)
  %ret = trunc i64 %raw to i32
  ret i32 %ret
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

define i32 @link(ptr %oldpath, ptr %newpath) {
entry:
  %raw = call i64 @__mtrt_host_link(ptr %oldpath, ptr %newpath)
  %ret = trunc i64 %raw to i32
  ret i32 %ret
}

define i32 @linkat(i32 %olddirfd, ptr %oldpath, i32 %newdirfd, ptr %newpath, i32 %flags) {
entry:
  %olddirfd64 = sext i32 %olddirfd to i64
  %newdirfd64 = sext i32 %newdirfd to i64
  %flags64 = sext i32 %flags to i64
  %raw = call i64 @__mtrt_host_linkat(i64 %olddirfd64, ptr %oldpath, i64 %newdirfd64, ptr %newpath, i64 %flags64)
  %ret = trunc i64 %raw to i32
  ret i32 %ret
}

define i64 @localtime_r(...) {
entry:
  %r = call i64 @__muffintop_enosys_i64()
  ret i64 %r
}

define i32 @lstat(ptr %path, ptr %buf) {
entry:
  %raw = call i64 @__mtrt_host_lstat(ptr %path, ptr %buf)
  %ret = trunc i64 %raw to i32
  ret i32 %ret
}

define i64 @madvise(...) {
entry:
  %r = call i64 @__muffintop_enosys_i64()
  ret i64 %r
}

define i32 @mkdir(ptr %path, i32 %mode) {
entry:
  %mode64 = sext i32 %mode to i64
  %raw = call i64 @__mtrt_host_mkdir(ptr %path, i64 %mode64)
  %ret = trunc i64 %raw to i32
  ret i32 %ret
}

define i32 @mkdirat(i32 %dirfd, ptr %path, i32 %mode) {
entry:
  %dirfd64 = sext i32 %dirfd to i64
  %mode64 = sext i32 %mode to i64
  %raw = call i64 @__mtrt_host_mkdirat(i64 %dirfd64, ptr %path, i64 %mode64)
  %ret = trunc i64 %raw to i32
  ret i32 %ret
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

define i64 @readlink(ptr %path, ptr %buf, i64 %size) {
entry:
  %raw = call i64 @__mtrt_host_readlink(ptr %path, ptr %buf, i64 %size)
  ret i64 %raw
}

define i64 @readlinkat(i32 %dirfd, ptr %path, ptr %buf, i64 %size) {
entry:
  %dirfd64 = sext i32 %dirfd to i64
  %raw = call i64 @__mtrt_host_readlinkat(i64 %dirfd64, ptr %path, ptr %buf, i64 %size)
  ret i64 %raw
}

define i32 @rename(ptr %oldpath, ptr %newpath) {
entry:
  %raw = call i64 @__mtrt_host_rename(ptr %oldpath, ptr %newpath)
  %ret = trunc i64 %raw to i32
  ret i32 %ret
}

define i32 @renameat(i32 %olddirfd, ptr %oldpath, i32 %newdirfd, ptr %newpath) {
entry:
  %olddirfd64 = sext i32 %olddirfd to i64
  %newdirfd64 = sext i32 %newdirfd to i64
  %raw = call i64 @__mtrt_host_renameat(i64 %olddirfd64, ptr %oldpath, i64 %newdirfd64, ptr %newpath)
  %ret = trunc i64 %raw to i32
  ret i32 %ret
}

define i64 @rewinddir(...) {
entry:
  %r = call i64 @__muffintop_enosys_i64()
  ret i64 %r
}

define i32 @rmdir(ptr %path) {
entry:
  %raw = call i64 @__mtrt_host_rmdir(ptr %path)
  %ret = trunc i64 %raw to i32
  ret i32 %ret
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
  %is_eintr = icmp eq i32 %rc, -4
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

define i32 @stat(ptr %path, ptr %buf) {
entry:
  %raw = call i64 @__mtrt_host_stat(ptr %path, ptr %buf)
  %ret = trunc i64 %raw to i32
  ret i32 %ret
}

define i64 @strftime(...) {
entry:
  %r = call i64 @__muffintop_enosys_i64()
  ret i64 %r
}

define i32 @symlink(ptr %target, ptr %linkpath) {
entry:
  %raw = call i64 @__mtrt_host_symlink(ptr %target, ptr %linkpath)
  %ret = trunc i64 %raw to i32
  ret i32 %ret
}

define i32 @symlinkat(ptr %target, i32 %newdirfd, ptr %linkpath) {
entry:
  %newdirfd64 = sext i32 %newdirfd to i64
  %raw = call i64 @__mtrt_host_symlinkat(ptr %target, i64 %newdirfd64, ptr %linkpath)
  %ret = trunc i64 %raw to i32
  ret i32 %ret
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
  %err = sext i32 %rc to i64
  ret i64 %err
}

define i64 @times(...) {
entry:
  %r = call i64 @__muffintop_enosys_i64()
  ret i64 %r
}

define i64 @usleep(i64 %usec) {
entry:
  %too_large = icmp uge i64 %usec, 1000000
  br i1 %too_large, label %einval, label %do_sleep

einval:
  ret i64 -22

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
