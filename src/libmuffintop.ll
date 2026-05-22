; libmuffintop public LLVM IR ABI surface.
; Public names are POSIX-derived, but the target ABI is not the C POSIX ABI.
; Target-aligned primitives return negative POSIX errno values directly.

%struct.timespec = type { i64, i64 }
%struct.mtrt_stat64 = type { i64, i64, i64, i32, i32, i32, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64 }

@__mtrt_poc_sigcont = constant i32 19, align 4

declare i64 @__mtrt_host_getpid()
declare i64 @__mtrt_host_getppid()
declare i64 @__mtrt_host_getuid()
declare i64 @__mtrt_host_geteuid()
declare i64 @__mtrt_host_getgid()
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
declare i64 @__mtrt_host_mkfifo(ptr, i64)
declare i64 @__mtrt_host_readlink(ptr, ptr, i64)
declare i64 @__mtrt_host_readlinkat(i64, ptr, ptr, i64)
declare i64 @__mtrt_host_rename(ptr, ptr)
declare i64 @__mtrt_host_renameat(i64, ptr, i64, ptr)
declare i64 @__mtrt_host_rmdir(ptr)
declare i64 @__mtrt_host_symlink(ptr, ptr)
declare i64 @__mtrt_host_symlinkat(ptr, i64, ptr)
declare i64 @__mtrt_host_tcgetattr(i64, ptr)
declare i64 @__mtrt_host_tcsetattr(i64, i64, ptr)
declare i64 @__mtrt_host_tcdrain(i64)
declare i64 @__mtrt_host_tcflow(i64, i64)
declare i64 @__mtrt_host_tcflush(i64, i64)
declare i64 @__mtrt_host_tcsendbreak(i64, i64)
declare i64 @__mtrt_host_tcgetpgrp(i64)
declare i64 @__mtrt_host_tcsetpgrp(i64, i64)
declare i64 @__mtrt_host_isatty(i64)
declare i64 @__mtrt_host_stat(ptr, ptr)
declare i64 @__mtrt_host_fstat(i64, ptr)
declare i64 @__mtrt_host_lstat(ptr, ptr)
declare i64 @__mtrt_host_fstatat(i64, ptr, ptr, i64)
declare i64 @__mtrt_host_ftruncate(i64, i64)
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
declare i64 @__mtrt_host_mmap(i64, i64, i64, i64, i64, i64)
declare i64 @__mtrt_host_mprotect(i64, i64, i64)
declare i64 @__mtrt_host_msync(i64, i64, i64)
declare i64 @__mtrt_host_munlock(i64, i64)
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
declare i64 @__mtrt_host_utimes(ptr, ptr)

define i8 @__mtrt_common_dtype(i8 %dtype) {
entry:
  switch i8 %dtype, label %unknown [
    i8 1, label %known
    i8 2, label %known
    i8 4, label %known
    i8 6, label %known
    i8 8, label %known
    i8 10, label %known
    i8 12, label %known
  ]

known:
  ret i8 %dtype

unknown:
  ret i8 0
}

define i64 @__mtrt_name_len_bounded(ptr %name, i64 %limit) {
entry:
  br label %loop

loop:
  %i = phi i64 [ 0, %entry ], [ %next, %cont ]
  %at_limit = icmp uge i64 %i, %limit
  br i1 %at_limit, label %done, label %check

check:
  %p = getelementptr i8, ptr %name, i64 %i
  %c = load i8, ptr %p, align 1
  %is_zero = icmp eq i8 %c, 0
  br i1 %is_zero, label %done, label %cont

cont:
  %next = add i64 %i, 1
  br label %loop

done:
  ret i64 %i
}

