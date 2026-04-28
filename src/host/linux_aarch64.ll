; Linux AArch64 kernel-primitive host layer for libmuffintop.
; Direct syscall path (no libc).

target triple = "aarch64-unknown-linux-gnu"

define internal i64 @__mtrt_linux_syscall0(i64 %nr) {
entry:
  %ret = call i64 asm sideeffect "svc #0", "={x0},{x8},~{memory}"(i64 %nr)
  ret i64 %ret
}

define internal i64 @__mtrt_linux_syscall1(i64 %nr, i64 %a1) {
entry:
  %ret = call i64 asm sideeffect "svc #0", "={x0},{x8},{x0},~{memory}"(i64 %nr, i64 %a1)
  ret i64 %ret
}

define internal i64 @__mtrt_linux_syscall2(i64 %nr, i64 %a1, i64 %a2) {
entry:
  %ret = call i64 asm sideeffect "svc #0", "={x0},{x8},{x0},{x1},~{memory}"(i64 %nr, i64 %a1, i64 %a2)
  ret i64 %ret
}

define internal i64 @__mtrt_linux_syscall3(i64 %nr, i64 %a1, i64 %a2, i64 %a3) {
entry:
  %ret = call i64 asm sideeffect "svc #0", "={x0},{x8},{x0},{x1},{x2},~{memory}"(i64 %nr, i64 %a1, i64 %a2, i64 %a3)
  ret i64 %ret
}

define internal i64 @__mtrt_linux_syscall4(i64 %nr, i64 %a1, i64 %a2, i64 %a3, i64 %a4) {
entry:
  %ret = call i64 asm sideeffect "svc #0", "={x0},{x8},{x0},{x1},{x2},{x3},~{memory}"(i64 %nr, i64 %a1, i64 %a2, i64 %a3, i64 %a4)
  ret i64 %ret
}

define internal i64 @__mtrt_linux_syscall5(i64 %nr, i64 %a1, i64 %a2, i64 %a3, i64 %a4, i64 %a5) {
entry:
  %ret = call i64 asm sideeffect "svc #0", "={x0},{x8},{x0},{x1},{x2},{x3},{x4},~{memory}"(i64 %nr, i64 %a1, i64 %a2, i64 %a3, i64 %a4, i64 %a5)
  ret i64 %ret
}

define i64 @__mtrt_host_getpid() {
  %r = call i64 @__mtrt_linux_syscall0(i64 172)
  ret i64 %r
}

define i64 @__mtrt_host_getppid() {
  %r = call i64 @__mtrt_linux_syscall0(i64 173)
  ret i64 %r
}

define i64 @__mtrt_host_fork() {
  %r = call i64 @__mtrt_linux_syscall5(i64 220, i64 17, i64 0, i64 0, i64 0, i64 0)
  ret i64 %r
}

define i64 @__mtrt_host_wait4(i64 %pid, ptr %status, i64 %options) {
  %status_i = ptrtoint ptr %status to i64
  %r = call i64 @__mtrt_linux_syscall4(i64 260, i64 %pid, i64 %status_i, i64 %options, i64 0)
  ret i64 %r
}

define void @__mtrt_host_exit(i64 %status) {
  %_ = call i64 @__mtrt_linux_syscall1(i64 93, i64 %status)
  unreachable
}

define i64 @__mtrt_host_write(i64 %fd, ptr %buf, i64 %count) {
  %buf_i = ptrtoint ptr %buf to i64
  %r = call i64 @__mtrt_linux_syscall3(i64 64, i64 %fd, i64 %buf_i, i64 %count)
  ret i64 %r
}

define i64 @__mtrt_host_read(i64 %fd, ptr %buf, i64 %count) {
  %buf_i = ptrtoint ptr %buf to i64
  %r = call i64 @__mtrt_linux_syscall3(i64 63, i64 %fd, i64 %buf_i, i64 %count)
  ret i64 %r
}

define i64 @__mtrt_host_close(i64 %fd) {
  %r = call i64 @__mtrt_linux_syscall1(i64 57, i64 %fd)
  ret i64 %r
}

