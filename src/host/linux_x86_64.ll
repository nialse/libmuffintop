; Linux x86_64 kernel-primitive host layer for libmuffintop.
; Direct syscall path (no libc).

target triple = "x86_64-unknown-linux-gnu"

%struct.mtrt_stat64 = type { i64, i64, i64, i32, i32, i32, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64 }

@.mtrt_empty_path = private unnamed_addr constant [1 x i8] zeroinitializer

define internal i64 @__mtrt_linux_syscall0(i64 %nr) {
entry:
  %ret = call i64 asm sideeffect "syscall", "={rax},{rax},~{rcx},~{r11},~{memory}"(i64 %nr)
  ret i64 %ret
}

define internal i64 @__mtrt_linux_syscall1(i64 %nr, i64 %a1) {
entry:
  %ret = call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 %nr, i64 %a1)
  ret i64 %ret
}

define internal i64 @__mtrt_linux_syscall2(i64 %nr, i64 %a1, i64 %a2) {
entry:
  %ret = call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},{rsi},~{rcx},~{r11},~{memory}"(i64 %nr, i64 %a1, i64 %a2)
  ret i64 %ret
}

define internal i64 @__mtrt_linux_syscall3(i64 %nr, i64 %a1, i64 %a2, i64 %a3) {
entry:
  %ret = call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},{rsi},{rdx},~{rcx},~{r11},~{memory}"(i64 %nr, i64 %a1, i64 %a2, i64 %a3)
  ret i64 %ret
}

define internal i64 @__mtrt_linux_syscall4(i64 %nr, i64 %a1, i64 %a2, i64 %a3, i64 %a4) {
entry:
  %ret = call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},{rsi},{rdx},{r10},~{rcx},~{r11},~{memory}"(i64 %nr, i64 %a1, i64 %a2, i64 %a3, i64 %a4)
  ret i64 %ret
}

define internal i64 @__mtrt_linux_syscall5(i64 %nr, i64 %a1, i64 %a2, i64 %a3, i64 %a4, i64 %a5) {
entry:
  %ret = call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},{rsi},{rdx},{r10},{r8},~{rcx},~{r11},~{memory}"(i64 %nr, i64 %a1, i64 %a2, i64 %a3, i64 %a4, i64 %a5)
  ret i64 %ret
}

define internal i64 @__mtrt_linux_syscall6(i64 %nr, i64 %a1, i64 %a2, i64 %a3, i64 %a4, i64 %a5, i64 %a6) {
entry:
  %ret = call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},{rsi},{rdx},{r10},{r8},{r9},~{rcx},~{r11},~{memory}"(i64 %nr, i64 %a1, i64 %a2, i64 %a3, i64 %a4, i64 %a5, i64 %a6)
  ret i64 %ret
}

define internal i64 @__mtrt_linux_makedev(i32 %major32, i32 %minor32) {
entry:
  %major = zext i32 %major32 to i64
  %minor = zext i32 %minor32 to i64
  %minor_low = and i64 %minor, 255
  %major_low = and i64 %major, 4095
  %major_low_shifted = shl i64 %major_low, 8
  %minor_high = and i64 %minor, 4294967040
  %minor_high_shifted = shl i64 %minor_high, 12
  %major_high = and i64 %major, 4294963200
  %major_high_shifted = shl i64 %major_high, 32
  %low = or i64 %minor_low, %major_low_shifted
  %with_minor_high = or i64 %low, %minor_high_shifted
  %dev = or i64 %with_minor_high, %major_high_shifted
  ret i64 %dev
}

