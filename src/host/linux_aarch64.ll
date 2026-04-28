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
