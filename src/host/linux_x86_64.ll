; Linux x86_64 kernel-primitive host layer for libmuffintop.
; Direct syscall path (no libc).

target triple = "x86_64-unknown-linux-gnu"

%struct.mtrt_stat64 = type { i64, i64, i64, i32, i32, i32, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64 }

@.mtrt_empty_path = private unnamed_addr constant [1 x i8] zeroinitializer
@__mtrt_platform_uname_sys = hidden constant [6 x i8] c"Linux\0A", align 1
@__mtrt_platform_uname_sys_len = hidden constant i64 6, align 8
@__mtrt_platform_uname_all = hidden constant [27 x i8] c"Linux muffintop 0 0 x86_64\0A", align 1
@__mtrt_platform_uname_all_len = hidden constant i64 27, align 8
@__mtrt_linux_target_handlers = internal global [23 x i64] zeroinitializer, align 8
@__mtrt_linux_target_flags = internal global [23 x i64] zeroinitializer, align 8

declare i8 @__mtrt_common_dtype(i8)
declare i64 @__mtrt_name_len_bounded(ptr, i64)
declare void @__mtrt_store_dent64(ptr, i64, i64, i8, ptr, i64)
declare i64 @__mtrt_linux_open_flags_to_native(i64)
declare i64 @__mtrt_linux_dirfd_to_native(i64)
declare i64 @__mtrt_linux_access_mode_to_native(i64)
declare i64 @__mtrt_linux_mode_to_native(i64)
declare i64 @__mtrt_linux_at_flags_to_native(i64)
declare i64 @__mtrt_linux_prot_to_native(i64)
declare i64 @__mtrt_linux_mmap_flags_to_native(i64)
declare i64 @__mtrt_linux_msync_flags_to_native(i64)
declare i64 @__mtrt_linux_madvise_to_native(i64)
declare i64 @__mtrt_linux_lseek_to_native(i64)
declare i64 @__mtrt_linux_wait_options_to_native(i64)
declare i64 @__mtrt_linux_pipe2_flags_to_native(i64)

define internal i64 @__mtrt_linux_result_to_target(i64 %result) {
entry:
  %failed = icmp slt i64 %result, 0
  %native = sub i64 0, %result
  %known = icmp ule i64 %native, 133
  %target_error = select i1 %known, i64 %result, i64 -5
  %target = select i1 %failed, i64 %target_error, i64 %result
  ret i64 %target
}

define internal i64 @__mtrt_linux_syscall0(i64 %nr) {
entry:
  %ret = call i64 asm sideeffect "syscall", "={rax},{rax},~{rcx},~{r11},~{memory}"(i64 %nr)
  %target = call i64 @__mtrt_linux_result_to_target(i64 %ret)
  ret i64 %target
}

define internal i64 @__mtrt_linux_syscall1(i64 %nr, i64 %a1) {
entry:
  %ret = call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},~{rcx},~{r11},~{memory}"(i64 %nr, i64 %a1)
  %target = call i64 @__mtrt_linux_result_to_target(i64 %ret)
  ret i64 %target
}

define internal i64 @__mtrt_linux_syscall2(i64 %nr, i64 %a1, i64 %a2) {
entry:
  %ret = call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},{rsi},~{rcx},~{r11},~{memory}"(i64 %nr, i64 %a1, i64 %a2)
  %target = call i64 @__mtrt_linux_result_to_target(i64 %ret)
  ret i64 %target
}

define internal i64 @__mtrt_linux_syscall3(i64 %nr, i64 %a1, i64 %a2, i64 %a3) {
entry:
  %ret = call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},{rsi},{rdx},~{rcx},~{r11},~{memory}"(i64 %nr, i64 %a1, i64 %a2, i64 %a3)
  %target = call i64 @__mtrt_linux_result_to_target(i64 %ret)
  ret i64 %target
}

define internal i64 @__mtrt_linux_syscall4(i64 %nr, i64 %a1, i64 %a2, i64 %a3, i64 %a4) {
entry:
  %ret = call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},{rsi},{rdx},{r10},~{rcx},~{r11},~{memory}"(i64 %nr, i64 %a1, i64 %a2, i64 %a3, i64 %a4)
  %target = call i64 @__mtrt_linux_result_to_target(i64 %ret)
  ret i64 %target
}

define internal i64 @__mtrt_linux_syscall5(i64 %nr, i64 %a1, i64 %a2, i64 %a3, i64 %a4, i64 %a5) {
entry:
  %ret = call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},{rsi},{rdx},{r10},{r8},~{rcx},~{r11},~{memory}"(i64 %nr, i64 %a1, i64 %a2, i64 %a3, i64 %a4, i64 %a5)
  %target = call i64 @__mtrt_linux_result_to_target(i64 %ret)
  ret i64 %target
}

define internal i64 @__mtrt_linux_syscall6(i64 %nr, i64 %a1, i64 %a2, i64 %a3, i64 %a4, i64 %a5, i64 %a6) {
entry:
  %ret = call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},{rsi},{rdx},{r10},{r8},{r9},~{rcx},~{r11},~{memory}"(i64 %nr, i64 %a1, i64 %a2, i64 %a3, i64 %a4, i64 %a5, i64 %a6)
  %target = call i64 @__mtrt_linux_result_to_target(i64 %ret)
  ret i64 %target
}

define internal i64 @__mtrt_linux_copy_checked(ptr %dst, ptr %src, i64 %len) {
entry:
  %zero = icmp eq i64 %len, 0
  br i1 %zero, label %done, label %open_pipe

open_pipe:
  %fds = alloca [2 x i32], align 4
  %fds_i = ptrtoint ptr %fds to i64
  %opened = call i64 @__mtrt_linux_syscall2(i64 293, i64 %fds_i, i64 0)
  %open_ok = icmp eq i64 %opened, 0
  br i1 %open_ok, label %write_source, label %fault

write_source:
  %read_fd_p = getelementptr inbounds [2 x i32], ptr %fds, i32 0, i32 0
  %write_fd_p = getelementptr inbounds [2 x i32], ptr %fds, i32 0, i32 1
  %read_fd32 = load i32, ptr %read_fd_p, align 4
  %write_fd32 = load i32, ptr %write_fd_p, align 4
  %read_fd = sext i32 %read_fd32 to i64
  %write_fd = sext i32 %write_fd32 to i64
  %src_i = ptrtoint ptr %src to i64
  %written = call i64 @__mtrt_linux_syscall3(i64 1, i64 %write_fd, i64 %src_i, i64 %len)
  %write_ok = icmp eq i64 %written, %len
  br i1 %write_ok, label %read_target, label %fault_close

read_target:
  %dst_i = ptrtoint ptr %dst to i64
  %read = call i64 @__mtrt_linux_syscall3(i64 0, i64 %read_fd, i64 %dst_i, i64 %len)
  %read_ok = icmp eq i64 %read, %len
  br i1 %read_ok, label %close_done, label %fault_close

close_done:
  %close_read = call i64 @__mtrt_linux_syscall1(i64 3, i64 %read_fd)
  %close_write = call i64 @__mtrt_linux_syscall1(i64 3, i64 %write_fd)
  br label %done

fault_close:
  %fault_close_read = call i64 @__mtrt_linux_syscall1(i64 3, i64 %read_fd)
  %fault_close_write = call i64 @__mtrt_linux_syscall1(i64 3, i64 %write_fd)
  br label %fault

done:
  ret i64 0

fault:
  ret i64 -14
}