define internal void @__mtrt_linux_store_statx(ptr %out, ptr %sx) {
entry:
  %blksize_p = getelementptr i8, ptr %sx, i64 4
  %blksize32 = load i32, ptr %blksize_p, align 4
  %blksize = zext i32 %blksize32 to i64
  %nlink_p = getelementptr i8, ptr %sx, i64 16
  %nlink32 = load i32, ptr %nlink_p, align 4
  %nlink = zext i32 %nlink32 to i64
  %uid_p = getelementptr i8, ptr %sx, i64 20
  %uid = load i32, ptr %uid_p, align 4
  %gid_p = getelementptr i8, ptr %sx, i64 24
  %gid = load i32, ptr %gid_p, align 4
  %mode_p = getelementptr i8, ptr %sx, i64 28
  %mode16 = load i16, ptr %mode_p, align 2
  %mode = zext i16 %mode16 to i32
  %ino_p = getelementptr i8, ptr %sx, i64 32
  %ino = load i64, ptr %ino_p, align 8
  %size_p = getelementptr i8, ptr %sx, i64 40
  %size = load i64, ptr %size_p, align 8
  %blocks_p = getelementptr i8, ptr %sx, i64 48
  %blocks = load i64, ptr %blocks_p, align 8
  %atime_sec_p = getelementptr i8, ptr %sx, i64 64
  %atime_sec = load i64, ptr %atime_sec_p, align 8
  %atime_nsec_p = getelementptr i8, ptr %sx, i64 72
  %atime_nsec32 = load i32, ptr %atime_nsec_p, align 4
  %atime_nsec = zext i32 %atime_nsec32 to i64
  %ctime_sec_p = getelementptr i8, ptr %sx, i64 96
  %ctime_sec = load i64, ptr %ctime_sec_p, align 8
  %ctime_nsec_p = getelementptr i8, ptr %sx, i64 104
  %ctime_nsec32 = load i32, ptr %ctime_nsec_p, align 4
  %ctime_nsec = zext i32 %ctime_nsec32 to i64
  %mtime_sec_p = getelementptr i8, ptr %sx, i64 112
  %mtime_sec = load i64, ptr %mtime_sec_p, align 8
  %mtime_nsec_p = getelementptr i8, ptr %sx, i64 120
  %mtime_nsec32 = load i32, ptr %mtime_nsec_p, align 4
  %mtime_nsec = zext i32 %mtime_nsec32 to i64
  %rdev_major_p = getelementptr i8, ptr %sx, i64 128
  %rdev_major = load i32, ptr %rdev_major_p, align 4
  %rdev_minor_p = getelementptr i8, ptr %sx, i64 132
  %rdev_minor = load i32, ptr %rdev_minor_p, align 4
  %dev_major_p = getelementptr i8, ptr %sx, i64 136
  %dev_major = load i32, ptr %dev_major_p, align 4
  %dev_minor_p = getelementptr i8, ptr %sx, i64 140
  %dev_minor = load i32, ptr %dev_minor_p, align 4
  %dev = call i64 @__mtrt_linux_makedev(i32 %dev_major, i32 %dev_minor)
  %rdev = call i64 @__mtrt_linux_makedev(i32 %rdev_major, i32 %rdev_minor)

  %dev_out = getelementptr inbounds %struct.mtrt_stat64, ptr %out, i32 0, i32 0
  store i64 %dev, ptr %dev_out, align 8
  %ino_out = getelementptr inbounds %struct.mtrt_stat64, ptr %out, i32 0, i32 1
  store i64 %ino, ptr %ino_out, align 8
  %nlink_out = getelementptr inbounds %struct.mtrt_stat64, ptr %out, i32 0, i32 2
  store i64 %nlink, ptr %nlink_out, align 8
  %mode_out = getelementptr inbounds %struct.mtrt_stat64, ptr %out, i32 0, i32 3
  store i32 %mode, ptr %mode_out, align 4
  %uid_out = getelementptr inbounds %struct.mtrt_stat64, ptr %out, i32 0, i32 4
  store i32 %uid, ptr %uid_out, align 4
  %gid_out = getelementptr inbounds %struct.mtrt_stat64, ptr %out, i32 0, i32 5
  store i32 %gid, ptr %gid_out, align 4
  %rdev_out = getelementptr inbounds %struct.mtrt_stat64, ptr %out, i32 0, i32 6
  store i64 %rdev, ptr %rdev_out, align 8
  %size_out = getelementptr inbounds %struct.mtrt_stat64, ptr %out, i32 0, i32 7
  store i64 %size, ptr %size_out, align 8
  %blksize_out = getelementptr inbounds %struct.mtrt_stat64, ptr %out, i32 0, i32 8
  store i64 %blksize, ptr %blksize_out, align 8
  %blocks_out = getelementptr inbounds %struct.mtrt_stat64, ptr %out, i32 0, i32 9
  store i64 %blocks, ptr %blocks_out, align 8
  %atime_sec_out = getelementptr inbounds %struct.mtrt_stat64, ptr %out, i32 0, i32 10
  store i64 %atime_sec, ptr %atime_sec_out, align 8
  %atime_nsec_out = getelementptr inbounds %struct.mtrt_stat64, ptr %out, i32 0, i32 11
  store i64 %atime_nsec, ptr %atime_nsec_out, align 8
  %mtime_sec_out = getelementptr inbounds %struct.mtrt_stat64, ptr %out, i32 0, i32 12
  store i64 %mtime_sec, ptr %mtime_sec_out, align 8
  %mtime_nsec_out = getelementptr inbounds %struct.mtrt_stat64, ptr %out, i32 0, i32 13
  store i64 %mtime_nsec, ptr %mtime_nsec_out, align 8
  %ctime_sec_out = getelementptr inbounds %struct.mtrt_stat64, ptr %out, i32 0, i32 14
  store i64 %ctime_sec, ptr %ctime_sec_out, align 8
  %ctime_nsec_out = getelementptr inbounds %struct.mtrt_stat64, ptr %out, i32 0, i32 15
  store i64 %ctime_nsec, ptr %ctime_nsec_out, align 8
  ret void
}

