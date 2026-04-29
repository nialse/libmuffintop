; libmuffintop public LLVM IR ABI surface.
; Public names are POSIX-derived, but the target ABI is not the C POSIX ABI.
; Target-aligned primitives return negative POSIX errno values directly.

target triple = "x86_64-unknown-linux-gnu"

%struct.timespec = type { i64, i64 }
%struct.mtrt_stat64 = type { i64, i64, i64, i32, i32, i32, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64 }

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
declare i64 @__mtrt_host_posix_getdents(i64, ptr, i64, i64)
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
declare i64 @__mtrt_host_chown(ptr, i64, i64)
declare i64 @__mtrt_host_clock_getres(i64, ptr)
declare i64 @__mtrt_host_clock_settime(i64, ptr)
declare i64 @__mtrt_host_execve(ptr, ptr, ptr)
declare i64 @__mtrt_host_fchown(i64, i64, i64)
declare i64 @__mtrt_host_fchownat(i64, ptr, i64, i64, i64)
declare i64 @__mtrt_host_fcntl(i64, i64, i64)
declare i64 @__mtrt_host_fdatasync(i64)
declare i64 @__mtrt_host_fsync(i64)
declare i64 @__mtrt_host_getcwd(ptr, i64)
declare i64 @__mtrt_host_lchown(ptr, i64, i64)
declare i64 @__mtrt_host_madvise(i64, i64, i64)
declare i64 @__mtrt_host_mlock(i64, i64)
declare i64 @__mtrt_host_mlockall(i64)
declare i64 @__mtrt_host_mmap(i64, i64, i64, i64, i64, i64)
declare i64 @__mtrt_host_mprotect(i64, i64, i64)
declare i64 @__mtrt_host_msync(i64, i64, i64)
declare i64 @__mtrt_host_munlock(i64, i64)
declare i64 @__mtrt_host_munlockall()
declare i64 @__mtrt_host_munmap(i64, i64)
declare i64 @__mtrt_host_pause()
declare i64 @__mtrt_host_pipe2(ptr, i64)
declare i64 @__mtrt_host_sched_yield()
declare i64 @__mtrt_host_sigaction(i64, ptr, ptr)
declare i64 @__mtrt_host_sigaltstack(ptr, ptr)
declare i64 @__mtrt_host_sigpending(ptr)
declare i64 @__mtrt_host_sigprocmask(i64, ptr, ptr)
declare i64 @__mtrt_host_sigsuspend(ptr)
declare i64 @__mtrt_host_sigtimedwait(ptr, ptr, ptr)
declare i64 @__mtrt_host_sigwaitinfo(ptr, ptr)
declare i64 @__mtrt_host_times(ptr)

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

