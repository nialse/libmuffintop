; Linux common host helper layer for pure Linux ABI translation/layout logic.
; Linked only with Linux architecture host layers.

%struct.mtrt_stat64 = type { i64, i64, i64, i32, i32, i32, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64 }

declare i8 @__mtrt_common_dtype(i8)
declare i64 @__mtrt_name_len_bounded(ptr, i64)
declare void @__mtrt_store_dent64(ptr, i64, i64, i8, ptr, i64)

define i64 @__mtrt_linux_makedev(i32 %major32, i32 %minor32) {
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

define i32 @__mtrt_linux_mode_from_native(i32 %mode) {
entry:
  %perm = and i32 %mode, 4095
  %type = and i32 %mode, 61440
  switch i32 %type, label %unknown [
    i32 4096, label %known
    i32 8192, label %known
    i32 16384, label %known
    i32 24576, label %known
    i32 32768, label %known
    i32 40960, label %known
    i32 49152, label %known
  ]

known:
  %ret = or i32 %perm, %type
  ret i32 %ret

unknown:
  ret i32 %perm
}

define void @__mtrt_linux_store_statx(ptr %out, ptr %sx) {
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
  %mode_raw = zext i16 %mode16 to i32
  %mode = call i32 @__mtrt_linux_mode_from_native(i32 %mode_raw)
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

define i64 @__mtrt_linux_translate_getdents64(ptr %buf, i64 %native_bytes) {
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

define i32 @__mtrt_linux_speed_to_native(i32 %speed) {
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

define i32 @__mtrt_linux_native_speed_to_target(i32 %native) {
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

define i64 @__mtrt_linux_iflag_to_target(i64 %native) {
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

define i64 @__mtrt_linux_iflag_to_native(i64 %target) {
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

define i64 @__mtrt_linux_oflag_to_target(i64 %native) {
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

define i64 @__mtrt_linux_oflag_to_native(i64 %target) {
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

define i64 @__mtrt_linux_cflag_to_target(i64 %native) {
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

define i64 @__mtrt_linux_cflag_to_native(i64 %target) {
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

define i64 @__mtrt_linux_lflag_to_target(i64 %native) {
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

define i64 @__mtrt_linux_lflag_to_native(i64 %target) {
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

define void @__mtrt_linux_zero_target_cc(ptr %target) {
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

define void @__mtrt_linux_copy_native_cc_to_target(ptr %target, ptr %native) {
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

define void @__mtrt_linux_copy_target_cc_to_native(ptr %native, ptr %target) {
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

define i1 @__mtrt_linux_termios_target_valid(ptr %target) {
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

define void @__mtrt_linux_store_target_termios(ptr %target, ptr %native) {
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

define void @__mtrt_linux_overlay_native_termios(ptr %native, ptr %target) {
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

define i64 @__mtrt_linux_tcsetattr_request(i64 %action) {
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

define i64 @__mtrt_linux_tcflow_action(i64 %action) {
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

define i64 @__mtrt_linux_tcflush_selector(i64 %selector) {
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

define i32 @__mtrt_linux_wait_status_from_native(i32 %status) {
entry:
  %low = and i32 %status, 255
  %is_exited = icmp eq i32 %low, 0
  br i1 %is_exited, label %preserve, label %check_continued

check_continued:
  %is_continued = icmp eq i32 %status, 65535
  br i1 %is_continued, label %preserve, label %check_stopped

check_stopped:
  %is_stopped = icmp eq i32 %low, 127
  br i1 %is_stopped, label %stopped, label %signaled

stopped:
  %stopped_shifted = lshr i32 %status, 8
  %stopped_native32 = and i32 %stopped_shifted, 255
  %stopped_native = zext i32 %stopped_native32 to i64
  %stopped_target = call i64 @__mtrt_linux_signal_from_native(i64 %stopped_native)
  %stopped_target32 = trunc i64 %stopped_target to i32
  %stopped_target_shifted = shl i32 %stopped_target32, 8
  %stopped_upper = and i32 %status, -65536
  %stopped_with_sig = or i32 %stopped_upper, %stopped_target_shifted
  %stopped_ret = or i32 %stopped_with_sig, 127
  ret i32 %stopped_ret

signaled:
  %signaled_native32 = and i32 %status, 127
  %signaled_native = zext i32 %signaled_native32 to i64
  %signaled_target = call i64 @__mtrt_linux_signal_from_native(i64 %signaled_native)
  %signaled_target32 = trunc i64 %signaled_target to i32
  %signaled_core = and i32 %status, 128
  %signaled_upper = and i32 %status, -256
  %signaled_with_core = or i32 %signaled_upper, %signaled_core
  %signaled_ret = or i32 %signaled_with_core, %signaled_target32
  ret i32 %signaled_ret

preserve:
  ret i32 %status
}

define i64 @__mtrt_linux_clockid_from_target(i64 %clockid) {
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

define i64 @__mtrt_linux_signal_to_native(i64 %sig) {
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

define i64 @__mtrt_linux_signal_from_native(i64 %sig) {
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

define i64 @__mtrt_linux_sigset_to_native(i64 %target) {
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

define i64 @__mtrt_linux_sigset_from_native(i64 %native) {
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

define void @__mtrt_linux_siginfo_to_target(ptr %target_info, ptr %native_info) {
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

define i64 @__mtrt_linux_fcntl_cmd_from_target(i64 %cmd) {
entry:
  switch i64 %cmd, label %bad [
    i64 0, label %dupfd
    i64 1, label %getfd
    i64 2, label %setfd
    i64 3, label %getfl
    i64 4, label %setfl
    i64 5, label %getlk
    i64 6, label %setlk
    i64 7, label %setlkw
  ]

dupfd:
  ret i64 0

getfd:
  ret i64 1

setfd:
  ret i64 2

getfl:
  ret i64 3

setfl:
  ret i64 4

getlk:
  ret i64 5

setlk:
  ret i64 6

setlkw:
  ret i64 7

bad:
  ret i64 -1
}

define i64 @__mtrt_linux_fd_flags_from_native(i64 %native) {
entry:
  %clo = and i64 %native, 1
  ret i64 %clo
}

define i64 @__mtrt_linux_fd_flags_to_native(i64 %target) {
entry:
  %known = and i64 %target, 1
  %unknown = xor i64 %target, %known
  %ok = icmp eq i64 %unknown, 0
  %ret = select i1 %ok, i64 %known, i64 -1
  ret i64 %ret
}

define i64 @__mtrt_linux_status_flags_from_native(i64 %native) {
entry:
  %access = and i64 %native, 3
  %append_bits = and i64 %native, 1024
  %has_append = icmp ne i64 %append_bits, 0
  %append = select i1 %has_append, i64 1024, i64 0
  %nonblock_bits = and i64 %native, 2048
  %has_nonblock = icmp ne i64 %nonblock_bits, 0
  %nonblock = select i1 %has_nonblock, i64 2048, i64 0
  %with_append = or i64 %access, %append
  %ret = or i64 %with_append, %nonblock
  ret i64 %ret
}

define i64 @__mtrt_linux_status_flags_to_native(i64 %target) {
entry:
  %known = and i64 %target, 3075
  %unknown = xor i64 %target, %known
  %bits_ok = icmp eq i64 %unknown, 0
  %access = and i64 %target, 3
  %access_ok = icmp ne i64 %access, 3
  %ok = and i1 %bits_ok, %access_ok
  %append_bits = and i64 %target, 1024
  %has_append = icmp ne i64 %append_bits, 0
  %append = select i1 %has_append, i64 1024, i64 0
  %nonblock_bits = and i64 %target, 2048
  %has_nonblock = icmp ne i64 %nonblock_bits, 0
  %nonblock = select i1 %has_nonblock, i64 2048, i64 0
  %mapped = or i64 %append, %nonblock
  %ret = select i1 %ok, i64 %mapped, i64 -1
  ret i64 %ret
}

define i64 @__mtrt_linux_flock_type_to_native(i16 %target) {
entry:
  switch i16 %target, label %bad [
    i16 0, label %rd
    i16 1, label %wr
    i16 2, label %un
  ]

rd:
  ret i64 0

wr:
  ret i64 1

un:
  ret i64 2

bad:
  ret i64 -1
}

define i64 @__mtrt_linux_flock_type_from_native(i16 %native) {
entry:
  switch i16 %native, label %bad [
    i16 0, label %rd
    i16 1, label %wr
    i16 2, label %un
  ]

rd:
  ret i64 0

wr:
  ret i64 1

un:
  ret i64 2

bad:
  ret i64 -1
}

define i64 @__mtrt_linux_flock_target_to_native(ptr %target, ptr %native) {
entry:
  %target_type = load i16, ptr %target, align 2
  %native_type = call i64 @__mtrt_linux_flock_type_to_native(i16 %target_type)
  %bad_type = icmp slt i64 %native_type, 0
  br i1 %bad_type, label %invalid, label %check_whence

check_whence:
  %target_whence_p = getelementptr i8, ptr %target, i64 2
  %target_whence = load i16, ptr %target_whence_p, align 2
  %whence64 = sext i16 %target_whence to i64
  %whence_low = icmp sge i64 %whence64, 0
  %whence_high = icmp sle i64 %whence64, 2
  %whence_ok = and i1 %whence_low, %whence_high
  br i1 %whence_ok, label %copy, label %invalid

copy:
  %native_type16 = trunc i64 %native_type to i16
  store i16 %native_type16, ptr %native, align 2
  %native_whence_p = getelementptr i8, ptr %native, i64 2
  store i16 %target_whence, ptr %native_whence_p, align 2
  %target_start_p = getelementptr i8, ptr %target, i64 8
  %start = load i64, ptr %target_start_p, align 8
  %native_start_p = getelementptr i8, ptr %native, i64 8
  store i64 %start, ptr %native_start_p, align 8
  %target_len_p = getelementptr i8, ptr %target, i64 16
  %len = load i64, ptr %target_len_p, align 8
  %native_len_p = getelementptr i8, ptr %native, i64 16
  store i64 %len, ptr %native_len_p, align 8
  %target_pid_p = getelementptr i8, ptr %target, i64 24
  %pid = load i32, ptr %target_pid_p, align 4
  %native_pid_p = getelementptr i8, ptr %native, i64 24
  store i32 %pid, ptr %native_pid_p, align 4
  ret i64 0

invalid:
  ret i64 -22
}

define i64 @__mtrt_linux_flock_native_to_target(ptr %target, ptr %native) {
entry:
  %native_type = load i16, ptr %native, align 2
  %target_type = call i64 @__mtrt_linux_flock_type_from_native(i16 %native_type)
  %bad_type = icmp slt i64 %target_type, 0
  br i1 %bad_type, label %invalid, label %check_whence

check_whence:
  %native_whence_p = getelementptr i8, ptr %native, i64 2
  %native_whence = load i16, ptr %native_whence_p, align 2
  %whence64 = sext i16 %native_whence to i64
  %whence_low = icmp sge i64 %whence64, 0
  %whence_high = icmp sle i64 %whence64, 2
  %whence_ok = and i1 %whence_low, %whence_high
  br i1 %whence_ok, label %copy, label %invalid

copy:
  %target_type16 = trunc i64 %target_type to i16
  store i16 %target_type16, ptr %target, align 2
  %target_whence_p = getelementptr i8, ptr %target, i64 2
  store i16 %native_whence, ptr %target_whence_p, align 2
  %native_start_p = getelementptr i8, ptr %native, i64 8
  %start = load i64, ptr %native_start_p, align 8
  %target_start_p = getelementptr i8, ptr %target, i64 8
  store i64 %start, ptr %target_start_p, align 8
  %native_len_p = getelementptr i8, ptr %native, i64 16
  %len = load i64, ptr %native_len_p, align 8
  %target_len_p = getelementptr i8, ptr %target, i64 16
  store i64 %len, ptr %target_len_p, align 8
  %native_pid_p = getelementptr i8, ptr %native, i64 24
  %pid = load i32, ptr %native_pid_p, align 4
  %target_pid_p = getelementptr i8, ptr %target, i64 24
  store i32 %pid, ptr %target_pid_p, align 4
  ret i64 0

invalid:
  ret i64 -22
}