define i64 @__mtrt_host_nanosleep(ptr %req, ptr %rem) {
  %req_i = ptrtoint ptr %req to i64
  %rem_i = ptrtoint ptr %rem to i64
  %r = call i64 @__mtrt_linux_syscall2(i64 101, i64 %req_i, i64 %rem_i)
  ret i64 %r
}

define i64 @__mtrt_host_clock_gettime(i64 %clockid, ptr %tp) {
  %tp_i = ptrtoint ptr %tp to i64
  %r = call i64 @__mtrt_linux_syscall2(i64 113, i64 %clockid, i64 %tp_i)
  ret i64 %r
}

define i64 @__mtrt_host_kill(i64 %pid, i64 %sig) {
  %r = call i64 @__mtrt_linux_syscall2(i64 129, i64 %pid, i64 %sig)
  ret i64 %r
}

define i64 @__mtrt_host_dup(i64 %oldfd) {
  %r = call i64 @__mtrt_linux_syscall1(i64 23, i64 %oldfd)
  ret i64 %r
}

define i64 @__mtrt_host_dup2(i64 %oldfd, i64 %newfd) {
entry:
  %same_fd = icmp eq i64 %oldfd, %newfd
  br i1 %same_fd, label %validate_same, label %dup3

validate_same:
  %valid = call i64 @__mtrt_linux_syscall3(i64 25, i64 %oldfd, i64 1, i64 0)
  %is_bad = icmp slt i64 %valid, 0
  br i1 %is_bad, label %same_bad, label %same_ok

same_bad:
  ret i64 %valid

same_ok:
  ret i64 %oldfd

dup3:
  %r = call i64 @__mtrt_linux_syscall3(i64 24, i64 %oldfd, i64 %newfd, i64 0)
  ret i64 %r
}

define i64 @__mtrt_host_chdir(ptr %path) {
  %path_i = ptrtoint ptr %path to i64
  %r = call i64 @__mtrt_linux_syscall1(i64 49, i64 %path_i)
  ret i64 %r
}

define i64 @__mtrt_host_fchdir(i64 %fd) {
  %r = call i64 @__mtrt_linux_syscall1(i64 50, i64 %fd)
  ret i64 %r
}

define i64 @__mtrt_host_getpgid(i64 %pid) {
  %r = call i64 @__mtrt_linux_syscall1(i64 155, i64 %pid)
  ret i64 %r
}

define i64 @__mtrt_host_getpgrp() {
  %r = call i64 @__mtrt_linux_syscall1(i64 155, i64 0)
  ret i64 %r
}

define i64 @__mtrt_host_getsid(i64 %pid) {
  %r = call i64 @__mtrt_linux_syscall1(i64 156, i64 %pid)
  ret i64 %r
}

define i64 @__mtrt_host_setpgid(i64 %pid, i64 %pgid) {
  %r = call i64 @__mtrt_linux_syscall2(i64 154, i64 %pid, i64 %pgid)
  ret i64 %r
}

define i64 @__mtrt_host_setsid() {
  %r = call i64 @__mtrt_linux_syscall0(i64 157)
  ret i64 %r
}

define i64 @__mtrt_host_umask(i64 %mask) {
  %r = call i64 @__mtrt_linux_syscall1(i64 166, i64 %mask)
  ret i64 %r
}

define i64 @__mtrt_host_pipe(ptr %fds) {
  %fds_i = ptrtoint ptr %fds to i64
  %r = call i64 @__mtrt_linux_syscall2(i64 59, i64 %fds_i, i64 0)
  ret i64 %r
}

define i64 @__mtrt_host_readv(i64 %fd, ptr %iov, i64 %iovcnt) {
  %iov_i = ptrtoint ptr %iov to i64
  %r = call i64 @__mtrt_linux_syscall3(i64 65, i64 %fd, i64 %iov_i, i64 %iovcnt)
  ret i64 %r
}

define i64 @__mtrt_host_writev(i64 %fd, ptr %iov, i64 %iovcnt) {
  %iov_i = ptrtoint ptr %iov to i64
  %r = call i64 @__mtrt_linux_syscall3(i64 66, i64 %fd, i64 %iov_i, i64 %iovcnt)
  ret i64 %r
}