define internal i64 @__mtrt_linux_statx_to_target(i64 %dirfd, ptr %path, i64 %flags, ptr %buf) {
entry:
  %is_null = icmp eq ptr %buf, null
  br i1 %is_null, label %fault, label %call_statx

fault:
  ret i64 -14

call_statx:
  %sx = alloca [256 x i8], align 8
  %path_i = ptrtoint ptr %path to i64
  %sx_i = ptrtoint ptr %sx to i64
  %r = call i64 @__mtrt_linux_syscall5(i64 332, i64 %dirfd, i64 %path_i, i64 %flags, i64 2047, i64 %sx_i)
  %ok = icmp eq i64 %r, 0
  br i1 %ok, label %store, label %done

store:
  call void @__mtrt_linux_store_statx(ptr %buf, ptr %sx)
  ret i64 0

done:
  ret i64 %r
}

define i64 @__mtrt_host_getpid() {
  %r = call i64 @__mtrt_linux_syscall0(i64 39)
  ret i64 %r
}

define i64 @__mtrt_host_getppid() {
  %r = call i64 @__mtrt_linux_syscall0(i64 110)
  ret i64 %r
}

define i64 @__mtrt_host_fork() {
  %r = call i64 @__mtrt_linux_syscall0(i64 57)
  ret i64 %r
}

define i64 @__mtrt_host_wait4(i64 %pid, ptr %status, i64 %options) {
  %status_i = ptrtoint ptr %status to i64
  %r = call i64 @__mtrt_linux_syscall4(i64 61, i64 %pid, i64 %status_i, i64 %options, i64 0)
  ret i64 %r
}

define void @__mtrt_host_exit(i64 %status) {
  %_ = call i64 @__mtrt_linux_syscall1(i64 60, i64 %status)
  unreachable
}

define i64 @__mtrt_host_write(i64 %fd, ptr %buf, i64 %count) {
  %buf_i = ptrtoint ptr %buf to i64
  %r = call i64 @__mtrt_linux_syscall3(i64 1, i64 %fd, i64 %buf_i, i64 %count)
  ret i64 %r
}

define i64 @__mtrt_host_read(i64 %fd, ptr %buf, i64 %count) {
  %buf_i = ptrtoint ptr %buf to i64
  %r = call i64 @__mtrt_linux_syscall3(i64 0, i64 %fd, i64 %buf_i, i64 %count)
  ret i64 %r
}

define i64 @__mtrt_host_close(i64 %fd) {
  %r = call i64 @__mtrt_linux_syscall1(i64 3, i64 %fd)
  ret i64 %r
}

define i64 @__mtrt_host_nanosleep(ptr %req, ptr %rem) {
  %req_i = ptrtoint ptr %req to i64
  %rem_i = ptrtoint ptr %rem to i64
  %r = call i64 @__mtrt_linux_syscall2(i64 35, i64 %req_i, i64 %rem_i)
  ret i64 %r
}