define void @__mtrt_store_dent64(ptr %dst, i64 %ino, i64 %reclen, i8 %dtype, ptr %name, i64 %name_len) {
entry:
  store i64 %ino, ptr %dst, align 8
  %reclen_p = getelementptr i8, ptr %dst, i64 8
  %reclen32 = trunc i64 %reclen to i32
  store i32 %reclen32, ptr %reclen_p, align 4
  %dtype_p = getelementptr i8, ptr %dst, i64 12
  store i8 %dtype, ptr %dtype_p, align 1
  %pad0_p = getelementptr i8, ptr %dst, i64 13
  store i8 0, ptr %pad0_p, align 1
  %pad1_p = getelementptr i8, ptr %dst, i64 14
  store i8 0, ptr %pad1_p, align 1
  %pad2_p = getelementptr i8, ptr %dst, i64 15
  store i8 0, ptr %pad2_p, align 1
  %first_pad = add i64 %name_len, 17
  br label %copy_loop

copy_loop:
  %i = phi i64 [ 0, %entry ], [ %next, %copy ]
  %copy_done = icmp ugt i64 %i, %name_len
  br i1 %copy_done, label %pad_loop, label %copy

copy:
  %src_p = getelementptr i8, ptr %name, i64 %i
  %dst_name_base = getelementptr i8, ptr %dst, i64 16
  %dst_p = getelementptr i8, ptr %dst_name_base, i64 %i
  %c = load i8, ptr %src_p, align 1
  store i8 %c, ptr %dst_p, align 1
  %next = add i64 %i, 1
  br label %copy_loop

pad_loop:
  %pad_i = phi i64 [ %first_pad, %copy_loop ], [ %pad_next, %pad ]
  %pad_done = icmp uge i64 %pad_i, %reclen
  br i1 %pad_done, label %done, label %pad

pad:
  %pad_p = getelementptr i8, ptr %dst, i64 %pad_i
  store i8 0, ptr %pad_p, align 1
  %pad_next = add i64 %pad_i, 1
  br label %pad_loop

done:
  ret void
}

define internal i1 @__mtrt_open_flags_supported(i32 %flags) {
entry:
  %known = and i32 %flags, 1731
  %unknown = xor i32 %flags, %known
  %bits_ok = icmp eq i32 %unknown, 0
  %access = and i32 %flags, 3
  %access_ok = icmp ne i32 %access, 3
  %ok = and i1 %bits_ok, %access_ok
  ret i1 %ok
}

define internal i1 @__mtrt_mmap_flags_supported(i32 %flags) {
entry:
  %known = and i32 %flags, 51
  %unknown = xor i32 %flags, %known
  %bits_ok = icmp eq i32 %unknown, 0
  %sharing = and i32 %flags, 3
  %is_shared = icmp eq i32 %sharing, 1
  %is_private = icmp eq i32 %sharing, 2
  %sharing_ok = or i1 %is_shared, %is_private
  %ok = and i1 %bits_ok, %sharing_ok
  ret i1 %ok
}

define internal i1 @__mtrt_msync_flags_supported(i32 %flags) {
entry:
  %known = and i32 %flags, 7
  %unknown = xor i32 %flags, %known
  %bits_ok = icmp eq i32 %unknown, 0
  %sync_selector = and i32 %flags, 5
  %is_async = icmp eq i32 %sync_selector, 1
  %is_sync = icmp eq i32 %sync_selector, 4
  %selector_ok = or i1 %is_async, %is_sync
  %ok = and i1 %bits_ok, %selector_ok
  ret i1 %ok
}

define internal i1 @__mtrt_file_mode_supported(i32 %mode) {
entry:
  %known = and i32 %mode, 4095
  %unknown = xor i32 %mode, %known
  %ok = icmp eq i32 %unknown, 0
  ret i1 %ok
}

define internal i1 @__mtrt_access_mode_supported(i32 %mode) {
entry:
  %known = and i32 %mode, 7
  %unknown = xor i32 %mode, %known
  %ok = icmp eq i32 %unknown, 0
  ret i1 %ok
}

define internal i1 @__mtrt_prot_supported(i32 %prot) {
entry:
  %known = and i32 %prot, 7
  %unknown = xor i32 %prot, %known
  %ok = icmp eq i32 %unknown, 0
  ret i1 %ok
}

define internal i1 @__mtrt_madvise_supported(i32 %advice) {
entry:
  %nonnegative = icmp sge i32 %advice, 0
  %in_range = icmp sle i32 %advice, 4
  %ok = and i1 %nonnegative, %in_range
  ret i1 %ok
}