define i64 @posix_getdents(i32 %fd, ptr %buf, i64 %nbyte, i32 %flags) {
entry:
  %fd64 = sext i32 %fd to i64
  %flags64 = sext i32 %flags to i64
  %raw = call i64 @__mtrt_host_posix_getdents(i64 %fd64, ptr %buf, i64 %nbyte, i64 %flags64)
  ret i64 %raw
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

define i32 @chown(ptr %path, i32 %uid, i32 %gid) {
entry:
  %uid64 = sext i32 %uid to i64
  %gid64 = sext i32 %gid to i64
  %raw = call i64 @__mtrt_host_chown(ptr %path, i64 %uid64, i64 %gid64)
  %ret = trunc i64 %raw to i32
  ret i32 %ret
}

define i32 @clock_getres(i32 %clockid, ptr %tp) {
entry:
  %clockid64 = sext i32 %clockid to i64
  %raw = call i64 @__mtrt_host_clock_getres(i64 %clockid64, ptr %tp)
  %ret = trunc i64 %raw to i32
  ret i32 %ret
}

define i32 @clock_settime(i32 %clockid, ptr %tp) {
entry:
  %clockid64 = sext i32 %clockid to i64
  %raw = call i64 @__mtrt_host_clock_settime(i64 %clockid64, ptr %tp)
  %ret = trunc i64 %raw to i32
  ret i32 %ret
}

define i32 @execve(ptr %path, ptr %argv, ptr %envp) {
entry:
  %raw = call i64 @__mtrt_host_execve(ptr %path, ptr %argv, ptr %envp)
  %ret = trunc i64 %raw to i32
  ret i32 %ret
}

define i32 @fchown(i32 %fd, i32 %uid, i32 %gid) {
entry:
  %fd64 = sext i32 %fd to i64
  %uid64 = sext i32 %uid to i64
  %gid64 = sext i32 %gid to i64
  %raw = call i64 @__mtrt_host_fchown(i64 %fd64, i64 %uid64, i64 %gid64)
  %ret = trunc i64 %raw to i32
  ret i32 %ret
}

define i32 @fchownat(i32 %dirfd, ptr %path, i32 %uid, i32 %gid, i32 %flags) {
entry:
  %dirfd64 = sext i32 %dirfd to i64
  %uid64 = sext i32 %uid to i64
  %gid64 = sext i32 %gid to i64
  %flags64 = sext i32 %flags to i64
  %raw = call i64 @__mtrt_host_fchownat(i64 %dirfd64, ptr %path, i64 %uid64, i64 %gid64, i64 %flags64)
  %ret = trunc i64 %raw to i32
  ret i32 %ret
}

define i64 @fcntl(i32 %fd, i32 %cmd, i64 %arg) {
entry:
  %fd64 = sext i32 %fd to i64
  %cmd64 = sext i32 %cmd to i64
  %raw = call i64 @__mtrt_host_fcntl(i64 %fd64, i64 %cmd64, i64 %arg)
  ret i64 %raw
}

define i32 @fdatasync(i32 %fd) {
entry:
  %fd64 = sext i32 %fd to i64
  %raw = call i64 @__mtrt_host_fdatasync(i64 %fd64)
  %ret = trunc i64 %raw to i32
  ret i32 %ret
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

define i32 @fsync(i32 %fd) {
entry:
  %fd64 = sext i32 %fd to i64
  %raw = call i64 @__mtrt_host_fsync(i64 %fd64)
  %ret = trunc i64 %raw to i32
  ret i32 %ret
}

define i64 @getcwd(ptr %buf, i64 %size) {
entry:
  %raw = call i64 @__mtrt_host_getcwd(ptr %buf, i64 %size)
  ret i64 %raw
}

define i32 @lchown(ptr %path, i32 %uid, i32 %gid) {
entry:
  %uid64 = sext i32 %uid to i64
  %gid64 = sext i32 %gid to i64
  %raw = call i64 @__mtrt_host_lchown(ptr %path, i64 %uid64, i64 %gid64)
  %ret = trunc i64 %raw to i32
  ret i32 %ret
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

define i32 @lstat(ptr %path, ptr %buf) {
entry:
  %raw = call i64 @__mtrt_host_lstat(ptr %path, ptr %buf)
  %ret = trunc i64 %raw to i32
  ret i32 %ret
}

define i32 @madvise(i64 %addr, i64 %length, i32 %advice) {
entry:
  %advice64 = sext i32 %advice to i64
  %raw = call i64 @__mtrt_host_madvise(i64 %addr, i64 %length, i64 %advice64)
  %ret = trunc i64 %raw to i32
  ret i32 %ret
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

define i32 @mlock(i64 %addr, i64 %length) {
entry:
  %raw = call i64 @__mtrt_host_mlock(i64 %addr, i64 %length)
  %ret = trunc i64 %raw to i32
  ret i32 %ret
}

define i32 @mlockall(i32 %flags) {
entry:
  %flags64 = sext i32 %flags to i64
  %raw = call i64 @__mtrt_host_mlockall(i64 %flags64)
  %ret = trunc i64 %raw to i32
  ret i32 %ret
}

define i64 @mmap(i64 %addr, i64 %length, i32 %prot, i32 %flags, i32 %fd, i64 %offset) {
entry:
  %prot64 = sext i32 %prot to i64
  %flags64 = sext i32 %flags to i64
  %fd64 = sext i32 %fd to i64
  %raw = call i64 @__mtrt_host_mmap(i64 %addr, i64 %length, i64 %prot64, i64 %flags64, i64 %fd64, i64 %offset)
  ret i64 %raw
}

define i32 @mprotect(i64 %addr, i64 %length, i32 %prot) {
entry:
  %prot64 = sext i32 %prot to i64
  %raw = call i64 @__mtrt_host_mprotect(i64 %addr, i64 %length, i64 %prot64)
  %ret = trunc i64 %raw to i32
  ret i32 %ret
}

define i32 @msync(i64 %addr, i64 %length, i32 %flags) {
entry:
  %flags64 = sext i32 %flags to i64
  %raw = call i64 @__mtrt_host_msync(i64 %addr, i64 %length, i64 %flags64)
  %ret = trunc i64 %raw to i32
  ret i32 %ret
}

define i32 @munlock(i64 %addr, i64 %length) {
entry:
  %raw = call i64 @__mtrt_host_munlock(i64 %addr, i64 %length)
  %ret = trunc i64 %raw to i32
  ret i32 %ret
}

define i32 @munlockall() {
entry:
  %raw = call i64 @__mtrt_host_munlockall()
  %ret = trunc i64 %raw to i32
  ret i32 %ret
}

define i32 @munmap(i64 %addr, i64 %length) {
entry:
  %raw = call i64 @__mtrt_host_munmap(i64 %addr, i64 %length)
  %ret = trunc i64 %raw to i32
  ret i32 %ret
}

define i32 @pause() {
entry:
  %raw = call i64 @__mtrt_host_pause()
  %ret = trunc i64 %raw to i32
  ret i32 %ret
}

define i32 @pipe2(ptr %fds, i32 %flags) {
entry:
  %flags64 = sext i32 %flags to i64
  %raw = call i64 @__mtrt_host_pipe2(ptr %fds, i64 %flags64)
  %ret = trunc i64 %raw to i32
  ret i32 %ret
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

define i32 @rmdir(ptr %path) {
entry:
  %raw = call i64 @__mtrt_host_rmdir(ptr %path)
  %ret = trunc i64 %raw to i32
  ret i32 %ret
}

define i32 @sched_yield() {
entry:
  %raw = call i64 @__mtrt_host_sched_yield()
  %ret = trunc i64 %raw to i32
  ret i32 %ret
}

define i32 @sigaction(i32 %sig, ptr %act, ptr %oldact) {
entry:
  %sig64 = sext i32 %sig to i64
  %raw = call i64 @__mtrt_host_sigaction(i64 %sig64, ptr %act, ptr %oldact)
  %ret = trunc i64 %raw to i32
  ret i32 %ret
}

define i32 @sigaltstack(ptr %ss, ptr %old_ss) {
entry:
  %raw = call i64 @__mtrt_host_sigaltstack(ptr %ss, ptr %old_ss)
  %ret = trunc i64 %raw to i32
  ret i32 %ret
}

define i32 @sigpending(ptr %sigset) {
entry:
  %raw = call i64 @__mtrt_host_sigpending(ptr %sigset)
  %ret = trunc i64 %raw to i32
  ret i32 %ret
}

define i32 @sigprocmask(i32 %how, ptr %set, ptr %oldset) {
entry:
  %how64 = sext i32 %how to i64
  %raw = call i64 @__mtrt_host_sigprocmask(i64 %how64, ptr %set, ptr %oldset)
  %ret = trunc i64 %raw to i32
  ret i32 %ret
}

define i32 @sigsuspend(ptr %sigmask) {
entry:
  %raw = call i64 @__mtrt_host_sigsuspend(ptr %sigmask)
  %ret = trunc i64 %raw to i32
  ret i32 %ret
}

define i32 @sigtimedwait(ptr %set, ptr %info, ptr %timeout) {
entry:
  %raw = call i64 @__mtrt_host_sigtimedwait(ptr %set, ptr %info, ptr %timeout)
  %ret = trunc i64 %raw to i32
  ret i32 %ret
}

define i32 @sigwaitinfo(ptr %set, ptr %info) {
entry:
  %raw = call i64 @__mtrt_host_sigwaitinfo(ptr %set, ptr %info)
  %ret = trunc i64 %raw to i32
  ret i32 %ret
}

define i32 @stat(ptr %path, ptr %buf) {
entry:
  %raw = call i64 @__mtrt_host_stat(ptr %path, ptr %buf)
  %ret = trunc i64 %raw to i32
  ret i32 %ret
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

define i64 @times(ptr %buf) {
entry:
  %raw = call i64 @__mtrt_host_times(ptr %buf)
  ret i64 %raw
}