define i64 @__mtrt_host_clock_gettime(i64 %clockid, ptr %tp) {
  %tp_i = ptrtoint ptr %tp to i64
  %r = call i64 @__mtrt_linux_syscall2(i64 228, i64 %clockid, i64 %tp_i)
  ret i64 %r
}

define i64 @__mtrt_host_kill(i64 %pid, i64 %sig) {
  %r = call i64 @__mtrt_linux_syscall2(i64 62, i64 %pid, i64 %sig)
  ret i64 %r
}

define i64 @__mtrt_host_dup(i64 %oldfd) {
  %r = call i64 @__mtrt_linux_syscall1(i64 32, i64 %oldfd)
  ret i64 %r
}

define i64 @__mtrt_host_dup2(i64 %oldfd, i64 %newfd) {
  %r = call i64 @__mtrt_linux_syscall2(i64 33, i64 %oldfd, i64 %newfd)
  ret i64 %r
}

define i64 @__mtrt_host_chdir(ptr %path) {
  %path_i = ptrtoint ptr %path to i64
  %r = call i64 @__mtrt_linux_syscall1(i64 80, i64 %path_i)
  ret i64 %r
}

define i64 @__mtrt_host_fchdir(i64 %fd) {
  %r = call i64 @__mtrt_linux_syscall1(i64 81, i64 %fd)
  ret i64 %r
}

define i64 @__mtrt_host_getpgid(i64 %pid) {
  %r = call i64 @__mtrt_linux_syscall1(i64 121, i64 %pid)
  ret i64 %r
}

define i64 @__mtrt_host_getpgrp() {
  %r = call i64 @__mtrt_linux_syscall0(i64 111)
  ret i64 %r
}

define i64 @__mtrt_host_getsid(i64 %pid) {
  %r = call i64 @__mtrt_linux_syscall1(i64 124, i64 %pid)
  ret i64 %r
}

define i64 @__mtrt_host_setpgid(i64 %pid, i64 %pgid) {
  %r = call i64 @__mtrt_linux_syscall2(i64 109, i64 %pid, i64 %pgid)
  ret i64 %r
}

define i64 @__mtrt_host_setsid() {
  %r = call i64 @__mtrt_linux_syscall0(i64 112)
  ret i64 %r
}

define i64 @__mtrt_host_umask(i64 %mask) {
  %r = call i64 @__mtrt_linux_syscall1(i64 95, i64 %mask)
  ret i64 %r
}

define i64 @__mtrt_host_pipe(ptr %fds) {
  %fds_i = ptrtoint ptr %fds to i64
  %r = call i64 @__mtrt_linux_syscall1(i64 22, i64 %fds_i)
  ret i64 %r
}

define i64 @__mtrt_host_readv(i64 %fd, ptr %iov, i64 %iovcnt) {
  %iov_i = ptrtoint ptr %iov to i64
  %r = call i64 @__mtrt_linux_syscall3(i64 19, i64 %fd, i64 %iov_i, i64 %iovcnt)
  ret i64 %r
}

define i64 @__mtrt_host_writev(i64 %fd, ptr %iov, i64 %iovcnt) {
  %iov_i = ptrtoint ptr %iov to i64
  %r = call i64 @__mtrt_linux_syscall3(i64 20, i64 %fd, i64 %iov_i, i64 %iovcnt)
  ret i64 %r
}

define i64 @__mtrt_host_open(ptr %path, i64 %flags, i64 %mode) {
  %path_i = ptrtoint ptr %path to i64
  %r = call i64 @__mtrt_linux_syscall3(i64 2, i64 %path_i, i64 %flags, i64 %mode)
  ret i64 %r
}

define i64 @__mtrt_host_openat(i64 %dirfd, ptr %path, i64 %flags, i64 %mode) {
  %path_i = ptrtoint ptr %path to i64
  %r = call i64 @__mtrt_linux_syscall4(i64 257, i64 %dirfd, i64 %path_i, i64 %flags, i64 %mode)
  ret i64 %r
}

