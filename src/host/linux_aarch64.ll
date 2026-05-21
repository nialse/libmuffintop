; Linux AArch64 kernel-primitive host layer for libmuffintop.
; Direct syscall path (no libc).

target triple = "aarch64-unknown-linux-gnu"

%struct.mtrt_stat64 = type { i64, i64, i64, i32, i32, i32, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64 }

@.mtrt_empty_path = private unnamed_addr constant [1 x i8] zeroinitializer
@__mtrt_platform_uname_sys = constant [6 x i8] c"Linux\0A", align 1
@__mtrt_platform_uname_sys_len = constant i64 6, align 8
@__mtrt_platform_uname_all = constant [28 x i8] c"Linux muffintop 0 0 aarch64\0A", align 1
@__mtrt_platform_uname_all_len = constant i64 28, align 8
@__mtrt_poc_sigcont = constant i32 19, align 4
@__mtrt_linux_handler_sig17 = internal global i64 0, align 8
@__mtrt_linux_handler_sig18 = internal global i64 0, align 8
@__mtrt_linux_handler_sig19 = internal global i64 0, align 8
@__mtrt_linux_handler_sig20 = internal global i64 0, align 8
@__mtrt_linux_flags_sig17 = internal global i64 0, align 8
@__mtrt_linux_flags_sig18 = internal global i64 0, align 8
@__mtrt_linux_flags_sig19 = internal global i64 0, align 8
@__mtrt_linux_flags_sig20 = internal global i64 0, align 8

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

define internal i64 @__mtrt_linux_syscall6(i64 %nr, i64 %a1, i64 %a2, i64 %a3, i64 %a4, i64 %a5, i64 %a6) {
entry:
  %ret = call i64 asm sideeffect "svc #0", "={x0},{x8},{x0},{x1},{x2},{x3},{x4},{x5},~{memory}"(i64 %nr, i64 %a1, i64 %a2, i64 %a3, i64 %a4, i64 %a5, i64 %a6)
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
  %r = call i64 @__mtrt_linux_syscall5(i64 291, i64 %dirfd, i64 %path_i, i64 %flags, i64 2047, i64 %sx_i)
  %ok = icmp eq i64 %r, 0
  br i1 %ok, label %store, label %done

store:
  call void @__mtrt_linux_store_statx(ptr %buf, ptr %sx)
  ret i64 0

done:
  ret i64 %r
}

