target triple = "arm64-apple-macosx13.0.0"

%struct.mtrt_stat64 = type { i64, i64, i64, i32, i32, i32, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64 }

@.mtrt_dot = private unnamed_addr constant [2 x i8] c".\00"

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

define i64 @__mtrt_host_geteuid() {
entry:
  %r = call i64 @__mtrt_darwin_syscall0(i64 25)
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
  %r = call i64 @__mtrt_darwin_syscall3(i64 116, i64 %tv_i, i64 0, i64 0)
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

define i64 @__mtrt_host_clock_getres(i64 %clockid, ptr %tp) {
entry:
  ret i64 -38
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

define i64 @__mtrt_host_mlockall(i64 %flags) {
entry:
  ret i64 -38
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

define i64 @__mtrt_host_munlockall() {
entry:
  ret i64 -38
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