define i64 @__mtrt_host_lseek(i64 %fd, i64 %offset, i64 %whence) {
  %r = call i64 @__mtrt_linux_syscall3(i64 8, i64 %fd, i64 %offset, i64 %whence)
  ret i64 %r
}

define i64 @__mtrt_host_pread(i64 %fd, ptr %buf, i64 %count, i64 %offset) {
  %buf_i = ptrtoint ptr %buf to i64
  %r = call i64 @__mtrt_linux_syscall4(i64 17, i64 %fd, i64 %buf_i, i64 %count, i64 %offset)
  ret i64 %r
}

define i64 @__mtrt_host_pwrite(i64 %fd, ptr %buf, i64 %count, i64 %offset) {
  %buf_i = ptrtoint ptr %buf to i64
  %r = call i64 @__mtrt_linux_syscall4(i64 18, i64 %fd, i64 %buf_i, i64 %count, i64 %offset)
  ret i64 %r
}

define i64 @__mtrt_host_unlink(ptr %path) {
  %path_i = ptrtoint ptr %path to i64
  %r = call i64 @__mtrt_linux_syscall1(i64 87, i64 %path_i)
  ret i64 %r
}

define i64 @__mtrt_host_unlinkat(i64 %dirfd, ptr %path, i64 %flags) {
  %path_i = ptrtoint ptr %path to i64
  %r = call i64 @__mtrt_linux_syscall3(i64 263, i64 %dirfd, i64 %path_i, i64 %flags)
  ret i64 %r
}

define i64 @__mtrt_host_access(ptr %path, i64 %mode) {
  %path_i = ptrtoint ptr %path to i64
  %r = call i64 @__mtrt_linux_syscall2(i64 21, i64 %path_i, i64 %mode)
  ret i64 %r
}

define i64 @__mtrt_host_faccessat(i64 %dirfd, ptr %path, i64 %mode, i64 %flags) {
  %path_i = ptrtoint ptr %path to i64
  %r = call i64 @__mtrt_linux_syscall4(i64 439, i64 %dirfd, i64 %path_i, i64 %mode, i64 %flags)
  ret i64 %r
}

define i64 @__mtrt_host_chmod(ptr %path, i64 %mode) {
  %path_i = ptrtoint ptr %path to i64
  %r = call i64 @__mtrt_linux_syscall2(i64 90, i64 %path_i, i64 %mode)
  ret i64 %r
}

define i64 @__mtrt_host_fchmod(i64 %fd, i64 %mode) {
  %r = call i64 @__mtrt_linux_syscall2(i64 91, i64 %fd, i64 %mode)
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
  %r = call i64 @__mtrt_linux_syscall2(i64 86, i64 %oldpath_i, i64 %newpath_i)
  ret i64 %r
}

define i64 @__mtrt_host_linkat(i64 %olddirfd, ptr %oldpath, i64 %newdirfd, ptr %newpath, i64 %flags) {
  %oldpath_i = ptrtoint ptr %oldpath to i64
  %newpath_i = ptrtoint ptr %newpath to i64
  %r = call i64 @__mtrt_linux_syscall5(i64 265, i64 %olddirfd, i64 %oldpath_i, i64 %newdirfd, i64 %newpath_i, i64 %flags)
  ret i64 %r
}

define i64 @__mtrt_host_mkdir(ptr %path, i64 %mode) {
  %path_i = ptrtoint ptr %path to i64
  %r = call i64 @__mtrt_linux_syscall2(i64 83, i64 %path_i, i64 %mode)
  ret i64 %r
}

define i64 @__mtrt_host_mkdirat(i64 %dirfd, ptr %path, i64 %mode) {
  %path_i = ptrtoint ptr %path to i64
  %r = call i64 @__mtrt_linux_syscall3(i64 258, i64 %dirfd, i64 %path_i, i64 %mode)
  ret i64 %r
}

define i64 @__mtrt_host_readlink(ptr %path, ptr %buf, i64 %size) {
  %path_i = ptrtoint ptr %path to i64
  %buf_i = ptrtoint ptr %buf to i64
  %r = call i64 @__mtrt_linux_syscall3(i64 89, i64 %path_i, i64 %buf_i, i64 %size)
  ret i64 %r
}

