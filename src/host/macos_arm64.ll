target triple = "arm64-apple-macosx13.0.0"

%struct.mtrt_stat64 = type { i64, i64, i64, i32, i32, i32, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64 }

@.mtrt_dot = private unnamed_addr constant [2 x i8] c".\00"
@__mtrt_platform_uname_sys = constant [7 x i8] c"Darwin\0A", align 1
@__mtrt_platform_uname_sys_len = constant i64 7, align 8
@__mtrt_platform_uname_all = constant [27 x i8] c"Darwin muffintop 0 0 arm64\0A", align 1
@__mtrt_platform_uname_all_len = constant i64 27, align 8

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

define internal i64 @__mtrt_darwin_syscall6(i64 %nr, i64 %a0, i64 %a1, i64 %a2, i64 %a3, i64 %a4, i64 %a5) {
entry:
  %r = call i64 asm sideeffect "mov x16, $7\0A svc #0x80\0A b.cc 1f\0A neg x0, x0\0A1:", "={x0},{x0},{x1},{x2},{x3},{x4},{x5},r,~{x16},~{memory},~{cc}"(i64 %a0, i64 %a1, i64 %a2, i64 %a3, i64 %a4, i64 %a5, i64 %nr)
  ret i64 %r
}

define internal i64 @__mtrt_darwin_clock_sleep_trap(i64 %clock, i64 %sleep_type, i64 %sec, i64 %nsec, ptr %rem) {
entry:
  %rem_i = ptrtoint ptr %rem to i64
  %r = call i64 asm sideeffect "mov x16, #-62\0A svc #0x80", "={x0},{x0},{x1},{x2},{x3},{x4},~{x16},~{memory},~{cc}"(i64 %clock, i64 %sleep_type, i64 %sec, i64 %nsec, i64 %rem_i)
  ret i64 %r
}

define internal i64 @__mtrt_darwin_abstime_trap() {
entry:
  %r = call i64 asm sideeffect "mov x16, #-3\0A svc #0x80", "={x0},~{x16},~{memory},~{cc}"()
  ret i64 %r
}

define internal i64 @__mtrt_darwin_continuous_time_trap() {
entry:
  %r = call i64 asm sideeffect "mov x16, #-4\0A svc #0x80", "={x0},~{x16},~{memory},~{cc}"()
  ret i64 %r
}

define internal i64 @__mtrt_darwin_timebase_info_trap(ptr %info) {
entry:
  %info_i = ptrtoint ptr %info to i64
  %r = call i64 asm sideeffect "mov x16, #-89\0A svc #0x80", "={x0},{x0},~{x16},~{memory},~{cc}"(i64 %info_i)
  ret i64 %r
}

