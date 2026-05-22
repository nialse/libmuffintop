; Linux x86_64 kernel-primitive host layer for libmuffintop.
; Direct syscall path (no libc).

target triple = "x86_64-unknown-linux-gnu"

%struct.mtrt_stat64 = type { i64, i64, i64, i32, i32, i32, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64 }

@.mtrt_empty_path = private unnamed_addr constant [1 x i8] zeroinitializer
@__mtrt_platform_uname_sys = constant [6 x i8] c"Linux\0A", align 1
@__mtrt_platform_uname_sys_len = constant i64 6, align 8
@__mtrt_platform_uname_all = constant [27 x i8] c"Linux muffintop 0 0 x86_64\0A", align 1
@__mtrt_platform_uname_all_len = constant i64 27, align 8
@__mtrt_linux_handler_sig17 = internal global i64 0, align 8
@__mtrt_linux_handler_sig18 = internal global i64 0, align 8
@__mtrt_linux_handler_sig19 = internal global i64 0, align 8
@__mtrt_linux_handler_sig20 = internal global i64 0, align 8
@__mtrt_linux_flags_sig17 = internal global i64 0, align 8
@__mtrt_linux_flags_sig18 = internal global i64 0, align 8
@__mtrt_linux_flags_sig19 = internal global i64 0, align 8
@__mtrt_linux_flags_sig20 = internal global i64 0, align 8

declare i8 @__mtrt_common_dtype(i8)
declare i64 @__mtrt_name_len_bounded(ptr, i64)
declare void @__mtrt_store_dent64(ptr, i64, i64, i8, ptr, i64)

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

declare i64 @__mtrt_linux_makedev(i32 %major32, i32 %minor32)


declare i32 @__mtrt_linux_mode_from_native(i32 %mode)


declare void @__mtrt_linux_store_statx(ptr %out, ptr %sx)


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

declare i64 @__mtrt_linux_translate_getdents64(ptr %buf, i64 %native_bytes)


define internal i64 @__mtrt_linux_ioctl_ptr(i64 %fd, i64 %request, ptr %arg) {
entry:
  %arg_i = ptrtoint ptr %arg to i64
  %r = call i64 @__mtrt_linux_syscall3(i64 16, i64 %fd, i64 %request, i64 %arg_i)
  ret i64 %r
}

define internal i64 @__mtrt_linux_ioctl_int(i64 %fd, i64 %request, i64 %arg) {
entry:
  %r = call i64 @__mtrt_linux_syscall3(i64 16, i64 %fd, i64 %request, i64 %arg)
  ret i64 %r
}

declare i32 @__mtrt_linux_speed_to_native(i32 %speed)


declare i32 @__mtrt_linux_native_speed_to_target(i32 %native)


declare i64 @__mtrt_linux_iflag_to_target(i64 %native)


declare i64 @__mtrt_linux_iflag_to_native(i64 %target)


declare i64 @__mtrt_linux_oflag_to_target(i64 %native)


declare i64 @__mtrt_linux_oflag_to_native(i64 %target)


declare i64 @__mtrt_linux_cflag_to_target(i64 %native)


declare i64 @__mtrt_linux_cflag_to_native(i64 %target)


declare i64 @__mtrt_linux_lflag_to_target(i64 %native)


declare i64 @__mtrt_linux_lflag_to_native(i64 %target)


declare void @__mtrt_linux_zero_target_cc(ptr %target)


declare void @__mtrt_linux_copy_native_cc_to_target(ptr %target, ptr %native)


declare void @__mtrt_linux_copy_target_cc_to_native(ptr %native, ptr %target)


declare i1 @__mtrt_linux_termios_target_valid(ptr %target)


declare void @__mtrt_linux_store_target_termios(ptr %target, ptr %native)


declare void @__mtrt_linux_overlay_native_termios(ptr %native, ptr %target)


declare i64 @__mtrt_linux_tcsetattr_request(i64 %action)


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

declare i64 @__mtrt_linux_tcflow_action(i64 %action)


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

declare i64 @__mtrt_linux_tcflush_selector(i64 %selector)


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

define i64 @__mtrt_host_getpid() {
  %r = call i64 @__mtrt_linux_syscall0(i64 39)
  ret i64 %r
}

