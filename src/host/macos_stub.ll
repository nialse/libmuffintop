; macOS host translation stub for libmuffintoprt.
; Keeps OS-specific translation isolated until native implementation is added.

target triple = "x86_64-apple-macosx13.0.0"

define i64 @__mtrt_macos_getpid() {
entry:
  ret i64 0
}

define i64 @__mtrt_macos_getppid() {
entry:
  ret i64 0
}

define i64 @__mtrt_macos_fork() {
entry:
  ret i64 -38 ; ENOSYS
}

define i64 @__mtrt_macos_wait4(i64 %pid, ptr %status, i64 %options) {
entry:
  ret i64 -38
}

define void @__mtrt_macos_exit(i64 %status) {
entry:
  unreachable
}

define i64 @__mtrt_macos_write(i64 %fd, ptr %buf, i64 %count) {
entry:
  ret i64 -38
}

define i64 @__mtrt_macos_read(i64 %fd, ptr %buf, i64 %count) {
entry:
  ret i64 -38
}

define i64 @__mtrt_macos_close(i64 %fd) {
entry:
  ret i64 -38
}

define i64 @__mtrt_macos_nanosleep(ptr %req, ptr %rem) {
entry:
  ret i64 -38
}

define i64 @__mtrt_macos_clock_gettime(i64 %clockid, ptr %tp) {
entry:
  ret i64 -38
}

define i64 @__mtrt_macos_kill(i64 %pid, i64 %sig) {
entry:
  ret i64 -38
}