define internal i64 @__mtrt_darwin_swtch_trap() {
entry:
  %r = call i64 asm sideeffect "mov x16, #-60\0A svc #0x80", "={x0},~{x16},~{memory},~{cc}"()
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

define internal i64 @__mtrt_strlen(ptr %s) {
entry:
  br label %loop

loop:
  %i = phi i64 [ 0, %entry ], [ %next, %cont ]
  %p = getelementptr i8, ptr %s, i64 %i
  %c = load i8, ptr %p, align 1
  %is_zero = icmp eq i8 %c, 0
  br i1 %is_zero, label %done, label %cont

cont:
  %next = add i64 %i, 1
  br label %loop

done:
  ret i64 %i
}

define internal void @__mtrt_copy_cstr(ptr %dst, ptr %src, i64 %len) {
entry:
  br label %loop

loop:
  %i = phi i64 [ 0, %entry ], [ %next, %copy ]
  %done = icmp ugt i64 %i, %len
  br i1 %done, label %ret, label %copy

copy:
  %sp = getelementptr i8, ptr %src, i64 %i
  %dp = getelementptr i8, ptr %dst, i64 %i
  %c = load i8, ptr %sp, align 1
  store i8 %c, ptr %dp, align 1
  %next = add i64 %i, 1
  br label %loop

ret:
  ret void
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

define internal i64 @__mtrt_darwin_translate_getdirentries64(ptr %buf, i64 %native_bytes) {
entry:
  br label %loop

loop:
  %src_off = phi i64 [ 0, %entry ], [ %src_next, %advance ]
  %dst_off = phi i64 [ 0, %entry ], [ %next_dst, %advance ]
  %more = icmp ult i64 %src_off, %native_bytes
  br i1 %more, label %record, label %done

record:
  %rec = getelementptr i8, ptr %buf, i64 %src_off
  %reclen_p = getelementptr i8, ptr %rec, i64 16
  %reclen16 = load i16, ptr %reclen_p, align 2
  %native_reclen = zext i16 %reclen16 to i64
  %src_next = add i64 %src_off, %native_reclen
  %reclen_min = icmp uge i64 %native_reclen, 22
  %reclen_nonzero = icmp ne i64 %native_reclen, 0
  %src_within = icmp ule i64 %src_next, %native_bytes
  %valid0 = and i1 %reclen_min, %reclen_nonzero
  %valid = and i1 %valid0, %src_within
  br i1 %valid, label %check_ino, label %bad

check_ino:
  %ino = load i64, ptr %rec, align 8
  %deleted = icmp eq i64 %ino, 0
  br i1 %deleted, label %skip, label %name

skip:
  br label %advance

name:
  %name_len_p = getelementptr i8, ptr %rec, i64 18
  %name_len16 = load i16, ptr %name_len_p, align 2
  %name_len = zext i16 %name_len16 to i64
  %dtype_p = getelementptr i8, ptr %rec, i64 20
  %native_dtype = load i8, ptr %dtype_p, align 1
  %dtype = call i8 @__mtrt_common_dtype(i8 %native_dtype)
  %name_p = getelementptr i8, ptr %rec, i64 21
  %name_limit = sub i64 %native_reclen, 21
  %name_with_nul = add i64 %name_len, 1
  %name_fits = icmp ule i64 %name_with_nul, %name_limit
  br i1 %name_fits, label %check_nul, label %bad

check_nul:
  %nul_p = getelementptr i8, ptr %name_p, i64 %name_len
  %nul = load i8, ptr %nul_p, align 1
  %has_nul = icmp eq i8 %nul, 0
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
  %next_dst = phi i64 [ %dst_off, %skip ], [ %dst_next, %write ]
  br label %loop

done:
  ret i64 %dst_off

bad:
  ret i64 -5
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

define internal i32 @__mtrt_darwin_mmap_flags_from_target(i32 %flags) {
entry:
  %anon_bits = and i32 %flags, 32
  %has_anon = icmp ne i32 %anon_bits, 0
  %without_anon = and i32 %flags, -33
  %anon_value = select i1 %has_anon, i32 4096, i32 0
  %mapped = or i32 %without_anon, %anon_value
  ret i32 %mapped
}

define internal i32 @__mtrt_darwin_msync_flags_from_target(i32 %flags) {
entry:
  %sync_bits = and i32 %flags, 4
  %has_sync = icmp ne i32 %sync_bits, 0
  %without_sync = and i32 %flags, -5
  %sync_value = select i1 %has_sync, i32 16, i32 0
  %mapped = or i32 %without_sync, %sync_value
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

define internal i32 @__mtrt_darwin_sigprocmask_how_from_target(i64 %how) {
entry:
  %how32 = trunc i64 %how to i32
  %is_block = icmp eq i32 %how32, 0
  br i1 %is_block, label %block, label %check_unblock

block:
  ret i32 1

check_unblock:
  %is_unblock = icmp eq i32 %how32, 1
  br i1 %is_unblock, label %unblock, label %check_setmask

unblock:
  ret i32 2

check_setmask:
  %is_setmask = icmp eq i32 %how32, 2
  br i1 %is_setmask, label %setmask, label %invalid

setmask:
  ret i32 3

invalid:
  ret i32 -1
}

define internal i64 @__mtrt_darwin_timeval_to_ticks(ptr %tv) {
entry:
  %sec_p = getelementptr i8, ptr %tv, i64 0
  %usec_p = getelementptr i8, ptr %tv, i64 8
  %sec = load i64, ptr %sec_p, align 8
  %usec32 = load i32, ptr %usec_p, align 4
  %usec = sext i32 %usec32 to i64
  %sec_ticks = mul i64 %sec, 100
  %usec_ticks = sdiv i64 %usec, 10000
  %ticks = add i64 %sec_ticks, %usec_ticks
  ret i64 %ticks
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

define i64 @__mtrt_host_getuid() {
entry:
  %r = call i64 @__mtrt_darwin_syscall0(i64 24)
  ret i64 %r
}

define i64 @__mtrt_host_geteuid() {
entry:
  %r = call i64 @__mtrt_darwin_syscall0(i64 25)
  ret i64 %r
}

define i64 @__mtrt_host_getgid() {
entry:
  %r = call i64 @__mtrt_darwin_syscall0(i64 47)
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
  br i1 %has_rem, label %compute_rem, label %intr_done

compute_rem:
  %now = alloca [8 x i8], align 4
  %now_r = call i64 @__mtrt_darwin_clock_sleep_trap(i64 0, i64 1, i64 0, i64 0, ptr %now)
  %now_ok = icmp eq i64 %now_r, 0
  br i1 %now_ok, label %load_rem, label %intr_done

load_rem:
  %deadline_sec_p = getelementptr i8, ptr %native_rem, i64 0
  %deadline_nsec_p = getelementptr i8, ptr %native_rem, i64 4
  %now_sec_p = getelementptr i8, ptr %now, i64 0
  %now_nsec_p = getelementptr i8, ptr %now, i64 4
  %deadline_sec32 = load i32, ptr %deadline_sec_p, align 4
  %deadline_nsec32 = load i32, ptr %deadline_nsec_p, align 4
  %now_sec32 = load i32, ptr %now_sec_p, align 4
  %now_nsec32 = load i32, ptr %now_nsec_p, align 4
  %deadline_sec = zext i32 %deadline_sec32 to i64
  %deadline_nsec = sext i32 %deadline_nsec32 to i64
  %now_sec = zext i32 %now_sec32 to i64
  %now_nsec = sext i32 %now_nsec32 to i64
  %sec_before = icmp ult i64 %deadline_sec, %now_sec
  br i1 %sec_before, label %store_zero_rem, label %check_same_sec

check_same_sec:
  %same_sec = icmp eq i64 %deadline_sec, %now_sec
  br i1 %same_sec, label %same_sec_rem, label %future_sec_rem

same_sec_rem:
  %nsec_left = sub i64 %deadline_nsec, %now_nsec
  %nsec_positive = icmp sgt i64 %nsec_left, 0
  br i1 %nsec_positive, label %store_same_sec_rem, label %store_zero_rem

store_same_sec_rem:
  br label %store_rem

future_sec_rem:
  %sec_diff = sub i64 %deadline_sec, %now_sec
  %nsec_order = icmp sge i64 %deadline_nsec, %now_nsec
  br i1 %nsec_order, label %store_future_direct, label %store_future_borrow

store_future_direct:
  %nsec_direct = sub i64 %deadline_nsec, %now_nsec
  br label %store_rem

store_future_borrow:
  %sec_borrow = sub i64 %sec_diff, 1
  %nsec_plus = add i64 %deadline_nsec, 1000000000
  %nsec_borrow = sub i64 %nsec_plus, %now_nsec
  br label %store_rem

store_zero_rem:
  br label %store_rem

store_rem:
  %rem_sec = phi i64 [ 0, %store_same_sec_rem ], [ %sec_diff, %store_future_direct ], [ %sec_borrow, %store_future_borrow ], [ 0, %store_zero_rem ]
  %rem_nsec = phi i64 [ %nsec_left, %store_same_sec_rem ], [ %nsec_direct, %store_future_direct ], [ %nsec_borrow, %store_future_borrow ], [ 0, %store_zero_rem ]
  %rem_sec_p = getelementptr i8, ptr %rem, i64 0
  %rem_nsec_p = getelementptr i8, ptr %rem, i64 8
  store i64 %rem_sec, ptr %rem_sec_p, align 8
  store i64 %rem_nsec, ptr %rem_nsec_p, align 8
  br label %intr_done

intr_done:
  ret i64 -4
}

define i64 @__mtrt_host_clock_gettime(i64 %clockid, ptr %tp) {
entry:
  switch i64 %clockid, label %invalid [
    i64 0, label %check_realtime_ptr
    i64 1, label %check_monotonic_ptr
  ]

invalid:
  ret i64 -22

check_realtime_ptr:
  %realtime_null = icmp eq ptr %tp, null
  br i1 %realtime_null, label %fault, label %call_realtime

check_monotonic_ptr:
  %monotonic_null = icmp eq ptr %tp, null
  br i1 %monotonic_null, label %fault, label %call_monotonic

fault:
  ret i64 -14

call_realtime:
  %tv = alloca [16 x i8], align 8
  %tv_i = ptrtoint ptr %tv to i64
  %r = call i64 @__mtrt_darwin_syscall3(i64 116, i64 %tv_i, i64 0, i64 0)
  %realtime_ok = icmp eq i64 %r, 0
  br i1 %realtime_ok, label %store_realtime, label %done

store_realtime:
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

call_monotonic:
  %timebase = alloca [8 x i8], align 4
  %timebase_r = call i64 @__mtrt_darwin_timebase_info_trap(ptr %timebase)
  %timebase_ok = icmp eq i64 %timebase_r, 0
  br i1 %timebase_ok, label %load_timebase, label %bad_timebase

bad_timebase:
  ret i64 -22

load_timebase:
  %numer_p = getelementptr i8, ptr %timebase, i64 0
  %denom_p = getelementptr i8, ptr %timebase, i64 4
  %numer32 = load i32, ptr %numer_p, align 4
  %denom32 = load i32, ptr %denom_p, align 4
  %numer_zero = icmp eq i32 %numer32, 0
  %denom_zero = icmp eq i32 %denom32, 0
  %bad_factor = or i1 %numer_zero, %denom_zero
  br i1 %bad_factor, label %bad_timebase, label %store_monotonic

store_monotonic:
  %ticks = call i64 @__mtrt_darwin_continuous_time_trap()
  %numer = zext i32 %numer32 to i64
  %denom = zext i32 %denom32 to i64
  %ticks_q = udiv i64 %ticks, %denom
  %ticks_r = urem i64 %ticks, %denom
  %ns_q = mul i64 %ticks_q, %numer
  %ns_r_mul = mul i64 %ticks_r, %numer
  %ns_r = udiv i64 %ns_r_mul, %denom
  %ns = add i64 %ns_q, %ns_r
  %mono_sec = udiv i64 %ns, 1000000000
  %mono_nsec = urem i64 %ns, 1000000000
  %mono_sec_p = getelementptr i8, ptr %tp, i64 0
  %mono_nsec_p = getelementptr i8, ptr %tp, i64 8
  store i64 %mono_sec, ptr %mono_sec_p, align 8
  store i64 %mono_nsec, ptr %mono_nsec_p, align 8
  ret i64 0
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

define i64 @__mtrt_host_posix_getdents(i64 %fd, ptr %buf, i64 %nbyte, i64 %flags) {
entry:
  %flags_ok = icmp eq i64 %flags, 0
  br i1 %flags_ok, label %check_size, label %invalid

check_size:
  %size_ok = icmp uge i64 %nbyte, 24
  br i1 %size_ok, label %call_getdirentries, label %invalid

call_getdirentries:
  %basep = alloca i64, align 8
  store i64 0, ptr %basep, align 8
  %buf_i = ptrtoint ptr %buf to i64
  %basep_i = ptrtoint ptr %basep to i64
  %r = call i64 @__mtrt_darwin_syscall4(i64 344, i64 %fd, i64 %buf_i, i64 %nbyte, i64 %basep_i)
  %has_entries = icmp sgt i64 %r, 0
  br i1 %has_entries, label %translate, label %done

translate:
  %translated = call i64 @__mtrt_darwin_translate_getdirentries64(ptr %buf, i64 %r)
  ret i64 %translated

done:
  ret i64 %r

invalid:
  ret i64 -22
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

define i64 @__mtrt_host_mkfifo(ptr %path, i64 %mode) {
entry:
  %path_i = ptrtoint ptr %path to i64
  %mode_masked = and i64 %mode, 511
  %r = call i64 @__mtrt_darwin_syscall2(i64 132, i64 %path_i, i64 %mode_masked)
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

define i64 @__mtrt_host_ftruncate(i64 %fd, i64 %length) {
entry:
  %r = call i64 @__mtrt_darwin_syscall2(i64 201, i64 %fd, i64 %length)
  ret i64 %r
}

define i64 @__mtrt_host_chown(ptr %path, i64 %uid, i64 %gid) {
entry:
  %path_i = ptrtoint ptr %path to i64
  %r = call i64 @__mtrt_darwin_syscall3(i64 16, i64 %path_i, i64 %uid, i64 %gid)
  ret i64 %r
}

define internal i64 @__mtrt_darwin_ioctl_ptr(i64 %fd, i64 %request, ptr %arg) {
entry:
  %arg_i = ptrtoint ptr %arg to i64
  %r = call i64 @__mtrt_darwin_syscall3(i64 54, i64 %fd, i64 %request, i64 %arg_i)
  ret i64 %r
}

define internal i64 @__mtrt_darwin_ioctl_int(i64 %fd, i64 %request, i64 %arg) {
entry:
  %r = call i64 @__mtrt_darwin_syscall3(i64 54, i64 %fd, i64 %request, i64 %arg)
  ret i64 %r
}

define internal i32 @__mtrt_darwin_speed_to_native(i32 %speed) {
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
  ret i32 -1
}

define internal i32 @__mtrt_darwin_native_speed_to_target(i32 %native) {
entry:
  switch i32 %native, label %bad [
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

define internal i64 @__mtrt_darwin_iflag_to_target(i64 %native) {
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
  %n9 = and i64 %native, 512
  %has9 = icmp ne i64 %n9, 0
  %v9 = select i1 %has9, i64 512, i64 0
  %acc9 = or i64 %acc8, %v9
  %n10 = and i64 %native, 1024
  %has10 = icmp ne i64 %n10, 0
  %v10 = select i1 %has10, i64 1024, i64 0
  %acc10 = or i64 %acc9, %v10
  %n11 = and i64 %native, 2048
  %has11 = icmp ne i64 %n11, 0
  %v11 = select i1 %has11, i64 2048, i64 0
  %acc11 = or i64 %acc10, %v11
  ret i64 %acc11
}

define internal i64 @__mtrt_darwin_iflag_to_native(i64 %target) {
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
  %v9 = select i1 %has9, i64 512, i64 0
  %acc9 = or i64 %acc8, %v9
  %t10 = and i64 %target, 1024
  %has10 = icmp ne i64 %t10, 0
  %v10 = select i1 %has10, i64 1024, i64 0
  %acc10 = or i64 %acc9, %v10
  %t11 = and i64 %target, 2048
  %has11 = icmp ne i64 %t11, 0
  %v11 = select i1 %has11, i64 2048, i64 0
  %acc11 = or i64 %acc10, %v11
  ret i64 %acc11
}

define internal i64 @__mtrt_darwin_oflag_to_target(i64 %native) {
entry:
  %n0 = and i64 %native, 1
  %has0 = icmp ne i64 %n0, 0
  %v0 = select i1 %has0, i64 1, i64 0
  %acc0 = or i64 0, %v0
  %n1 = and i64 %native, 2
  %has1 = icmp ne i64 %n1, 0
  %v1 = select i1 %has1, i64 2, i64 0
  %acc1 = or i64 %acc0, %v1
  %n2 = and i64 %native, 16
  %has2 = icmp ne i64 %n2, 0
  %v2 = select i1 %has2, i64 4, i64 0
  %acc2 = or i64 %acc1, %v2
  %n3 = and i64 %native, 32
  %has3 = icmp ne i64 %n3, 0
  %v3 = select i1 %has3, i64 8, i64 0
  %acc3 = or i64 %acc2, %v3
  %n4 = and i64 %native, 64
  %has4 = icmp ne i64 %n4, 0
  %v4 = select i1 %has4, i64 16, i64 0
  %acc4 = or i64 %acc3, %v4
  %n5 = and i64 %native, 128
  %has5 = icmp ne i64 %n5, 0
  %v5 = select i1 %has5, i64 32, i64 0
  %acc5 = or i64 %acc4, %v5
  ret i64 %acc5
}

define internal i64 @__mtrt_darwin_oflag_to_native(i64 %target) {
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
  %v2 = select i1 %has2, i64 16, i64 0
  %acc2 = or i64 %acc1, %v2
  %t3 = and i64 %target, 8
  %has3 = icmp ne i64 %t3, 0
  %v3 = select i1 %has3, i64 32, i64 0
  %acc3 = or i64 %acc2, %v3
  %t4 = and i64 %target, 16
  %has4 = icmp ne i64 %t4, 0
  %v4 = select i1 %has4, i64 64, i64 0
  %acc4 = or i64 %acc3, %v4
  %t5 = and i64 %target, 32
  %has5 = icmp ne i64 %t5, 0
  %v5 = select i1 %has5, i64 128, i64 0
  %acc5 = or i64 %acc4, %v5
  ret i64 %acc5
}

define internal i64 @__mtrt_darwin_cflag_to_target(i64 %native) {
entry:
  %size = and i64 %native, 768
  %is_cs6 = icmp eq i64 %size, 256
  %cs6 = select i1 %is_cs6, i64 1, i64 0
  %is_cs7 = icmp eq i64 %size, 512
  %cs7 = select i1 %is_cs7, i64 2, i64 0
  %is_cs8 = icmp eq i64 %size, 768
  %cs8 = select i1 %is_cs8, i64 3, i64 0
  %cs67 = or i64 %cs6, %cs7
  %cs = or i64 %cs67, %cs8
  %stop_n = and i64 %native, 1024
  %stop_has = icmp ne i64 %stop_n, 0
  %stop = select i1 %stop_has, i64 4, i64 0
  %read_n = and i64 %native, 2048
  %read_has = icmp ne i64 %read_n, 0
  %read = select i1 %read_has, i64 8, i64 0
  %parenb_n = and i64 %native, 4096
  %parenb_has = icmp ne i64 %parenb_n, 0
  %parenb = select i1 %parenb_has, i64 16, i64 0
  %parodd_n = and i64 %native, 8192
  %parodd_has = icmp ne i64 %parodd_n, 0
  %parodd = select i1 %parodd_has, i64 32, i64 0
  %hup_n = and i64 %native, 16384
  %hup_has = icmp ne i64 %hup_n, 0
  %hup = select i1 %hup_has, i64 64, i64 0
  %local_n = and i64 %native, 32768
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

define internal i64 @__mtrt_darwin_cflag_to_native(i64 %target) {
entry:
  %size = and i64 %target, 3
  %is_cs6 = icmp eq i64 %size, 1
  %cs6 = select i1 %is_cs6, i64 256, i64 0
  %is_cs7 = icmp eq i64 %size, 2
  %cs7 = select i1 %is_cs7, i64 512, i64 0
  %is_cs8 = icmp eq i64 %size, 3
  %cs8 = select i1 %is_cs8, i64 768, i64 0
  %cs67 = or i64 %cs6, %cs7
  %cs = or i64 %cs67, %cs8
  %stop_t = and i64 %target, 4
  %stop_has = icmp ne i64 %stop_t, 0
  %stop = select i1 %stop_has, i64 1024, i64 0
  %read_t = and i64 %target, 8
  %read_has = icmp ne i64 %read_t, 0
  %read = select i1 %read_has, i64 2048, i64 0
  %parenb_t = and i64 %target, 16
  %parenb_has = icmp ne i64 %parenb_t, 0
  %parenb = select i1 %parenb_has, i64 4096, i64 0
  %parodd_t = and i64 %target, 32
  %parodd_has = icmp ne i64 %parodd_t, 0
  %parodd = select i1 %parodd_has, i64 8192, i64 0
  %hup_t = and i64 %target, 64
  %hup_has = icmp ne i64 %hup_t, 0
  %hup = select i1 %hup_has, i64 16384, i64 0
  %local_t = and i64 %target, 128
  %local_has = icmp ne i64 %local_t, 0
  %local = select i1 %local_has, i64 32768, i64 0
  %a = or i64 %cs, %stop
  %b = or i64 %a, %read
  %c = or i64 %b, %parenb
  %d = or i64 %c, %parodd
  %e = or i64 %d, %hup
  %f = or i64 %e, %local
  ret i64 %f
}

define internal i64 @__mtrt_darwin_lflag_to_target(i64 %native) {
entry:
  %n0 = and i64 %native, 8
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
  %n3 = and i64 %native, 16
  %has3 = icmp ne i64 %n3, 0
  %v3 = select i1 %has3, i64 8, i64 0
  %acc3 = or i64 %acc2, %v3
  %n4 = and i64 %native, 256
  %has4 = icmp ne i64 %n4, 0
  %v4 = select i1 %has4, i64 16, i64 0
  %acc4 = or i64 %acc3, %v4
  %n5 = and i64 %native, 1024
  %has5 = icmp ne i64 %n5, 0
  %v5 = select i1 %has5, i64 32, i64 0
  %acc5 = or i64 %acc4, %v5
  %n6 = and i64 %native, 128
  %has6 = icmp ne i64 %n6, 0
  %v6 = select i1 %has6, i64 64, i64 0
  %acc6 = or i64 %acc5, %v6
  %n7 = and i64 %native, 2147483648
  %has7 = icmp ne i64 %n7, 0
  %v7 = select i1 %has7, i64 128, i64 0
  %acc7 = or i64 %acc6, %v7
  %n8 = and i64 %native, 4194304
  %has8 = icmp ne i64 %n8, 0
  %v8 = select i1 %has8, i64 256, i64 0
  %acc8 = or i64 %acc7, %v8
  ret i64 %acc8
}

define internal i64 @__mtrt_darwin_lflag_to_native(i64 %target) {
entry:
  %t0 = and i64 %target, 1
  %has0 = icmp ne i64 %t0, 0
  %v0 = select i1 %has0, i64 8, i64 0
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
  %v3 = select i1 %has3, i64 16, i64 0
  %acc3 = or i64 %acc2, %v3
  %t4 = and i64 %target, 16
  %has4 = icmp ne i64 %t4, 0
  %v4 = select i1 %has4, i64 256, i64 0
  %acc4 = or i64 %acc3, %v4
  %t5 = and i64 %target, 32
  %has5 = icmp ne i64 %t5, 0
  %v5 = select i1 %has5, i64 1024, i64 0
  %acc5 = or i64 %acc4, %v5
  %t6 = and i64 %target, 64
  %has6 = icmp ne i64 %t6, 0
  %v6 = select i1 %has6, i64 128, i64 0
  %acc6 = or i64 %acc5, %v6
  %t7 = and i64 %target, 128
  %has7 = icmp ne i64 %t7, 0
  %v7 = select i1 %has7, i64 2147483648, i64 0
  %acc7 = or i64 %acc6, %v7
  %t8 = and i64 %target, 256
  %has8 = icmp ne i64 %t8, 0
  %v8 = select i1 %has8, i64 4194304, i64 0
  %acc8 = or i64 %acc7, %v8
  ret i64 %acc8
}

define internal void @__mtrt_darwin_zero_target_cc(ptr %target) {
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

define internal void @__mtrt_darwin_copy_native_cc_to_target(ptr %target, ptr %native) {
entry:
  call void @__mtrt_darwin_zero_target_cc(ptr %target)
  %src0 = getelementptr i8, ptr %native, i64 40
  %v0 = load i8, ptr %src0, align 1
  %dst0 = getelementptr i8, ptr %target, i64 40
  store i8 %v0, ptr %dst0, align 1
  %src1 = getelementptr i8, ptr %native, i64 41
  %v1 = load i8, ptr %src1, align 1
  %dst1 = getelementptr i8, ptr %target, i64 41
  store i8 %v1, ptr %dst1, align 1
  %src2 = getelementptr i8, ptr %native, i64 35
  %v2 = load i8, ptr %src2, align 1
  %dst2 = getelementptr i8, ptr %target, i64 42
  store i8 %v2, ptr %dst2, align 1
  %src3 = getelementptr i8, ptr %native, i64 37
  %v3 = load i8, ptr %src3, align 1
  %dst3 = getelementptr i8, ptr %target, i64 43
  store i8 %v3, ptr %dst3, align 1
  %src4 = getelementptr i8, ptr %native, i64 32
  %v4 = load i8, ptr %src4, align 1
  %dst4 = getelementptr i8, ptr %target, i64 44
  store i8 %v4, ptr %dst4, align 1
  %src5 = getelementptr i8, ptr %native, i64 49
  %v5 = load i8, ptr %src5, align 1
  %dst5 = getelementptr i8, ptr %target, i64 45
  store i8 %v5, ptr %dst5, align 1
  %src6 = getelementptr i8, ptr %native, i64 48
  %v6 = load i8, ptr %src6, align 1
  %dst6 = getelementptr i8, ptr %target, i64 46
  store i8 %v6, ptr %dst6, align 1
  %src7 = getelementptr i8, ptr %native, i64 44
  %v7 = load i8, ptr %src7, align 1
  %dst7 = getelementptr i8, ptr %target, i64 48
  store i8 %v7, ptr %dst7, align 1
  %src8 = getelementptr i8, ptr %native, i64 45
  %v8 = load i8, ptr %src8, align 1
  %dst8 = getelementptr i8, ptr %target, i64 49
  store i8 %v8, ptr %dst8, align 1
  %src9 = getelementptr i8, ptr %native, i64 42
  %v9 = load i8, ptr %src9, align 1
  %dst9 = getelementptr i8, ptr %target, i64 50
  store i8 %v9, ptr %dst9, align 1
  %src10 = getelementptr i8, ptr %native, i64 33
  %v10 = load i8, ptr %src10, align 1
  %dst10 = getelementptr i8, ptr %target, i64 51
  store i8 %v10, ptr %dst10, align 1
  %src11 = getelementptr i8, ptr %native, i64 34
  %v11 = load i8, ptr %src11, align 1
  %dst11 = getelementptr i8, ptr %target, i64 56
  store i8 %v11, ptr %dst11, align 1
  ret void
}

define internal void @__mtrt_darwin_copy_target_cc_to_native(ptr %native, ptr %target) {
entry:
  %src0 = getelementptr i8, ptr %target, i64 40
  %v0 = load i8, ptr %src0, align 1
  %dst0 = getelementptr i8, ptr %native, i64 40
  store i8 %v0, ptr %dst0, align 1
  %src1 = getelementptr i8, ptr %target, i64 41
  %v1 = load i8, ptr %src1, align 1
  %dst1 = getelementptr i8, ptr %native, i64 41
  store i8 %v1, ptr %dst1, align 1
  %src2 = getelementptr i8, ptr %target, i64 42
  %v2 = load i8, ptr %src2, align 1
  %dst2 = getelementptr i8, ptr %native, i64 35
  store i8 %v2, ptr %dst2, align 1
  %src3 = getelementptr i8, ptr %target, i64 43
  %v3 = load i8, ptr %src3, align 1
  %dst3 = getelementptr i8, ptr %native, i64 37
  store i8 %v3, ptr %dst3, align 1
  %src4 = getelementptr i8, ptr %target, i64 44
  %v4 = load i8, ptr %src4, align 1
  %dst4 = getelementptr i8, ptr %native, i64 32
  store i8 %v4, ptr %dst4, align 1
  %src5 = getelementptr i8, ptr %target, i64 45
  %v5 = load i8, ptr %src5, align 1
  %dst5 = getelementptr i8, ptr %native, i64 49
  store i8 %v5, ptr %dst5, align 1
  %src6 = getelementptr i8, ptr %target, i64 46
  %v6 = load i8, ptr %src6, align 1
  %dst6 = getelementptr i8, ptr %native, i64 48
  store i8 %v6, ptr %dst6, align 1
  %src7 = getelementptr i8, ptr %target, i64 48
  %v7 = load i8, ptr %src7, align 1
  %dst7 = getelementptr i8, ptr %native, i64 44
  store i8 %v7, ptr %dst7, align 1
  %src8 = getelementptr i8, ptr %target, i64 49
  %v8 = load i8, ptr %src8, align 1
  %dst8 = getelementptr i8, ptr %native, i64 45
  store i8 %v8, ptr %dst8, align 1
  %src9 = getelementptr i8, ptr %target, i64 50
  %v9 = load i8, ptr %src9, align 1
  %dst9 = getelementptr i8, ptr %native, i64 42
  store i8 %v9, ptr %dst9, align 1
  %src10 = getelementptr i8, ptr %target, i64 51
  %v10 = load i8, ptr %src10, align 1
  %dst10 = getelementptr i8, ptr %native, i64 33
  store i8 %v10, ptr %dst10, align 1
  %src11 = getelementptr i8, ptr %target, i64 56
  %v11 = load i8, ptr %src11, align 1
  %dst11 = getelementptr i8, ptr %native, i64 34
  store i8 %v11, ptr %dst11, align 1
  ret void
}

define internal i1 @__mtrt_darwin_termios_target_valid(ptr %target) {
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
  %inative = call i32 @__mtrt_darwin_speed_to_native(i32 %ispeed)
  %ibad = icmp eq i32 %inative, -1
  br i1 %ibad, label %bad, label %ospeed_check

ospeed_check:
  %ospeed_p = getelementptr i8, ptr %target, i64 36
  %ospeed = load i32, ptr %ospeed_p, align 4
  %onative = call i32 @__mtrt_darwin_speed_to_native(i32 %ospeed)
  %obad = icmp eq i32 %onative, -1
  br i1 %obad, label %bad, label %ok

ok:
  ret i1 true

bad:
  ret i1 false
}

define internal void @__mtrt_darwin_store_target_termios(ptr %target, ptr %native) {
entry:
  %if64 = load i64, ptr %native, align 8
  %if_target = call i64 @__mtrt_darwin_iflag_to_target(i64 %if64)
  store i64 %if_target, ptr %target, align 8
  %ofp = getelementptr i8, ptr %native, i64 8
  %of64 = load i64, ptr %ofp, align 8
  %of_target = call i64 @__mtrt_darwin_oflag_to_target(i64 %of64)
  %of_target_p = getelementptr i8, ptr %target, i64 8
  store i64 %of_target, ptr %of_target_p, align 8
  %cfp = getelementptr i8, ptr %native, i64 16
  %cf64 = load i64, ptr %cfp, align 8
  %cf_target = call i64 @__mtrt_darwin_cflag_to_target(i64 %cf64)
  %cf_target_p = getelementptr i8, ptr %target, i64 16
  store i64 %cf_target, ptr %cf_target_p, align 8
  %lfp = getelementptr i8, ptr %native, i64 24
  %lf64 = load i64, ptr %lfp, align 8
  %lf_target = call i64 @__mtrt_darwin_lflag_to_target(i64 %lf64)
  %lf_target_p = getelementptr i8, ptr %target, i64 24
  store i64 %lf_target, ptr %lf_target_p, align 8
  %is_native_p = getelementptr i8, ptr %native, i64 56
  %is_native64 = load i64, ptr %is_native_p, align 8
  %is_native = trunc i64 %is_native64 to i32
  %is_target = call i32 @__mtrt_darwin_native_speed_to_target(i32 %is_native)
  %is_target_p = getelementptr i8, ptr %target, i64 32
  store i32 %is_target, ptr %is_target_p, align 4
  %os_native_p = getelementptr i8, ptr %native, i64 64
  %os_native64 = load i64, ptr %os_native_p, align 8
  %os_native = trunc i64 %os_native64 to i32
  %os_target = call i32 @__mtrt_darwin_native_speed_to_target(i32 %os_native)
  %os_target_p = getelementptr i8, ptr %target, i64 36
  store i32 %os_target, ptr %os_target_p, align 4
  call void @__mtrt_darwin_copy_native_cc_to_target(ptr %target, ptr %native)
  ret void
}

define internal void @__mtrt_darwin_overlay_native_termios(ptr %native, ptr %target) {
entry:
  %iflag = load i64, ptr %target, align 8
  %if_native = call i64 @__mtrt_darwin_iflag_to_native(i64 %iflag)
  %if_old = load i64, ptr %native, align 8
  %if_preserved = and i64 %if_old, -4096
  %if_new = or i64 %if_preserved, %if_native
  store i64 %if_new, ptr %native, align 8
  %of_target_p = getelementptr i8, ptr %target, i64 8
  %oflag = load i64, ptr %of_target_p, align 8
  %of_native = call i64 @__mtrt_darwin_oflag_to_native(i64 %oflag)
  %of_native_p = getelementptr i8, ptr %native, i64 8
  %of_old = load i64, ptr %of_native_p, align 8
  %of_preserved = and i64 %of_old, -244
  %of_new = or i64 %of_preserved, %of_native
  store i64 %of_new, ptr %of_native_p, align 8
  %cf_target_p = getelementptr i8, ptr %target, i64 16
  %cflag = load i64, ptr %cf_target_p, align 8
  %cf_native = call i64 @__mtrt_darwin_cflag_to_native(i64 %cflag)
  %cf_native_p = getelementptr i8, ptr %native, i64 16
  %cf_old = load i64, ptr %cf_native_p, align 8
  %cf_preserved = and i64 %cf_old, -65281
  %cf_new = or i64 %cf_preserved, %cf_native
  store i64 %cf_new, ptr %cf_native_p, align 8
  %lf_target_p = getelementptr i8, ptr %target, i64 24
  %lflag = load i64, ptr %lf_target_p, align 8
  %lf_native = call i64 @__mtrt_darwin_lflag_to_native(i64 %lflag)
  %lf_native_p = getelementptr i8, ptr %native, i64 24
  %lf_old = load i64, ptr %lf_native_p, align 8
  %lf_preserved = and i64 %lf_old, -2151675295
  %lf_new = or i64 %lf_preserved, %lf_native
  store i64 %lf_new, ptr %lf_native_p, align 8
  %ispeed_p = getelementptr i8, ptr %target, i64 32
  %ispeed = load i32, ptr %ispeed_p, align 4
  %is_native32 = call i32 @__mtrt_darwin_speed_to_native(i32 %ispeed)
  %is_native = zext i32 %is_native32 to i64
  %is_native_p = getelementptr i8, ptr %native, i64 56
  store i64 %is_native, ptr %is_native_p, align 8
  %ospeed_p = getelementptr i8, ptr %target, i64 36
  %ospeed = load i32, ptr %ospeed_p, align 4
  %os_native32 = call i32 @__mtrt_darwin_speed_to_native(i32 %ospeed)
  %os_native = zext i32 %os_native32 to i64
  %os_native_p = getelementptr i8, ptr %native, i64 64
  store i64 %os_native, ptr %os_native_p, align 8
  call void @__mtrt_darwin_copy_target_cc_to_native(ptr %native, ptr %target)
  ret void
}

define internal i64 @__mtrt_darwin_tcsetattr_request(i64 %action) {
entry:
  switch i64 %action, label %bad [
    i64 0, label %now
    i64 1, label %drain
    i64 2, label %flush
  ]

now:
  ret i64 2152231956

drain:
  ret i64 2152231957

flush:
  ret i64 2152231958

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
  %native = alloca [72 x i8], align 8
  %r = call i64 @__mtrt_darwin_ioctl_ptr(i64 %fd, i64 1078490131, ptr %native)
  %ok = icmp eq i64 %r, 0
  br i1 %ok, label %store, label %done

store:
  call void @__mtrt_darwin_store_target_termios(ptr %termios, ptr %native)
  ret i64 0

done:
  ret i64 %r
}

define i64 @__mtrt_host_isatty(i64 %fd) {
entry:
  %native = alloca [72 x i8], align 8
  %r = call i64 @__mtrt_darwin_ioctl_ptr(i64 %fd, i64 1078490131, ptr %native)
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
  %request = call i64 @__mtrt_darwin_tcsetattr_request(i64 %action)
  %bad_action = icmp eq i64 %request, -1
  br i1 %bad_action, label %invalid, label %validate

invalid:
  ret i64 -22

validate:
  %valid = call i1 @__mtrt_darwin_termios_target_valid(ptr %termios)
  br i1 %valid, label %read_native, label %invalid

read_native:
  %native = alloca [72 x i8], align 8
  %get = call i64 @__mtrt_darwin_ioctl_ptr(i64 %fd, i64 1078490131, ptr %native)
  %get_ok = icmp eq i64 %get, 0
  br i1 %get_ok, label %overlay, label %done

overlay:
  call void @__mtrt_darwin_overlay_native_termios(ptr %native, ptr %termios)
  %set = call i64 @__mtrt_darwin_ioctl_ptr(i64 %fd, i64 %request, ptr %native)
  ret i64 %set

done:
  ret i64 %get
}

define i64 @__mtrt_host_tcdrain(i64 %fd) {
entry:
  %r = call i64 @__mtrt_darwin_ioctl_int(i64 %fd, i64 536900702, i64 0)
  ret i64 %r
}

define internal i64 @__mtrt_darwin_tcflow_request(i64 %action) {
entry:
  switch i64 %action, label %bad [
    i64 0, label %off
    i64 1, label %on
    i64 2, label %ioff
    i64 3, label %ion
  ]

off:
  ret i64 536900719

on:
  ret i64 536900718

ioff:
  ret i64 536900736

ion:
  ret i64 536900737

bad:
  ret i64 -1
}

define i64 @__mtrt_host_tcflow(i64 %fd, i64 %action) {
entry:
  %request = call i64 @__mtrt_darwin_tcflow_request(i64 %action)
  %bad = icmp eq i64 %request, -1
  br i1 %bad, label %invalid, label %call_ioctl

invalid:
  ret i64 -22

call_ioctl:
  %r = call i64 @__mtrt_darwin_ioctl_int(i64 %fd, i64 %request, i64 0)
  ret i64 %r
}

define internal i64 @__mtrt_darwin_tcflush_selector(i64 %selector) {
entry:
  switch i64 %selector, label %bad [
    i64 0, label %in
    i64 1, label %out
    i64 2, label %both
  ]

in:
  ret i64 1

out:
  ret i64 2

both:
  ret i64 3

bad:
  ret i64 -1
}

define i64 @__mtrt_host_tcflush(i64 %fd, i64 %selector) {
entry:
  %native = call i64 @__mtrt_darwin_tcflush_selector(i64 %selector)
  %bad = icmp eq i64 %native, -1
  br i1 %bad, label %invalid, label %call_ioctl

invalid:
  ret i64 -22

call_ioctl:
  %slot = alloca i32, align 4
  %native32 = trunc i64 %native to i32
  store i32 %native32, ptr %slot, align 4
  %r = call i64 @__mtrt_darwin_ioctl_ptr(i64 %fd, i64 2147775504, ptr %slot)
  ret i64 %r
}

define i64 @__mtrt_host_tcsendbreak(i64 %fd, i64 %duration) {
entry:
  %set = call i64 @__mtrt_darwin_ioctl_int(i64 %fd, i64 536900731, i64 0)
  %ok = icmp eq i64 %set, 0
  br i1 %ok, label %clear, label %done

clear:
  %clear_r = call i64 @__mtrt_darwin_ioctl_int(i64 %fd, i64 536900730, i64 0)
  ret i64 %clear_r

done:
  ret i64 %set
}

define i64 @__mtrt_host_tcgetpgrp(i64 %fd) {
entry:
  %pgrp = alloca i32, align 4
  %r = call i64 @__mtrt_darwin_ioctl_ptr(i64 %fd, i64 1074033783, ptr %pgrp)
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
  %r = call i64 @__mtrt_darwin_ioctl_ptr(i64 %fd, i64 2147775606, ptr %slot)
  ret i64 %r
}

define i64 @__mtrt_host_clock_getres(i64 %clockid, ptr %tp) {
entry:
  switch i64 %clockid, label %invalid [
    i64 0, label %realtime
    i64 1, label %monotonic
  ]

invalid:
  ret i64 -22

realtime:
  %realtime_null = icmp eq ptr %tp, null
  br i1 %realtime_null, label %done, label %store_realtime

store_realtime:
  %realtime_sec_p = getelementptr i8, ptr %tp, i64 0
  %realtime_nsec_p = getelementptr i8, ptr %tp, i64 8
  store i64 0, ptr %realtime_sec_p, align 8
  store i64 1000, ptr %realtime_nsec_p, align 8
  ret i64 0

monotonic:
  %monotonic_null = icmp eq ptr %tp, null
  br i1 %monotonic_null, label %done, label %load_monotonic_res

load_monotonic_res:
  %timebase = alloca [8 x i8], align 4
  %timebase_r = call i64 @__mtrt_darwin_timebase_info_trap(ptr %timebase)
  %timebase_ok = icmp eq i64 %timebase_r, 0
  br i1 %timebase_ok, label %compute_monotonic_res, label %bad_timebase

bad_timebase:
  ret i64 -22

compute_monotonic_res:
  %numer_p = getelementptr i8, ptr %timebase, i64 0
  %denom_p = getelementptr i8, ptr %timebase, i64 4
  %numer32 = load i32, ptr %numer_p, align 4
  %denom32 = load i32, ptr %denom_p, align 4
  %numer_zero = icmp eq i32 %numer32, 0
  %denom_zero = icmp eq i32 %denom32, 0
  %bad_factor = or i1 %numer_zero, %denom_zero
  br i1 %bad_factor, label %bad_timebase, label %store_monotonic_res

store_monotonic_res:
  %numer = zext i32 %numer32 to i64
  %denom = zext i32 %denom32 to i64
  %denom_minus_one = sub i64 %denom, 1
  %ceil_numer = add i64 %numer, %denom_minus_one
  %res_ns = udiv i64 %ceil_numer, %denom
  %res_sec = udiv i64 %res_ns, 1000000000
  %res_nsec = urem i64 %res_ns, 1000000000
  %monotonic_sec_p = getelementptr i8, ptr %tp, i64 0
  %monotonic_nsec_p = getelementptr i8, ptr %tp, i64 8
  store i64 %res_sec, ptr %monotonic_sec_p, align 8
  store i64 %res_nsec, ptr %monotonic_nsec_p, align 8
  ret i64 0

done:
  ret i64 0
}

define i64 @__mtrt_host_clock_settime(i64 %clockid, ptr %tp) {
entry:
  ret i64 -38
}

define i64 @__mtrt_host_execve(ptr %path, ptr %argv, ptr %envp) {
entry:
  %path_i = ptrtoint ptr %path to i64
  %argv_i = ptrtoint ptr %argv to i64
  %envp_i = ptrtoint ptr %envp to i64
  %r = call i64 @__mtrt_darwin_syscall3(i64 59, i64 %path_i, i64 %argv_i, i64 %envp_i)
  ret i64 %r
}

define i64 @__mtrt_host_fchown(i64 %fd, i64 %uid, i64 %gid) {
entry:
  %r = call i64 @__mtrt_darwin_syscall3(i64 123, i64 %fd, i64 %uid, i64 %gid)
  ret i64 %r
}

define i64 @__mtrt_host_fchownat(i64 %dirfd, ptr %path, i64 %uid, i64 %gid, i64 %flags) {
entry:
  %dirfd32 = call i32 @__mtrt_darwin_dirfd_from_target(i64 %dirfd)
  %flags_ok = call i1 @__mtrt_darwin_at_flags_supported(i64 %flags)
  br i1 %flags_ok, label %call_fchownat, label %invalid

invalid:
  ret i64 -22

call_fchownat:
  %flags32 = call i32 @__mtrt_darwin_at_flags_from_target(i64 %flags)
  %dirfd64 = sext i32 %dirfd32 to i64
  %path_i = ptrtoint ptr %path to i64
  %flags64 = sext i32 %flags32 to i64
  %r = call i64 @__mtrt_darwin_syscall5(i64 468, i64 %dirfd64, i64 %path_i, i64 %uid, i64 %gid, i64 %flags64)
  ret i64 %r
}

define i64 @__mtrt_host_fcntl(i64 %fd, i64 %cmd, i64 %arg) {
entry:
  %r = call i64 @__mtrt_darwin_syscall3(i64 92, i64 %fd, i64 %cmd, i64 %arg)
  ret i64 %r
}

define i64 @__mtrt_host_fdatasync(i64 %fd) {
entry:
  %r = call i64 @__mtrt_darwin_syscall1(i64 187, i64 %fd)
  ret i64 %r
}

define i64 @__mtrt_host_fsync(i64 %fd) {
entry:
  %r = call i64 @__mtrt_darwin_syscall1(i64 95, i64 %fd)
  ret i64 %r
}

define i64 @__mtrt_host_getcwd(ptr %buf, i64 %size) {
entry:
  %is_null = icmp eq ptr %buf, null
  br i1 %is_null, label %fault, label %check_size

fault:
  ret i64 -14

check_size:
  %zero_size = icmp eq i64 %size, 0
  br i1 %zero_size, label %invalid, label %open_dot

invalid:
  ret i64 -22

open_dot:
  %tmp = alloca [1024 x i8], align 16
  %tmp_p = getelementptr inbounds [1024 x i8], ptr %tmp, i64 0, i64 0
  %dot_i = ptrtoint ptr @.mtrt_dot to i64
  %fd = call i64 @__mtrt_darwin_syscall3(i64 5, i64 %dot_i, i64 0, i64 0)
  %open_bad = icmp slt i64 %fd, 0
  br i1 %open_bad, label %open_done, label %call_fcntl

call_fcntl:
  %tmp_i = ptrtoint ptr %tmp_p to i64
  %fr = call i64 @__mtrt_darwin_syscall3(i64 92, i64 %fd, i64 50, i64 %tmp_i)
  %_close = call i64 @__mtrt_darwin_syscall1(i64 6, i64 %fd)
  %fcntl_bad = icmp slt i64 %fr, 0
  br i1 %fcntl_bad, label %fcntl_done, label %measure

measure:
  %len = call i64 @__mtrt_strlen(ptr %tmp_p)
  %need = add i64 %len, 1
  %too_small = icmp ugt i64 %need, %size
  br i1 %too_small, label %range, label %copy

range:
  ret i64 -34

copy:
  call void @__mtrt_copy_cstr(ptr %buf, ptr %tmp_p, i64 %len)
  %ret = ptrtoint ptr %buf to i64
  ret i64 %ret

fcntl_done:
  ret i64 %fr

open_done:
  ret i64 %fd
}

define i64 @__mtrt_host_lchown(ptr %path, i64 %uid, i64 %gid) {
entry:
  %path_i = ptrtoint ptr %path to i64
  %r = call i64 @__mtrt_darwin_syscall3(i64 364, i64 %path_i, i64 %uid, i64 %gid)
  ret i64 %r
}

define i64 @__mtrt_host_madvise(i64 %addr, i64 %length, i64 %advice) {
entry:
  %advice32 = trunc i64 %advice to i32
  %advice64 = sext i32 %advice32 to i64
  %r = call i64 @__mtrt_darwin_syscall3(i64 75, i64 %addr, i64 %length, i64 %advice64)
  ret i64 %r
}

define i64 @__mtrt_host_mlock(i64 %addr, i64 %length) {
entry:
  %r = call i64 @__mtrt_darwin_syscall2(i64 203, i64 %addr, i64 %length)
  ret i64 %r
}

define i64 @__mtrt_host_mmap(i64 %addr, i64 %length, i64 %prot, i64 %flags, i64 %fd, i64 %offset) {
entry:
  %prot32 = trunc i64 %prot to i32
  %flags32 = trunc i64 %flags to i32
  %fd32 = trunc i64 %fd to i32
  %mapped_flags = call i32 @__mtrt_darwin_mmap_flags_from_target(i32 %flags32)
  %prot64 = sext i32 %prot32 to i64
  %flags64 = sext i32 %mapped_flags to i64
  %fd64 = sext i32 %fd32 to i64
  %r = call i64 @__mtrt_darwin_syscall6(i64 197, i64 %addr, i64 %length, i64 %prot64, i64 %flags64, i64 %fd64, i64 %offset)
  ret i64 %r
}

define i64 @__mtrt_host_mprotect(i64 %addr, i64 %length, i64 %prot) {
entry:
  %prot32 = trunc i64 %prot to i32
  %prot64 = sext i32 %prot32 to i64
  %r = call i64 @__mtrt_darwin_syscall3(i64 74, i64 %addr, i64 %length, i64 %prot64)
  ret i64 %r
}

define i64 @__mtrt_host_msync(i64 %addr, i64 %length, i64 %flags) {
entry:
  %flags32 = trunc i64 %flags to i32
  %mapped_flags = call i32 @__mtrt_darwin_msync_flags_from_target(i32 %flags32)
  %flags64 = sext i32 %mapped_flags to i64
  %r = call i64 @__mtrt_darwin_syscall3(i64 65, i64 %addr, i64 %length, i64 %flags64)
  ret i64 %r
}

define i64 @__mtrt_host_munlock(i64 %addr, i64 %length) {
entry:
  %r = call i64 @__mtrt_darwin_syscall2(i64 204, i64 %addr, i64 %length)
  ret i64 %r
}

define i64 @__mtrt_host_munmap(i64 %addr, i64 %length) {
entry:
  %r = call i64 @__mtrt_darwin_syscall2(i64 73, i64 %addr, i64 %length)
  ret i64 %r
}

define i64 @__mtrt_host_pause() {
entry:
  %old = alloca i32, align 4
  %old_i = ptrtoint ptr %old to i64
  %get_mask = call i64 @__mtrt_darwin_syscall3(i64 48, i64 1, i64 0, i64 %old_i)
  %mask_bad = icmp slt i64 %get_mask, 0
  br i1 %mask_bad, label %done, label %suspend

suspend:
  %mask = load i32, ptr %old, align 4
  %mask64 = zext i32 %mask to i64
  %r = call i64 @__mtrt_darwin_syscall1(i64 111, i64 %mask64)
  ret i64 %r

done:
  ret i64 %get_mask
}

define i64 @__mtrt_host_pipe2(ptr %fds, i64 %flags) {
entry:
  ret i64 -38
}

define i64 @__mtrt_host_sched_yield() {
entry:
  %r = call i64 @__mtrt_darwin_swtch_trap()
  ret i64 0
}

define i64 @__mtrt_host_sigaction(i64 %sig, ptr %act, ptr %oldact) {
entry:
  %act_i = ptrtoint ptr %act to i64
  %oldact_i = ptrtoint ptr %oldact to i64
  %r = call i64 @__mtrt_darwin_syscall3(i64 46, i64 %sig, i64 %act_i, i64 %oldact_i)
  ret i64 %r
}

define i64 @__mtrt_host_sigaltstack(ptr %ss, ptr %old_ss) {
entry:
  %ss_i = ptrtoint ptr %ss to i64
  %old_i = ptrtoint ptr %old_ss to i64
  %r = call i64 @__mtrt_darwin_syscall2(i64 53, i64 %ss_i, i64 %old_i)
  ret i64 %r
}

define i64 @__mtrt_host_sigpending(ptr %sigset) {
entry:
  %sigset_i = ptrtoint ptr %sigset to i64
  %r = call i64 @__mtrt_darwin_syscall1(i64 52, i64 %sigset_i)
  ret i64 %r
}

define i64 @__mtrt_host_sigprocmask(i64 %how, ptr %set, ptr %oldset) {
entry:
  %mapped_how = call i32 @__mtrt_darwin_sigprocmask_how_from_target(i64 %how)
  %bad_how = icmp eq i32 %mapped_how, -1
  br i1 %bad_how, label %invalid, label %call_sigprocmask

invalid:
  ret i64 -22

call_sigprocmask:
  %set_i = ptrtoint ptr %set to i64
  %oldset_i = ptrtoint ptr %oldset to i64
  %how64 = sext i32 %mapped_how to i64
  %r = call i64 @__mtrt_darwin_syscall3(i64 48, i64 %how64, i64 %set_i, i64 %oldset_i)
  ret i64 %r
}

define i64 @__mtrt_host_sigsuspend(ptr %sigmask) {
entry:
  %sigmask_i = ptrtoint ptr %sigmask to i64
  %r = call i64 @__mtrt_darwin_syscall1(i64 111, i64 %sigmask_i)
  ret i64 %r
}

define i64 @__mtrt_host_sigtimedwait(ptr %set, ptr %info, ptr %timeout) {
entry:
  ret i64 -38
}

define i64 @__mtrt_host_sigwaitinfo(ptr %set, ptr %info) {
entry:
  ret i64 -38
}

define i64 @__mtrt_host_times(ptr %buf) {
entry:
  %timebase = alloca [8 x i8], align 4
  %timebase_r = call i64 @__mtrt_darwin_timebase_info_trap(ptr %timebase)
  %timebase_ok = icmp eq i64 %timebase_r, 0
  br i1 %timebase_ok, label %load_timebase, label %bad_timebase

bad_timebase:
  ret i64 -22

load_timebase:
  %numer_p = getelementptr i8, ptr %timebase, i64 0
  %denom_p = getelementptr i8, ptr %timebase, i64 4
  %numer32 = load i32, ptr %numer_p, align 4
  %denom32 = load i32, ptr %denom_p, align 4
  %denom_zero = icmp eq i32 %denom32, 0
  br i1 %denom_zero, label %bad_timebase, label %compute_elapsed

compute_elapsed:
  %abs = call i64 @__mtrt_darwin_abstime_trap()
  %numer = zext i32 %numer32 to i64
  %denom = zext i32 %denom32 to i64
  %abs_q = udiv i64 %abs, %denom
  %abs_r = urem i64 %abs, %denom
  %ns_q = mul i64 %abs_q, %numer
  %ns_r_mul = mul i64 %abs_r, %numer
  %ns_r = udiv i64 %ns_r_mul, %denom
  %ns = add i64 %ns_q, %ns_r
  %elapsed_ticks = udiv i64 %ns, 10000000
  %has_buf = icmp ne ptr %buf, null
  br i1 %has_buf, label %get_self_usage, label %done

get_self_usage:
  %self = alloca [256 x i8], align 16
  %children = alloca [256 x i8], align 16
  %self_i = ptrtoint ptr %self to i64
  %self_r = call i64 @__mtrt_darwin_syscall2(i64 117, i64 0, i64 %self_i)
  %self_ok = icmp eq i64 %self_r, 0
  br i1 %self_ok, label %get_child_usage, label %self_done

get_child_usage:
  %children_i = ptrtoint ptr %children to i64
  %children_r = call i64 @__mtrt_darwin_syscall2(i64 117, i64 -1, i64 %children_i)
  %children_ok = icmp eq i64 %children_r, 0
  br i1 %children_ok, label %store_tms, label %children_done

store_tms:
  %self_utime_p = getelementptr i8, ptr %self, i64 0
  %self_stime_p = getelementptr i8, ptr %self, i64 16
  %children_utime_p = getelementptr i8, ptr %children, i64 0
  %children_stime_p = getelementptr i8, ptr %children, i64 16
  %utime_ticks = call i64 @__mtrt_darwin_timeval_to_ticks(ptr %self_utime_p)
  %stime_ticks = call i64 @__mtrt_darwin_timeval_to_ticks(ptr %self_stime_p)
  %cutime_ticks = call i64 @__mtrt_darwin_timeval_to_ticks(ptr %children_utime_p)
  %cstime_ticks = call i64 @__mtrt_darwin_timeval_to_ticks(ptr %children_stime_p)
  %utime_out = getelementptr i8, ptr %buf, i64 0
  %stime_out = getelementptr i8, ptr %buf, i64 8
  %cutime_out = getelementptr i8, ptr %buf, i64 16
  %cstime_out = getelementptr i8, ptr %buf, i64 24
  store i64 %utime_ticks, ptr %utime_out, align 8
  store i64 %stime_ticks, ptr %stime_out, align 8
  store i64 %cutime_ticks, ptr %cutime_out, align 8
  store i64 %cstime_ticks, ptr %cstime_out, align 8
  br label %done

self_done:
  ret i64 %self_r

children_done:
  ret i64 %children_r

done:
  ret i64 %elapsed_ticks
}

define i64 @__mtrt_host_utimes(ptr %path, ptr %times) {
entry:
  %path_i = ptrtoint ptr %path to i64
  %is_null = icmp eq ptr %times, null
  br i1 %is_null, label %call_null, label %convert

call_null:
  %r_null = call i64 @__mtrt_darwin_syscall2(i64 138, i64 %path_i, i64 0)
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
  %native = alloca [32 x i8], align 8
  %atime_usec32 = trunc i64 %atime_usec to i32
  %mtime_usec32 = trunc i64 %mtime_usec to i32
  %native_atime_sec_p = getelementptr i8, ptr %native, i64 0
  %native_atime_usec_p = getelementptr i8, ptr %native, i64 8
  %native_atime_pad_p = getelementptr i8, ptr %native, i64 12
  %native_mtime_sec_p = getelementptr i8, ptr %native, i64 16
  %native_mtime_usec_p = getelementptr i8, ptr %native, i64 24
  %native_mtime_pad_p = getelementptr i8, ptr %native, i64 28
  store i64 %atime_sec, ptr %native_atime_sec_p, align 8
  store i32 %atime_usec32, ptr %native_atime_usec_p, align 4
  store i32 0, ptr %native_atime_pad_p, align 4
  store i64 %mtime_sec, ptr %native_mtime_sec_p, align 8
  store i32 %mtime_usec32, ptr %native_mtime_usec_p, align 4
  store i32 0, ptr %native_mtime_pad_p, align 4
  %native_i = ptrtoint ptr %native to i64
  %r = call i64 @__mtrt_darwin_syscall2(i64 138, i64 %path_i, i64 %native_i)
  ret i64 %r
}
