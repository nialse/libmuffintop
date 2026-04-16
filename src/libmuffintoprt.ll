; POSIX API surface for libmuffintoprt.
; Exposes POSIX signatures and translates kernel-style return conventions.

target triple = "x86_64-unknown-linux-gnu"

@mtrt_errno = global i32 0, align 4

declare i64 @__mtrt_linux_getpid()
declare i64 @__mtrt_linux_getppid()
declare i64 @__mtrt_linux_fork()
declare i64 @__mtrt_linux_wait4(i64, ptr, i64)
declare void @__mtrt_linux_exit(i64)
declare i64 @__mtrt_linux_write(i64, ptr, i64)
declare i64 @__mtrt_linux_read(i64, ptr, i64)
declare i64 @__mtrt_linux_close(i64)
declare i64 @__mtrt_linux_nanosleep(ptr, ptr)
declare i64 @__mtrt_linux_clock_gettime(i64, ptr)
declare i64 @__mtrt_linux_kill(i64, i64)

define ptr @__errno_location() {
entry:
  ret ptr @mtrt_errno
}

define internal i64 @__mtrt_raw_to_posix_i64(i64 %raw) {
entry:
  %is_neg = icmp slt i64 %raw, 0
  br i1 %is_neg, label %neg, label %ok

neg:
  %err64 = sub i64 0, %raw
  %err = trunc i64 %err64 to i32
  store i32 %err, ptr @mtrt_errno, align 4
  ret i64 -1

ok:
  ret i64 %raw
}

define internal i32 @__mtrt_raw_to_posix_i32(i64 %raw) {
entry:
  %mapped = call i64 @__mtrt_raw_to_posix_i64(i64 %raw)
  %ret = trunc i64 %mapped to i32
  ret i32 %ret
}

define i32 @getpid() {
entry:
  %raw = call i64 @__mtrt_linux_getpid()
  %ret = call i32 @__mtrt_raw_to_posix_i32(i64 %raw)
  ret i32 %ret
}

define i32 @getppid() {
entry:
  %raw = call i64 @__mtrt_linux_getppid()
  %ret = call i32 @__mtrt_raw_to_posix_i32(i64 %raw)
  ret i32 %ret
}

define i32 @fork() {
entry:
  %raw = call i64 @__mtrt_linux_fork()
  %ret = call i32 @__mtrt_raw_to_posix_i32(i64 %raw)
  ret i32 %ret
}

define i32 @waitpid(i32 %pid, ptr %status, i32 %options) {
entry:
  %pid64 = sext i32 %pid to i64
  %opt64 = sext i32 %options to i64
  %raw = call i64 @__mtrt_linux_wait4(i64 %pid64, ptr %status, i64 %opt64)
  %ret = call i32 @__mtrt_raw_to_posix_i32(i64 %raw)
  ret i32 %ret
}

define void @_exit(i32 %status) {
entry:
  %st64 = sext i32 %status to i64
  call void @__mtrt_linux_exit(i64 %st64)
  unreachable
}

define i64 @write(i32 %fd, ptr %buf, i64 %count) {
entry:
  %fd64 = sext i32 %fd to i64
  %raw = call i64 @__mtrt_linux_write(i64 %fd64, ptr %buf, i64 %count)
  %ret = call i64 @__mtrt_raw_to_posix_i64(i64 %raw)
  ret i64 %ret
}

define i64 @read(i32 %fd, ptr %buf, i64 %count) {
entry:
  %fd64 = sext i32 %fd to i64
  %raw = call i64 @__mtrt_linux_read(i64 %fd64, ptr %buf, i64 %count)
  %ret = call i64 @__mtrt_raw_to_posix_i64(i64 %raw)
  ret i64 %ret
}

define i32 @close(i32 %fd) {
entry:
  %fd64 = sext i32 %fd to i64
  %raw = call i64 @__mtrt_linux_close(i64 %fd64)
  %ret = call i32 @__mtrt_raw_to_posix_i32(i64 %raw)
  ret i32 %ret
}

define i32 @nanosleep(ptr %req, ptr %rem) {
entry:
  %raw = call i64 @__mtrt_linux_nanosleep(ptr %req, ptr %rem)
  %ret = call i32 @__mtrt_raw_to_posix_i32(i64 %raw)
  ret i32 %ret
}

define i32 @clock_gettime(i32 %clockid, ptr %tp) {
entry:
  %cid64 = sext i32 %clockid to i64
  %raw = call i64 @__mtrt_linux_clock_gettime(i64 %cid64, ptr %tp)
  %ret = call i32 @__mtrt_raw_to_posix_i32(i64 %raw)
  ret i32 %ret
}

define i32 @kill(i32 %pid, i32 %sig) {
entry:
  %pid64 = sext i32 %pid to i64
  %sig64 = sext i32 %sig to i64
  %raw = call i64 @__mtrt_linux_kill(i64 %pid64, i64 %sig64)
  %ret = call i32 @__mtrt_raw_to_posix_i32(i64 %raw)
  ret i32 %ret
}