define i64 @__mtrt_host_readlinkat(i64 %dirfd, ptr %path, ptr %buf, i64 %size) {
  %path_i = ptrtoint ptr %path to i64
  %buf_i = ptrtoint ptr %buf to i64
  %r = call i64 @__mtrt_linux_syscall4(i64 267, i64 %dirfd, i64 %path_i, i64 %buf_i, i64 %size)
  ret i64 %r
}

define i64 @__mtrt_host_rename(ptr %oldpath, ptr %newpath) {
  %oldpath_i = ptrtoint ptr %oldpath to i64
  %newpath_i = ptrtoint ptr %newpath to i64
  %r = call i64 @__mtrt_linux_syscall2(i64 82, i64 %oldpath_i, i64 %newpath_i)
  ret i64 %r
}

define i64 @__mtrt_host_renameat(i64 %olddirfd, ptr %oldpath, i64 %newdirfd, ptr %newpath) {
  %oldpath_i = ptrtoint ptr %oldpath to i64
  %newpath_i = ptrtoint ptr %newpath to i64
  %r = call i64 @__mtrt_linux_syscall4(i64 264, i64 %olddirfd, i64 %oldpath_i, i64 %newdirfd, i64 %newpath_i)
  ret i64 %r
}

define i64 @__mtrt_host_rmdir(ptr %path) {
  %path_i = ptrtoint ptr %path to i64
  %r = call i64 @__mtrt_linux_syscall1(i64 84, i64 %path_i)
  ret i64 %r
}

define i64 @__mtrt_host_symlink(ptr %target, ptr %linkpath) {
  %target_i = ptrtoint ptr %target to i64
  %linkpath_i = ptrtoint ptr %linkpath to i64
  %r = call i64 @__mtrt_linux_syscall2(i64 88, i64 %target_i, i64 %linkpath_i)
  ret i64 %r
}

define i64 @__mtrt_host_symlinkat(ptr %target, i64 %newdirfd, ptr %linkpath) {
  %target_i = ptrtoint ptr %target to i64
  %linkpath_i = ptrtoint ptr %linkpath to i64
  %r = call i64 @__mtrt_linux_syscall3(i64 266, i64 %target_i, i64 %newdirfd, i64 %linkpath_i)
  ret i64 %r
}

define i64 @__mtrt_host_stat(ptr %path, ptr %buf) {
  %r = call i64 @__mtrt_linux_statx_to_target(i64 -100, ptr %path, i64 0, ptr %buf)
  ret i64 %r
}

define i64 @__mtrt_host_fstat(i64 %fd, ptr %buf) {
  %r = call i64 @__mtrt_linux_statx_to_target(i64 %fd, ptr @.mtrt_empty_path, i64 4096, ptr %buf)
  ret i64 %r
}

define i64 @__mtrt_host_lstat(ptr %path, ptr %buf) {
  %r = call i64 @__mtrt_linux_statx_to_target(i64 -100, ptr %path, i64 256, ptr %buf)
  ret i64 %r
}

define i64 @__mtrt_host_fstatat(i64 %dirfd, ptr %path, ptr %buf, i64 %flags) {
  %r = call i64 @__mtrt_linux_statx_to_target(i64 %dirfd, ptr %path, i64 %flags, ptr %buf)
  ret i64 %r
}

define i64 @__mtrt_host_brk(i64 %addr) {
  %r = call i64 @__mtrt_linux_syscall1(i64 12, i64 %addr)
  ret i64 %r
}

define i64 @__mtrt_host_chown(ptr %path, i64 %uid, i64 %gid) {
  %path_i = ptrtoint ptr %path to i64
  %r = call i64 @__mtrt_linux_syscall3(i64 92, i64 %path_i, i64 %uid, i64 %gid)
  ret i64 %r
}

define i64 @__mtrt_host_clock_getres(i64 %clockid, ptr %tp) {
  %tp_i = ptrtoint ptr %tp to i64
  %r = call i64 @__mtrt_linux_syscall2(i64 229, i64 %clockid, i64 %tp_i)
  ret i64 %r
}

define i64 @__mtrt_host_clock_settime(i64 %clockid, ptr %tp) {
  %tp_i = ptrtoint ptr %tp to i64
  %r = call i64 @__mtrt_linux_syscall2(i64 227, i64 %clockid, i64 %tp_i)
  ret i64 %r
}

