target triple = "arm64-apple-macosx13.0.0"

%struct.mtrt_stat64 = type { i64, i64, i64, i32, i32, i32, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64 }

define internal i64 @__mtrt_darwin_syscall0(i64 %nr) {
entry:
  %r = call i64 asm sideeffect "mov x16, $1\0A svc #0x80\0A b.cc 1f\0A neg x0, x0\0A1:", "={x0},r,~{x16},~{memory},~{cc}"(i64 %nr)
  ret i64 %r
}

define internal i64 @__mtrt_darwin_syscall1(i64 %nr, i64 %a0) {
entry:
  %r = call i64 asm sideeffect "mov x16, $2\0A svc #0x80\0A b.cc 1f\0A neg x0, x0\0A1:", "={x0},{x0},r,~{x16},~{memory},~{cc}"(i64 %a0, i64 %nr)
  ret i64 %r
}

define internal i64 @__mtrt_darwin_syscall2(i64 %nr, i64 %a0, i64 %a1) {
entry:
  %r = call i64 asm sideeffect "mov x16, $3\0A svc #0x80\0A b.cc 1f\0A neg x0, x0\0A1:", "={x0},{x0},{x1},r,~{x16},~{memory},~{cc}"(i64 %a0, i64 %a1, i64 %nr)
  ret i64 %r
}

define internal i64 @__mtrt_darwin_syscall3(i64 %nr, i64 %a0, i64 %a1, i64 %a2) {
entry:
  %r = call i64 asm sideeffect "mov x16, $4\0A svc #0x80\0A b.cc 1f\0A neg x0, x0\0A1:", "={x0},{x0},{x1},{x2},r,~{x16},~{memory},~{cc}"(i64 %a0, i64 %a1, i64 %a2, i64 %nr)
  ret i64 %r
}

define internal i64 @__mtrt_darwin_syscall4(i64 %nr, i64 %a0, i64 %a1, i64 %a2, i64 %a3) {
entry:
  %r = call i64 asm sideeffect "mov x16, $5\0A svc #0x80\0A b.cc 1f\0A neg x0, x0\0A1:", "={x0},{x0},{x1},{x2},{x3},r,~{x16},~{memory},~{cc}"(i64 %a0, i64 %a1, i64 %a2, i64 %a3, i64 %nr)
  ret i64 %r
}

define internal i64 @__mtrt_darwin_syscall5(i64 %nr, i64 %a0, i64 %a1, i64 %a2, i64 %a3, i64 %a4) {
entry:
  %r = call i64 asm sideeffect "mov x16, $6\0A svc #0x80\0A b.cc 1f\0A neg x0, x0\0A1:", "={x0},{x0},{x1},{x2},{x3},{x4},r,~{x16},~{memory},~{cc}"(i64 %a0, i64 %a1, i64 %a2, i64 %a3, i64 %a4, i64 %nr)
  ret i64 %r
}

define internal i64 @__mtrt_darwin_clock_sleep_trap(i64 %clock, i64 %sleep_type, i64 %sec, i64 %nsec, ptr %rem) {
entry:
  %rem_i = ptrtoint ptr %rem to i64
  %r = call i64 asm sideeffect "mov x16, #-62\0A svc #0x80", "={x0},{x0},{x1},{x2},{x3},{x4},~{x16},~{memory},~{cc}"(i64 %clock, i64 %sleep_type, i64 %sec, i64 %nsec, i64 %rem_i)
  ret i64 %r
}

define internal i64 @__mtrt_darwin_pipe(ptr %fds) {
entry:
  %fds_i = ptrtoint ptr %fds to i64
  %r = call i64 asm sideeffect "mov x9, $1\0A mov x16, #42\0A svc #0x80\0A b.cc 1f\0A neg x0, x0\0A b 2f\0A1:\0A stp w0, w1, [x9]\0A mov x0, #0\0A2:", "={x0},r,~{x1},~{x9},~{x16},~{memory},~{cc}"(i64 %fds_i)
  ret i64 %r
}

define internal i64 @__mtrt_darwin_fork() {
entry:
  %r = call i64 asm sideeffect "mov x16, #2\0A svc #0x80\0A b.cc 1f\0A neg x0, x0\0A b 2f\0A1:\0A cbz x1, 2f\0A mov x0, #0\0A2:", "={x0},~{x1},~{x16},~{memory},~{cc}"()
  ret i64 %r
}