define internal i8 @__mtrt_common_dtype(i8 %dtype) {
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

define internal i64 @__mtrt_name_len_bounded(ptr %name, i64 %limit) {
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

define internal void @__mtrt_store_dent64(ptr %dst, i64 %ino, i64 %reclen, i8 %dtype, ptr %name, i64 %name_len) {
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

define internal i64 @__mtrt_linux_translate_getdents64(ptr %buf, i64 %native_bytes) {
entry:
  br label %loop

loop:
  %src_off = phi i64 [ 0, %entry ], [ %src_next, %advance ]
  %dst_off = phi i64 [ 0, %entry ], [ %dst_next, %advance ]
  %more = icmp ult i64 %src_off, %native_bytes
  br i1 %more, label %record, label %done

record:
  %rec = getelementptr i8, ptr %buf, i64 %src_off
  %reclen_p = getelementptr i8, ptr %rec, i64 16
  %reclen16 = load i16, ptr %reclen_p, align 2
  %native_reclen = zext i16 %reclen16 to i64
  %src_next = add i64 %src_off, %native_reclen
  %reclen_min = icmp uge i64 %native_reclen, 20
  %reclen_nonzero = icmp ne i64 %native_reclen, 0
  %src_within = icmp ule i64 %src_next, %native_bytes
  %valid0 = and i1 %reclen_min, %reclen_nonzero
  %valid = and i1 %valid0, %src_within
  br i1 %valid, label %name, label %bad

name:
  %ino = load i64, ptr %rec, align 8
  %dtype_p = getelementptr i8, ptr %rec, i64 18
  %native_dtype = load i8, ptr %dtype_p, align 1
  %dtype = call i8 @__mtrt_common_dtype(i8 %native_dtype)
  %name_p = getelementptr i8, ptr %rec, i64 19
  %name_limit = sub i64 %native_reclen, 19
  %name_len = call i64 @__mtrt_name_len_bounded(ptr %name_p, i64 %name_limit)
  %has_nul = icmp ult i64 %name_len, %name_limit
  br i1 %has_nul, label %store, label %bad

store:
  %target_reclen_raw = add i64 %name_len, 24
  %target_reclen = and i64 %target_reclen_raw, -8
  %dst_next = add i64 %dst_off, %target_reclen
  %dst_within = icmp ule i64 %dst_next, %native_bytes
  br i1 %dst_within, label %write, label %bad

write:
  %dst = getelementptr i8, ptr %buf, i64 %dst_off
  call void @__mtrt_store_dent64(ptr %dst, i64 %ino, i64 %target_reclen, i8 %dtype, ptr %name_p, i64 %name_len)
  br label %advance

advance:
  br label %loop

done:
  ret i64 %dst_off

bad:
  ret i64 -5
}

define i64 @__mtrt_host_getpid() {
  %r = call i64 @__mtrt_linux_syscall0(i64 172)
  ret i64 %r
}

define i64 @__mtrt_host_getppid() {
  %r = call i64 @__mtrt_linux_syscall0(i64 173)
  ret i64 %r
}

define i64 @__mtrt_host_getuid() {
  %r = call i64 @__mtrt_linux_syscall0(i64 174)
  ret i64 %r
}

define i64 @__mtrt_host_geteuid() {
  %r = call i64 @__mtrt_linux_syscall0(i64 175)
  ret i64 %r
}

define i64 @__mtrt_host_getgid() {
  %r = call i64 @__mtrt_linux_syscall0(i64 176)
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

define internal i64 @__mtrt_linux_clockid_from_target(i64 %clockid) {
entry:
  switch i64 %clockid, label %invalid [
    i64 0, label %realtime
    i64 1, label %monotonic
  ]

realtime:
  ret i64 0

monotonic:
  ret i64 1

invalid:
  ret i64 -22
}

define i64 @__mtrt_host_clock_gettime(i64 %clockid, ptr %tp) {
entry:
  %native_clockid = call i64 @__mtrt_linux_clockid_from_target(i64 %clockid)
  %bad_clockid = icmp slt i64 %native_clockid, 0
  br i1 %bad_clockid, label %invalid_clockid, label %call_clock

call_clock:
  %tp_i = ptrtoint ptr %tp to i64
  %r = call i64 @__mtrt_linux_syscall2(i64 113, i64 %native_clockid, i64 %tp_i)
  ret i64 %r

invalid_clockid:
  ret i64 %native_clockid
}

define internal i64 @__mtrt_linux_signal_to_native(i64 %sig) {
entry:
  switch i64 %sig, label %invalid [
    i64 0, label %same
    i64 1, label %same
    i64 2, label %same
    i64 3, label %same
    i64 4, label %same
    i64 5, label %same
    i64 6, label %same
    i64 7, label %same
    i64 8, label %same
    i64 9, label %same
    i64 10, label %same
    i64 11, label %same
    i64 12, label %same
    i64 13, label %same
    i64 14, label %same
    i64 15, label %same
    i64 17, label %sigstop
    i64 18, label %sigtstp
    i64 19, label %sigcont
    i64 20, label %sigchld
    i64 21, label %same
    i64 22, label %same
  ]

sigstop:
  ret i64 19

sigtstp:
  ret i64 20

sigcont:
  ret i64 18

sigchld:
  ret i64 17

same:
  ret i64 %sig

invalid:
  ret i64 -22
}

define internal i64 @__mtrt_linux_signal_from_native(i64 %sig) {
entry:
  switch i64 %sig, label %same [
    i64 17, label %sigchld
    i64 18, label %sigcont
    i64 19, label %sigstop
    i64 20, label %sigtstp
  ]

sigchld:
  ret i64 20

sigcont:
  ret i64 19

sigstop:
  ret i64 17

sigtstp:
  ret i64 18

same:
  ret i64 %sig
}

define internal i64 @__mtrt_linux_sigset_to_native(i64 %target) {
entry:
  %known = and i64 %target, 4161535
  %unknown = xor i64 %target, %known
  %ok = icmp eq i64 %unknown, 0
  br i1 %ok, label %map, label %invalid

invalid:
  ret i64 -22

map:
  %base = and i64 %target, 32767
  %target_stop = and i64 %target, 65536
  %has_stop = icmp ne i64 %target_stop, 0
  %with_stop = select i1 %has_stop, i64 262144, i64 0
  %target_tstp = and i64 %target, 131072
  %has_tstp = icmp ne i64 %target_tstp, 0
  %with_tstp = select i1 %has_tstp, i64 524288, i64 0
  %target_cont = and i64 %target, 262144
  %has_cont = icmp ne i64 %target_cont, 0
  %with_cont = select i1 %has_cont, i64 131072, i64 0
  %target_chld = and i64 %target, 524288
  %has_chld = icmp ne i64 %target_chld, 0
  %with_chld = select i1 %has_chld, i64 65536, i64 0
  %target_ttin = and i64 %target, 1048576
  %target_ttou = and i64 %target, 2097152
  %r0 = or i64 %base, %with_stop
  %r1 = or i64 %r0, %with_tstp
  %r2 = or i64 %r1, %with_cont
  %r3 = or i64 %r2, %with_chld
  %r4 = or i64 %r3, %target_ttin
  %r5 = or i64 %r4, %target_ttou
  ret i64 %r5
}

define internal i64 @__mtrt_linux_sigset_from_native(i64 %native) {
entry:
  %base = and i64 %native, 32767
  %native_stop = and i64 %native, 262144
  %has_stop = icmp ne i64 %native_stop, 0
  %with_stop = select i1 %has_stop, i64 65536, i64 0
  %native_tstp = and i64 %native, 524288
  %has_tstp = icmp ne i64 %native_tstp, 0
  %with_tstp = select i1 %has_tstp, i64 131072, i64 0
  %native_cont = and i64 %native, 131072
  %has_cont = icmp ne i64 %native_cont, 0
  %with_cont = select i1 %has_cont, i64 262144, i64 0
  %native_chld = and i64 %native, 65536
  %has_chld = icmp ne i64 %native_chld, 0
  %with_chld = select i1 %has_chld, i64 524288, i64 0
  %native_ttin = and i64 %native, 1048576
  %native_ttou = and i64 %native, 2097152
  %r0 = or i64 %base, %with_stop
  %r1 = or i64 %r0, %with_tstp
  %r2 = or i64 %r1, %with_cont
  %r3 = or i64 %r2, %with_chld
  %r4 = or i64 %r3, %native_ttin
  %r5 = or i64 %r4, %native_ttou
  ret i64 %r5
}

define internal i64 @__mtrt_linux_sigaction_flags_to_native(i64 %target) {
entry:
  %known = and i64 %target, 127
  %unknown = xor i64 %target, %known
  %ok = icmp eq i64 %unknown, 0
  br i1 %ok, label %map, label %invalid

invalid:
  ret i64 -22

map:
  %low = and i64 %target, 7
  %restart_bit = and i64 %target, 8
  %has_restart = icmp ne i64 %restart_bit, 0
  %restart = select i1 %has_restart, i64 268435456, i64 0
  %onstack_bit = and i64 %target, 16
  %has_onstack = icmp ne i64 %onstack_bit, 0
  %onstack = select i1 %has_onstack, i64 134217728, i64 0
  %reset_bit = and i64 %target, 32
  %has_reset = icmp ne i64 %reset_bit, 0
  %reset = select i1 %has_reset, i64 2147483648, i64 0
  %nodefer_bit = and i64 %target, 64
  %has_nodefer = icmp ne i64 %nodefer_bit, 0
  %nodefer = select i1 %has_nodefer, i64 1073741824, i64 0
  %r0 = or i64 %low, %restart
  %r1 = or i64 %r0, %onstack
  %r2 = or i64 %r1, %reset
  %r3 = or i64 %r2, %nodefer
  ret i64 %r3
}

define internal i64 @__mtrt_linux_sigaction_flags_from_native(i64 %native) {
entry:
  %low = and i64 %native, 7
  %restart_bit = and i64 %native, 268435456
  %has_restart = icmp ne i64 %restart_bit, 0
  %restart = select i1 %has_restart, i64 8, i64 0
  %onstack_bit = and i64 %native, 134217728
  %has_onstack = icmp ne i64 %onstack_bit, 0
  %onstack = select i1 %has_onstack, i64 16, i64 0
  %reset_bit = and i64 %native, 2147483648
  %has_reset = icmp ne i64 %reset_bit, 0
  %reset = select i1 %has_reset, i64 32, i64 0
  %nodefer_bit = and i64 %native, 1073741824
  %has_nodefer = icmp ne i64 %nodefer_bit, 0
  %nodefer = select i1 %has_nodefer, i64 64, i64 0
  %r0 = or i64 %low, %restart
  %r1 = or i64 %r0, %onstack
  %r2 = or i64 %r1, %reset
  %r3 = or i64 %r2, %nodefer
  ret i64 %r3
}

define internal void @__mtrt_linux_siginfo_to_target(ptr %target_info, ptr %native_info) {
entry:
  %native_signo32 = load i32, ptr %native_info, align 4
  %native_signo = sext i32 %native_signo32 to i64
  %target_signo = call i64 @__mtrt_linux_signal_from_native(i64 %native_signo)
  %target_signo32 = trunc i64 %target_signo to i32
  store i32 %target_signo32, ptr %target_info, align 4
  %native_errno_p = getelementptr i8, ptr %native_info, i64 4
  %target_errno_p = getelementptr i8, ptr %target_info, i64 4
  %errno = load i32, ptr %native_errno_p, align 4
  store i32 %errno, ptr %target_errno_p, align 4
  %native_code_p = getelementptr i8, ptr %native_info, i64 8
  %target_code_p = getelementptr i8, ptr %target_info, i64 8
  %code = load i32, ptr %native_code_p, align 4
  store i32 %code, ptr %target_code_p, align 4
  %target_pad_p = getelementptr i8, ptr %target_info, i64 12
  store i32 0, ptr %target_pad_p, align 4
  ret void
}

define internal void @__mtrt_linux_dispatch_target_signal(i64 %target_sig, ptr %handler_slot, ptr %flags_slot, ptr %native_info, ptr %ucontext) {
entry:
  %handler_i = load i64, ptr %handler_slot, align 8
  %is_dfl = icmp eq i64 %handler_i, 0
  %is_ign = icmp eq i64 %handler_i, 1
  %is_special = or i1 %is_dfl, %is_ign
  br i1 %is_special, label %done, label %check_siginfo

check_siginfo:
  %flags = load i64, ptr %flags_slot, align 8
  %siginfo_bit = and i64 %flags, 4
  %has_siginfo = icmp ne i64 %siginfo_bit, 0
  br i1 %has_siginfo, label %call_siginfo, label %call_simple

call_simple:
  %handler = inttoptr i64 %handler_i to ptr
  %target_sig32 = trunc i64 %target_sig to i32
  call void %handler(i32 %target_sig32)
  br label %done

call_siginfo:
  %target_info = alloca [16 x i8], align 4
  %native_info_null = icmp eq ptr %native_info, null
  br i1 %native_info_null, label %call_siginfo_handler, label %copy_siginfo

copy_siginfo:
  call void @__mtrt_linux_siginfo_to_target(ptr %target_info, ptr %native_info)
  br label %call_siginfo_handler

call_siginfo_handler:
  %info_arg = phi ptr [ null, %call_siginfo ], [ %target_info, %copy_siginfo ]
  %handler3 = inttoptr i64 %handler_i to ptr
  %target_sig32_info = trunc i64 %target_sig to i32
  call void %handler3(i32 %target_sig32_info, ptr %info_arg, ptr %ucontext)
  br label %done

done:
  ret void
}

define internal void @__mtrt_linux_dispatch_sig17(i32 %native_sig, ptr %native_info, ptr %ucontext) {
entry:
  call void @__mtrt_linux_dispatch_target_signal(i64 17, ptr @__mtrt_linux_handler_sig17, ptr @__mtrt_linux_flags_sig17, ptr %native_info, ptr %ucontext)
  ret void
}

define internal void @__mtrt_linux_dispatch_sig18(i32 %native_sig, ptr %native_info, ptr %ucontext) {
entry:
  call void @__mtrt_linux_dispatch_target_signal(i64 18, ptr @__mtrt_linux_handler_sig18, ptr @__mtrt_linux_flags_sig18, ptr %native_info, ptr %ucontext)
  ret void
}

define internal void @__mtrt_linux_dispatch_sig19(i32 %native_sig, ptr %native_info, ptr %ucontext) {
entry:
  call void @__mtrt_linux_dispatch_target_signal(i64 19, ptr @__mtrt_linux_handler_sig19, ptr @__mtrt_linux_flags_sig19, ptr %native_info, ptr %ucontext)
  ret void
}

define internal void @__mtrt_linux_dispatch_sig20(i32 %native_sig, ptr %native_info, ptr %ucontext) {
entry:
  call void @__mtrt_linux_dispatch_target_signal(i64 20, ptr @__mtrt_linux_handler_sig20, ptr @__mtrt_linux_flags_sig20, ptr %native_info, ptr %ucontext)
  ret void
}

define internal i64 @__mtrt_linux_sigaction_dispatcher(i64 %sig) {
entry:
  switch i64 %sig, label %none [
    i64 17, label %sig17
    i64 18, label %sig18
    i64 19, label %sig19
    i64 20, label %sig20
  ]

sig17:
  %d17 = ptrtoint ptr @__mtrt_linux_dispatch_sig17 to i64
  ret i64 %d17

sig18:
  %d18 = ptrtoint ptr @__mtrt_linux_dispatch_sig18 to i64
  ret i64 %d18

sig19:
  %d19 = ptrtoint ptr @__mtrt_linux_dispatch_sig19 to i64
  ret i64 %d19

sig20:
  %d20 = ptrtoint ptr @__mtrt_linux_dispatch_sig20 to i64
  ret i64 %d20

none:
  ret i64 0
}

define internal i64 @__mtrt_linux_load_target_handler(i64 %sig) {
entry:
  switch i64 %sig, label %none [
    i64 17, label %sig17
    i64 18, label %sig18
    i64 19, label %sig19
    i64 20, label %sig20
  ]

sig17:
  %h17 = load i64, ptr @__mtrt_linux_handler_sig17, align 8
  ret i64 %h17

sig18:
  %h18 = load i64, ptr @__mtrt_linux_handler_sig18, align 8
  ret i64 %h18

sig19:
  %h19 = load i64, ptr @__mtrt_linux_handler_sig19, align 8
  ret i64 %h19

sig20:
  %h20 = load i64, ptr @__mtrt_linux_handler_sig20, align 8
  ret i64 %h20

none:
  ret i64 0
}

define internal i64 @__mtrt_linux_load_target_flags(i64 %sig) {
entry:
  switch i64 %sig, label %none [
    i64 17, label %sig17
    i64 18, label %sig18
    i64 19, label %sig19
    i64 20, label %sig20
  ]

sig17:
  %f17 = load i64, ptr @__mtrt_linux_flags_sig17, align 8
  ret i64 %f17

sig18:
  %f18 = load i64, ptr @__mtrt_linux_flags_sig18, align 8
  ret i64 %f18

sig19:
  %f19 = load i64, ptr @__mtrt_linux_flags_sig19, align 8
  ret i64 %f19

sig20:
  %f20 = load i64, ptr @__mtrt_linux_flags_sig20, align 8
  ret i64 %f20

none:
  ret i64 0
}

define internal void @__mtrt_linux_store_target_action(i64 %sig, i64 %handler, i64 %flags) {
entry:
  switch i64 %sig, label %done [
    i64 17, label %sig17
    i64 18, label %sig18
    i64 19, label %sig19
    i64 20, label %sig20
  ]

sig17:
  store i64 %handler, ptr @__mtrt_linux_handler_sig17, align 8
  store i64 %flags, ptr @__mtrt_linux_flags_sig17, align 8
  br label %done

sig18:
  store i64 %handler, ptr @__mtrt_linux_handler_sig18, align 8
  store i64 %flags, ptr @__mtrt_linux_flags_sig18, align 8
  br label %done

sig19:
  store i64 %handler, ptr @__mtrt_linux_handler_sig19, align 8
  store i64 %flags, ptr @__mtrt_linux_flags_sig19, align 8
  br label %done

sig20:
  store i64 %handler, ptr @__mtrt_linux_handler_sig20, align 8
  store i64 %flags, ptr @__mtrt_linux_flags_sig20, align 8
  br label %done

done:
  ret void
}

define internal i64 @__mtrt_linux_sigaction_handler_from_native(i64 %sig, i64 %native_handler, i64 %previous_handler) {
entry:
  %dispatcher = call i64 @__mtrt_linux_sigaction_dispatcher(i64 %sig)
  %is_dispatcher = icmp eq i64 %native_handler, %dispatcher
  %handler = select i1 %is_dispatcher, i64 %previous_handler, i64 %native_handler
  ret i64 %handler
}

define i64 @__mtrt_host_kill(i64 %pid, i64 %sig) {
  %native_sig = call i64 @__mtrt_linux_signal_to_native(i64 %sig)
  %bad_sig = icmp slt i64 %native_sig, 0
  br i1 %bad_sig, label %invalid, label %call_kill

invalid:
  ret i64 %native_sig

call_kill:
  %r = call i64 @__mtrt_linux_syscall2(i64 129, i64 %pid, i64 %native_sig)
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

define i64 @__mtrt_host_posix_getdents(i64 %fd, ptr %buf, i64 %nbyte, i64 %flags) {
entry:
  %flags_ok = icmp eq i64 %flags, 0
  br i1 %flags_ok, label %check_size, label %invalid

check_size:
  %size_ok = icmp uge i64 %nbyte, 24
  br i1 %size_ok, label %call_getdents, label %invalid

call_getdents:
  %buf_i = ptrtoint ptr %buf to i64
  %r = call i64 @__mtrt_linux_syscall3(i64 61, i64 %fd, i64 %buf_i, i64 %nbyte)
  %has_entries = icmp sgt i64 %r, 0
  br i1 %has_entries, label %translate, label %done

translate:
  %translated = call i64 @__mtrt_linux_translate_getdents64(ptr %buf, i64 %r)
  ret i64 %translated

done:
  ret i64 %r

invalid:
  ret i64 -22
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

define i64 @__mtrt_host_mkfifo(ptr %path, i64 %mode) {
  %path_i = ptrtoint ptr %path to i64
  %perm = and i64 %mode, 511
  %fifo_mode = or i64 %perm, 4096
  %r = call i64 @__mtrt_linux_syscall4(i64 33, i64 -100, i64 %path_i, i64 %fifo_mode, i64 0)
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

define i64 @__mtrt_host_ftruncate(i64 %fd, i64 %length) {
  %r = call i64 @__mtrt_linux_syscall2(i64 46, i64 %fd, i64 %length)
  ret i64 %r
}

define i64 @__mtrt_host_chown(ptr %path, i64 %uid, i64 %gid) {
  %path_i = ptrtoint ptr %path to i64
  %r = call i64 @__mtrt_linux_syscall5(i64 54, i64 -100, i64 %path_i, i64 %uid, i64 %gid, i64 0)
  ret i64 %r
}

define internal i64 @__mtrt_linux_ioctl_ptr(i64 %fd, i64 %request, ptr %arg) {
entry:
  %arg_i = ptrtoint ptr %arg to i64
  %r = call i64 @__mtrt_linux_syscall3(i64 29, i64 %fd, i64 %request, i64 %arg_i)
  ret i64 %r
}

define internal i64 @__mtrt_linux_ioctl_int(i64 %fd, i64 %request, i64 %arg) {
entry:
  %r = call i64 @__mtrt_linux_syscall3(i64 29, i64 %fd, i64 %request, i64 %arg)
  ret i64 %r
}

define internal i32 @__mtrt_linux_speed_to_native(i32 %speed) {
entry:
  switch i32 %speed, label %bad [
    i32 0, label %s0
    i32 50, label %s1
    i32 75, label %s2
    i32 110, label %s3
    i32 134, label %s4
    i32 150, label %s5
    i32 200, label %s6
    i32 300, label %s7
    i32 600, label %s8
    i32 1200, label %s9
    i32 1800, label %s10
    i32 2400, label %s11
    i32 4800, label %s12
    i32 9600, label %s13
    i32 19200, label %s14
    i32 38400, label %s15
  ]

s0:
  ret i32 0

s1:
  ret i32 1

s2:
  ret i32 2

s3:
  ret i32 3

s4:
  ret i32 4

s5:
  ret i32 5

s6:
  ret i32 6

s7:
  ret i32 7

s8:
  ret i32 8

s9:
  ret i32 9

s10:
  ret i32 10

s11:
  ret i32 11

s12:
  ret i32 12

s13:
  ret i32 13

s14:
  ret i32 14

s15:
  ret i32 15

bad:
  ret i32 -1
}

define internal i32 @__mtrt_linux_native_speed_to_target(i32 %native) {
entry:
  switch i32 %native, label %bad [
    i32 0, label %s0
    i32 1, label %s1
    i32 2, label %s2
    i32 3, label %s3
    i32 4, label %s4
    i32 5, label %s5
    i32 6, label %s6
    i32 7, label %s7
    i32 8, label %s8
    i32 9, label %s9
    i32 10, label %s10
    i32 11, label %s11
    i32 12, label %s12
    i32 13, label %s13
    i32 14, label %s14
    i32 15, label %s15
  ]

s0:
  ret i32 0

s1:
  ret i32 50

s2:
  ret i32 75

s3:
  ret i32 110

s4:
  ret i32 134

s5:
  ret i32 150

s6:
  ret i32 200

s7:
  ret i32 300

s8:
  ret i32 600

s9:
  ret i32 1200

s10:
  ret i32 1800

s11:
  ret i32 2400

s12:
  ret i32 4800

s13:
  ret i32 9600

s14:
  ret i32 19200

s15:
  ret i32 38400

bad:
  ret i32 0
}

define internal i64 @__mtrt_linux_iflag_to_target(i64 %native) {
entry:
  %n0 = and i64 %native, 1
  %has0 = icmp ne i64 %n0, 0
  %v0 = select i1 %has0, i64 1, i64 0
  %acc0 = or i64 0, %v0
  %n1 = and i64 %native, 2
  %has1 = icmp ne i64 %n1, 0
  %v1 = select i1 %has1, i64 2, i64 0
  %acc1 = or i64 %acc0, %v1
  %n2 = and i64 %native, 4
  %has2 = icmp ne i64 %n2, 0
  %v2 = select i1 %has2, i64 4, i64 0
  %acc2 = or i64 %acc1, %v2
  %n3 = and i64 %native, 8
  %has3 = icmp ne i64 %n3, 0
  %v3 = select i1 %has3, i64 8, i64 0
  %acc3 = or i64 %acc2, %v3
  %n4 = and i64 %native, 16
  %has4 = icmp ne i64 %n4, 0
  %v4 = select i1 %has4, i64 16, i64 0
  %acc4 = or i64 %acc3, %v4
  %n5 = and i64 %native, 32
  %has5 = icmp ne i64 %n5, 0
  %v5 = select i1 %has5, i64 32, i64 0
  %acc5 = or i64 %acc4, %v5
  %n6 = and i64 %native, 64
  %has6 = icmp ne i64 %n6, 0
  %v6 = select i1 %has6, i64 64, i64 0
  %acc6 = or i64 %acc5, %v6
  %n7 = and i64 %native, 128
  %has7 = icmp ne i64 %n7, 0
  %v7 = select i1 %has7, i64 128, i64 0
  %acc7 = or i64 %acc6, %v7
  %n8 = and i64 %native, 256
  %has8 = icmp ne i64 %n8, 0
  %v8 = select i1 %has8, i64 256, i64 0
  %acc8 = or i64 %acc7, %v8
  %n9 = and i64 %native, 1024
  %has9 = icmp ne i64 %n9, 0
  %v9 = select i1 %has9, i64 512, i64 0
  %acc9 = or i64 %acc8, %v9
  %n10 = and i64 %native, 4096
  %has10 = icmp ne i64 %n10, 0
  %v10 = select i1 %has10, i64 1024, i64 0
  %acc10 = or i64 %acc9, %v10
  %n11 = and i64 %native, 2048
  %has11 = icmp ne i64 %n11, 0
  %v11 = select i1 %has11, i64 2048, i64 0
  %acc11 = or i64 %acc10, %v11
  ret i64 %acc11
}

define internal i64 @__mtrt_linux_iflag_to_native(i64 %target) {
entry:
  %t0 = and i64 %target, 1
  %has0 = icmp ne i64 %t0, 0
  %v0 = select i1 %has0, i64 1, i64 0
  %acc0 = or i64 0, %v0
  %t1 = and i64 %target, 2
  %has1 = icmp ne i64 %t1, 0
  %v1 = select i1 %has1, i64 2, i64 0
  %acc1 = or i64 %acc0, %v1
  %t2 = and i64 %target, 4
  %has2 = icmp ne i64 %t2, 0
  %v2 = select i1 %has2, i64 4, i64 0
  %acc2 = or i64 %acc1, %v2
  %t3 = and i64 %target, 8
  %has3 = icmp ne i64 %t3, 0
  %v3 = select i1 %has3, i64 8, i64 0
  %acc3 = or i64 %acc2, %v3
  %t4 = and i64 %target, 16
  %has4 = icmp ne i64 %t4, 0
  %v4 = select i1 %has4, i64 16, i64 0
  %acc4 = or i64 %acc3, %v4
  %t5 = and i64 %target, 32
  %has5 = icmp ne i64 %t5, 0
  %v5 = select i1 %has5, i64 32, i64 0
  %acc5 = or i64 %acc4, %v5
  %t6 = and i64 %target, 64
  %has6 = icmp ne i64 %t6, 0
  %v6 = select i1 %has6, i64 64, i64 0
  %acc6 = or i64 %acc5, %v6
  %t7 = and i64 %target, 128
  %has7 = icmp ne i64 %t7, 0
  %v7 = select i1 %has7, i64 128, i64 0
  %acc7 = or i64 %acc6, %v7
  %t8 = and i64 %target, 256
  %has8 = icmp ne i64 %t8, 0
  %v8 = select i1 %has8, i64 256, i64 0
  %acc8 = or i64 %acc7, %v8
  %t9 = and i64 %target, 512
  %has9 = icmp ne i64 %t9, 0
  %v9 = select i1 %has9, i64 1024, i64 0
  %acc9 = or i64 %acc8, %v9
  %t10 = and i64 %target, 1024
  %has10 = icmp ne i64 %t10, 0
  %v10 = select i1 %has10, i64 4096, i64 0
  %acc10 = or i64 %acc9, %v10
  %t11 = and i64 %target, 2048
  %has11 = icmp ne i64 %t11, 0
  %v11 = select i1 %has11, i64 2048, i64 0
  %acc11 = or i64 %acc10, %v11
  ret i64 %acc11
}

define internal i64 @__mtrt_linux_oflag_to_target(i64 %native) {
entry:
  %n0 = and i64 %native, 1
  %has0 = icmp ne i64 %n0, 0
  %v0 = select i1 %has0, i64 1, i64 0
  %acc0 = or i64 0, %v0
  %n1 = and i64 %native, 4
  %has1 = icmp ne i64 %n1, 0
  %v1 = select i1 %has1, i64 2, i64 0
  %acc1 = or i64 %acc0, %v1
  %n2 = and i64 %native, 8
  %has2 = icmp ne i64 %n2, 0
  %v2 = select i1 %has2, i64 4, i64 0
  %acc2 = or i64 %acc1, %v2
  %n3 = and i64 %native, 16
  %has3 = icmp ne i64 %n3, 0
  %v3 = select i1 %has3, i64 8, i64 0
  %acc3 = or i64 %acc2, %v3
  %n4 = and i64 %native, 32
  %has4 = icmp ne i64 %n4, 0
  %v4 = select i1 %has4, i64 16, i64 0
  %acc4 = or i64 %acc3, %v4
  %n5 = and i64 %native, 64
  %has5 = icmp ne i64 %n5, 0
  %v5 = select i1 %has5, i64 32, i64 0
  %acc5 = or i64 %acc4, %v5
  ret i64 %acc5
}

define internal i64 @__mtrt_linux_oflag_to_native(i64 %target) {
entry:
  %t0 = and i64 %target, 1
  %has0 = icmp ne i64 %t0, 0
  %v0 = select i1 %has0, i64 1, i64 0
  %acc0 = or i64 0, %v0
  %t1 = and i64 %target, 2
  %has1 = icmp ne i64 %t1, 0
  %v1 = select i1 %has1, i64 4, i64 0
  %acc1 = or i64 %acc0, %v1
  %t2 = and i64 %target, 4
  %has2 = icmp ne i64 %t2, 0
  %v2 = select i1 %has2, i64 8, i64 0
  %acc2 = or i64 %acc1, %v2
  %t3 = and i64 %target, 8
  %has3 = icmp ne i64 %t3, 0
  %v3 = select i1 %has3, i64 16, i64 0
  %acc3 = or i64 %acc2, %v3
  %t4 = and i64 %target, 16
  %has4 = icmp ne i64 %t4, 0
  %v4 = select i1 %has4, i64 32, i64 0
  %acc4 = or i64 %acc3, %v4
  %t5 = and i64 %target, 32
  %has5 = icmp ne i64 %t5, 0
  %v5 = select i1 %has5, i64 64, i64 0
  %acc5 = or i64 %acc4, %v5
  ret i64 %acc5
}

define internal i64 @__mtrt_linux_cflag_to_target(i64 %native) {
entry:
  %size = and i64 %native, 48
  %is_cs6 = icmp eq i64 %size, 16
  %cs6 = select i1 %is_cs6, i64 1, i64 0
  %is_cs7 = icmp eq i64 %size, 32
  %cs7 = select i1 %is_cs7, i64 2, i64 0
  %is_cs8 = icmp eq i64 %size, 48
  %cs8 = select i1 %is_cs8, i64 3, i64 0
  %cs67 = or i64 %cs6, %cs7
  %cs = or i64 %cs67, %cs8
  %stop_n = and i64 %native, 64
  %stop_has = icmp ne i64 %stop_n, 0
  %stop = select i1 %stop_has, i64 4, i64 0
  %read_n = and i64 %native, 128
  %read_has = icmp ne i64 %read_n, 0
  %read = select i1 %read_has, i64 8, i64 0
  %parenb_n = and i64 %native, 256
  %parenb_has = icmp ne i64 %parenb_n, 0
  %parenb = select i1 %parenb_has, i64 16, i64 0
  %parodd_n = and i64 %native, 512
  %parodd_has = icmp ne i64 %parodd_n, 0
  %parodd = select i1 %parodd_has, i64 32, i64 0
  %hup_n = and i64 %native, 1024
  %hup_has = icmp ne i64 %hup_n, 0
  %hup = select i1 %hup_has, i64 64, i64 0
  %local_n = and i64 %native, 2048
  %local_has = icmp ne i64 %local_n, 0
  %local = select i1 %local_has, i64 128, i64 0
  %a = or i64 %cs, %stop
  %b = or i64 %a, %read
  %c = or i64 %b, %parenb
  %d = or i64 %c, %parodd
  %e = or i64 %d, %hup
  %f = or i64 %e, %local
  ret i64 %f
}

define internal i64 @__mtrt_linux_cflag_to_native(i64 %target) {
entry:
  %size = and i64 %target, 3
  %is_cs6 = icmp eq i64 %size, 1
  %cs6 = select i1 %is_cs6, i64 16, i64 0
  %is_cs7 = icmp eq i64 %size, 2
  %cs7 = select i1 %is_cs7, i64 32, i64 0
  %is_cs8 = icmp eq i64 %size, 3
  %cs8 = select i1 %is_cs8, i64 48, i64 0
  %cs67 = or i64 %cs6, %cs7
  %cs = or i64 %cs67, %cs8
  %stop_t = and i64 %target, 4
  %stop_has = icmp ne i64 %stop_t, 0
  %stop = select i1 %stop_has, i64 64, i64 0
  %read_t = and i64 %target, 8
  %read_has = icmp ne i64 %read_t, 0
  %read = select i1 %read_has, i64 128, i64 0
  %parenb_t = and i64 %target, 16
  %parenb_has = icmp ne i64 %parenb_t, 0
  %parenb = select i1 %parenb_has, i64 256, i64 0
  %parodd_t = and i64 %target, 32
  %parodd_has = icmp ne i64 %parodd_t, 0
  %parodd = select i1 %parodd_has, i64 512, i64 0
  %hup_t = and i64 %target, 64
  %hup_has = icmp ne i64 %hup_t, 0
  %hup = select i1 %hup_has, i64 1024, i64 0
  %local_t = and i64 %target, 128
  %local_has = icmp ne i64 %local_t, 0
  %local = select i1 %local_has, i64 2048, i64 0
  %a = or i64 %cs, %stop
  %b = or i64 %a, %read
  %c = or i64 %b, %parenb
  %d = or i64 %c, %parodd
  %e = or i64 %d, %hup
  %f = or i64 %e, %local
  ret i64 %f
}

define internal i64 @__mtrt_linux_lflag_to_target(i64 %native) {
entry:
  %n0 = and i64 %native, 8
  %has0 = icmp ne i64 %n0, 0
  %v0 = select i1 %has0, i64 1, i64 0
  %acc0 = or i64 0, %v0
  %n1 = and i64 %native, 16
  %has1 = icmp ne i64 %n1, 0
  %v1 = select i1 %has1, i64 2, i64 0
  %acc1 = or i64 %acc0, %v1
  %n2 = and i64 %native, 32
  %has2 = icmp ne i64 %n2, 0
  %v2 = select i1 %has2, i64 4, i64 0
  %acc2 = or i64 %acc1, %v2
  %n3 = and i64 %native, 64
  %has3 = icmp ne i64 %n3, 0
  %v3 = select i1 %has3, i64 8, i64 0
  %acc3 = or i64 %acc2, %v3
  %n4 = and i64 %native, 2
  %has4 = icmp ne i64 %n4, 0
  %v4 = select i1 %has4, i64 16, i64 0
  %acc4 = or i64 %acc3, %v4
  %n5 = and i64 %native, 32768
  %has5 = icmp ne i64 %n5, 0
  %v5 = select i1 %has5, i64 32, i64 0
  %acc5 = or i64 %acc4, %v5
  %n6 = and i64 %native, 1
  %has6 = icmp ne i64 %n6, 0
  %v6 = select i1 %has6, i64 64, i64 0
  %acc6 = or i64 %acc5, %v6
  %n7 = and i64 %native, 128
  %has7 = icmp ne i64 %n7, 0
  %v7 = select i1 %has7, i64 128, i64 0
  %acc7 = or i64 %acc6, %v7
  %n8 = and i64 %native, 256
  %has8 = icmp ne i64 %n8, 0
  %v8 = select i1 %has8, i64 256, i64 0
  %acc8 = or i64 %acc7, %v8
  ret i64 %acc8
}

define internal i64 @__mtrt_linux_lflag_to_native(i64 %target) {
entry:
  %t0 = and i64 %target, 1
  %has0 = icmp ne i64 %t0, 0
  %v0 = select i1 %has0, i64 8, i64 0
  %acc0 = or i64 0, %v0
  %t1 = and i64 %target, 2
  %has1 = icmp ne i64 %t1, 0
  %v1 = select i1 %has1, i64 16, i64 0
  %acc1 = or i64 %acc0, %v1
  %t2 = and i64 %target, 4
  %has2 = icmp ne i64 %t2, 0
  %v2 = select i1 %has2, i64 32, i64 0
  %acc2 = or i64 %acc1, %v2
  %t3 = and i64 %target, 8
  %has3 = icmp ne i64 %t3, 0
  %v3 = select i1 %has3, i64 64, i64 0
  %acc3 = or i64 %acc2, %v3
  %t4 = and i64 %target, 16
  %has4 = icmp ne i64 %t4, 0
  %v4 = select i1 %has4, i64 2, i64 0
  %acc4 = or i64 %acc3, %v4
  %t5 = and i64 %target, 32
  %has5 = icmp ne i64 %t5, 0
  %v5 = select i1 %has5, i64 32768, i64 0
  %acc5 = or i64 %acc4, %v5
  %t6 = and i64 %target, 64
  %has6 = icmp ne i64 %t6, 0
  %v6 = select i1 %has6, i64 1, i64 0
  %acc6 = or i64 %acc5, %v6
  %t7 = and i64 %target, 128
  %has7 = icmp ne i64 %t7, 0
  %v7 = select i1 %has7, i64 128, i64 0
  %acc7 = or i64 %acc6, %v7
  %t8 = and i64 %target, 256
  %has8 = icmp ne i64 %t8, 0
  %v8 = select i1 %has8, i64 256, i64 0
  %acc8 = or i64 %acc7, %v8
  ret i64 %acc8
}

define internal void @__mtrt_linux_zero_target_cc(ptr %target) {
entry:
  br label %loop

loop:
  %i = phi i64 [ 0, %entry ], [ %next, %body ]
  %done = icmp uge i64 %i, 32
  br i1 %done, label %ret, label %body

body:
  %p0 = getelementptr i8, ptr %target, i64 40
  %p = getelementptr i8, ptr %p0, i64 %i
  store i8 0, ptr %p, align 1
  %next = add i64 %i, 1
  br label %loop

ret:
  ret void
}

define internal void @__mtrt_linux_copy_native_cc_to_target(ptr %target, ptr %native) {
entry:
  call void @__mtrt_linux_zero_target_cc(ptr %target)
  br label %loop

loop:
  %i = phi i64 [ 0, %entry ], [ %next, %body ]
  %done = icmp uge i64 %i, 19
  br i1 %done, label %ret, label %body

body:
  %src0 = getelementptr i8, ptr %native, i64 17
  %src = getelementptr i8, ptr %src0, i64 %i
  %v = load i8, ptr %src, align 1
  %dst0 = getelementptr i8, ptr %target, i64 40
  %dst = getelementptr i8, ptr %dst0, i64 %i
  store i8 %v, ptr %dst, align 1
  %next = add i64 %i, 1
  br label %loop

ret:
  ret void
}

define internal void @__mtrt_linux_copy_target_cc_to_native(ptr %native, ptr %target) {
entry:
  br label %loop

loop:
  %i = phi i64 [ 0, %entry ], [ %next, %body ]
  %done = icmp uge i64 %i, 19
  br i1 %done, label %ret, label %body

body:
  %src0 = getelementptr i8, ptr %target, i64 40
  %src = getelementptr i8, ptr %src0, i64 %i
  %v = load i8, ptr %src, align 1
  %dst0 = getelementptr i8, ptr %native, i64 17
  %dst = getelementptr i8, ptr %dst0, i64 %i
  store i8 %v, ptr %dst, align 1
  %next = add i64 %i, 1
  br label %loop

ret:
  ret void
}

define internal i1 @__mtrt_linux_termios_target_valid(ptr %target) {
entry:
  %iflag = load i64, ptr %target, align 8
  %if_extra = and i64 %iflag, -4096
  %if_bad = icmp ne i64 %if_extra, 0
  br i1 %if_bad, label %bad, label %oflag_check

oflag_check:
  %oflag_p = getelementptr i8, ptr %target, i64 8
  %oflag = load i64, ptr %oflag_p, align 8
  %of_extra = and i64 %oflag, -64
  %of_bad = icmp ne i64 %of_extra, 0
  br i1 %of_bad, label %bad, label %cflag_check

cflag_check:
  %cflag_p = getelementptr i8, ptr %target, i64 16
  %cflag = load i64, ptr %cflag_p, align 8
  %cf_extra = and i64 %cflag, -256
  %cf_bad = icmp ne i64 %cf_extra, 0
  br i1 %cf_bad, label %bad, label %lflag_check

lflag_check:
  %lflag_p = getelementptr i8, ptr %target, i64 24
  %lflag = load i64, ptr %lflag_p, align 8
  %lf_extra = and i64 %lflag, -512
  %lf_bad = icmp ne i64 %lf_extra, 0
  br i1 %lf_bad, label %bad, label %speed_check

speed_check:
  %ispeed_p = getelementptr i8, ptr %target, i64 32
  %ispeed = load i32, ptr %ispeed_p, align 4
  %inative = call i32 @__mtrt_linux_speed_to_native(i32 %ispeed)
  %ibad = icmp eq i32 %inative, -1
  br i1 %ibad, label %bad, label %ospeed_check

ospeed_check:
  %ospeed_p = getelementptr i8, ptr %target, i64 36
  %ospeed = load i32, ptr %ospeed_p, align 4
  %onative = call i32 @__mtrt_linux_speed_to_native(i32 %ospeed)
  %obad = icmp eq i32 %onative, -1
  br i1 %obad, label %bad, label %ok

ok:
  ret i1 true

bad:
  ret i1 false
}

define internal void @__mtrt_linux_store_target_termios(ptr %target, ptr %native) {
entry:
  %if32 = load i32, ptr %native, align 4
  %if64 = zext i32 %if32 to i64
  %if_target = call i64 @__mtrt_linux_iflag_to_target(i64 %if64)
  store i64 %if_target, ptr %target, align 8
  %ofp = getelementptr i8, ptr %native, i64 4
  %of32 = load i32, ptr %ofp, align 4
  %of64 = zext i32 %of32 to i64
  %of_target = call i64 @__mtrt_linux_oflag_to_target(i64 %of64)
  %of_target_p = getelementptr i8, ptr %target, i64 8
  store i64 %of_target, ptr %of_target_p, align 8
  %cfp = getelementptr i8, ptr %native, i64 8
  %cf32 = load i32, ptr %cfp, align 4
  %cf64 = zext i32 %cf32 to i64
  %cf_target = call i64 @__mtrt_linux_cflag_to_target(i64 %cf64)
  %cf_target_p = getelementptr i8, ptr %target, i64 16
  store i64 %cf_target, ptr %cf_target_p, align 8
  %lfp = getelementptr i8, ptr %native, i64 12
  %lf32 = load i32, ptr %lfp, align 4
  %lf64 = zext i32 %lf32 to i64
  %lf_target = call i64 @__mtrt_linux_lflag_to_target(i64 %lf64)
  %lf_target_p = getelementptr i8, ptr %target, i64 24
  store i64 %lf_target, ptr %lf_target_p, align 8
  %os_code64 = and i64 %cf64, 15
  %os_code = trunc i64 %os_code64 to i32
  %os_target = call i32 @__mtrt_linux_native_speed_to_target(i32 %os_code)
  %is_code_shifted = lshr i64 %cf64, 16
  %is_code64 = and i64 %is_code_shifted, 15
  %is_code = trunc i64 %is_code64 to i32
  %is_zero = icmp eq i32 %is_code, 0
  %is_target_raw = call i32 @__mtrt_linux_native_speed_to_target(i32 %is_code)
  %is_target = select i1 %is_zero, i32 %os_target, i32 %is_target_raw
  %is_target_p = getelementptr i8, ptr %target, i64 32
  store i32 %is_target, ptr %is_target_p, align 4
  %os_target_p = getelementptr i8, ptr %target, i64 36
  store i32 %os_target, ptr %os_target_p, align 4
  call void @__mtrt_linux_copy_native_cc_to_target(ptr %target, ptr %native)
  ret void
}

define internal void @__mtrt_linux_overlay_native_termios(ptr %native, ptr %target) {
entry:
  %iflag = load i64, ptr %target, align 8
  %if_native = call i64 @__mtrt_linux_iflag_to_native(i64 %iflag)
  %if_old32 = load i32, ptr %native, align 4
  %if_old = zext i32 %if_old32 to i64
  %if_preserved = and i64 %if_old, -7680
  %if_new = or i64 %if_preserved, %if_native
  %if_new32 = trunc i64 %if_new to i32
  store i32 %if_new32, ptr %native, align 4
  %of_target_p = getelementptr i8, ptr %target, i64 8
  %oflag = load i64, ptr %of_target_p, align 8
  %of_native = call i64 @__mtrt_linux_oflag_to_native(i64 %oflag)
  %of_native_p = getelementptr i8, ptr %native, i64 4
  %of_old32 = load i32, ptr %of_native_p, align 4
  %of_old = zext i32 %of_old32 to i64
  %of_preserved = and i64 %of_old, -126
  %of_new = or i64 %of_preserved, %of_native
  %of_new32 = trunc i64 %of_new to i32
  store i32 %of_new32, ptr %of_native_p, align 4
  %cf_target_p = getelementptr i8, ptr %target, i64 16
  %cflag = load i64, ptr %cf_target_p, align 8
  %cf_native_flags = call i64 @__mtrt_linux_cflag_to_native(i64 %cflag)
  %ispeed_p = getelementptr i8, ptr %target, i64 32
  %ispeed = load i32, ptr %ispeed_p, align 4
  %is_native32 = call i32 @__mtrt_linux_speed_to_native(i32 %ispeed)
  %is_native = zext i32 %is_native32 to i64
  %is_shifted = shl i64 %is_native, 16
  %ospeed_p = getelementptr i8, ptr %target, i64 36
  %ospeed = load i32, ptr %ospeed_p, align 4
  %os_native32 = call i32 @__mtrt_linux_speed_to_native(i32 %ospeed)
  %os_native = zext i32 %os_native32 to i64
  %speed_bits = or i64 %is_shifted, %os_native
  %cf_native = or i64 %cf_native_flags, %speed_bits
  %cf_native_p = getelementptr i8, ptr %native, i64 8
  %cf_old32 = load i32, ptr %cf_native_p, align 4
  %cf_old = zext i32 %cf_old32 to i64
  %cf_preserved = and i64 %cf_old, -269422592
  %cf_new = or i64 %cf_preserved, %cf_native
  %cf_new32 = trunc i64 %cf_new to i32
  store i32 %cf_new32, ptr %cf_native_p, align 4
  %lf_target_p = getelementptr i8, ptr %target, i64 24
  %lflag = load i64, ptr %lf_target_p, align 8
  %lf_native = call i64 @__mtrt_linux_lflag_to_native(i64 %lflag)
  %lf_native_p = getelementptr i8, ptr %native, i64 12
  %lf_old32 = load i32, ptr %lf_native_p, align 4
  %lf_old = zext i32 %lf_old32 to i64
  %lf_preserved = and i64 %lf_old, -33276
  %lf_new = or i64 %lf_preserved, %lf_native
  %lf_new32 = trunc i64 %lf_new to i32
  store i32 %lf_new32, ptr %lf_native_p, align 4
  call void @__mtrt_linux_copy_target_cc_to_native(ptr %native, ptr %target)
  ret void
}

define internal i64 @__mtrt_linux_tcsetattr_request(i64 %action) {
entry:
  switch i64 %action, label %bad [
    i64 0, label %now
    i64 1, label %drain
    i64 2, label %flush
  ]

now:
  ret i64 21506

drain:
  ret i64 21507

flush:
  ret i64 21508

bad:
  ret i64 -1
}

define i64 @__mtrt_host_tcgetattr(i64 %fd, ptr %termios) {
entry:
  %is_null = icmp eq ptr %termios, null
  br i1 %is_null, label %fault, label %call_get

fault:
  ret i64 -14

call_get:
  %native = alloca [36 x i8], align 4
  %r = call i64 @__mtrt_linux_ioctl_ptr(i64 %fd, i64 21505, ptr %native)
  %ok = icmp eq i64 %r, 0
  br i1 %ok, label %store, label %done

store:
  call void @__mtrt_linux_store_target_termios(ptr %termios, ptr %native)
  ret i64 0

done:
  ret i64 %r
}

define i64 @__mtrt_host_isatty(i64 %fd) {
entry:
  %native = alloca [36 x i8], align 4
  %r = call i64 @__mtrt_linux_ioctl_ptr(i64 %fd, i64 21505, ptr %native)
  %ok = icmp eq i64 %r, 0
  br i1 %ok, label %terminal, label %check_enotty

terminal:
  ret i64 1

check_enotty:
  %not_tty = icmp eq i64 %r, -25
  br i1 %not_tty, label %non_terminal, label %check_enodev

check_enodev:
  %no_device = icmp eq i64 %r, -19
  br i1 %no_device, label %non_terminal, label %done

non_terminal:
  ret i64 0

done:
  ret i64 %r
}

define i64 @__mtrt_host_tcsetattr(i64 %fd, i64 %action, ptr %termios) {
entry:
  %is_null = icmp eq ptr %termios, null
  br i1 %is_null, label %fault, label %map_action

fault:
  ret i64 -14

map_action:
  %request = call i64 @__mtrt_linux_tcsetattr_request(i64 %action)
  %bad_action = icmp eq i64 %request, -1
  br i1 %bad_action, label %invalid, label %validate

invalid:
  ret i64 -22

validate:
  %valid = call i1 @__mtrt_linux_termios_target_valid(ptr %termios)
  br i1 %valid, label %read_native, label %invalid

read_native:
  %native = alloca [36 x i8], align 4
  %get = call i64 @__mtrt_linux_ioctl_ptr(i64 %fd, i64 21505, ptr %native)
  %get_ok = icmp eq i64 %get, 0
  br i1 %get_ok, label %overlay, label %done

overlay:
  call void @__mtrt_linux_overlay_native_termios(ptr %native, ptr %termios)
  %set = call i64 @__mtrt_linux_ioctl_ptr(i64 %fd, i64 %request, ptr %native)
  ret i64 %set

done:
  ret i64 %get
}

define i64 @__mtrt_host_tcdrain(i64 %fd) {
entry:
  %r = call i64 @__mtrt_linux_ioctl_int(i64 %fd, i64 21513, i64 1)
  ret i64 %r
}

define internal i64 @__mtrt_linux_tcflow_action(i64 %action) {
entry:
  switch i64 %action, label %bad [
    i64 0, label %ok0
    i64 1, label %ok1
    i64 2, label %ok2
    i64 3, label %ok3
  ]

ok0:
  ret i64 0

ok1:
  ret i64 1

ok2:
  ret i64 2

ok3:
  ret i64 3

bad:
  ret i64 -1
}

define i64 @__mtrt_host_tcflow(i64 %fd, i64 %action) {
entry:
  %native = call i64 @__mtrt_linux_tcflow_action(i64 %action)
  %bad = icmp eq i64 %native, -1
  br i1 %bad, label %invalid, label %call_ioctl

invalid:
  ret i64 -22

call_ioctl:
  %r = call i64 @__mtrt_linux_ioctl_int(i64 %fd, i64 21514, i64 %native)
  ret i64 %r
}

define internal i64 @__mtrt_linux_tcflush_selector(i64 %selector) {
entry:
  switch i64 %selector, label %bad [
    i64 0, label %ok0
    i64 1, label %ok1
    i64 2, label %ok2
  ]

ok0:
  ret i64 0

ok1:
  ret i64 1

ok2:
  ret i64 2

bad:
  ret i64 -1
}

define i64 @__mtrt_host_tcflush(i64 %fd, i64 %selector) {
entry:
  %native = call i64 @__mtrt_linux_tcflush_selector(i64 %selector)
  %bad = icmp eq i64 %native, -1
  br i1 %bad, label %invalid, label %call_ioctl

invalid:
  ret i64 -22

call_ioctl:
  %r = call i64 @__mtrt_linux_ioctl_int(i64 %fd, i64 21515, i64 %native)
  ret i64 %r
}

define i64 @__mtrt_host_tcsendbreak(i64 %fd, i64 %duration) {
entry:
  %is_zero = icmp eq i64 %duration, 0
  br i1 %is_zero, label %basic, label %duration_ioctl

basic:
  %r0 = call i64 @__mtrt_linux_ioctl_int(i64 %fd, i64 21513, i64 0)
  ret i64 %r0

duration_ioctl:
  %r1 = call i64 @__mtrt_linux_ioctl_int(i64 %fd, i64 21541, i64 %duration)
  ret i64 %r1
}

define i64 @__mtrt_host_tcgetpgrp(i64 %fd) {
entry:
  %pgrp = alloca i32, align 4
  %r = call i64 @__mtrt_linux_ioctl_ptr(i64 %fd, i64 21519, ptr %pgrp)
  %ok = icmp eq i64 %r, 0
  br i1 %ok, label %load, label %done

load:
  %pgrp32 = load i32, ptr %pgrp, align 4
  %pgrp64 = sext i32 %pgrp32 to i64
  ret i64 %pgrp64

done:
  ret i64 %r
}

define i64 @__mtrt_host_tcsetpgrp(i64 %fd, i64 %pgrp) {
entry:
  %slot = alloca i32, align 4
  %pgrp32 = trunc i64 %pgrp to i32
  store i32 %pgrp32, ptr %slot, align 4
  %r = call i64 @__mtrt_linux_ioctl_ptr(i64 %fd, i64 21520, ptr %slot)
  ret i64 %r
}

define i64 @__mtrt_host_clock_getres(i64 %clockid, ptr %tp) {
entry:
  %native_clockid = call i64 @__mtrt_linux_clockid_from_target(i64 %clockid)
  %bad_clockid = icmp slt i64 %native_clockid, 0
  br i1 %bad_clockid, label %invalid_clockid, label %call_clock

call_clock:
  %tp_i = ptrtoint ptr %tp to i64
  %r = call i64 @__mtrt_linux_syscall2(i64 114, i64 %native_clockid, i64 %tp_i)
  ret i64 %r

invalid_clockid:
  ret i64 %native_clockid
}

define i64 @__mtrt_host_clock_settime(i64 %clockid, ptr %tp) {
entry:
  %native_clockid = call i64 @__mtrt_linux_clockid_from_target(i64 %clockid)
  %bad_clockid = icmp slt i64 %native_clockid, 0
  br i1 %bad_clockid, label %invalid_clockid, label %check_settable

check_settable:
  %is_monotonic = icmp eq i64 %clockid, 1
  br i1 %is_monotonic, label %invalid_monotonic, label %call_clock

call_clock:
  %tp_i = ptrtoint ptr %tp to i64
  %r = call i64 @__mtrt_linux_syscall2(i64 112, i64 %native_clockid, i64 %tp_i)
  ret i64 %r

invalid_clockid:
  ret i64 %native_clockid

invalid_monotonic:
  ret i64 -22
}

define i64 @__mtrt_host_execve(ptr %path, ptr %argv, ptr %envp) {
  %path_i = ptrtoint ptr %path to i64
  %argv_i = ptrtoint ptr %argv to i64
  %envp_i = ptrtoint ptr %envp to i64
  %r = call i64 @__mtrt_linux_syscall3(i64 221, i64 %path_i, i64 %argv_i, i64 %envp_i)
  ret i64 %r
}

define i64 @__mtrt_host_fchown(i64 %fd, i64 %uid, i64 %gid) {
  %r = call i64 @__mtrt_linux_syscall3(i64 55, i64 %fd, i64 %uid, i64 %gid)
  ret i64 %r
}

define i64 @__mtrt_host_fchownat(i64 %dirfd, ptr %path, i64 %uid, i64 %gid, i64 %flags) {
  %path_i = ptrtoint ptr %path to i64
  %r = call i64 @__mtrt_linux_syscall5(i64 54, i64 %dirfd, i64 %path_i, i64 %uid, i64 %gid, i64 %flags)
  ret i64 %r
}

define i64 @__mtrt_host_fcntl(i64 %fd, i64 %cmd, i64 %arg) {
  %r = call i64 @__mtrt_linux_syscall3(i64 25, i64 %fd, i64 %cmd, i64 %arg)
  ret i64 %r
}

define i64 @__mtrt_host_fdatasync(i64 %fd) {
  %r = call i64 @__mtrt_linux_syscall1(i64 83, i64 %fd)
  ret i64 %r
}

define i64 @__mtrt_host_fsync(i64 %fd) {
  %r = call i64 @__mtrt_linux_syscall1(i64 82, i64 %fd)
  ret i64 %r
}

define i64 @__mtrt_host_getcwd(ptr %buf, i64 %size) {
entry:
  %buf_i = ptrtoint ptr %buf to i64
  %r = call i64 @__mtrt_linux_syscall2(i64 17, i64 %buf_i, i64 %size)
  %bad = icmp slt i64 %r, 0
  br i1 %bad, label %done, label %success

success:
  %ret = ptrtoint ptr %buf to i64
  ret i64 %ret

done:
  ret i64 %r
}

define i64 @__mtrt_host_lchown(ptr %path, i64 %uid, i64 %gid) {
  %path_i = ptrtoint ptr %path to i64
  %r = call i64 @__mtrt_linux_syscall5(i64 54, i64 -100, i64 %path_i, i64 %uid, i64 %gid, i64 256)
  ret i64 %r
}

define i64 @__mtrt_host_madvise(i64 %addr, i64 %length, i64 %advice) {
  %r = call i64 @__mtrt_linux_syscall3(i64 233, i64 %addr, i64 %length, i64 %advice)
  ret i64 %r
}

define i64 @__mtrt_host_mlock(i64 %addr, i64 %length) {
  %r = call i64 @__mtrt_linux_syscall2(i64 228, i64 %addr, i64 %length)
  ret i64 %r
}

define i64 @__mtrt_host_mmap(i64 %addr, i64 %length, i64 %prot, i64 %flags, i64 %fd, i64 %offset) {
  %r = call i64 @__mtrt_linux_syscall6(i64 222, i64 %addr, i64 %length, i64 %prot, i64 %flags, i64 %fd, i64 %offset)
  ret i64 %r
}

define i64 @__mtrt_host_mprotect(i64 %addr, i64 %length, i64 %prot) {
  %r = call i64 @__mtrt_linux_syscall3(i64 226, i64 %addr, i64 %length, i64 %prot)
  ret i64 %r
}

define i64 @__mtrt_host_msync(i64 %addr, i64 %length, i64 %flags) {
  %r = call i64 @__mtrt_linux_syscall3(i64 227, i64 %addr, i64 %length, i64 %flags)
  ret i64 %r
}

define i64 @__mtrt_host_munlock(i64 %addr, i64 %length) {
  %r = call i64 @__mtrt_linux_syscall2(i64 229, i64 %addr, i64 %length)
  ret i64 %r
}

define i64 @__mtrt_host_munmap(i64 %addr, i64 %length) {
  %r = call i64 @__mtrt_linux_syscall2(i64 215, i64 %addr, i64 %length)
  ret i64 %r
}

define i64 @__mtrt_host_pause() {
entry:
  %native_old = alloca i64, align 8
  %target_old = alloca i64, align 8
  %native_mask = alloca i64, align 8
  %old_i = ptrtoint ptr %native_old to i64
  %get_mask = call i64 @__mtrt_linux_syscall4(i64 135, i64 0, i64 0, i64 %old_i, i64 8)
  %bad = icmp slt i64 %get_mask, 0
  br i1 %bad, label %done, label %translate

translate:
  %native_old_v = load i64, ptr %native_old, align 8
  %target_old_v = call i64 @__mtrt_linux_sigset_from_native(i64 %native_old_v)
  store i64 %target_old_v, ptr %target_old, align 8
  %native_mask_v = call i64 @__mtrt_linux_sigset_to_native(i64 %target_old_v)
  store i64 %native_mask_v, ptr %native_mask, align 8
  %mask_i = ptrtoint ptr %native_mask to i64
  %r = call i64 @__mtrt_linux_syscall2(i64 133, i64 %mask_i, i64 8)
  ret i64 %r

done:
  ret i64 %get_mask
}

define i64 @__mtrt_host_pipe2(ptr %fds, i64 %flags) {
  %fds_i = ptrtoint ptr %fds to i64
  %r = call i64 @__mtrt_linux_syscall2(i64 59, i64 %fds_i, i64 %flags)
  ret i64 %r
}

define i64 @__mtrt_host_sched_yield() {
  %r = call i64 @__mtrt_linux_syscall0(i64 124)
  ret i64 %r
}

define i64 @__mtrt_host_sigaction(i64 %sig, ptr %act, ptr %oldact) {
entry:
  %native_act = alloca [32 x i8], align 8
  %native_oldact = alloca [32 x i8], align 8
  %native_sig = call i64 @__mtrt_linux_signal_to_native(i64 %sig)
  %bad_sig = icmp slt i64 %native_sig, 0
  br i1 %bad_sig, label %invalid, label %check_act

check_act:
  %current_handler = call i64 @__mtrt_linux_load_target_handler(i64 %sig)
  %current_flags = call i64 @__mtrt_linux_load_target_flags(i64 %sig)
  %act_is_null = icmp eq ptr %act, null
  br i1 %act_is_null, label %prep_oldact, label %copy_act

copy_act:
  %target_handler_i = load i64, ptr %act, align 8
  %dispatcher_i = call i64 @__mtrt_linux_sigaction_dispatcher(i64 %sig)
  %is_remapped = icmp ne i64 %dispatcher_i, 0
  %is_dfl = icmp eq i64 %target_handler_i, 0
  %is_ign = icmp eq i64 %target_handler_i, 1
  %is_special = or i1 %is_dfl, %is_ign
  %use_dispatcher = and i1 %is_remapped, %is_special
  %use_target_dispatcher = xor i1 %use_dispatcher, %is_remapped
  %native_handler_i = select i1 %use_target_dispatcher, i64 %dispatcher_i, i64 %target_handler_i
  store i64 %native_handler_i, ptr %native_act, align 8
  %target_flags_p = getelementptr i8, ptr %act, i64 8
  %target_flags = load i64, ptr %target_flags_p, align 8
  %native_flags = call i64 @__mtrt_linux_sigaction_flags_to_native(i64 %target_flags)
  %bad_flags = icmp slt i64 %native_flags, 0
  br i1 %bad_flags, label %invalid, label %copy_act_mask

copy_act_mask:
  %native_flags_p = getelementptr i8, ptr %native_act, i64 8
  store i64 %native_flags, ptr %native_flags_p, align 8
  %native_restorer_p = getelementptr i8, ptr %native_act, i64 16
  store i64 0, ptr %native_restorer_p, align 8
  %target_mask_p = getelementptr i8, ptr %act, i64 16
  %target_mask = load i64, ptr %target_mask_p, align 8
  %native_mask = call i64 @__mtrt_linux_sigset_to_native(i64 %target_mask)
  %bad_mask = icmp slt i64 %native_mask, 0
  br i1 %bad_mask, label %invalid, label %store_act_mask

store_act_mask:
  %native_mask_p = getelementptr i8, ptr %native_act, i64 24
  store i64 %native_mask, ptr %native_mask_p, align 8
  br i1 %is_remapped, label %store_target_action, label %act_ready

store_target_action:
  call void @__mtrt_linux_store_target_action(i64 %sig, i64 %target_handler_i, i64 %target_flags)
  br label %act_ready

act_ready:
  %native_act_i = ptrtoint ptr %native_act to i64
  br label %prep_oldact

prep_oldact:
  %previous_handler_phi = phi i64 [ %current_handler, %check_act ], [ %current_handler, %act_ready ]
  %previous_flags_phi = phi i64 [ %current_flags, %check_act ], [ %current_flags, %act_ready ]
  %stored_remapped_phi = phi i1 [ false, %check_act ], [ %is_remapped, %act_ready ]
  %act_i = phi i64 [ 0, %check_act ], [ %native_act_i, %act_ready ]
  %oldact_is_null = icmp eq ptr %oldact, null
  br i1 %oldact_is_null, label %do_call, label %set_oldact

set_oldact:
  %native_oldact_i = ptrtoint ptr %native_oldact to i64
  br label %do_call

do_call:
  %oldact_i = phi i64 [ 0, %prep_oldact ], [ %native_oldact_i, %set_oldact ]
  %r = call i64 @__mtrt_linux_syscall4(i64 134, i64 %native_sig, i64 %act_i, i64 %oldact_i, i64 8)
  %bad = icmp slt i64 %r, 0
  br i1 %bad, label %restore_on_error, label %maybe_store_oldact

restore_on_error:
  br i1 %stored_remapped_phi, label %restore_previous_action, label %done

restore_previous_action:
  call void @__mtrt_linux_store_target_action(i64 %sig, i64 %previous_handler_phi, i64 %previous_flags_phi)
  br label %done

maybe_store_oldact:
  br i1 %oldact_is_null, label %done, label %store_oldact

store_oldact:
  %old_handler = load i64, ptr %native_oldact, align 8
  %old_target_handler = call i64 @__mtrt_linux_sigaction_handler_from_native(i64 %sig, i64 %old_handler, i64 %previous_handler_phi)
  store i64 %old_target_handler, ptr %oldact, align 8
  %old_native_flags_p = getelementptr i8, ptr %native_oldact, i64 8
  %old_native_flags = load i64, ptr %old_native_flags_p, align 8
  %old_target_flags = call i64 @__mtrt_linux_sigaction_flags_from_native(i64 %old_native_flags)
  %old_target_flags_p = getelementptr i8, ptr %oldact, i64 8
  store i64 %old_target_flags, ptr %old_target_flags_p, align 8
  %old_native_mask_p = getelementptr i8, ptr %native_oldact, i64 24
  %old_native_mask = load i64, ptr %old_native_mask_p, align 8
  %old_target_mask = call i64 @__mtrt_linux_sigset_from_native(i64 %old_native_mask)
  %old_target_mask_p = getelementptr i8, ptr %oldact, i64 16
  store i64 %old_target_mask, ptr %old_target_mask_p, align 8
  ret i64 %r

invalid:
  ret i64 -22

done:
  ret i64 %r
}

define i64 @__mtrt_host_sigaltstack(ptr %ss, ptr %old_ss) {
  %ss_i = ptrtoint ptr %ss to i64
  %old_i = ptrtoint ptr %old_ss to i64
  %r = call i64 @__mtrt_linux_syscall2(i64 132, i64 %ss_i, i64 %old_i)
  ret i64 %r
}

define i64 @__mtrt_host_sigpending(ptr %sigset) {
entry:
  %native_sigset = alloca i64, align 8
  %is_null = icmp eq ptr %sigset, null
  br i1 %is_null, label %fault, label %call_sigpending

fault:
  ret i64 -14

call_sigpending:
  %native_sigset_i = ptrtoint ptr %native_sigset to i64
  %r = call i64 @__mtrt_linux_syscall2(i64 136, i64 %native_sigset_i, i64 8)
  %bad = icmp slt i64 %r, 0
  br i1 %bad, label %done, label %store_sigset

store_sigset:
  %native_value = load i64, ptr %native_sigset, align 8
  %target_value = call i64 @__mtrt_linux_sigset_from_native(i64 %native_value)
  store i64 %target_value, ptr %sigset, align 8
  ret i64 %r

done:
  ret i64 %r
}

define i64 @__mtrt_host_sigprocmask(i64 %how, ptr %set, ptr %oldset) {
entry:
  %native_set = alloca i64, align 8
  %native_oldset = alloca i64, align 8
  %set_is_null = icmp eq ptr %set, null
  br i1 %set_is_null, label %prep_oldset, label %copy_set

copy_set:
  %target_set = load i64, ptr %set, align 8
  %native_set_value = call i64 @__mtrt_linux_sigset_to_native(i64 %target_set)
  %bad_set = icmp slt i64 %native_set_value, 0
  br i1 %bad_set, label %invalid, label %store_set

store_set:
  store i64 %native_set_value, ptr %native_set, align 8
  %native_set_i = ptrtoint ptr %native_set to i64
  br label %prep_oldset

prep_oldset:
  %set_i = phi i64 [ 0, %entry ], [ %native_set_i, %store_set ]
  %oldset_is_null = icmp eq ptr %oldset, null
  br i1 %oldset_is_null, label %do_call, label %set_oldset

set_oldset:
  %native_oldset_i = ptrtoint ptr %native_oldset to i64
  br label %do_call

do_call:
  %oldset_i = phi i64 [ 0, %prep_oldset ], [ %native_oldset_i, %set_oldset ]
  %r = call i64 @__mtrt_linux_syscall4(i64 135, i64 %how, i64 %set_i, i64 %oldset_i, i64 8)
  %bad = icmp slt i64 %r, 0
  br i1 %bad, label %done, label %maybe_store_oldset

maybe_store_oldset:
  br i1 %oldset_is_null, label %done, label %store_oldset

store_oldset:
  %native_old = load i64, ptr %native_oldset, align 8
  %target_old = call i64 @__mtrt_linux_sigset_from_native(i64 %native_old)
  store i64 %target_old, ptr %oldset, align 8
  ret i64 %r

invalid:
  ret i64 -22

done:
  ret i64 %r
}

define i64 @__mtrt_host_sigsuspend(ptr %sigmask) {
entry:
  %native_sigmask = alloca i64, align 8
  %is_null = icmp eq ptr %sigmask, null
  br i1 %is_null, label %fault, label %check_ptr

fault:
  ret i64 -14

check_ptr:
  %sigmask_addr = ptrtoint ptr %sigmask to i64
  %bad_ptr = icmp ult i64 %sigmask_addr, 4096
  br i1 %bad_ptr, label %fault, label %copy_mask

copy_mask:
  %target_mask = load i64, ptr %sigmask, align 8
  %native_mask = call i64 @__mtrt_linux_sigset_to_native(i64 %target_mask)
  %bad_mask = icmp slt i64 %native_mask, 0
  br i1 %bad_mask, label %invalid, label %call_sigsuspend

invalid:
  ret i64 -22

call_sigsuspend:
  store i64 %native_mask, ptr %native_sigmask, align 8
  %sigmask_i = ptrtoint ptr %native_sigmask to i64
  %r = call i64 @__mtrt_linux_syscall2(i64 133, i64 %sigmask_i, i64 8)
  ret i64 %r
}

define i64 @__mtrt_host_sigtimedwait(ptr %set, ptr %info, ptr %timeout) {
entry:
  %native_set = alloca i64, align 8
  %native_info = alloca [128 x i8], align 8
  %set_is_null = icmp eq ptr %set, null
  br i1 %set_is_null, label %fault, label %copy_set

fault:
  ret i64 -14

copy_set:
  %target_set = load i64, ptr %set, align 8
  %native_set_value = call i64 @__mtrt_linux_sigset_to_native(i64 %target_set)
  %bad_set = icmp slt i64 %native_set_value, 0
  br i1 %bad_set, label %invalid, label %prep_info

invalid:
  ret i64 -22

prep_info:
  store i64 %native_set_value, ptr %native_set, align 8
  %set_i = ptrtoint ptr %native_set to i64
  %info_is_null = icmp eq ptr %info, null
  br i1 %info_is_null, label %do_call, label %set_info

set_info:
  %native_info_i = ptrtoint ptr %native_info to i64
  br label %do_call

do_call:
  %info_i = phi i64 [ 0, %prep_info ], [ %native_info_i, %set_info ]
  %timeout_i = ptrtoint ptr %timeout to i64
  %r = call i64 @__mtrt_linux_syscall4(i64 137, i64 %set_i, i64 %info_i, i64 %timeout_i, i64 8)
  %delivered = icmp sgt i64 %r, 0
  br i1 %delivered, label %maybe_copy_info, label %done

maybe_copy_info:
  br i1 %info_is_null, label %return_signal, label %copy_info

copy_info:
  call void @__mtrt_linux_siginfo_to_target(ptr %info, ptr %native_info)
  br label %return_signal

return_signal:
  %target_sig = call i64 @__mtrt_linux_signal_from_native(i64 %r)
  ret i64 %target_sig

done:
  ret i64 %r
}

define i64 @__mtrt_host_sigwaitinfo(ptr %set, ptr %info) {
  %r = call i64 @__mtrt_host_sigtimedwait(ptr %set, ptr %info, ptr null)
  ret i64 %r
}

define i64 @__mtrt_host_times(ptr %buf) {
  %buf_i = ptrtoint ptr %buf to i64
  %r = call i64 @__mtrt_linux_syscall1(i64 153, i64 %buf_i)
  ret i64 %r
}

define i64 @__mtrt_host_utimes(ptr %path, ptr %times) {
entry:
  %path_i = ptrtoint ptr %path to i64
  %is_null = icmp eq ptr %times, null
  br i1 %is_null, label %call_null, label %convert

call_null:
  %r_null = call i64 @__mtrt_linux_syscall4(i64 88, i64 -100, i64 %path_i, i64 0, i64 0)
  ret i64 %r_null

convert:
  %atime_sec_p = getelementptr i8, ptr %times, i64 0
  %atime_usec_p = getelementptr i8, ptr %times, i64 8
  %mtime_sec_p = getelementptr i8, ptr %times, i64 16
  %mtime_usec_p = getelementptr i8, ptr %times, i64 24
  %atime_sec = load i64, ptr %atime_sec_p, align 8
  %atime_usec = load i64, ptr %atime_usec_p, align 8
  %mtime_sec = load i64, ptr %mtime_sec_p, align 8
  %mtime_usec = load i64, ptr %mtime_usec_p, align 8
  %atime_usec_neg = icmp slt i64 %atime_usec, 0
  %atime_usec_big = icmp sge i64 %atime_usec, 1000000
  %mtime_usec_neg = icmp slt i64 %mtime_usec, 0
  %mtime_usec_big = icmp sge i64 %mtime_usec, 1000000
  %atime_usec_bad = or i1 %atime_usec_neg, %atime_usec_big
  %mtime_usec_bad = or i1 %mtime_usec_neg, %mtime_usec_big
  %usec_bad = or i1 %atime_usec_bad, %mtime_usec_bad
  br i1 %usec_bad, label %invalid, label %store

invalid:
  ret i64 -22

store:
  %ts = alloca [4 x i64], align 8
  %atime_nsec = mul i64 %atime_usec, 1000
  %mtime_nsec = mul i64 %mtime_usec, 1000
  %ts_atime_sec_p = getelementptr inbounds [4 x i64], ptr %ts, i64 0, i64 0
  %ts_atime_nsec_p = getelementptr inbounds [4 x i64], ptr %ts, i64 0, i64 1
  %ts_mtime_sec_p = getelementptr inbounds [4 x i64], ptr %ts, i64 0, i64 2
  %ts_mtime_nsec_p = getelementptr inbounds [4 x i64], ptr %ts, i64 0, i64 3
  store i64 %atime_sec, ptr %ts_atime_sec_p, align 8
  store i64 %atime_nsec, ptr %ts_atime_nsec_p, align 8
  store i64 %mtime_sec, ptr %ts_mtime_sec_p, align 8
  store i64 %mtime_nsec, ptr %ts_mtime_nsec_p, align 8
  %ts_i = ptrtoint ptr %ts to i64
  %r = call i64 @__mtrt_linux_syscall4(i64 88, i64 -100, i64 %path_i, i64 %ts_i, i64 0)
  ret i64 %r
}