define i64 @__mtrt_host_execve(ptr %path, ptr %argv, ptr %envp) {
  %path_i = ptrtoint ptr %path to i64
  %argv_i = ptrtoint ptr %argv to i64
  %envp_i = ptrtoint ptr %envp to i64
  %r = call i64 @__mtrt_linux_syscall3(i64 59, i64 %path_i, i64 %argv_i, i64 %envp_i)
  ret i64 %r
}

define i64 @__mtrt_host_fchown(i64 %fd, i64 %uid, i64 %gid) {
  %r = call i64 @__mtrt_linux_syscall3(i64 93, i64 %fd, i64 %uid, i64 %gid)
  ret i64 %r
}

define i64 @__mtrt_host_fchownat(i64 %dirfd, ptr %path, i64 %uid, i64 %gid, i64 %flags) {
  %path_i = ptrtoint ptr %path to i64
  %r = call i64 @__mtrt_linux_syscall5(i64 260, i64 %dirfd, i64 %path_i, i64 %uid, i64 %gid, i64 %flags)
  ret i64 %r
}

define i64 @__mtrt_host_fcntl(i64 %fd, i64 %cmd, i64 %arg) {
  %r = call i64 @__mtrt_linux_syscall3(i64 72, i64 %fd, i64 %cmd, i64 %arg)
  ret i64 %r
}

define i64 @__mtrt_host_fdatasync(i64 %fd) {
  %r = call i64 @__mtrt_linux_syscall1(i64 75, i64 %fd)
  ret i64 %r
}

define i64 @__mtrt_host_fsync(i64 %fd) {
  %r = call i64 @__mtrt_linux_syscall1(i64 74, i64 %fd)
  ret i64 %r
}

define i64 @__mtrt_host_getcwd(ptr %buf, i64 %size) {
entry:
  %buf_i = ptrtoint ptr %buf to i64
  %r = call i64 @__mtrt_linux_syscall2(i64 79, i64 %buf_i, i64 %size)
  %bad = icmp slt i64 %r, 0
  br i1 %bad, label %done, label %success

success:
  %ret = ptrtoint ptr %buf to i64
  ret i64 %ret

done:
  ret i64 %r
}

define i64 @__mtrt_host_gettimeofday(ptr %tv, ptr %tz) {
  %tv_i = ptrtoint ptr %tv to i64
  %tz_i = ptrtoint ptr %tz to i64
  %r = call i64 @__mtrt_linux_syscall2(i64 96, i64 %tv_i, i64 %tz_i)
  ret i64 %r
}

define i64 @__mtrt_host_lchown(ptr %path, i64 %uid, i64 %gid) {
  %path_i = ptrtoint ptr %path to i64
  %r = call i64 @__mtrt_linux_syscall3(i64 94, i64 %path_i, i64 %uid, i64 %gid)
  ret i64 %r
}

define i64 @__mtrt_host_madvise(i64 %addr, i64 %length, i64 %advice) {
  %r = call i64 @__mtrt_linux_syscall3(i64 28, i64 %addr, i64 %length, i64 %advice)
  ret i64 %r
}

define i64 @__mtrt_host_mlock(i64 %addr, i64 %length) {
  %r = call i64 @__mtrt_linux_syscall2(i64 149, i64 %addr, i64 %length)
  ret i64 %r
}

define i64 @__mtrt_host_mlockall(i64 %flags) {
  %r = call i64 @__mtrt_linux_syscall1(i64 151, i64 %flags)
  ret i64 %r
}

define i64 @__mtrt_host_mmap(i64 %addr, i64 %length, i64 %prot, i64 %flags, i64 %fd, i64 %offset) {
  %r = call i64 @__mtrt_linux_syscall6(i64 9, i64 %addr, i64 %length, i64 %prot, i64 %flags, i64 %fd, i64 %offset)
  ret i64 %r
}

define i64 @__mtrt_host_mprotect(i64 %addr, i64 %length, i64 %prot) {
  %r = call i64 @__mtrt_linux_syscall3(i64 10, i64 %addr, i64 %length, i64 %prot)
  ret i64 %r
}