define internal i32 @__mtrt_darwin_open_flags_from_target(i32 %flags) {
entry:
  %access = and i32 %flags, 3
  %creat_bits = and i32 %flags, 64
  %has_creat = icmp ne i32 %creat_bits, 0
  %creat_value = select i1 %has_creat, i32 512, i32 0
  %with_creat = or i32 %access, %creat_value
  %excl_bits = and i32 %flags, 128
  %has_excl = icmp ne i32 %excl_bits, 0
  %excl_value = select i1 %has_excl, i32 2048, i32 0
  %with_excl = or i32 %with_creat, %excl_value
  %trunc_bits = and i32 %flags, 512
  %has_trunc = icmp ne i32 %trunc_bits, 0
  %trunc_value = select i1 %has_trunc, i32 1024, i32 0
  %with_trunc = or i32 %with_excl, %trunc_value
  %append_bits = and i32 %flags, 1024
  %has_append = icmp ne i32 %append_bits, 0
  %append_value = select i1 %has_append, i32 8, i32 0
  %mapped = or i32 %with_trunc, %append_value
  ret i32 %mapped
}

define internal i32 @__mtrt_darwin_dirfd_from_target(i64 %dirfd) {
entry:
  %dirfd32 = trunc i64 %dirfd to i32
  %is_at_fdcwd = icmp eq i32 %dirfd32, -100
  %mapped = select i1 %is_at_fdcwd, i32 -2, i32 %dirfd32
  ret i32 %mapped
}

define internal i32 @__mtrt_darwin_at_flags_from_target(i64 %flags) {
entry:
  %flags32 = trunc i64 %flags to i32
  %nofollow_bits = and i32 %flags32, 256
  %has_nofollow = icmp ne i32 %nofollow_bits, 0
  %mapped = select i1 %has_nofollow, i32 32, i32 0
  ret i32 %mapped
}

define internal i32 @__mtrt_darwin_unlinkat_flags_from_target(i64 %flags) {
entry:
  %flags32 = trunc i64 %flags to i32
  %is_zero = icmp eq i32 %flags32, 0
  br i1 %is_zero, label %zero, label %check_removedir

zero:
  ret i32 0

check_removedir:
  %is_removedir = icmp eq i32 %flags32, 512
  br i1 %is_removedir, label %removedir, label %invalid

removedir:
  ret i32 128

invalid:
  ret i32 -1
}

define internal i32 @__mtrt_darwin_faccessat_flags_from_target(i64 %flags) {
entry:
  %flags32 = trunc i64 %flags to i32
  %eaccess_bits = and i32 %flags32, 512
  %has_eaccess = icmp ne i32 %eaccess_bits, 0
  %eaccess_value = select i1 %has_eaccess, i32 16, i32 0
  %nofollow_bits = and i32 %flags32, 256
  %has_nofollow = icmp ne i32 %nofollow_bits, 0
  %nofollow_value = select i1 %has_nofollow, i32 32, i32 0
  %known = and i32 %flags32, 768
  %unknown = xor i32 %flags32, %known
  %ok = icmp eq i32 %unknown, 0
  %mapped = or i32 %eaccess_value, %nofollow_value
  %ret = select i1 %ok, i32 %mapped, i32 -1
  ret i32 %ret
}

define internal i32 @__mtrt_darwin_linkat_flags_from_target(i64 %flags) {
entry:
  %flags32 = trunc i64 %flags to i32
  %is_zero = icmp eq i32 %flags32, 0
  br i1 %is_zero, label %zero, label %check_follow

zero:
  ret i32 0

check_follow:
  %is_follow = icmp eq i32 %flags32, 1024
  br i1 %is_follow, label %follow, label %invalid

follow:
  ret i32 64

invalid:
  ret i32 -1
}

define internal i1 @__mtrt_darwin_at_flags_supported(i64 %flags) {
entry:
  %flags32 = trunc i64 %flags to i32
  %unknown = and i32 %flags32, -257
  %ok = icmp eq i32 %unknown, 0
  ret i1 %ok
}