define internal i1 @__mtrt_lseek_whence_supported(i32 %whence) {
entry:
  %nonnegative = icmp sge i32 %whence, 0
  %in_range = icmp sle i32 %whence, 2
  %ok = and i1 %nonnegative, %in_range
  ret i1 %ok
}

define internal i1 @__mtrt_waitpid_options_supported(i32 %options) {
entry:
  %known = and i32 %options, 11
  %unknown = xor i32 %options, %known
  %ok = icmp eq i32 %unknown, 0
  ret i1 %ok
}

define internal i1 @__mtrt_pipe2_flags_supported(i32 %flags) {
entry:
  %known = and i32 %flags, 526336
  %unknown = xor i32 %flags, %known
  %ok = icmp eq i32 %unknown, 0
  ret i1 %ok
}

define internal i1 @__mtrt_fcntl_cmd_supported(i32 %cmd) {
entry:
  %nonnegative = icmp sge i32 %cmd, 0
  %in_range = icmp sle i32 %cmd, 7
  %ok = and i1 %nonnegative, %in_range
  ret i1 %ok
}

define internal i1 @__mtrt_fcntl_arg_supported(i32 %cmd, i64 %arg) {
entry:
  switch i32 %cmd, label %ok [
    i32 2, label %setfd
    i32 4, label %setfl
  ]

setfd:
  %fd_known = and i64 %arg, 1
  %fd_unknown = xor i64 %arg, %fd_known
  %fd_ok = icmp eq i64 %fd_unknown, 0
  ret i1 %fd_ok

setfl:
  %fl_known = and i64 %arg, 3075
  %fl_unknown = xor i64 %arg, %fl_known
  %fl_bits_ok = icmp eq i64 %fl_unknown, 0
  %fl_access = and i64 %arg, 3
  %fl_access_ok = icmp ne i64 %fl_access, 3
  %fl_ok = and i1 %fl_bits_ok, %fl_access_ok
  ret i1 %fl_ok

ok:
  ret i1 true
}

define internal i1 @__mtrt_at_nofollow_flags_supported(i32 %flags) {
entry:
  %known = and i32 %flags, 256
  %unknown = xor i32 %flags, %known
  %ok = icmp eq i32 %unknown, 0
  ret i1 %ok
}

define internal i1 @__mtrt_faccessat_flags_supported(i32 %flags) {
entry:
  %known = and i32 %flags, 768
  %unknown = xor i32 %flags, %known
  %ok = icmp eq i32 %unknown, 0
  ret i1 %ok
}

define internal i1 @__mtrt_linkat_flags_supported(i32 %flags) {
entry:
  %is_zero = icmp eq i32 %flags, 0
  %is_follow = icmp eq i32 %flags, 1024
  %ok = or i1 %is_zero, %is_follow
  ret i1 %ok
}