define i64 @__mtrt_host_getppid() {
  %r = call i64 @__mtrt_linux_syscall0(i64 110)
  ret i64 %r
}

define i64 @__mtrt_host_getuid() {
  %r = call i64 @__mtrt_linux_syscall0(i64 102)
  ret i64 %r
}

define i64 @__mtrt_host_geteuid() {
  %r = call i64 @__mtrt_linux_syscall0(i64 107)
  ret i64 %r
}

define i64 @__mtrt_host_getgid() {
  %r = call i64 @__mtrt_linux_syscall0(i64 104)
  ret i64 %r
}

define i64 @__mtrt_host_fork() {
  %r = call i64 @__mtrt_linux_syscall0(i64 57)
  ret i64 %r
}

declare i32 @__mtrt_linux_wait_status_from_native(i32 %status)


define i64 @__mtrt_host_wait4(i64 %pid, ptr %status, i64 %options) {
entry:
  %status_i = ptrtoint ptr %status to i64
  %r = call i64 @__mtrt_linux_syscall4(i64 61, i64 %pid, i64 %status_i, i64 %options, i64 0)
  %waited = icmp sgt i64 %r, 0
  %status_present = icmp ne ptr %status, null
  %translate = and i1 %waited, %status_present
  br i1 %translate, label %translate_status, label %done

translate_status:
  %native_status = load i32, ptr %status, align 4
  %target_status = call i32 @__mtrt_linux_wait_status_from_native(i32 %native_status)
  store i32 %target_status, ptr %status, align 4
  ret i64 %r

done:
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

declare i64 @__mtrt_linux_clockid_from_target(i64 %clockid)


define i64 @__mtrt_host_clock_gettime(i64 %clockid, ptr %tp) {
entry:
  %native_clockid = call i64 @__mtrt_linux_clockid_from_target(i64 %clockid)
  %bad_clockid = icmp slt i64 %native_clockid, 0
  br i1 %bad_clockid, label %invalid_clockid, label %call_clock

call_clock:
  %tp_i = ptrtoint ptr %tp to i64
  %r = call i64 @__mtrt_linux_syscall2(i64 228, i64 %native_clockid, i64 %tp_i)
  ret i64 %r

invalid_clockid:
  ret i64 %native_clockid
}

declare i64 @__mtrt_linux_signal_to_native(i64 %sig)


declare i64 @__mtrt_linux_signal_from_native(i64 %sig)


declare i64 @__mtrt_linux_sigset_to_native(i64 %target)


declare i64 @__mtrt_linux_sigset_from_native(i64 %native)


define internal i64 @__mtrt_linux_sigaction_flags_to_native_x86_64(i64 %target) {
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
  %r4 = or i64 %r3, 67108864
  ret i64 %r4
}

define internal i64 @__mtrt_linux_sigaction_flags_from_native_x86_64(i64 %native) {
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

define internal void @__mtrt_linux_rt_sigreturn_restorer_x86_64() #0 {
entry:
  call void asm sideeffect "mov $$15, %rax\0A syscall", "~{rax},~{rcx},~{r11},~{memory}"()
  unreachable
}

declare void @__mtrt_linux_siginfo_to_target(ptr %target_info, ptr %native_info)


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
  %r = call i64 @__mtrt_linux_syscall2(i64 62, i64 %pid, i64 %native_sig)
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

define i64 @__mtrt_host_posix_getdents(i64 %fd, ptr %buf, i64 %nbyte, i64 %flags) {
entry:
  %flags_ok = icmp eq i64 %flags, 0
  br i1 %flags_ok, label %check_size, label %invalid

check_size:
  %size_ok = icmp uge i64 %nbyte, 24
  br i1 %size_ok, label %call_getdents, label %invalid

call_getdents:
  %buf_i = ptrtoint ptr %buf to i64
  %r = call i64 @__mtrt_linux_syscall3(i64 217, i64 %fd, i64 %buf_i, i64 %nbyte)
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
  %has_flags = icmp ne i64 %flags, 0
  br i1 %has_flags, label %call_fchmodat2, label %call_fchmodat

call_fchmodat:
  %legacy = call i64 @__mtrt_linux_syscall3(i64 268, i64 %dirfd, i64 %path_i, i64 %mode)
  ret i64 %legacy

call_fchmodat2:
  %modern = call i64 @__mtrt_linux_syscall4(i64 452, i64 %dirfd, i64 %path_i, i64 %mode, i64 %flags)
  ret i64 %modern
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

define i64 @__mtrt_host_mkfifo(ptr %path, i64 %mode) {
  %path_i = ptrtoint ptr %path to i64
  %perm = and i64 %mode, 511
  %fifo_mode = or i64 %perm, 4096
  %r = call i64 @__mtrt_linux_syscall4(i64 259, i64 -100, i64 %path_i, i64 %fifo_mode, i64 0)
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

define i64 @__mtrt_host_ftruncate(i64 %fd, i64 %length) {
  %r = call i64 @__mtrt_linux_syscall2(i64 77, i64 %fd, i64 %length)
  ret i64 %r
}

define i64 @__mtrt_host_chown(ptr %path, i64 %uid, i64 %gid) {
  %path_i = ptrtoint ptr %path to i64
  %r = call i64 @__mtrt_linux_syscall3(i64 92, i64 %path_i, i64 %uid, i64 %gid)
  ret i64 %r
}

define i64 @__mtrt_host_clock_getres(i64 %clockid, ptr %tp) {
entry:
  %native_clockid = call i64 @__mtrt_linux_clockid_from_target(i64 %clockid)
  %bad_clockid = icmp slt i64 %native_clockid, 0
  br i1 %bad_clockid, label %invalid_clockid, label %call_clock

call_clock:
  %tp_i = ptrtoint ptr %tp to i64
  %r = call i64 @__mtrt_linux_syscall2(i64 229, i64 %native_clockid, i64 %tp_i)
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
  %r = call i64 @__mtrt_linux_syscall2(i64 227, i64 %native_clockid, i64 %tp_i)
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

declare i64 @__mtrt_linux_fcntl_cmd_from_target(i64 %cmd)


declare i64 @__mtrt_linux_fd_flags_from_native(i64 %native)


declare i64 @__mtrt_linux_fd_flags_to_native(i64 %target)


declare i64 @__mtrt_linux_status_flags_from_native(i64 %native)


declare i64 @__mtrt_linux_status_flags_to_native(i64 %target)


declare i64 @__mtrt_linux_flock_type_to_native(i16 %target)


declare i64 @__mtrt_linux_flock_type_from_native(i16 %native)


declare i64 @__mtrt_linux_flock_target_to_native(ptr %target, ptr %native)


declare i64 @__mtrt_linux_flock_native_to_target(ptr %target, ptr %native)


define i64 @__mtrt_host_fcntl(i64 %fd, i64 %cmd, i64 %arg) {
entry:
  %native_cmd = call i64 @__mtrt_linux_fcntl_cmd_from_target(i64 %cmd)
  switch i64 %cmd, label %scalar [
    i64 1, label %getfd
    i64 2, label %setfd
    i64 3, label %getfl
    i64 4, label %setfl
    i64 5, label %lock
    i64 6, label %lock
    i64 7, label %lock
  ]

scalar:
  %scalar_r = call i64 @__mtrt_linux_syscall3(i64 72, i64 %fd, i64 %native_cmd, i64 %arg)
  ret i64 %scalar_r

getfd:
  %getfd_r = call i64 @__mtrt_linux_syscall3(i64 72, i64 %fd, i64 %native_cmd, i64 %arg)
  %getfd_bad = icmp slt i64 %getfd_r, 0
  br i1 %getfd_bad, label %getfd_done, label %map_getfd

map_getfd:
  %target_fd_flags = call i64 @__mtrt_linux_fd_flags_from_native(i64 %getfd_r)
  ret i64 %target_fd_flags

getfd_done:
  ret i64 %getfd_r

setfd:
  %native_fd_flags = call i64 @__mtrt_linux_fd_flags_to_native(i64 %arg)
  %setfd_r = call i64 @__mtrt_linux_syscall3(i64 72, i64 %fd, i64 %native_cmd, i64 %native_fd_flags)
  ret i64 %setfd_r

getfl:
  %getfl_r = call i64 @__mtrt_linux_syscall3(i64 72, i64 %fd, i64 %native_cmd, i64 %arg)
  %getfl_bad = icmp slt i64 %getfl_r, 0
  br i1 %getfl_bad, label %getfl_done, label %map_getfl

map_getfl:
  %target_status_flags = call i64 @__mtrt_linux_status_flags_from_native(i64 %getfl_r)
  ret i64 %target_status_flags

getfl_done:
  ret i64 %getfl_r

setfl:
  %native_status_flags = call i64 @__mtrt_linux_status_flags_to_native(i64 %arg)
  %setfl_r = call i64 @__mtrt_linux_syscall3(i64 72, i64 %fd, i64 %native_cmd, i64 %native_status_flags)
  ret i64 %setfl_r

lock:
  %target_flock = inttoptr i64 %arg to ptr
  %lock_null = icmp eq ptr %target_flock, null
  br i1 %lock_null, label %fault, label %copy_lock_in

copy_lock_in:
  %native_flock = alloca [32 x i8], align 8
  %prep = call i64 @__mtrt_linux_flock_target_to_native(ptr %target_flock, ptr %native_flock)
  %prep_bad = icmp slt i64 %prep, 0
  br i1 %prep_bad, label %prep_done, label %call_lock

call_lock:
  %native_flock_i = ptrtoint ptr %native_flock to i64
  %lock_r = call i64 @__mtrt_linux_syscall3(i64 72, i64 %fd, i64 %native_cmd, i64 %native_flock_i)
  %is_getlk = icmp eq i64 %cmd, 5
  %lock_ok = icmp eq i64 %lock_r, 0
  %copy_out = and i1 %is_getlk, %lock_ok
  br i1 %copy_out, label %copy_lock_out, label %lock_done

copy_lock_out:
  %copy = call i64 @__mtrt_linux_flock_native_to_target(ptr %target_flock, ptr %native_flock)
  ret i64 %copy

lock_done:
  ret i64 %lock_r

prep_done:
  ret i64 %prep

fault:
  ret i64 -14
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
  %native_flags = call i64 @__mtrt_linux_sigaction_flags_to_native_x86_64(i64 %target_flags)
  %bad_flags = icmp slt i64 %native_flags, 0
  br i1 %bad_flags, label %invalid, label %copy_act_mask

copy_act_mask:
  %native_flags_p = getelementptr i8, ptr %native_act, i64 8
  store i64 %native_flags, ptr %native_flags_p, align 8
  %native_restorer_p = getelementptr i8, ptr %native_act, i64 16
  store ptr @__mtrt_linux_rt_sigreturn_restorer_x86_64, ptr %native_restorer_p, align 8
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
  %r = call i64 @__mtrt_linux_syscall4(i64 13, i64 %native_sig, i64 %act_i, i64 %oldact_i, i64 8)
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
  %old_target_flags = call i64 @__mtrt_linux_sigaction_flags_from_native_x86_64(i64 %old_native_flags)
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
  %r = call i64 @__mtrt_linux_syscall2(i64 131, i64 %ss_i, i64 %old_i)
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
  %r = call i64 @__mtrt_linux_syscall2(i64 127, i64 %native_sigset_i, i64 8)
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
  %r = call i64 @__mtrt_linux_syscall4(i64 14, i64 %how, i64 %set_i, i64 %oldset_i, i64 8)
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
  %r = call i64 @__mtrt_linux_syscall2(i64 130, i64 %sigmask_i, i64 8)
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
  %r = call i64 @__mtrt_linux_syscall4(i64 128, i64 %set_i, i64 %info_i, i64 %timeout_i, i64 8)
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
  %r = call i64 @__mtrt_linux_syscall1(i64 100, i64 %buf_i)
  ret i64 %r
}

define i64 @__mtrt_host_utimes(ptr %path, ptr %times) {
  %path_i = ptrtoint ptr %path to i64
  %times_i = ptrtoint ptr %times to i64
  %r = call i64 @__mtrt_linux_syscall2(i64 235, i64 %path_i, i64 %times_i)
  ret i64 %r
}

attributes #0 = { naked noreturn }