define internal i64 @__mtrt_linux_copy_from_target(ptr %dst, ptr %src, i64 %len) {
entry:
  %result = call i64 @__mtrt_linux_copy_checked(ptr %dst, ptr %src, i64 %len)
  ret i64 %result
}

define internal i64 @__mtrt_linux_copy_to_target(ptr %dst, ptr %src, i64 %len) {
entry:
  %result = call i64 @__mtrt_linux_copy_checked(ptr %dst, ptr %src, i64 %len)
  ret i64 %result
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
  %target_stat = alloca [120 x i8], align 8
  call void @__mtrt_linux_store_statx(ptr %target_stat, ptr %sx)
  %copy = call i64 @__mtrt_linux_copy_to_target(ptr %buf, ptr %target_stat, i64 120)
  ret i64 %copy

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


define hidden i64 @__mtrt_host_tcgetattr(i64 %fd, ptr %termios) {
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
  %target_termios = alloca [72 x i8], align 8
  call void @__mtrt_linux_store_target_termios(ptr %target_termios, ptr %native)
  %copy = call i64 @__mtrt_linux_copy_to_target(ptr %termios, ptr %target_termios, i64 72)
  ret i64 %copy

done:
  ret i64 %r
}

define hidden i64 @__mtrt_host_isatty(i64 %fd) {
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

define hidden i64 @__mtrt_host_tcsetattr(i64 %fd, i64 %action, ptr %termios) {
entry:
  %is_null = icmp eq ptr %termios, null
  br i1 %is_null, label %fault, label %map_action

fault:
  ret i64 -14

map_action:
  %request = call i64 @__mtrt_linux_tcsetattr_request(i64 %action)
  %bad_action = icmp eq i64 %request, -1
  br i1 %bad_action, label %invalid, label %copy_termios

invalid:
  ret i64 -22

copy_termios:
  %target_termios = alloca [72 x i8], align 8
  %copy = call i64 @__mtrt_linux_copy_from_target(ptr %target_termios, ptr %termios, i64 72)
  %copy_ok = icmp eq i64 %copy, 0
  br i1 %copy_ok, label %validate, label %fault

validate:
  %valid = call i1 @__mtrt_linux_termios_target_valid(ptr %target_termios)
  br i1 %valid, label %read_native, label %invalid

read_native:
  %native = alloca [36 x i8], align 4
  %get = call i64 @__mtrt_linux_ioctl_ptr(i64 %fd, i64 21505, ptr %native)
  %get_ok = icmp eq i64 %get, 0
  br i1 %get_ok, label %overlay, label %done

overlay:
  call void @__mtrt_linux_overlay_native_termios(ptr %native, ptr %target_termios)
  %set = call i64 @__mtrt_linux_ioctl_ptr(i64 %fd, i64 %request, ptr %native)
  ret i64 %set

done:
  ret i64 %get
}

define hidden i64 @__mtrt_host_tcdrain(i64 %fd) {
entry:
  %r = call i64 @__mtrt_linux_ioctl_int(i64 %fd, i64 21513, i64 1)
  ret i64 %r
}

declare i64 @__mtrt_linux_tcflow_action(i64 %action)


define hidden i64 @__mtrt_host_tcflow(i64 %fd, i64 %action) {
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


define hidden i64 @__mtrt_host_tcflush(i64 %fd, i64 %selector) {
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

define hidden i64 @__mtrt_host_tcsendbreak(i64 %fd, i64 %duration) {
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

define hidden i64 @__mtrt_host_tcgetpgrp(i64 %fd) {
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

define hidden i64 @__mtrt_host_tcsetpgrp(i64 %fd, i64 %pgrp) {
entry:
  %slot = alloca i32, align 4
  %pgrp32 = trunc i64 %pgrp to i32
  store i32 %pgrp32, ptr %slot, align 4
  %r = call i64 @__mtrt_linux_ioctl_ptr(i64 %fd, i64 21520, ptr %slot)
  ret i64 %r
}

define hidden i64 @__mtrt_host_getpid() {
  %r = call i64 @__mtrt_linux_syscall0(i64 39)
  ret i64 %r
}

define hidden i64 @__mtrt_host_getppid() {
  %r = call i64 @__mtrt_linux_syscall0(i64 110)
  ret i64 %r
}

define hidden i64 @__mtrt_host_getuid() {
  %r = call i64 @__mtrt_linux_syscall0(i64 102)
  ret i64 %r
}

define hidden i64 @__mtrt_host_geteuid() {
  %r = call i64 @__mtrt_linux_syscall0(i64 107)
  ret i64 %r
}

define hidden i64 @__mtrt_host_getgid() {
  %r = call i64 @__mtrt_linux_syscall0(i64 104)
  ret i64 %r
}

define hidden i64 @__mtrt_host_fork() {
  %r = call i64 @__mtrt_linux_syscall0(i64 57)
  ret i64 %r
}

declare i32 @__mtrt_linux_wait_status_from_native(i32 %status)


define hidden i64 @__mtrt_host_wait4(i64 %pid, ptr %status, i64 %options) {
entry:
  %native_options = call i64 @__mtrt_linux_wait_options_to_native(i64 %options)
  %status_i = ptrtoint ptr %status to i64
  %r = call i64 @__mtrt_linux_syscall4(i64 61, i64 %pid, i64 %status_i, i64 %native_options, i64 0)
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

define hidden void @__mtrt_host_exit(i64 %status) {
  %_ = call i64 @__mtrt_linux_syscall1(i64 60, i64 %status)
  unreachable
}

define hidden i64 @__mtrt_host_write(i64 %fd, ptr %buf, i64 %count) {
  %buf_i = ptrtoint ptr %buf to i64
  %r = call i64 @__mtrt_linux_syscall3(i64 1, i64 %fd, i64 %buf_i, i64 %count)
  ret i64 %r
}

define hidden i64 @__mtrt_host_read(i64 %fd, ptr %buf, i64 %count) {
  %buf_i = ptrtoint ptr %buf to i64
  %r = call i64 @__mtrt_linux_syscall3(i64 0, i64 %fd, i64 %buf_i, i64 %count)
  ret i64 %r
}

define hidden i64 @__mtrt_host_close(i64 %fd) {
  %r = call i64 @__mtrt_linux_syscall1(i64 3, i64 %fd)
  ret i64 %r
}

define hidden i64 @__mtrt_host_nanosleep(ptr %req, ptr %rem) {
  %req_i = ptrtoint ptr %req to i64
  %rem_i = ptrtoint ptr %rem to i64
  %r = call i64 @__mtrt_linux_syscall2(i64 35, i64 %req_i, i64 %rem_i)
  ret i64 %r
}

declare i64 @__mtrt_linux_clockid_from_target(i64 %clockid)


define hidden i64 @__mtrt_host_clock_gettime(i64 %clockid, ptr %tp) {
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

define internal void @__mtrt_linux_build_ucontext_v1(ptr %target_context) {
entry:
  %native_mask_p = alloca i64, align 8
  %native_stack = alloca [24 x i8], align 8
  store i64 0, ptr %native_mask_p, align 8
  store i64 0, ptr %native_stack, align 8
  %native_stack_flags_p = getelementptr i8, ptr %native_stack, i64 8
  store i32 0, ptr %native_stack_flags_p, align 4
  %native_stack_size_p = getelementptr i8, ptr %native_stack, i64 16
  store i64 0, ptr %native_stack_size_p, align 8
  %mask_i = ptrtoint ptr %native_mask_p to i64
  %mask_r = call i64 @__mtrt_linux_syscall4(i64 14, i64 0, i64 0, i64 %mask_i, i64 8)
  %stack_i = ptrtoint ptr %native_stack to i64
  %stack_r = call i64 @__mtrt_linux_syscall2(i64 131, i64 0, i64 %stack_i)
  %native_mask = load i64, ptr %native_mask_p, align 8
  %mask_ok = icmp eq i64 %mask_r, 0
  %target_mask_value = call i64 @__mtrt_linux_sigset_from_native(i64 %native_mask)
  %target_mask = select i1 %mask_ok, i64 %target_mask_value, i64 0
  %stack_address = load i64, ptr %native_stack, align 8
  %stack_flags32 = load i32, ptr %native_stack_flags_p, align 4
  %stack_flags = and i32 %stack_flags32, 3
  %stack_size = load i64, ptr %native_stack_size_p, align 8
  %stack_ok = icmp eq i64 %stack_r, 0
  %target_stack_address = select i1 %stack_ok, i64 %stack_address, i64 0
  %target_stack_size = select i1 %stack_ok, i64 %stack_size, i64 0
  %target_stack_flags = select i1 %stack_ok, i32 %stack_flags, i32 0
  store i64 1, ptr %target_context, align 8
  %mask_out = getelementptr i8, ptr %target_context, i64 8
  store i64 %target_mask, ptr %mask_out, align 8
  %stack_address_out = getelementptr i8, ptr %target_context, i64 16
  store i64 %target_stack_address, ptr %stack_address_out, align 8
  %stack_size_out = getelementptr i8, ptr %target_context, i64 24
  store i64 %target_stack_size, ptr %stack_size_out, align 8
  %stack_flags_out = getelementptr i8, ptr %target_context, i64 32
  store i32 %target_stack_flags, ptr %stack_flags_out, align 4
  %reserved_out = getelementptr i8, ptr %target_context, i64 36
  store i32 0, ptr %reserved_out, align 4
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
  %target_context = alloca [40 x i8], align 8
  call void @__mtrt_linux_build_ucontext_v1(ptr %target_context)
  %native_info_null = icmp eq ptr %native_info, null
  br i1 %native_info_null, label %call_siginfo_handler, label %copy_siginfo

copy_siginfo:
  call void @__mtrt_linux_siginfo_to_target(ptr %target_info, ptr %native_info)
  br label %call_siginfo_handler

call_siginfo_handler:
  %info_arg = phi ptr [ null, %call_siginfo ], [ %target_info, %copy_siginfo ]
  %handler3 = inttoptr i64 %handler_i to ptr
  %target_sig32_info = trunc i64 %target_sig to i32
  call void %handler3(i32 %target_sig32_info, ptr %info_arg, ptr %target_context)
  br label %done

done:
  ret void
}

define internal void @__mtrt_linux_dispatch_any(i32 %native_sig32, ptr %native_info, ptr %ucontext) {
entry:
  %native_sig = zext i32 %native_sig32 to i64
  %target_sig = call i64 @__mtrt_linux_signal_from_native(i64 %native_sig)
  %handler_slot = getelementptr inbounds [23 x i64], ptr @__mtrt_linux_target_handlers, i64 0, i64 %target_sig
  %flags_slot = getelementptr inbounds [23 x i64], ptr @__mtrt_linux_target_flags, i64 0, i64 %target_sig
  call void @__mtrt_linux_dispatch_target_signal(i64 %target_sig, ptr %handler_slot, ptr %flags_slot, ptr %native_info, ptr %ucontext)
  ret void
}

define internal i64 @__mtrt_linux_sigaction_dispatcher(i64 %sig) {
entry:
  %dispatcher = ptrtoint ptr @__mtrt_linux_dispatch_any to i64
  ret i64 %dispatcher
}

define internal i64 @__mtrt_linux_load_target_handler(i64 %sig) {
entry:
  %slot = getelementptr inbounds [23 x i64], ptr @__mtrt_linux_target_handlers, i64 0, i64 %sig
  %handler = load i64, ptr %slot, align 8
  ret i64 %handler
}

define internal i64 @__mtrt_linux_load_target_flags(i64 %sig) {
entry:
  %slot = getelementptr inbounds [23 x i64], ptr @__mtrt_linux_target_flags, i64 0, i64 %sig
  %flags = load i64, ptr %slot, align 8
  ret i64 %flags
}

define internal void @__mtrt_linux_store_target_action(i64 %sig, i64 %handler, i64 %flags) {
entry:
  %handler_slot = getelementptr inbounds [23 x i64], ptr @__mtrt_linux_target_handlers, i64 0, i64 %sig
  %flags_slot = getelementptr inbounds [23 x i64], ptr @__mtrt_linux_target_flags, i64 0, i64 %sig
  store i64 %handler, ptr %handler_slot, align 8
  store i64 %flags, ptr %flags_slot, align 8
  ret void
}

define internal i64 @__mtrt_linux_sigaction_handler_from_native(i64 %sig, i64 %native_handler, i64 %previous_handler) {
entry:
  %dispatcher = call i64 @__mtrt_linux_sigaction_dispatcher(i64 %sig)
  %is_dispatcher = icmp eq i64 %native_handler, %dispatcher
  %handler = select i1 %is_dispatcher, i64 %previous_handler, i64 %native_handler
  ret i64 %handler
}

define hidden i64 @__mtrt_host_kill(i64 %pid, i64 %sig) {
  %native_sig = call i64 @__mtrt_linux_signal_to_native(i64 %sig)
  %bad_sig = icmp slt i64 %native_sig, 0
  br i1 %bad_sig, label %invalid, label %call_kill

invalid:
  ret i64 %native_sig

call_kill:
  %r = call i64 @__mtrt_linux_syscall2(i64 62, i64 %pid, i64 %native_sig)
  ret i64 %r
}

define hidden i64 @__mtrt_host_dup(i64 %oldfd) {
  %r = call i64 @__mtrt_linux_syscall1(i64 32, i64 %oldfd)
  ret i64 %r
}

define hidden i64 @__mtrt_host_dup2(i64 %oldfd, i64 %newfd) {
  %r = call i64 @__mtrt_linux_syscall2(i64 33, i64 %oldfd, i64 %newfd)
  ret i64 %r
}

define hidden i64 @__mtrt_host_chdir(ptr %path) {
  %path_i = ptrtoint ptr %path to i64
  %r = call i64 @__mtrt_linux_syscall1(i64 80, i64 %path_i)
  ret i64 %r
}

define hidden i64 @__mtrt_host_fchdir(i64 %fd) {
  %r = call i64 @__mtrt_linux_syscall1(i64 81, i64 %fd)
  ret i64 %r
}

define hidden i64 @__mtrt_host_getpgid(i64 %pid) {
  %r = call i64 @__mtrt_linux_syscall1(i64 121, i64 %pid)
  ret i64 %r
}

define hidden i64 @__mtrt_host_getpgrp() {
  %r = call i64 @__mtrt_linux_syscall0(i64 111)
  ret i64 %r
}

define hidden i64 @__mtrt_host_getsid(i64 %pid) {
  %r = call i64 @__mtrt_linux_syscall1(i64 124, i64 %pid)
  ret i64 %r
}

define hidden i64 @__mtrt_host_setpgid(i64 %pid, i64 %pgid) {
  %r = call i64 @__mtrt_linux_syscall2(i64 109, i64 %pid, i64 %pgid)
  ret i64 %r
}

define hidden i64 @__mtrt_host_setsid() {
  %r = call i64 @__mtrt_linux_syscall0(i64 112)
  ret i64 %r
}

define hidden i64 @__mtrt_host_umask(i64 %mask) {
  %native_mask = call i64 @__mtrt_linux_mode_to_native(i64 %mask)
  %r = call i64 @__mtrt_linux_syscall1(i64 95, i64 %native_mask)
  ret i64 %r
}

define hidden i64 @__mtrt_host_pipe(ptr %fds) {
  %fds_i = ptrtoint ptr %fds to i64
  %r = call i64 @__mtrt_linux_syscall1(i64 22, i64 %fds_i)
  ret i64 %r
}

define internal i64 @__mtrt_linux_iovec_from_target(ptr %target, i64 %count, ptr %native) {
entry:
  %target_entry = alloca [16 x i8], align 8
  br label %loop

loop:
  %i = phi i64 [ 0, %entry ], [ %next, %store ]
  %done = icmp uge i64 %i, %count
  br i1 %done, label %return, label %copy

copy:
  %offset = mul i64 %i, 16
  %target_base_p = getelementptr i8, ptr %target, i64 %offset
  %copied = call i64 @__mtrt_linux_copy_from_target(ptr %target_entry, ptr %target_base_p, i64 16)
  %copy_ok = icmp eq i64 %copied, 0
  br i1 %copy_ok, label %store, label %fault

store:
  %target_len_p = getelementptr i8, ptr %target_entry, i64 8
  %base_i = load i64, ptr %target_entry, align 8
  %len = load i64, ptr %target_len_p, align 8
  %native_base_p = getelementptr i8, ptr %native, i64 %offset
  %native_len_p = getelementptr i8, ptr %native_base_p, i64 8
  %base = inttoptr i64 %base_i to ptr
  store ptr %base, ptr %native_base_p, align 8
  store i64 %len, ptr %native_len_p, align 8
  %next = add i64 %i, 1
  br label %loop

fault:
  ret i64 -14

return:
  ret i64 0
}

define hidden i64 @__mtrt_host_readv(i64 %fd, ptr %iov, i64 %iovcnt) {
  %native_iov = alloca [16 x i8], i64 %iovcnt, align 8
  %copied = call i64 @__mtrt_linux_iovec_from_target(ptr %iov, i64 %iovcnt, ptr %native_iov)
  %copy_ok = icmp eq i64 %copied, 0
  br i1 %copy_ok, label %call_readv, label %fault

call_readv:
  %iov_i = ptrtoint ptr %native_iov to i64
  %r = call i64 @__mtrt_linux_syscall3(i64 19, i64 %fd, i64 %iov_i, i64 %iovcnt)
  ret i64 %r

fault:
  ret i64 -14
}

define hidden i64 @__mtrt_host_writev(i64 %fd, ptr %iov, i64 %iovcnt) {
  %native_iov = alloca [16 x i8], i64 %iovcnt, align 8
  %copied = call i64 @__mtrt_linux_iovec_from_target(ptr %iov, i64 %iovcnt, ptr %native_iov)
  %copy_ok = icmp eq i64 %copied, 0
  br i1 %copy_ok, label %call_writev, label %fault

call_writev:
  %iov_i = ptrtoint ptr %native_iov to i64
  %r = call i64 @__mtrt_linux_syscall3(i64 20, i64 %fd, i64 %iov_i, i64 %iovcnt)
  ret i64 %r

fault:
  ret i64 -14
}

define hidden i64 @__mtrt_host_open(ptr %path, i64 %flags, i64 %mode) {
  %native_flags = call i64 @__mtrt_linux_open_flags_to_native(i64 %flags)
  %native_mode = call i64 @__mtrt_linux_mode_to_native(i64 %mode)
  %path_i = ptrtoint ptr %path to i64
  %r = call i64 @__mtrt_linux_syscall3(i64 2, i64 %path_i, i64 %native_flags, i64 %native_mode)
  ret i64 %r
}

define hidden i64 @__mtrt_host_openat(i64 %dirfd, ptr %path, i64 %flags, i64 %mode) {
  %native_dirfd = call i64 @__mtrt_linux_dirfd_to_native(i64 %dirfd)
  %native_flags = call i64 @__mtrt_linux_open_flags_to_native(i64 %flags)
  %native_mode = call i64 @__mtrt_linux_mode_to_native(i64 %mode)
  %path_i = ptrtoint ptr %path to i64
  %r = call i64 @__mtrt_linux_syscall4(i64 257, i64 %native_dirfd, i64 %path_i, i64 %native_flags, i64 %native_mode)
  ret i64 %r
}

define hidden i64 @__mtrt_host_posix_getdents(i64 %fd, ptr %buf, i64 %nbyte, i64 %flags) {
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

define hidden i64 @__mtrt_host_lseek(i64 %fd, i64 %offset, i64 %whence) {
  %native_whence = call i64 @__mtrt_linux_lseek_to_native(i64 %whence)
  %r = call i64 @__mtrt_linux_syscall3(i64 8, i64 %fd, i64 %offset, i64 %native_whence)
  ret i64 %r
}

define hidden i64 @__mtrt_host_pread(i64 %fd, ptr %buf, i64 %count, i64 %offset) {
  %buf_i = ptrtoint ptr %buf to i64
  %r = call i64 @__mtrt_linux_syscall4(i64 17, i64 %fd, i64 %buf_i, i64 %count, i64 %offset)
  ret i64 %r
}

define hidden i64 @__mtrt_host_pwrite(i64 %fd, ptr %buf, i64 %count, i64 %offset) {
  %buf_i = ptrtoint ptr %buf to i64
  %r = call i64 @__mtrt_linux_syscall4(i64 18, i64 %fd, i64 %buf_i, i64 %count, i64 %offset)
  ret i64 %r
}

define hidden i64 @__mtrt_host_unlink(ptr %path) {
  %path_i = ptrtoint ptr %path to i64
  %r = call i64 @__mtrt_linux_syscall1(i64 87, i64 %path_i)
  ret i64 %r
}

define hidden i64 @__mtrt_host_unlinkat(i64 %dirfd, ptr %path, i64 %flags) {
  %native_dirfd = call i64 @__mtrt_linux_dirfd_to_native(i64 %dirfd)
  %native_flags = call i64 @__mtrt_linux_at_flags_to_native(i64 %flags)
  %path_i = ptrtoint ptr %path to i64
  %r = call i64 @__mtrt_linux_syscall3(i64 263, i64 %native_dirfd, i64 %path_i, i64 %native_flags)
  ret i64 %r
}

define hidden i64 @__mtrt_host_access(ptr %path, i64 %mode) {
  %native_mode = call i64 @__mtrt_linux_access_mode_to_native(i64 %mode)
  %path_i = ptrtoint ptr %path to i64
  %r = call i64 @__mtrt_linux_syscall2(i64 21, i64 %path_i, i64 %native_mode)
  ret i64 %r
}

define hidden i64 @__mtrt_host_faccessat(i64 %dirfd, ptr %path, i64 %mode, i64 %flags) {
  %native_dirfd = call i64 @__mtrt_linux_dirfd_to_native(i64 %dirfd)
  %native_mode = call i64 @__mtrt_linux_access_mode_to_native(i64 %mode)
  %native_flags = call i64 @__mtrt_linux_at_flags_to_native(i64 %flags)
  %path_i = ptrtoint ptr %path to i64
  %r = call i64 @__mtrt_linux_syscall4(i64 439, i64 %native_dirfd, i64 %path_i, i64 %native_mode, i64 %native_flags)
  ret i64 %r
}

define hidden i64 @__mtrt_host_chmod(ptr %path, i64 %mode) {
  %native_mode = call i64 @__mtrt_linux_mode_to_native(i64 %mode)
  %path_i = ptrtoint ptr %path to i64
  %r = call i64 @__mtrt_linux_syscall2(i64 90, i64 %path_i, i64 %native_mode)
  ret i64 %r
}

define hidden i64 @__mtrt_host_fchmod(i64 %fd, i64 %mode) {
  %native_mode = call i64 @__mtrt_linux_mode_to_native(i64 %mode)
  %r = call i64 @__mtrt_linux_syscall2(i64 91, i64 %fd, i64 %native_mode)
  ret i64 %r
}

define hidden i64 @__mtrt_host_fchmodat(i64 %dirfd, ptr %path, i64 %mode, i64 %flags) {
  %native_dirfd = call i64 @__mtrt_linux_dirfd_to_native(i64 %dirfd)
  %native_mode = call i64 @__mtrt_linux_mode_to_native(i64 %mode)
  %native_flags = call i64 @__mtrt_linux_at_flags_to_native(i64 %flags)
  %path_i = ptrtoint ptr %path to i64
  %has_flags = icmp ne i64 %native_flags, 0
  br i1 %has_flags, label %call_fchmodat2, label %call_fchmodat

call_fchmodat:
  %legacy = call i64 @__mtrt_linux_syscall3(i64 268, i64 %native_dirfd, i64 %path_i, i64 %native_mode)
  ret i64 %legacy

call_fchmodat2:
  %modern = call i64 @__mtrt_linux_syscall4(i64 452, i64 %native_dirfd, i64 %path_i, i64 %native_mode, i64 %native_flags)
  ret i64 %modern
}

define hidden i64 @__mtrt_host_link(ptr %oldpath, ptr %newpath) {
  %oldpath_i = ptrtoint ptr %oldpath to i64
  %newpath_i = ptrtoint ptr %newpath to i64
  %r = call i64 @__mtrt_linux_syscall2(i64 86, i64 %oldpath_i, i64 %newpath_i)
  ret i64 %r
}

define hidden i64 @__mtrt_host_linkat(i64 %olddirfd, ptr %oldpath, i64 %newdirfd, ptr %newpath, i64 %flags) {
  %native_olddirfd = call i64 @__mtrt_linux_dirfd_to_native(i64 %olddirfd)
  %native_newdirfd = call i64 @__mtrt_linux_dirfd_to_native(i64 %newdirfd)
  %native_flags = call i64 @__mtrt_linux_at_flags_to_native(i64 %flags)
  %oldpath_i = ptrtoint ptr %oldpath to i64
  %newpath_i = ptrtoint ptr %newpath to i64
  %r = call i64 @__mtrt_linux_syscall5(i64 265, i64 %native_olddirfd, i64 %oldpath_i, i64 %native_newdirfd, i64 %newpath_i, i64 %native_flags)
  ret i64 %r
}

define hidden i64 @__mtrt_host_mkdir(ptr %path, i64 %mode) {
  %native_mode = call i64 @__mtrt_linux_mode_to_native(i64 %mode)
  %path_i = ptrtoint ptr %path to i64
  %r = call i64 @__mtrt_linux_syscall2(i64 83, i64 %path_i, i64 %native_mode)
  ret i64 %r
}

define hidden i64 @__mtrt_host_mkdirat(i64 %dirfd, ptr %path, i64 %mode) {
  %native_dirfd = call i64 @__mtrt_linux_dirfd_to_native(i64 %dirfd)
  %native_mode = call i64 @__mtrt_linux_mode_to_native(i64 %mode)
  %path_i = ptrtoint ptr %path to i64
  %r = call i64 @__mtrt_linux_syscall3(i64 258, i64 %native_dirfd, i64 %path_i, i64 %native_mode)
  ret i64 %r
}

define hidden i64 @__mtrt_host_mkfifo(ptr %path, i64 %mode) {
  %path_i = ptrtoint ptr %path to i64
  %perm = call i64 @__mtrt_linux_mode_to_native(i64 %mode)
  %fifo_mode = or i64 %perm, 4096
  %r = call i64 @__mtrt_linux_syscall4(i64 259, i64 -100, i64 %path_i, i64 %fifo_mode, i64 0)
  ret i64 %r
}

define hidden i64 @__mtrt_host_readlink(ptr %path, ptr %buf, i64 %size) {
  %path_i = ptrtoint ptr %path to i64
  %buf_i = ptrtoint ptr %buf to i64
  %r = call i64 @__mtrt_linux_syscall3(i64 89, i64 %path_i, i64 %buf_i, i64 %size)
  ret i64 %r
}

define hidden i64 @__mtrt_host_readlinkat(i64 %dirfd, ptr %path, ptr %buf, i64 %size) {
  %native_dirfd = call i64 @__mtrt_linux_dirfd_to_native(i64 %dirfd)
  %path_i = ptrtoint ptr %path to i64
  %buf_i = ptrtoint ptr %buf to i64
  %r = call i64 @__mtrt_linux_syscall4(i64 267, i64 %native_dirfd, i64 %path_i, i64 %buf_i, i64 %size)
  ret i64 %r
}

define hidden i64 @__mtrt_host_rename(ptr %oldpath, ptr %newpath) {
  %oldpath_i = ptrtoint ptr %oldpath to i64
  %newpath_i = ptrtoint ptr %newpath to i64
  %r = call i64 @__mtrt_linux_syscall2(i64 82, i64 %oldpath_i, i64 %newpath_i)
  ret i64 %r
}

define hidden i64 @__mtrt_host_renameat(i64 %olddirfd, ptr %oldpath, i64 %newdirfd, ptr %newpath) {
  %native_olddirfd = call i64 @__mtrt_linux_dirfd_to_native(i64 %olddirfd)
  %native_newdirfd = call i64 @__mtrt_linux_dirfd_to_native(i64 %newdirfd)
  %oldpath_i = ptrtoint ptr %oldpath to i64
  %newpath_i = ptrtoint ptr %newpath to i64
  %r = call i64 @__mtrt_linux_syscall4(i64 264, i64 %native_olddirfd, i64 %oldpath_i, i64 %native_newdirfd, i64 %newpath_i)
  ret i64 %r
}

define hidden i64 @__mtrt_host_rmdir(ptr %path) {
  %path_i = ptrtoint ptr %path to i64
  %r = call i64 @__mtrt_linux_syscall1(i64 84, i64 %path_i)
  ret i64 %r
}

define hidden i64 @__mtrt_host_symlink(ptr %target, ptr %linkpath) {
  %target_i = ptrtoint ptr %target to i64
  %linkpath_i = ptrtoint ptr %linkpath to i64
  %r = call i64 @__mtrt_linux_syscall2(i64 88, i64 %target_i, i64 %linkpath_i)
  ret i64 %r
}

define hidden i64 @__mtrt_host_symlinkat(ptr %target, i64 %newdirfd, ptr %linkpath) {
  %native_newdirfd = call i64 @__mtrt_linux_dirfd_to_native(i64 %newdirfd)
  %target_i = ptrtoint ptr %target to i64
  %linkpath_i = ptrtoint ptr %linkpath to i64
  %r = call i64 @__mtrt_linux_syscall3(i64 266, i64 %target_i, i64 %native_newdirfd, i64 %linkpath_i)
  ret i64 %r
}

define hidden i64 @__mtrt_host_stat(ptr %path, ptr %buf) {
  %r = call i64 @__mtrt_linux_statx_to_target(i64 -100, ptr %path, i64 0, ptr %buf)
  ret i64 %r
}

define hidden i64 @__mtrt_host_fstat(i64 %fd, ptr %buf) {
  %r = call i64 @__mtrt_linux_statx_to_target(i64 %fd, ptr @.mtrt_empty_path, i64 4096, ptr %buf)
  ret i64 %r
}

define hidden i64 @__mtrt_host_lstat(ptr %path, ptr %buf) {
  %r = call i64 @__mtrt_linux_statx_to_target(i64 -100, ptr %path, i64 256, ptr %buf)
  ret i64 %r
}

define hidden i64 @__mtrt_host_fstatat(i64 %dirfd, ptr %path, ptr %buf, i64 %flags) {
  %native_dirfd = call i64 @__mtrt_linux_dirfd_to_native(i64 %dirfd)
  %native_flags = call i64 @__mtrt_linux_at_flags_to_native(i64 %flags)
  %r = call i64 @__mtrt_linux_statx_to_target(i64 %native_dirfd, ptr %path, i64 %native_flags, ptr %buf)
  ret i64 %r
}

define hidden i64 @__mtrt_host_ftruncate(i64 %fd, i64 %length) {
  %r = call i64 @__mtrt_linux_syscall2(i64 77, i64 %fd, i64 %length)
  ret i64 %r
}

define hidden i64 @__mtrt_host_chown(ptr %path, i64 %uid, i64 %gid) {
  %path_i = ptrtoint ptr %path to i64
  %r = call i64 @__mtrt_linux_syscall3(i64 92, i64 %path_i, i64 %uid, i64 %gid)
  ret i64 %r
}

define hidden i64 @__mtrt_host_clock_getres(i64 %clockid, ptr %tp) {
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

define hidden i64 @__mtrt_host_clock_settime(i64 %clockid, ptr %tp) {
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

define hidden i64 @__mtrt_host_execve(ptr %path, ptr %argv, ptr %envp) {
  %path_i = ptrtoint ptr %path to i64
  %argv_i = ptrtoint ptr %argv to i64
  %envp_i = ptrtoint ptr %envp to i64
  %r = call i64 @__mtrt_linux_syscall3(i64 59, i64 %path_i, i64 %argv_i, i64 %envp_i)
  ret i64 %r
}

define hidden i64 @__mtrt_host_fchown(i64 %fd, i64 %uid, i64 %gid) {
  %r = call i64 @__mtrt_linux_syscall3(i64 93, i64 %fd, i64 %uid, i64 %gid)
  ret i64 %r
}

define hidden i64 @__mtrt_host_fchownat(i64 %dirfd, ptr %path, i64 %uid, i64 %gid, i64 %flags) {
  %native_dirfd = call i64 @__mtrt_linux_dirfd_to_native(i64 %dirfd)
  %native_flags = call i64 @__mtrt_linux_at_flags_to_native(i64 %flags)
  %path_i = ptrtoint ptr %path to i64
  %r = call i64 @__mtrt_linux_syscall5(i64 260, i64 %native_dirfd, i64 %path_i, i64 %uid, i64 %gid, i64 %native_flags)
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


define hidden i64 @__mtrt_host_fcntl(i64 %fd, i64 %cmd, i64 %arg) {
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
  %target_flock_scratch = alloca [32 x i8], align 8
  %native_flock = alloca [32 x i8], align 8
  %input_copied = call i64 @__mtrt_linux_copy_from_target(ptr %target_flock_scratch, ptr %target_flock, i64 32)
  %input_copy_bad = icmp slt i64 %input_copied, 0
  br i1 %input_copy_bad, label %input_copy_done, label %prepare_lock

prepare_lock:
  %prep = call i64 @__mtrt_linux_flock_target_to_native(ptr %target_flock_scratch, ptr %native_flock)
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
  %translated = call i64 @__mtrt_linux_flock_native_to_target(ptr %target_flock_scratch, ptr %native_flock)
  %translate_bad = icmp slt i64 %translated, 0
  br i1 %translate_bad, label %translate_done, label %copy_target_lock

copy_target_lock:
  %copy = call i64 @__mtrt_linux_copy_to_target(ptr %target_flock, ptr %target_flock_scratch, i64 32)
  ret i64 %copy

translate_done:
  ret i64 %translated

lock_done:
  ret i64 %lock_r

prep_done:
  ret i64 %prep

input_copy_done:
  ret i64 %input_copied

fault:
  ret i64 -14
}

define hidden i64 @__mtrt_host_fdatasync(i64 %fd) {
  %r = call i64 @__mtrt_linux_syscall1(i64 75, i64 %fd)
  ret i64 %r
}

define hidden i64 @__mtrt_host_fsync(i64 %fd) {
  %r = call i64 @__mtrt_linux_syscall1(i64 74, i64 %fd)
  ret i64 %r
}

define hidden i64 @__mtrt_host_getcwd(ptr %buf, i64 %size) {
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

define hidden i64 @__mtrt_host_lchown(ptr %path, i64 %uid, i64 %gid) {
  %path_i = ptrtoint ptr %path to i64
  %r = call i64 @__mtrt_linux_syscall3(i64 94, i64 %path_i, i64 %uid, i64 %gid)
  ret i64 %r
}

define hidden i64 @__mtrt_host_madvise(i64 %addr, i64 %length, i64 %advice) {
  %native_advice = call i64 @__mtrt_linux_madvise_to_native(i64 %advice)
  %r = call i64 @__mtrt_linux_syscall3(i64 28, i64 %addr, i64 %length, i64 %native_advice)
  ret i64 %r
}

define hidden i64 @__mtrt_host_mlock(i64 %addr, i64 %length) {
  %r = call i64 @__mtrt_linux_syscall2(i64 149, i64 %addr, i64 %length)
  ret i64 %r
}

define hidden i64 @__mtrt_host_mmap(i64 %addr, i64 %length, i64 %prot, i64 %flags, i64 %fd, i64 %offset) {
  %native_prot = call i64 @__mtrt_linux_prot_to_native(i64 %prot)
  %native_flags = call i64 @__mtrt_linux_mmap_flags_to_native(i64 %flags)
  %r = call i64 @__mtrt_linux_syscall6(i64 9, i64 %addr, i64 %length, i64 %native_prot, i64 %native_flags, i64 %fd, i64 %offset)
  ret i64 %r
}

define hidden i64 @__mtrt_host_mprotect(i64 %addr, i64 %length, i64 %prot) {
  %native_prot = call i64 @__mtrt_linux_prot_to_native(i64 %prot)
  %r = call i64 @__mtrt_linux_syscall3(i64 10, i64 %addr, i64 %length, i64 %native_prot)
  ret i64 %r
}

define hidden i64 @__mtrt_host_msync(i64 %addr, i64 %length, i64 %flags) {
  %native_flags = call i64 @__mtrt_linux_msync_flags_to_native(i64 %flags)
  %r = call i64 @__mtrt_linux_syscall3(i64 26, i64 %addr, i64 %length, i64 %native_flags)
  ret i64 %r
}

define hidden i64 @__mtrt_host_munlock(i64 %addr, i64 %length) {
  %r = call i64 @__mtrt_linux_syscall2(i64 150, i64 %addr, i64 %length)
  ret i64 %r
}

define hidden i64 @__mtrt_host_munmap(i64 %addr, i64 %length) {
  %r = call i64 @__mtrt_linux_syscall2(i64 11, i64 %addr, i64 %length)
  ret i64 %r
}

define hidden i64 @__mtrt_host_pause() {
  %r = call i64 @__mtrt_linux_syscall0(i64 34)
  ret i64 %r
}

define hidden i64 @__mtrt_host_pipe2(ptr %fds, i64 %flags) {
  %native_flags = call i64 @__mtrt_linux_pipe2_flags_to_native(i64 %flags)
  %fds_i = ptrtoint ptr %fds to i64
  %r = call i64 @__mtrt_linux_syscall2(i64 293, i64 %fds_i, i64 %native_flags)
  ret i64 %r
}

define hidden i64 @__mtrt_host_sched_yield() {
  %r = call i64 @__mtrt_linux_syscall0(i64 24)
  ret i64 %r
}

define hidden i64 @__mtrt_host_sigaction(i64 %sig, ptr %act, ptr %oldact) {
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
  %target_act = alloca [24 x i8], align 8
  %copy_act_in = call i64 @__mtrt_linux_copy_from_target(ptr %target_act, ptr %act, i64 24)
  %copy_act_ok = icmp eq i64 %copy_act_in, 0
  br i1 %copy_act_ok, label %load_act, label %fault

load_act:
  %target_handler_i = load i64, ptr %target_act, align 8
  %dispatcher_i = call i64 @__mtrt_linux_sigaction_dispatcher(i64 %sig)
  %is_remapped = icmp ne i64 %dispatcher_i, 0
  %is_dfl = icmp eq i64 %target_handler_i, 0
  %is_ign = icmp eq i64 %target_handler_i, 1
  %is_special = or i1 %is_dfl, %is_ign
  %use_dispatcher = and i1 %is_remapped, %is_special
  %use_target_dispatcher = xor i1 %use_dispatcher, %is_remapped
  %native_handler_i = select i1 %use_target_dispatcher, i64 %dispatcher_i, i64 %target_handler_i
  store i64 %native_handler_i, ptr %native_act, align 8
  %target_flags_p = getelementptr i8, ptr %target_act, i64 8
  %target_flags = load i64, ptr %target_flags_p, align 8
  %native_flags = call i64 @__mtrt_linux_sigaction_flags_to_native_x86_64(i64 %target_flags)
  %bad_flags = icmp slt i64 %native_flags, 0
  br i1 %bad_flags, label %invalid, label %copy_act_mask

copy_act_mask:
  %native_flags_p = getelementptr i8, ptr %native_act, i64 8
  store i64 %native_flags, ptr %native_flags_p, align 8
  %native_restorer_p = getelementptr i8, ptr %native_act, i64 16
  store ptr @__mtrt_linux_rt_sigreturn_restorer_x86_64, ptr %native_restorer_p, align 8
  %target_mask_p = getelementptr i8, ptr %target_act, i64 16
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
  %target_oldact_out = alloca [24 x i8], align 8
  %old_handler = load i64, ptr %native_oldact, align 8
  %old_target_handler = call i64 @__mtrt_linux_sigaction_handler_from_native(i64 %sig, i64 %old_handler, i64 %previous_handler_phi)
  store i64 %old_target_handler, ptr %target_oldact_out, align 8
  %old_native_flags_p = getelementptr i8, ptr %native_oldact, i64 8
  %old_native_flags = load i64, ptr %old_native_flags_p, align 8
  %old_target_flags = call i64 @__mtrt_linux_sigaction_flags_from_native_x86_64(i64 %old_native_flags)
  %old_target_flags_p = getelementptr i8, ptr %target_oldact_out, i64 8
  store i64 %old_target_flags, ptr %old_target_flags_p, align 8
  %old_native_mask_p = getelementptr i8, ptr %native_oldact, i64 24
  %old_native_mask = load i64, ptr %old_native_mask_p, align 8
  %old_target_mask = call i64 @__mtrt_linux_sigset_from_native(i64 %old_native_mask)
  %old_target_mask_p = getelementptr i8, ptr %target_oldact_out, i64 16
  store i64 %old_target_mask, ptr %old_target_mask_p, align 8
  %copy_oldact = call i64 @__mtrt_linux_copy_to_target(ptr %oldact, ptr %target_oldact_out, i64 24)
  %copy_oldact_ok = icmp eq i64 %copy_oldact, 0
  br i1 %copy_oldact_ok, label %oldact_done, label %restore_after_copy_fault

oldact_done:
  ret i64 %r

restore_after_copy_fault:
  %restore_native_act_i = ptrtoint ptr %native_oldact to i64
  %restore_ignored = call i64 @__mtrt_linux_syscall4(i64 13, i64 %native_sig, i64 %restore_native_act_i, i64 0, i64 8)
  br i1 %stored_remapped_phi, label %restore_previous_action_copy_fault, label %fault

restore_previous_action_copy_fault:
  call void @__mtrt_linux_store_target_action(i64 %sig, i64 %previous_handler_phi, i64 %previous_flags_phi)
  br label %fault

invalid:
  ret i64 -22

fault:
  ret i64 -14

done:
  ret i64 %r
}

define hidden i64 @__mtrt_host_sigaltstack(ptr %ss, ptr %old_ss) {
entry:
  %native_ss = alloca [24 x i8], align 8
  %native_old = alloca [24 x i8], align 8
  %target_ss = alloca [24 x i8], align 8
  %target_old = alloca [24 x i8], align 8
  %ss_null = icmp eq ptr %ss, null
  br i1 %ss_null, label %prepare_old, label %copy_ss

copy_ss:
  %ss_copied = call i64 @__mtrt_linux_copy_from_target(ptr %target_ss, ptr %ss, i64 24)
  %ss_copy_ok = icmp eq i64 %ss_copied, 0
  br i1 %ss_copy_ok, label %translate_ss, label %fault

translate_ss:
  %sp_i = load i64, ptr %target_ss, align 8
  %size_p = getelementptr i8, ptr %target_ss, i64 8
  %size = load i64, ptr %size_p, align 8
  %flags_p = getelementptr i8, ptr %target_ss, i64 16
  %flags = load i32, ptr %flags_p, align 4
  %flags_zero = icmp eq i32 %flags, 0
  %flags_disable = icmp eq i32 %flags, 2
  %flags_ok = or i1 %flags_zero, %flags_disable
  br i1 %flags_ok, label %store_ss, label %invalid

store_ss:
  %sp = inttoptr i64 %sp_i to ptr
  store ptr %sp, ptr %native_ss, align 8
  %native_flags_p = getelementptr i8, ptr %native_ss, i64 8
  store i32 %flags, ptr %native_flags_p, align 4
  %native_size_p = getelementptr i8, ptr %native_ss, i64 16
  store i64 %size, ptr %native_size_p, align 8
  br label %prepare_old

prepare_old:
  %native_ss_arg = phi ptr [ null, %entry ], [ %native_ss, %store_ss ]
  %old_null = icmp eq ptr %old_ss, null
  %native_old_arg = select i1 %old_null, ptr null, ptr %native_old
  %ss_i = ptrtoint ptr %native_ss_arg to i64
  %old_i = ptrtoint ptr %native_old_arg to i64
  %r = call i64 @__mtrt_linux_syscall2(i64 131, i64 %ss_i, i64 %old_i)
  %failed = icmp slt i64 %r, 0
  %skip_old = or i1 %failed, %old_null
  br i1 %skip_old, label %done, label %translate_old

translate_old:
  %old_sp = load i64, ptr %native_old, align 8
  %old_native_flags_p = getelementptr i8, ptr %native_old, i64 8
  %old_flags = load i32, ptr %old_native_flags_p, align 4
  %old_native_size_p = getelementptr i8, ptr %native_old, i64 16
  %old_size = load i64, ptr %old_native_size_p, align 8
  store i64 %old_sp, ptr %target_old, align 8
  %old_size_p = getelementptr i8, ptr %target_old, i64 8
  store i64 %old_size, ptr %old_size_p, align 8
  %old_flags_p = getelementptr i8, ptr %target_old, i64 16
  store i32 %old_flags, ptr %old_flags_p, align 4
  %old_reserved_p = getelementptr i8, ptr %target_old, i64 20
  store i32 0, ptr %old_reserved_p, align 4
  %old_copied = call i64 @__mtrt_linux_copy_to_target(ptr %old_ss, ptr %target_old, i64 24)
  %old_copy_ok = icmp eq i64 %old_copied, 0
  br i1 %old_copy_ok, label %done, label %fault

fault:
  ret i64 -14

invalid:
  ret i64 -22

done:
  ret i64 %r
}

define hidden i64 @__mtrt_host_sigpending(ptr %sigset) {
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
  %target_value_p = alloca i64, align 8
  store i64 %target_value, ptr %target_value_p, align 8
  %copied = call i64 @__mtrt_linux_copy_to_target(ptr %sigset, ptr %target_value_p, i64 8)
  %copy_ok = icmp eq i64 %copied, 0
  br i1 %copy_ok, label %done, label %fault

done:
  ret i64 %r
}

define hidden i64 @__mtrt_host_sigprocmask(i64 %how, ptr %set, ptr %oldset) {
entry:
  %native_set = alloca i64, align 8
  %native_oldset = alloca i64, align 8
  %set_is_null = icmp eq ptr %set, null
  br i1 %set_is_null, label %prep_oldset, label %copy_set

copy_set:
  %target_set_p = alloca i64, align 8
  %copy_set_in = call i64 @__mtrt_linux_copy_from_target(ptr %target_set_p, ptr %set, i64 8)
  %copy_set_ok = icmp eq i64 %copy_set_in, 0
  br i1 %copy_set_ok, label %load_set, label %fault

load_set:
  %target_set = load i64, ptr %target_set_p, align 8
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
  %target_old_p = alloca i64, align 8
  store i64 %target_old, ptr %target_old_p, align 8
  %copy_oldset = call i64 @__mtrt_linux_copy_to_target(ptr %oldset, ptr %target_old_p, i64 8)
  %copy_oldset_ok = icmp eq i64 %copy_oldset, 0
  br i1 %copy_oldset_ok, label %oldset_done, label %restore_mask_after_copy_fault

oldset_done:
  ret i64 %r

restore_mask_after_copy_fault:
  %restore_mask_i = ptrtoint ptr %native_oldset to i64
  %restore_mask_ignored = call i64 @__mtrt_linux_syscall4(i64 14, i64 2, i64 %restore_mask_i, i64 0, i64 8)
  br label %fault

invalid:
  ret i64 -22

fault:
  ret i64 -14

done:
  ret i64 %r
}

define hidden i64 @__mtrt_host_sigsuspend(ptr %sigmask) {
entry:
  %native_sigmask = alloca i64, align 8
  %target_sigmask = alloca i64, align 8
  %is_null = icmp eq ptr %sigmask, null
  br i1 %is_null, label %fault, label %copy_mask

fault:
  ret i64 -14

copy_mask:
  %copied = call i64 @__mtrt_linux_copy_from_target(ptr %target_sigmask, ptr %sigmask, i64 8)
  %copy_ok = icmp eq i64 %copied, 0
  br i1 %copy_ok, label %translate_mask, label %fault

translate_mask:
  %target_mask = load i64, ptr %target_sigmask, align 8
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

define hidden i64 @__mtrt_host_sigtimedwait(ptr %set, ptr %info, ptr %timeout) {
entry:
  %native_set = alloca i64, align 8
  %native_info = alloca [128 x i8], align 8
  %target_set_p = alloca i64, align 8
  %target_info = alloca [16 x i8], align 8
  %set_is_null = icmp eq ptr %set, null
  br i1 %set_is_null, label %fault, label %copy_set

fault:
  ret i64 -14

copy_set:
  %set_copied = call i64 @__mtrt_linux_copy_from_target(ptr %target_set_p, ptr %set, i64 8)
  %set_copy_ok = icmp eq i64 %set_copied, 0
  br i1 %set_copy_ok, label %translate_set, label %fault

translate_set:
  %target_set = load i64, ptr %target_set_p, align 8
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
  call void @__mtrt_linux_siginfo_to_target(ptr %target_info, ptr %native_info)
  %info_copied = call i64 @__mtrt_linux_copy_to_target(ptr %info, ptr %target_info, i64 16)
  %info_copy_ok = icmp eq i64 %info_copied, 0
  br i1 %info_copy_ok, label %return_signal, label %fault

return_signal:
  %target_sig = call i64 @__mtrt_linux_signal_from_native(i64 %r)
  ret i64 %target_sig

done:
  ret i64 %r
}

define hidden i64 @__mtrt_host_sigwaitinfo(ptr %set, ptr %info) {
  %r = call i64 @__mtrt_host_sigtimedwait(ptr %set, ptr %info, ptr null)
  ret i64 %r
}

define hidden i64 @__mtrt_host_times(ptr %buf) {
  %buf_i = ptrtoint ptr %buf to i64
  %r = call i64 @__mtrt_linux_syscall1(i64 100, i64 %buf_i)
  ret i64 %r
}

define hidden i64 @__mtrt_host_utimes(ptr %path, ptr %times) {
  %path_i = ptrtoint ptr %path to i64
  %times_i = ptrtoint ptr %times to i64
  %r = call i64 @__mtrt_linux_syscall2(i64 235, i64 %path_i, i64 %times_i)
  ret i64 %r
}

attributes #0 = { naked noreturn }