define i64 @__mtrt_host_open(ptr %path, i64 %flags, i64 %mode) {
  %path_i = ptrtoint ptr %path to i64
  %r = call i64 @__mtrt_linux_syscall4(i64 56, i64 -100, i64 %path_i, i64 %flags, i64 %mode)
  ret i64 %r
}

define i64 @__mtrt_host_openat(i64 %dirfd, ptr %path, i64 %flags, i64 %mode) {
  %path_i = ptrtoint ptr %path to i64
  %r = call i64 @__mtrt_linux_syscall4(i64 56, i64 %dirfd, i64 %path_i, i64 %flags, i64 %mode)
  ret i64 %r
}

define i64 @__mtrt_host_lseek(i64 %fd, i64 %offset, i64 %whence) {
  %r = call i64 @__mtrt_linux_syscall3(i64 62, i64 %fd, i64 %offset, i64 %whence)
  ret i64 %r
}

define i64 @__mtrt_host_pread(i64 %fd, ptr %buf, i64 %count, i64 %offset) {
  %buf_i = ptrtoint ptr %buf to i64
  %r = call i64 @__mtrt_linux_syscall4(i64 67, i64 %fd, i64 %buf_i, i64 %count, i64 %offset)
  ret i64 %r
}

define i64 @__mtrt_host_pwrite(i64 %fd, ptr %buf, i64 %count, i64 %offset) {
  %buf_i = ptrtoint ptr %buf to i64
  %r = call i64 @__mtrt_linux_syscall4(i64 68, i64 %fd, i64 %buf_i, i64 %count, i64 %offset)
  ret i64 %r
}

define i64 @__mtrt_host_unlink(ptr %path) {
  %path_i = ptrtoint ptr %path to i64
  %r = call i64 @__mtrt_linux_syscall3(i64 35, i64 -100, i64 %path_i, i64 0)
  ret i64 %r
}

define i64 @__mtrt_host_unlinkat(i64 %dirfd, ptr %path, i64 %flags) {
  %path_i = ptrtoint ptr %path to i64
  %r = call i64 @__mtrt_linux_syscall3(i64 35, i64 %dirfd, i64 %path_i, i64 %flags)
  ret i64 %r
}

define i64 @__mtrt_host_access(ptr %path, i64 %mode) {
  %path_i = ptrtoint ptr %path to i64
  %r = call i64 @__mtrt_linux_syscall4(i64 439, i64 -100, i64 %path_i, i64 %mode, i64 0)
  ret i64 %r
}

define i64 @__mtrt_host_faccessat(i64 %dirfd, ptr %path, i64 %mode, i64 %flags) {
  %path_i = ptrtoint ptr %path to i64
  %r = call i64 @__mtrt_linux_syscall4(i64 439, i64 %dirfd, i64 %path_i, i64 %mode, i64 %flags)
  ret i64 %r
}

define i64 @__mtrt_host_chmod(ptr %path, i64 %mode) {
  %path_i = ptrtoint ptr %path to i64
  %r = call i64 @__mtrt_linux_syscall4(i64 452, i64 -100, i64 %path_i, i64 %mode, i64 0)
  ret i64 %r
}

define i64 @__mtrt_host_fchmod(i64 %fd, i64 %mode) {
  %r = call i64 @__mtrt_linux_syscall2(i64 52, i64 %fd, i64 %mode)
  ret i64 %r
}

define i64 @__mtrt_host_fchmodat(i64 %dirfd, ptr %path, i64 %mode, i64 %flags) {
  %path_i = ptrtoint ptr %path to i64
  %r = call i64 @__mtrt_linux_syscall4(i64 452, i64 %dirfd, i64 %path_i, i64 %mode, i64 %flags)
  ret i64 %r
}