define i64 @__mtrt_host_msync(i64 %addr, i64 %length, i64 %flags) {
  %r = call i64 @__mtrt_linux_syscall3(i64 26, i64 %addr, i64 %length, i64 %flags)
  ret i64 %r
}

define i64 @__mtrt_host_munlock(i64 %addr, i64 %length) {
  %r = call i64 @__mtrt_linux_syscall2(i64 150, i64 %addr, i64 %length)
  ret i64 %r
}

define i64 @__mtrt_host_munlockall() {
  %r = call i64 @__mtrt_linux_syscall0(i64 152)
  ret i64 %r
}

define i64 @__mtrt_host_munmap(i64 %addr, i64 %length) {
  %r = call i64 @__mtrt_linux_syscall2(i64 11, i64 %addr, i64 %length)
  ret i64 %r
}

define i64 @__mtrt_host_pause() {
  %r = call i64 @__mtrt_linux_syscall0(i64 34)
  ret i64 %r
}

define i64 @__mtrt_host_pipe2(ptr %fds, i64 %flags) {
  %fds_i = ptrtoint ptr %fds to i64
  %r = call i64 @__mtrt_linux_syscall2(i64 293, i64 %fds_i, i64 %flags)
  ret i64 %r
}

define i64 @__mtrt_host_sched_yield() {
  %r = call i64 @__mtrt_linux_syscall0(i64 24)
  ret i64 %r
}

define i64 @__mtrt_host_sigaction(i64 %sig, ptr %act, ptr %oldact) {
  %act_i = ptrtoint ptr %act to i64
  %oldact_i = ptrtoint ptr %oldact to i64
  %r = call i64 @__mtrt_linux_syscall4(i64 13, i64 %sig, i64 %act_i, i64 %oldact_i, i64 8)
  ret i64 %r
}

define i64 @__mtrt_host_sigaltstack(ptr %ss, ptr %old_ss) {
  %ss_i = ptrtoint ptr %ss to i64
  %old_i = ptrtoint ptr %old_ss to i64
  %r = call i64 @__mtrt_linux_syscall2(i64 131, i64 %ss_i, i64 %old_i)
  ret i64 %r
}

define i64 @__mtrt_host_sigpending(ptr %sigset) {
  %sigset_i = ptrtoint ptr %sigset to i64
  %r = call i64 @__mtrt_linux_syscall2(i64 127, i64 %sigset_i, i64 8)
  ret i64 %r
}

define i64 @__mtrt_host_sigprocmask(i64 %how, ptr %set, ptr %oldset) {
  %set_i = ptrtoint ptr %set to i64
  %oldset_i = ptrtoint ptr %oldset to i64
  %r = call i64 @__mtrt_linux_syscall4(i64 14, i64 %how, i64 %set_i, i64 %oldset_i, i64 8)
  ret i64 %r
}

define i64 @__mtrt_host_sigsuspend(ptr %sigmask) {
  %sigmask_i = ptrtoint ptr %sigmask to i64
  %r = call i64 @__mtrt_linux_syscall2(i64 130, i64 %sigmask_i, i64 8)
  ret i64 %r
}

define i64 @__mtrt_host_sigtimedwait(ptr %set, ptr %info, ptr %timeout) {
  %set_i = ptrtoint ptr %set to i64
  %info_i = ptrtoint ptr %info to i64
  %timeout_i = ptrtoint ptr %timeout to i64
  %r = call i64 @__mtrt_linux_syscall4(i64 128, i64 %set_i, i64 %info_i, i64 %timeout_i, i64 8)
  ret i64 %r
}

define i64 @__mtrt_host_sigwaitinfo(ptr %set, ptr %info) {
  %r = call i64 @__mtrt_host_sigtimedwait(ptr %set, ptr %info, ptr null)
  ret i64 %r
}

define i64 @__mtrt_host_times(ptr %buf) {
  %buf_i = ptrtoint ptr %buf to i64
  %r = call i64 @__mtrt_linux_syscall1(i64 100, i64 %buf_i)
  ret i64 %r
}

define i64 @__mtrt_host_vfork() {
  %r = call i64 @__mtrt_linux_syscall0(i64 58)
  ret i64 %r
}