define internal void @__mtrt_darwin_store_stat64(ptr %out, ptr %native) {
entry:
  %dev_p = getelementptr i8, ptr %native, i64 0
  %dev32 = load i32, ptr %dev_p, align 4
  %dev = zext i32 %dev32 to i64
  %mode_p = getelementptr i8, ptr %native, i64 4
  %mode16 = load i16, ptr %mode_p, align 2
  %mode = zext i16 %mode16 to i32
  %nlink_p = getelementptr i8, ptr %native, i64 6
  %nlink16 = load i16, ptr %nlink_p, align 2
  %nlink = zext i16 %nlink16 to i64
  %ino_p = getelementptr i8, ptr %native, i64 8
  %ino = load i64, ptr %ino_p, align 8
  %uid_p = getelementptr i8, ptr %native, i64 16
  %uid = load i32, ptr %uid_p, align 4
  %gid_p = getelementptr i8, ptr %native, i64 20
  %gid = load i32, ptr %gid_p, align 4
  %rdev_p = getelementptr i8, ptr %native, i64 24
  %rdev32 = load i32, ptr %rdev_p, align 4
  %rdev = zext i32 %rdev32 to i64
  %atime_sec_p = getelementptr i8, ptr %native, i64 32
  %atime_sec = load i64, ptr %atime_sec_p, align 8
  %atime_nsec_p = getelementptr i8, ptr %native, i64 40
  %atime_nsec = load i64, ptr %atime_nsec_p, align 8
  %mtime_sec_p = getelementptr i8, ptr %native, i64 48
  %mtime_sec = load i64, ptr %mtime_sec_p, align 8
  %mtime_nsec_p = getelementptr i8, ptr %native, i64 56
  %mtime_nsec = load i64, ptr %mtime_nsec_p, align 8
  %ctime_sec_p = getelementptr i8, ptr %native, i64 64
  %ctime_sec = load i64, ptr %ctime_sec_p, align 8
  %ctime_nsec_p = getelementptr i8, ptr %native, i64 72
  %ctime_nsec = load i64, ptr %ctime_nsec_p, align 8
  %size_p = getelementptr i8, ptr %native, i64 96
  %size = load i64, ptr %size_p, align 8
  %blocks_p = getelementptr i8, ptr %native, i64 104
  %blocks = load i64, ptr %blocks_p, align 8
  %blksize_p = getelementptr i8, ptr %native, i64 112
  %blksize32 = load i32, ptr %blksize_p, align 4
  %blksize = sext i32 %blksize32 to i64

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

define i64 @__mtrt_host_getpid() {
entry:
  %r = call i64 @__mtrt_darwin_syscall0(i64 20)
  ret i64 %r
}

define i64 @__mtrt_host_getppid() {
entry:
  %r = call i64 @__mtrt_darwin_syscall0(i64 39)
  ret i64 %r
}

define i64 @__mtrt_host_fork() {
entry:
  %r = call i64 @__mtrt_darwin_fork()
  ret i64 %r
}

define i64 @__mtrt_host_wait4(i64 %pid, ptr %status, i64 %options) {
entry:
  %status_i = ptrtoint ptr %status to i64
  %r = call i64 @__mtrt_darwin_syscall4(i64 7, i64 %pid, i64 %status_i, i64 %options, i64 0)
  ret i64 %r
}

define void @__mtrt_host_exit(i64 %status) {
entry:
  %_ = call i64 @__mtrt_darwin_syscall1(i64 1, i64 %status)
  unreachable
}

define i64 @__mtrt_host_write(i64 %fd, ptr %buf, i64 %count) {
entry:
  %buf_i = ptrtoint ptr %buf to i64
  %r = call i64 @__mtrt_darwin_syscall3(i64 4, i64 %fd, i64 %buf_i, i64 %count)
  ret i64 %r
}

define i64 @__mtrt_host_read(i64 %fd, ptr %buf, i64 %count) {
entry:
  %buf_i = ptrtoint ptr %buf to i64
  %r = call i64 @__mtrt_darwin_syscall3(i64 3, i64 %fd, i64 %buf_i, i64 %count)
  ret i64 %r
}

define i64 @__mtrt_host_close(i64 %fd) {
entry:
  %r = call i64 @__mtrt_darwin_syscall1(i64 6, i64 %fd)
  ret i64 %r
}

define i64 @__mtrt_host_nanosleep(ptr %req, ptr %rem) {
entry:
  %is_null = icmp eq ptr %req, null
  br i1 %is_null, label %fault, label %check

fault:
  ret i64 -14

check:
  %sec_p = getelementptr i8, ptr %req, i64 0
  %nsec_p = getelementptr i8, ptr %req, i64 8
  %sec = load i64, ptr %sec_p, align 8
  %nsec = load i64, ptr %nsec_p, align 8
  %sec_neg = icmp slt i64 %sec, 0
  %nsec_neg = icmp slt i64 %nsec, 0
  %nsec_big = icmp sge i64 %nsec, 1000000000
  %bad_nsec_0 = or i1 %nsec_neg, %nsec_big
  %bad_time_0 = or i1 %sec_neg, %bad_nsec_0
  %sec_too_big = icmp ugt i64 %sec, 4294967295
  %bad_time = or i1 %bad_time_0, %sec_too_big
  br i1 %bad_time, label %invalid, label %sleep

invalid:
  ret i64 -22

sleep:
  %native_rem = alloca [8 x i8], align 4
  %has_rem = icmp ne ptr %rem, null
  %rem_arg = select i1 %has_rem, ptr %native_rem, ptr null
  %r = call i64 @__mtrt_darwin_clock_sleep_trap(i64 0, i64 1, i64 %sec, i64 %nsec, ptr %rem_arg)
  %ok = icmp eq i64 %r, 0
  br i1 %ok, label %done, label %interrupted

done:
  ret i64 0

interrupted:
  ret i64 -4
}

define i64 @__mtrt_host_clock_gettime(i64 %clockid, ptr %tp) {
entry:
  %is_realtime = icmp eq i64 %clockid, 0
  br i1 %is_realtime, label %check_ptr, label %invalid

invalid:
  ret i64 -22

check_ptr:
  %is_null = icmp eq ptr %tp, null
  br i1 %is_null, label %fault, label %call_time

fault:
  ret i64 -14

call_time:
  %tv = alloca [16 x i8], align 8
  %tv_i = ptrtoint ptr %tv to i64
  %r = call i64 @__mtrt_darwin_syscall2(i64 116, i64 %tv_i, i64 0)
  %ok = icmp eq i64 %r, 0
  br i1 %ok, label %store, label %done

store:
  %sec_p = getelementptr i8, ptr %tv, i64 0
  %usec_p = getelementptr i8, ptr %tv, i64 8
  %sec = load i64, ptr %sec_p, align 8
  %usec32 = load i32, ptr %usec_p, align 4
  %usec = sext i32 %usec32 to i64
  %nsec = mul i64 %usec, 1000
  %tp_sec_p = getelementptr i8, ptr %tp, i64 0
  %tp_nsec_p = getelementptr i8, ptr %tp, i64 8
  store i64 %sec, ptr %tp_sec_p, align 8
  store i64 %nsec, ptr %tp_nsec_p, align 8
  ret i64 0

done:
  ret i64 %r
}

define i64 @__mtrt_host_kill(i64 %pid, i64 %sig) {
entry:
  %r = call i64 @__mtrt_darwin_syscall2(i64 37, i64 %pid, i64 %sig)
  ret i64 %r
}

define i64 @__mtrt_host_dup(i64 %oldfd) {
entry:
  %r = call i64 @__mtrt_darwin_syscall1(i64 41, i64 %oldfd)
  ret i64 %r
}

define i64 @__mtrt_host_dup2(i64 %oldfd, i64 %newfd) {
entry:
  %r = call i64 @__mtrt_darwin_syscall2(i64 90, i64 %oldfd, i64 %newfd)
  ret i64 %r
}

define i64 @__mtrt_host_chdir(ptr %path) {
entry:
  %path_i = ptrtoint ptr %path to i64
  %r = call i64 @__mtrt_darwin_syscall1(i64 12, i64 %path_i)
  ret i64 %r
}

define i64 @__mtrt_host_fchdir(i64 %fd) {
entry:
  %r = call i64 @__mtrt_darwin_syscall1(i64 13, i64 %fd)
  ret i64 %r
}

define i64 @__mtrt_host_getpgid(i64 %pid) {
entry:
  %r = call i64 @__mtrt_darwin_syscall1(i64 151, i64 %pid)
  ret i64 %r
}

define i64 @__mtrt_host_getpgrp() {
entry:
  %r = call i64 @__mtrt_darwin_syscall0(i64 81)
  ret i64 %r
}

define i64 @__mtrt_host_getsid(i64 %pid) {
entry:
  %r = call i64 @__mtrt_darwin_syscall1(i64 310, i64 %pid)
  ret i64 %r
}

define i64 @__mtrt_host_setpgid(i64 %pid, i64 %pgid) {
entry:
  %r = call i64 @__mtrt_darwin_syscall2(i64 82, i64 %pid, i64 %pgid)
  ret i64 %r
}

define i64 @__mtrt_host_setsid() {
entry:
  %r = call i64 @__mtrt_darwin_syscall0(i64 147)
  ret i64 %r
}

define i64 @__mtrt_host_umask(i64 %mask) {
entry:
  %r = call i64 @__mtrt_darwin_syscall1(i64 60, i64 %mask)
  ret i64 %r
}

define i64 @__mtrt_host_pipe(ptr %fds) {
entry:
  %is_null = icmp eq ptr %fds, null
  br i1 %is_null, label %fault, label %call_pipe

fault:
  ret i64 -14

call_pipe:
  %r = call i64 @__mtrt_darwin_pipe(ptr %fds)
  ret i64 %r
}

define i64 @__mtrt_host_readv(i64 %fd, ptr %iov, i64 %iovcnt) {
entry:
  %iov_i = ptrtoint ptr %iov to i64
  %r = call i64 @__mtrt_darwin_syscall3(i64 120, i64 %fd, i64 %iov_i, i64 %iovcnt)
  ret i64 %r
}

define i64 @__mtrt_host_writev(i64 %fd, ptr %iov, i64 %iovcnt) {
entry:
  %iov_i = ptrtoint ptr %iov to i64
  %r = call i64 @__mtrt_darwin_syscall3(i64 121, i64 %fd, i64 %iov_i, i64 %iovcnt)
  ret i64 %r
}

define i64 @__mtrt_host_open(ptr %path, i64 %flags, i64 %mode) {
entry:
  %flags32 = trunc i64 %flags to i32
  %mode32 = trunc i64 %mode to i32
  %mapped_flags = call i32 @__mtrt_darwin_open_flags_from_target(i32 %flags32)
  %path_i = ptrtoint ptr %path to i64
  %flags64 = sext i32 %mapped_flags to i64
  %mode64 = sext i32 %mode32 to i64
  %r = call i64 @__mtrt_darwin_syscall3(i64 5, i64 %path_i, i64 %flags64, i64 %mode64)
  ret i64 %r
}

define i64 @__mtrt_host_openat(i64 %dirfd, ptr %path, i64 %flags, i64 %mode) {
entry:
  %dirfd32 = call i32 @__mtrt_darwin_dirfd_from_target(i64 %dirfd)
  %flags32 = trunc i64 %flags to i32
  %mode32 = trunc i64 %mode to i32
  %mapped_flags = call i32 @__mtrt_darwin_open_flags_from_target(i32 %flags32)
  %dirfd64 = sext i32 %dirfd32 to i64
  %path_i = ptrtoint ptr %path to i64
  %flags64 = sext i32 %mapped_flags to i64
  %mode64 = sext i32 %mode32 to i64
  %r = call i64 @__mtrt_darwin_syscall4(i64 463, i64 %dirfd64, i64 %path_i, i64 %flags64, i64 %mode64)
  ret i64 %r
}

define i64 @__mtrt_host_lseek(i64 %fd, i64 %offset, i64 %whence) {
entry:
  %whence32 = trunc i64 %whence to i32
  %whence64 = sext i32 %whence32 to i64
  %r = call i64 @__mtrt_darwin_syscall3(i64 199, i64 %fd, i64 %offset, i64 %whence64)
  ret i64 %r
}

define i64 @__mtrt_host_pread(i64 %fd, ptr %buf, i64 %count, i64 %offset) {
entry:
  %buf_i = ptrtoint ptr %buf to i64
  %r = call i64 @__mtrt_darwin_syscall4(i64 153, i64 %fd, i64 %buf_i, i64 %count, i64 %offset)
  ret i64 %r
}

define i64 @__mtrt_host_pwrite(i64 %fd, ptr %buf, i64 %count, i64 %offset) {
entry:
  %buf_i = ptrtoint ptr %buf to i64
  %r = call i64 @__mtrt_darwin_syscall4(i64 154, i64 %fd, i64 %buf_i, i64 %count, i64 %offset)
  ret i64 %r
}

define i64 @__mtrt_host_unlink(ptr %path) {
entry:
  %path_i = ptrtoint ptr %path to i64
  %r = call i64 @__mtrt_darwin_syscall1(i64 10, i64 %path_i)
  ret i64 %r
}

define i64 @__mtrt_host_unlinkat(i64 %dirfd, ptr %path, i64 %flags) {
entry:
  %dirfd32 = call i32 @__mtrt_darwin_dirfd_from_target(i64 %dirfd)
  %flags32 = call i32 @__mtrt_darwin_unlinkat_flags_from_target(i64 %flags)
  %bad_flags = icmp eq i32 %flags32, -1
  br i1 %bad_flags, label %invalid, label %call_unlinkat

invalid:
  ret i64 -22

call_unlinkat:
  %dirfd64 = sext i32 %dirfd32 to i64
  %path_i = ptrtoint ptr %path to i64
  %flags64 = sext i32 %flags32 to i64
  %r = call i64 @__mtrt_darwin_syscall3(i64 472, i64 %dirfd64, i64 %path_i, i64 %flags64)
  ret i64 %r
}

define i64 @__mtrt_host_access(ptr %path, i64 %mode) {
entry:
  %path_i = ptrtoint ptr %path to i64
  %r = call i64 @__mtrt_darwin_syscall2(i64 33, i64 %path_i, i64 %mode)
  ret i64 %r
}

define i64 @__mtrt_host_faccessat(i64 %dirfd, ptr %path, i64 %mode, i64 %flags) {
entry:
  %dirfd32 = call i32 @__mtrt_darwin_dirfd_from_target(i64 %dirfd)
  %flags32 = call i32 @__mtrt_darwin_faccessat_flags_from_target(i64 %flags)
  %bad_flags = icmp eq i32 %flags32, -1
  br i1 %bad_flags, label %invalid, label %call_faccessat

invalid:
  ret i64 -22

call_faccessat:
  %dirfd64 = sext i32 %dirfd32 to i64
  %path_i = ptrtoint ptr %path to i64
  %flags64 = sext i32 %flags32 to i64
  %r = call i64 @__mtrt_darwin_syscall4(i64 466, i64 %dirfd64, i64 %path_i, i64 %mode, i64 %flags64)
  ret i64 %r
}

define i64 @__mtrt_host_chmod(ptr %path, i64 %mode) {
entry:
  %path_i = ptrtoint ptr %path to i64
  %r = call i64 @__mtrt_darwin_syscall2(i64 15, i64 %path_i, i64 %mode)
  ret i64 %r
}

define i64 @__mtrt_host_fchmod(i64 %fd, i64 %mode) {
entry:
  %r = call i64 @__mtrt_darwin_syscall2(i64 124, i64 %fd, i64 %mode)
  ret i64 %r
}

define i64 @__mtrt_host_fchmodat(i64 %dirfd, ptr %path, i64 %mode, i64 %flags) {
entry:
  %dirfd32 = call i32 @__mtrt_darwin_dirfd_from_target(i64 %dirfd)
  %flags_ok = call i1 @__mtrt_darwin_at_flags_supported(i64 %flags)
  br i1 %flags_ok, label %call_fchmodat, label %invalid

invalid:
  ret i64 -22

call_fchmodat:
  %flags32 = call i32 @__mtrt_darwin_at_flags_from_target(i64 %flags)
  %dirfd64 = sext i32 %dirfd32 to i64
  %path_i = ptrtoint ptr %path to i64
  %flags64 = sext i32 %flags32 to i64
  %r = call i64 @__mtrt_darwin_syscall4(i64 467, i64 %dirfd64, i64 %path_i, i64 %mode, i64 %flags64)
  ret i64 %r
}

define i64 @__mtrt_host_link(ptr %oldpath, ptr %newpath) {
entry:
  %oldpath_i = ptrtoint ptr %oldpath to i64
  %newpath_i = ptrtoint ptr %newpath to i64
  %r = call i64 @__mtrt_darwin_syscall2(i64 9, i64 %oldpath_i, i64 %newpath_i)
  ret i64 %r
}

define i64 @__mtrt_host_linkat(i64 %olddirfd, ptr %oldpath, i64 %newdirfd, ptr %newpath, i64 %flags) {
entry:
  %olddirfd32 = call i32 @__mtrt_darwin_dirfd_from_target(i64 %olddirfd)
  %newdirfd32 = call i32 @__mtrt_darwin_dirfd_from_target(i64 %newdirfd)
  %flags32 = call i32 @__mtrt_darwin_linkat_flags_from_target(i64 %flags)
  %bad_flags = icmp eq i32 %flags32, -1
  br i1 %bad_flags, label %invalid, label %call_linkat

invalid:
  ret i64 -22

call_linkat:
  %olddirfd64 = sext i32 %olddirfd32 to i64
  %newdirfd64 = sext i32 %newdirfd32 to i64
  %oldpath_i = ptrtoint ptr %oldpath to i64
  %newpath_i = ptrtoint ptr %newpath to i64
  %flags64 = sext i32 %flags32 to i64
  %r = call i64 @__mtrt_darwin_syscall5(i64 471, i64 %olddirfd64, i64 %oldpath_i, i64 %newdirfd64, i64 %newpath_i, i64 %flags64)
  ret i64 %r
}

define i64 @__mtrt_host_mkdir(ptr %path, i64 %mode) {
entry:
  %path_i = ptrtoint ptr %path to i64
  %r = call i64 @__mtrt_darwin_syscall2(i64 136, i64 %path_i, i64 %mode)
  ret i64 %r
}

define i64 @__mtrt_host_mkdirat(i64 %dirfd, ptr %path, i64 %mode) {
entry:
  %dirfd32 = call i32 @__mtrt_darwin_dirfd_from_target(i64 %dirfd)
  %dirfd64 = sext i32 %dirfd32 to i64
  %path_i = ptrtoint ptr %path to i64
  %r = call i64 @__mtrt_darwin_syscall3(i64 475, i64 %dirfd64, i64 %path_i, i64 %mode)
  ret i64 %r
}

define i64 @__mtrt_host_readlink(ptr %path, ptr %buf, i64 %size) {
entry:
  %path_i = ptrtoint ptr %path to i64
  %buf_i = ptrtoint ptr %buf to i64
  %r = call i64 @__mtrt_darwin_syscall3(i64 58, i64 %path_i, i64 %buf_i, i64 %size)
  ret i64 %r
}

define i64 @__mtrt_host_readlinkat(i64 %dirfd, ptr %path, ptr %buf, i64 %size) {
entry:
  %dirfd32 = call i32 @__mtrt_darwin_dirfd_from_target(i64 %dirfd)
  %dirfd64 = sext i32 %dirfd32 to i64
  %path_i = ptrtoint ptr %path to i64
  %buf_i = ptrtoint ptr %buf to i64
  %r = call i64 @__mtrt_darwin_syscall4(i64 473, i64 %dirfd64, i64 %path_i, i64 %buf_i, i64 %size)
  ret i64 %r
}

define i64 @__mtrt_host_rename(ptr %oldpath, ptr %newpath) {
entry:
  %oldpath_i = ptrtoint ptr %oldpath to i64
  %newpath_i = ptrtoint ptr %newpath to i64
  %r = call i64 @__mtrt_darwin_syscall2(i64 128, i64 %oldpath_i, i64 %newpath_i)
  ret i64 %r
}

define i64 @__mtrt_host_renameat(i64 %olddirfd, ptr %oldpath, i64 %newdirfd, ptr %newpath) {
entry:
  %olddirfd32 = call i32 @__mtrt_darwin_dirfd_from_target(i64 %olddirfd)
  %newdirfd32 = call i32 @__mtrt_darwin_dirfd_from_target(i64 %newdirfd)
  %olddirfd64 = sext i32 %olddirfd32 to i64
  %newdirfd64 = sext i32 %newdirfd32 to i64
  %oldpath_i = ptrtoint ptr %oldpath to i64
  %newpath_i = ptrtoint ptr %newpath to i64
  %r = call i64 @__mtrt_darwin_syscall4(i64 465, i64 %olddirfd64, i64 %oldpath_i, i64 %newdirfd64, i64 %newpath_i)
  ret i64 %r
}

define i64 @__mtrt_host_rmdir(ptr %path) {
entry:
  %path_i = ptrtoint ptr %path to i64
  %r = call i64 @__mtrt_darwin_syscall1(i64 137, i64 %path_i)
  ret i64 %r
}

define i64 @__mtrt_host_symlink(ptr %target, ptr %linkpath) {
entry:
  %target_i = ptrtoint ptr %target to i64
  %linkpath_i = ptrtoint ptr %linkpath to i64
  %r = call i64 @__mtrt_darwin_syscall2(i64 57, i64 %target_i, i64 %linkpath_i)
  ret i64 %r
}

define i64 @__mtrt_host_symlinkat(ptr %target, i64 %newdirfd, ptr %linkpath) {
entry:
  %newdirfd32 = call i32 @__mtrt_darwin_dirfd_from_target(i64 %newdirfd)
  %newdirfd64 = sext i32 %newdirfd32 to i64
  %target_i = ptrtoint ptr %target to i64
  %linkpath_i = ptrtoint ptr %linkpath to i64
  %r = call i64 @__mtrt_darwin_syscall3(i64 474, i64 %target_i, i64 %newdirfd64, i64 %linkpath_i)
  ret i64 %r
}

define i64 @__mtrt_host_stat(ptr %path, ptr %buf) {
entry:
  %is_null = icmp eq ptr %buf, null
  br i1 %is_null, label %fault, label %call_stat

fault:
  ret i64 -14

call_stat:
  %native = alloca [144 x i8], align 8
  %path_i = ptrtoint ptr %path to i64
  %native_i = ptrtoint ptr %native to i64
  %r = call i64 @__mtrt_darwin_syscall2(i64 338, i64 %path_i, i64 %native_i)
  %ok = icmp eq i64 %r, 0
  br i1 %ok, label %store, label %done

store:
  call void @__mtrt_darwin_store_stat64(ptr %buf, ptr %native)
  ret i64 0

done:
  ret i64 %r
}

define i64 @__mtrt_host_fstat(i64 %fd, ptr %buf) {
entry:
  %is_null = icmp eq ptr %buf, null
  br i1 %is_null, label %fault, label %call_fstat

fault:
  ret i64 -14

call_fstat:
  %native = alloca [144 x i8], align 8
  %native_i = ptrtoint ptr %native to i64
  %r = call i64 @__mtrt_darwin_syscall2(i64 339, i64 %fd, i64 %native_i)
  %ok = icmp eq i64 %r, 0
  br i1 %ok, label %store, label %done

store:
  call void @__mtrt_darwin_store_stat64(ptr %buf, ptr %native)
  ret i64 0

done:
  ret i64 %r
}

define i64 @__mtrt_host_lstat(ptr %path, ptr %buf) {
entry:
  %is_null = icmp eq ptr %buf, null
  br i1 %is_null, label %fault, label %call_lstat

fault:
  ret i64 -14

call_lstat:
  %native = alloca [144 x i8], align 8
  %path_i = ptrtoint ptr %path to i64
  %native_i = ptrtoint ptr %native to i64
  %r = call i64 @__mtrt_darwin_syscall2(i64 340, i64 %path_i, i64 %native_i)
  %ok = icmp eq i64 %r, 0
  br i1 %ok, label %store, label %done

store:
  call void @__mtrt_darwin_store_stat64(ptr %buf, ptr %native)
  ret i64 0

done:
  ret i64 %r
}

define i64 @__mtrt_host_fstatat(i64 %dirfd, ptr %path, ptr %buf, i64 %flags) {
entry:
  %is_null = icmp eq ptr %buf, null
  br i1 %is_null, label %fault, label %check_flags

fault:
  ret i64 -14

check_flags:
  %flags_ok = call i1 @__mtrt_darwin_at_flags_supported(i64 %flags)
  br i1 %flags_ok, label %call_fstatat, label %invalid

invalid:
  ret i64 -22

call_fstatat:
  %dirfd32 = call i32 @__mtrt_darwin_dirfd_from_target(i64 %dirfd)
  %flags32 = call i32 @__mtrt_darwin_at_flags_from_target(i64 %flags)
  %native = alloca [144 x i8], align 8
  %dirfd64 = sext i32 %dirfd32 to i64
  %path_i = ptrtoint ptr %path to i64
  %native_i = ptrtoint ptr %native to i64
  %flags64 = sext i32 %flags32 to i64
  %r = call i64 @__mtrt_darwin_syscall4(i64 470, i64 %dirfd64, i64 %path_i, i64 %native_i, i64 %flags64)
  %ok = icmp eq i64 %r, 0
  br i1 %ok, label %store, label %done

store:
  call void @__mtrt_darwin_store_stat64(ptr %buf, ptr %native)
  ret i64 0

done:
  ret i64 %r
}