define i64 @__mtrt_host_link(ptr %oldpath, ptr %newpath) {
  %oldpath_i = ptrtoint ptr %oldpath to i64
  %newpath_i = ptrtoint ptr %newpath to i64
  %r = call i64 @__mtrt_linux_syscall5(i64 37, i64 -100, i64 %oldpath_i, i64 -100, i64 %newpath_i, i64 0)
  ret i64 %r
}

define i64 @__mtrt_host_linkat(i64 %olddirfd, ptr %oldpath, i64 %newdirfd, ptr %newpath, i64 %flags) {
  %oldpath_i = ptrtoint ptr %oldpath to i64
  %newpath_i = ptrtoint ptr %newpath to i64
  %r = call i64 @__mtrt_linux_syscall5(i64 37, i64 %olddirfd, i64 %oldpath_i, i64 %newdirfd, i64 %newpath_i, i64 %flags)
  ret i64 %r
}

define i64 @__mtrt_host_mkdir(ptr %path, i64 %mode) {
  %path_i = ptrtoint ptr %path to i64
  %r = call i64 @__mtrt_linux_syscall3(i64 34, i64 -100, i64 %path_i, i64 %mode)
  ret i64 %r
}

define i64 @__mtrt_host_mkdirat(i64 %dirfd, ptr %path, i64 %mode) {
  %path_i = ptrtoint ptr %path to i64
  %r = call i64 @__mtrt_linux_syscall3(i64 34, i64 %dirfd, i64 %path_i, i64 %mode)
  ret i64 %r
}

define i64 @__mtrt_host_readlink(ptr %path, ptr %buf, i64 %size) {
  %path_i = ptrtoint ptr %path to i64
  %buf_i = ptrtoint ptr %buf to i64
  %r = call i64 @__mtrt_linux_syscall4(i64 78, i64 -100, i64 %path_i, i64 %buf_i, i64 %size)
  ret i64 %r
}

define i64 @__mtrt_host_readlinkat(i64 %dirfd, ptr %path, ptr %buf, i64 %size) {
  %path_i = ptrtoint ptr %path to i64
  %buf_i = ptrtoint ptr %buf to i64
  %r = call i64 @__mtrt_linux_syscall4(i64 78, i64 %dirfd, i64 %path_i, i64 %buf_i, i64 %size)
  ret i64 %r
}

define i64 @__mtrt_host_rename(ptr %oldpath, ptr %newpath) {
  %oldpath_i = ptrtoint ptr %oldpath to i64
  %newpath_i = ptrtoint ptr %newpath to i64
  %r = call i64 @__mtrt_linux_syscall4(i64 38, i64 -100, i64 %oldpath_i, i64 -100, i64 %newpath_i)
  ret i64 %r
}

define i64 @__mtrt_host_renameat(i64 %olddirfd, ptr %oldpath, i64 %newdirfd, ptr %newpath) {
  %oldpath_i = ptrtoint ptr %oldpath to i64
  %newpath_i = ptrtoint ptr %newpath to i64
  %r = call i64 @__mtrt_linux_syscall4(i64 38, i64 %olddirfd, i64 %oldpath_i, i64 %newdirfd, i64 %newpath_i)
  ret i64 %r
}

define i64 @__mtrt_host_rmdir(ptr %path) {
  %path_i = ptrtoint ptr %path to i64
  %r = call i64 @__mtrt_linux_syscall3(i64 35, i64 -100, i64 %path_i, i64 512)
  ret i64 %r
}

define i64 @__mtrt_host_symlink(ptr %target, ptr %linkpath) {
  %target_i = ptrtoint ptr %target to i64
  %linkpath_i = ptrtoint ptr %linkpath to i64
  %r = call i64 @__mtrt_linux_syscall3(i64 36, i64 %target_i, i64 -100, i64 %linkpath_i)
  ret i64 %r
}

define i64 @__mtrt_host_symlinkat(ptr %target, i64 %newdirfd, ptr %linkpath) {
  %target_i = ptrtoint ptr %target to i64
  %linkpath_i = ptrtoint ptr %linkpath to i64
  %r = call i64 @__mtrt_linux_syscall3(i64 36, i64 %target_i, i64 %newdirfd, i64 %linkpath_i)
  ret i64 %r
}