define internal i1 @__mtrt_unlinkat_flags_supported(i32 %flags) {
entry:
  %is_zero = icmp eq i32 %flags, 0
  %is_removedir = icmp eq i32 %flags, 512
  %ok = or i1 %is_zero, %is_removedir
  ret i1 %ok
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

define i32 @getuid() {
entry:
  %raw = call i64 @__mtrt_host_getuid()
  %ret = trunc i64 %raw to i32
  ret i32 %ret
}

define i32 @geteuid() {
entry:
  %raw = call i64 @__mtrt_host_geteuid()
  %ret = trunc i64 %raw to i32
  ret i32 %ret
}

define i32 @getgid() {
entry:
  %raw = call i64 @__mtrt_host_getgid()
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
  %options_ok = call i1 @__mtrt_waitpid_options_supported(i32 %options)
  br i1 %options_ok, label %call_host, label %invalid

call_host:
  %pid64 = sext i32 %pid to i64
  %opt64 = sext i32 %options to i64
  %raw = call i64 @__mtrt_host_wait4(i64 %pid64, ptr %status, i64 %opt64)
  %ret = trunc i64 %raw to i32
  ret i32 %ret

invalid:
  ret i32 -22
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
  %mask_ok = call i1 @__mtrt_file_mode_supported(i32 %mask)
  br i1 %mask_ok, label %call_host, label %invalid

call_host:
  %mask64 = sext i32 %mask to i64
  %raw = call i64 @__mtrt_host_umask(i64 %mask64)
  %ret = trunc i64 %raw to i32
  ret i32 %ret

invalid:
  ret i32 -22
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
  %flags_ok = call i1 @__mtrt_open_flags_supported(i32 %flags)
  %mode_ok = call i1 @__mtrt_file_mode_supported(i32 %mode)
  %ok = and i1 %flags_ok, %mode_ok
  br i1 %ok, label %call_host, label %invalid

call_host:
  %flags64 = sext i32 %flags to i64
  %mode64 = sext i32 %mode to i64
  %raw = call i64 @__mtrt_host_open(ptr %path, i64 %flags64, i64 %mode64)
  %ret = trunc i64 %raw to i32
  ret i32 %ret

invalid:
  ret i32 -22
}

define i32 @openat(i32 %dirfd, ptr %path, i32 %flags, i32 %mode) {
entry:
  %flags_ok = call i1 @__mtrt_open_flags_supported(i32 %flags)
  %mode_ok = call i1 @__mtrt_file_mode_supported(i32 %mode)
  %ok = and i1 %flags_ok, %mode_ok
  br i1 %ok, label %call_host, label %invalid

call_host:
  %dirfd64 = sext i32 %dirfd to i64
  %flags64 = sext i32 %flags to i64
  %mode64 = sext i32 %mode to i64
  %raw = call i64 @__mtrt_host_openat(i64 %dirfd64, ptr %path, i64 %flags64, i64 %mode64)
  %ret = trunc i64 %raw to i32
  ret i32 %ret

invalid:
  ret i32 -22
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
  %whence_ok = call i1 @__mtrt_lseek_whence_supported(i32 %whence)
  br i1 %whence_ok, label %call_host, label %invalid

call_host:
  %fd64 = sext i32 %fd to i64
  %whence64 = sext i32 %whence to i64
  %raw = call i64 @__mtrt_host_lseek(i64 %fd64, i64 %offset, i64 %whence64)
  ret i64 %raw

invalid:
  ret i64 -22
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
  %flags_ok = call i1 @__mtrt_unlinkat_flags_supported(i32 %flags)
  br i1 %flags_ok, label %call_host, label %invalid

call_host:
  %dirfd64 = sext i32 %dirfd to i64
  %flags64 = sext i32 %flags to i64
  %raw = call i64 @__mtrt_host_unlinkat(i64 %dirfd64, ptr %path, i64 %flags64)
  %ret = trunc i64 %raw to i32
  ret i32 %ret

invalid:
  ret i32 -22
}

define i32 @access(ptr %path, i32 %mode) {
entry:
  %mode_ok = call i1 @__mtrt_access_mode_supported(i32 %mode)
  br i1 %mode_ok, label %call_host, label %invalid

call_host:
  %mode64 = sext i32 %mode to i64
  %raw = call i64 @__mtrt_host_access(ptr %path, i64 %mode64)
  %ret = trunc i64 %raw to i32
  ret i32 %ret

invalid:
  ret i32 -22
}

define i32 @faccessat(i32 %dirfd, ptr %path, i32 %mode, i32 %flags) {
entry:
  %flags_ok = call i1 @__mtrt_faccessat_flags_supported(i32 %flags)
  %mode_ok = call i1 @__mtrt_access_mode_supported(i32 %mode)
  %ok = and i1 %flags_ok, %mode_ok
  br i1 %ok, label %call_host, label %invalid

call_host:
  %dirfd64 = sext i32 %dirfd to i64
  %mode64 = sext i32 %mode to i64
  %flags64 = sext i32 %flags to i64
  %raw = call i64 @__mtrt_host_faccessat(i64 %dirfd64, ptr %path, i64 %mode64, i64 %flags64)
  %ret = trunc i64 %raw to i32
  ret i32 %ret

invalid:
  ret i32 -22
}

define i32 @chmod(ptr %path, i32 %mode) {
entry:
  %mode_ok = call i1 @__mtrt_file_mode_supported(i32 %mode)
  br i1 %mode_ok, label %call_host, label %invalid

call_host:
  %mode64 = sext i32 %mode to i64
  %raw = call i64 @__mtrt_host_chmod(ptr %path, i64 %mode64)
  %ret = trunc i64 %raw to i32
  ret i32 %ret

invalid:
  ret i32 -22
}

define i32 @fchmod(i32 %fd, i32 %mode) {
entry:
  %mode_ok = call i1 @__mtrt_file_mode_supported(i32 %mode)
  br i1 %mode_ok, label %call_host, label %invalid

call_host:
  %fd64 = sext i32 %fd to i64
  %mode64 = sext i32 %mode to i64
  %raw = call i64 @__mtrt_host_fchmod(i64 %fd64, i64 %mode64)
  %ret = trunc i64 %raw to i32
  ret i32 %ret

invalid:
  ret i32 -22
}

define i32 @fchmodat(i32 %dirfd, ptr %path, i32 %mode, i32 %flags) {
entry:
  %flags_ok = call i1 @__mtrt_at_nofollow_flags_supported(i32 %flags)
  %mode_ok = call i1 @__mtrt_file_mode_supported(i32 %mode)
  %ok = and i1 %flags_ok, %mode_ok
  br i1 %ok, label %call_host, label %invalid

call_host:
  %dirfd64 = sext i32 %dirfd to i64
  %mode64 = sext i32 %mode to i64
  %flags64 = sext i32 %flags to i64
  %raw = call i64 @__mtrt_host_fchmodat(i64 %dirfd64, ptr %path, i64 %mode64, i64 %flags64)
  %ret = trunc i64 %raw to i32
  ret i32 %ret

invalid:
  ret i32 -22
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
  %flags_ok = call i1 @__mtrt_at_nofollow_flags_supported(i32 %flags)
  br i1 %flags_ok, label %call_host, label %invalid

call_host:
  %dirfd64 = sext i32 %dirfd to i64
  %uid64 = sext i32 %uid to i64
  %gid64 = sext i32 %gid to i64
  %flags64 = sext i32 %flags to i64
  %raw = call i64 @__mtrt_host_fchownat(i64 %dirfd64, ptr %path, i64 %uid64, i64 %gid64, i64 %flags64)
  %ret = trunc i64 %raw to i32
  ret i32 %ret

invalid:
  ret i32 -22
}

define i64 @fcntl(i32 %fd, i32 %cmd, i64 %arg) {
entry:
  %cmd_ok = call i1 @__mtrt_fcntl_cmd_supported(i32 %cmd)
  %arg_ok = call i1 @__mtrt_fcntl_arg_supported(i32 %cmd, i64 %arg)
  %ok = and i1 %cmd_ok, %arg_ok
  br i1 %ok, label %call_host, label %invalid

call_host:
  %fd64 = sext i32 %fd to i64
  %cmd64 = sext i32 %cmd to i64
  %raw = call i64 @__mtrt_host_fcntl(i64 %fd64, i64 %cmd64, i64 %arg)
  ret i64 %raw

invalid:
  ret i64 -22
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
  %flags_ok = call i1 @__mtrt_at_nofollow_flags_supported(i32 %flags)
  br i1 %flags_ok, label %call_host, label %invalid

call_host:
  %dirfd64 = sext i32 %dirfd to i64
  %flags64 = sext i32 %flags to i64
  %raw = call i64 @__mtrt_host_fstatat(i64 %dirfd64, ptr %path, ptr %buf, i64 %flags64)
  %ret = trunc i64 %raw to i32
  ret i32 %ret

invalid:
  ret i32 -22
}

define i32 @ftruncate(i32 %fd, i64 %length) {
entry:
  %fd64 = sext i32 %fd to i64
  %raw = call i64 @__mtrt_host_ftruncate(i64 %fd64, i64 %length)
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
  %flags_ok = call i1 @__mtrt_linkat_flags_supported(i32 %flags)
  br i1 %flags_ok, label %call_host, label %invalid

call_host:
  %olddirfd64 = sext i32 %olddirfd to i64
  %newdirfd64 = sext i32 %newdirfd to i64
  %flags64 = sext i32 %flags to i64
  %raw = call i64 @__mtrt_host_linkat(i64 %olddirfd64, ptr %oldpath, i64 %newdirfd64, ptr %newpath, i64 %flags64)
  %ret = trunc i64 %raw to i32
  ret i32 %ret

invalid:
  ret i32 -22
}

define i32 @lstat(ptr %path, ptr %buf) {
entry:
  %raw = call i64 @__mtrt_host_lstat(ptr %path, ptr %buf)
  %ret = trunc i64 %raw to i32
  ret i32 %ret
}

define i32 @madvise(i64 %addr, i64 %length, i32 %advice) {
entry:
  %advice_ok = call i1 @__mtrt_madvise_supported(i32 %advice)
  br i1 %advice_ok, label %call_host, label %invalid

call_host:
  %advice64 = sext i32 %advice to i64
  %raw = call i64 @__mtrt_host_madvise(i64 %addr, i64 %length, i64 %advice64)
  %ret = trunc i64 %raw to i32
  ret i32 %ret

invalid:
  ret i32 -22
}

define i32 @mkdir(ptr %path, i32 %mode) {
entry:
  %mode_ok = call i1 @__mtrt_file_mode_supported(i32 %mode)
  br i1 %mode_ok, label %call_host, label %invalid

call_host:
  %mode64 = sext i32 %mode to i64
  %raw = call i64 @__mtrt_host_mkdir(ptr %path, i64 %mode64)
  %ret = trunc i64 %raw to i32
  ret i32 %ret

invalid:
  ret i32 -22
}

define i32 @mkdirat(i32 %dirfd, ptr %path, i32 %mode) {
entry:
  %mode_ok = call i1 @__mtrt_file_mode_supported(i32 %mode)
  br i1 %mode_ok, label %call_host, label %invalid

call_host:
  %dirfd64 = sext i32 %dirfd to i64
  %mode64 = sext i32 %mode to i64
  %raw = call i64 @__mtrt_host_mkdirat(i64 %dirfd64, ptr %path, i64 %mode64)
  %ret = trunc i64 %raw to i32
  ret i32 %ret

invalid:
  ret i32 -22
}

define i32 @mkfifo(ptr %path, i32 %mode) {
entry:
  %mode_ok = call i1 @__mtrt_file_mode_supported(i32 %mode)
  br i1 %mode_ok, label %call_host, label %invalid

call_host:
  %mode64 = sext i32 %mode to i64
  %raw = call i64 @__mtrt_host_mkfifo(ptr %path, i64 %mode64)
  %ret = trunc i64 %raw to i32
  ret i32 %ret

invalid:
  ret i32 -22
}

define i32 @mlock(i64 %addr, i64 %length) {
entry:
  %raw = call i64 @__mtrt_host_mlock(i64 %addr, i64 %length)
  %ret = trunc i64 %raw to i32
  ret i32 %ret
}

define i64 @mmap(i64 %addr, i64 %length, i32 %prot, i32 %flags, i32 %fd, i64 %offset) {
entry:
  %flags_ok = call i1 @__mtrt_mmap_flags_supported(i32 %flags)
  %prot_ok = call i1 @__mtrt_prot_supported(i32 %prot)
  %ok = and i1 %flags_ok, %prot_ok
  br i1 %ok, label %call_host, label %invalid

call_host:
  %prot64 = sext i32 %prot to i64
  %flags64 = sext i32 %flags to i64
  %fd64 = sext i32 %fd to i64
  %raw = call i64 @__mtrt_host_mmap(i64 %addr, i64 %length, i64 %prot64, i64 %flags64, i64 %fd64, i64 %offset)
  ret i64 %raw

invalid:
  ret i64 -22
}

define i32 @mprotect(i64 %addr, i64 %length, i32 %prot) {
entry:
  %prot_ok = call i1 @__mtrt_prot_supported(i32 %prot)
  br i1 %prot_ok, label %call_host, label %invalid

call_host:
  %prot64 = sext i32 %prot to i64
  %raw = call i64 @__mtrt_host_mprotect(i64 %addr, i64 %length, i64 %prot64)
  %ret = trunc i64 %raw to i32
  ret i32 %ret

invalid:
  ret i32 -22
}

define i32 @msync(i64 %addr, i64 %length, i32 %flags) {
entry:
  %flags_ok = call i1 @__mtrt_msync_flags_supported(i32 %flags)
  br i1 %flags_ok, label %call_host, label %invalid

call_host:
  %flags64 = sext i32 %flags to i64
  %raw = call i64 @__mtrt_host_msync(i64 %addr, i64 %length, i64 %flags64)
  %ret = trunc i64 %raw to i32
  ret i32 %ret

invalid:
  ret i32 -22
}

define i32 @munlock(i64 %addr, i64 %length) {
entry:
  %raw = call i64 @__mtrt_host_munlock(i64 %addr, i64 %length)
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
  %flags_ok = call i1 @__mtrt_pipe2_flags_supported(i32 %flags)
  br i1 %flags_ok, label %call_host, label %invalid

call_host:
  %flags64 = sext i32 %flags to i64
  %raw = call i64 @__mtrt_host_pipe2(ptr %fds, i64 %flags64)
  %ret = trunc i64 %raw to i32
  ret i32 %ret

invalid:
  ret i32 -22
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

define i32 @tcgetattr(i32 %fd, ptr %termios) {
entry:
  %fd64 = sext i32 %fd to i64
  %raw = call i64 @__mtrt_host_tcgetattr(i64 %fd64, ptr %termios)
  %ret = trunc i64 %raw to i32
  ret i32 %ret
}

define i32 @isatty(i32 %fd) {
entry:
  %fd64 = sext i32 %fd to i64
  %raw = call i64 @__mtrt_host_isatty(i64 %fd64)
  %ret = trunc i64 %raw to i32
  ret i32 %ret
}

define i32 @tcsetattr(i32 %fd, i32 %action, ptr %termios) {
entry:
  %fd64 = sext i32 %fd to i64
  %action64 = sext i32 %action to i64
  %raw = call i64 @__mtrt_host_tcsetattr(i64 %fd64, i64 %action64, ptr %termios)
  %ret = trunc i64 %raw to i32
  ret i32 %ret
}

define i32 @tcdrain(i32 %fd) {
entry:
  %fd64 = sext i32 %fd to i64
  %raw = call i64 @__mtrt_host_tcdrain(i64 %fd64)
  %ret = trunc i64 %raw to i32
  ret i32 %ret
}

define i32 @tcflow(i32 %fd, i32 %action) {
entry:
  %fd64 = sext i32 %fd to i64
  %action64 = sext i32 %action to i64
  %raw = call i64 @__mtrt_host_tcflow(i64 %fd64, i64 %action64)
  %ret = trunc i64 %raw to i32
  ret i32 %ret
}

define i32 @tcflush(i32 %fd, i32 %queue_selector) {
entry:
  %fd64 = sext i32 %fd to i64
  %selector64 = sext i32 %queue_selector to i64
  %raw = call i64 @__mtrt_host_tcflush(i64 %fd64, i64 %selector64)
  %ret = trunc i64 %raw to i32
  ret i32 %ret
}

define i32 @tcsendbreak(i32 %fd, i32 %duration) {
entry:
  %fd64 = sext i32 %fd to i64
  %duration64 = sext i32 %duration to i64
  %raw = call i64 @__mtrt_host_tcsendbreak(i64 %fd64, i64 %duration64)
  %ret = trunc i64 %raw to i32
  ret i32 %ret
}

define i32 @tcgetpgrp(i32 %fd) {
entry:
  %fd64 = sext i32 %fd to i64
  %raw = call i64 @__mtrt_host_tcgetpgrp(i64 %fd64)
  %ret = trunc i64 %raw to i32
  ret i32 %ret
}

define i32 @tcsetpgrp(i32 %fd, i32 %pgrp) {
entry:
  %fd64 = sext i32 %fd to i64
  %pgrp64 = sext i32 %pgrp to i64
  %raw = call i64 @__mtrt_host_tcsetpgrp(i64 %fd64, i64 %pgrp64)
  %ret = trunc i64 %raw to i32
  ret i32 %ret
}

define i64 @times(ptr %buf) {
entry:
  %raw = call i64 @__mtrt_host_times(ptr %buf)
  ret i64 %raw
}

define i32 @utimes(ptr %path, ptr %times) {
entry:
  %raw = call i64 @__mtrt_host_utimes(ptr %path, ptr %times)
  %ret = trunc i64 %raw to i32
  ret i32 %ret
}
