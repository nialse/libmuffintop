; Temporary macOS host bridge for current scaffold behavior.
; This libSystem/dlsym path is quarantined and is not the target architecture.
; Target macOS work should use a direct kernel-primitive path or mark gaps.

target triple = "arm64-apple-macosx13.0.0"

@.sym_getpid = private unnamed_addr constant [7 x i8] c"getpid\00"
@.sym_getppid = private unnamed_addr constant [8 x i8] c"getppid\00"
@.sym_fork = private unnamed_addr constant [5 x i8] c"fork\00"
@.sym_waitpid = private unnamed_addr constant [8 x i8] c"waitpid\00"
@.sym_exit = private unnamed_addr constant [6 x i8] c"_exit\00"
@.sym_write = private unnamed_addr constant [6 x i8] c"write\00"
@.sym_read = private unnamed_addr constant [5 x i8] c"read\00"
@.sym_close = private unnamed_addr constant [6 x i8] c"close\00"
@.sym_nanosleep = private unnamed_addr constant [10 x i8] c"nanosleep\00"
@.sym_clock_gettime = private unnamed_addr constant [14 x i8] c"clock_gettime\00"
@.sym_kill = private unnamed_addr constant [5 x i8] c"kill\00"
@.sym_dup = private unnamed_addr constant [4 x i8] c"dup\00"
@.sym_dup2 = private unnamed_addr constant [5 x i8] c"dup2\00"
@.sym_chdir = private unnamed_addr constant [6 x i8] c"chdir\00"
@.sym_fchdir = private unnamed_addr constant [7 x i8] c"fchdir\00"
@.sym_getpgid = private unnamed_addr constant [8 x i8] c"getpgid\00"
@.sym_getpgrp = private unnamed_addr constant [8 x i8] c"getpgrp\00"
@.sym_getsid = private unnamed_addr constant [7 x i8] c"getsid\00"
@.sym_setpgid = private unnamed_addr constant [8 x i8] c"setpgid\00"
@.sym_setsid = private unnamed_addr constant [7 x i8] c"setsid\00"
@.sym_umask = private unnamed_addr constant [6 x i8] c"umask\00"

declare ptr @"\01___error"()
declare ptr @"\01_dlsym"(ptr, ptr)

define internal ptr @__mtrt_darwin_lookup(ptr %name) {
entry:
  %sym = call ptr @"\01_dlsym"(ptr inttoptr (i64 -1 to ptr), ptr %name)
  ret ptr %sym
}

define internal i64 @__mtrt_darwin_posix_to_raw_i64(i64 %ret) {
entry:
  %is_fail = icmp eq i64 %ret, -1
  br i1 %is_fail, label %fail, label %ok

fail:
  %ep = call ptr @"\01___error"()
  %ev = load i32, ptr %ep, align 4
  %ev64 = sext i32 %ev to i64
  %neg = sub i64 0, %ev64
  ret i64 %neg

ok:
  ret i64 %ret
}

define internal i64 @__mtrt_darwin_posix_to_raw_i32(i32 %ret) {
entry:
  %ret64 = sext i32 %ret to i64
  %mapped = call i64 @__mtrt_darwin_posix_to_raw_i64(i64 %ret64)
  ret i64 %mapped
}

define i64 @__mtrt_host_getpid() {
entry:
  %sym = call ptr @__mtrt_darwin_lookup(ptr @.sym_getpid)
  %r = call i32 %sym()
  %mapped = call i64 @__mtrt_darwin_posix_to_raw_i32(i32 %r)
  ret i64 %mapped
}

define i64 @__mtrt_host_getppid() {
entry:
  %sym = call ptr @__mtrt_darwin_lookup(ptr @.sym_getppid)
  %r = call i32 %sym()
  %mapped = call i64 @__mtrt_darwin_posix_to_raw_i32(i32 %r)
  ret i64 %mapped
}

define i64 @__mtrt_host_fork() {
entry:
  %sym = call ptr @__mtrt_darwin_lookup(ptr @.sym_fork)
  %r = call i32 %sym()
  %mapped = call i64 @__mtrt_darwin_posix_to_raw_i32(i32 %r)
  ret i64 %mapped
}

define i64 @__mtrt_host_wait4(i64 %pid, ptr %status, i64 %options) {
entry:
  %pid32 = trunc i64 %pid to i32
  %opt32 = trunc i64 %options to i32
  %sym = call ptr @__mtrt_darwin_lookup(ptr @.sym_waitpid)
  %r = call i32 %sym(i32 %pid32, ptr %status, i32 %opt32)
  %mapped = call i64 @__mtrt_darwin_posix_to_raw_i32(i32 %r)
  ret i64 %mapped
}

define void @__mtrt_host_exit(i64 %status) {
entry:
  %status32 = trunc i64 %status to i32
  %sym = call ptr @__mtrt_darwin_lookup(ptr @.sym_exit)
  call void %sym(i32 %status32)
  unreachable
}

define i64 @__mtrt_host_write(i64 %fd, ptr %buf, i64 %count) {
entry:
  %fd32 = trunc i64 %fd to i32
  %sym = call ptr @__mtrt_darwin_lookup(ptr @.sym_write)
  %r = call i64 %sym(i32 %fd32, ptr %buf, i64 %count)
  %mapped = call i64 @__mtrt_darwin_posix_to_raw_i64(i64 %r)
  ret i64 %mapped
}

define i64 @__mtrt_host_read(i64 %fd, ptr %buf, i64 %count) {
entry:
  %fd32 = trunc i64 %fd to i32
  %sym = call ptr @__mtrt_darwin_lookup(ptr @.sym_read)
  %r = call i64 %sym(i32 %fd32, ptr %buf, i64 %count)
  %mapped = call i64 @__mtrt_darwin_posix_to_raw_i64(i64 %r)
  ret i64 %mapped
}

define i64 @__mtrt_host_close(i64 %fd) {
entry:
  %fd32 = trunc i64 %fd to i32
  %sym = call ptr @__mtrt_darwin_lookup(ptr @.sym_close)
  %r = call i32 %sym(i32 %fd32)
  %mapped = call i64 @__mtrt_darwin_posix_to_raw_i32(i32 %r)
  ret i64 %mapped
}

define i64 @__mtrt_host_nanosleep(ptr %req, ptr %rem) {
entry:
  %sym = call ptr @__mtrt_darwin_lookup(ptr @.sym_nanosleep)
  %r = call i32 %sym(ptr %req, ptr %rem)
  %mapped = call i64 @__mtrt_darwin_posix_to_raw_i32(i32 %r)
  ret i64 %mapped
}

define i64 @__mtrt_host_clock_gettime(i64 %clockid, ptr %tp) {
entry:
  %cid32 = trunc i64 %clockid to i32
  %sym = call ptr @__mtrt_darwin_lookup(ptr @.sym_clock_gettime)
  %r = call i32 %sym(i32 %cid32, ptr %tp)
  %mapped = call i64 @__mtrt_darwin_posix_to_raw_i32(i32 %r)
  ret i64 %mapped
}

define i64 @__mtrt_host_kill(i64 %pid, i64 %sig) {
entry:
  %pid32 = trunc i64 %pid to i32
  %sig32 = trunc i64 %sig to i32
  %sym = call ptr @__mtrt_darwin_lookup(ptr @.sym_kill)
  %r = call i32 %sym(i32 %pid32, i32 %sig32)
  %mapped = call i64 @__mtrt_darwin_posix_to_raw_i32(i32 %r)
  ret i64 %mapped
}

define i64 @__mtrt_host_dup(i64 %oldfd) {
entry:
  %oldfd32 = trunc i64 %oldfd to i32
  %sym = call ptr @__mtrt_darwin_lookup(ptr @.sym_dup)
  %r = call i32 %sym(i32 %oldfd32)
  %mapped = call i64 @__mtrt_darwin_posix_to_raw_i32(i32 %r)
  ret i64 %mapped
}

define i64 @__mtrt_host_dup2(i64 %oldfd, i64 %newfd) {
entry:
  %oldfd32 = trunc i64 %oldfd to i32
  %newfd32 = trunc i64 %newfd to i32
  %sym = call ptr @__mtrt_darwin_lookup(ptr @.sym_dup2)
  %r = call i32 %sym(i32 %oldfd32, i32 %newfd32)
  %mapped = call i64 @__mtrt_darwin_posix_to_raw_i32(i32 %r)
  ret i64 %mapped
}

define i64 @__mtrt_host_chdir(ptr %path) {
entry:
  %sym = call ptr @__mtrt_darwin_lookup(ptr @.sym_chdir)
  %r = call i32 %sym(ptr %path)
  %mapped = call i64 @__mtrt_darwin_posix_to_raw_i32(i32 %r)
  ret i64 %mapped
}

define i64 @__mtrt_host_fchdir(i64 %fd) {
entry:
  %fd32 = trunc i64 %fd to i32
  %sym = call ptr @__mtrt_darwin_lookup(ptr @.sym_fchdir)
  %r = call i32 %sym(i32 %fd32)
  %mapped = call i64 @__mtrt_darwin_posix_to_raw_i32(i32 %r)
  ret i64 %mapped
}

define i64 @__mtrt_host_getpgid(i64 %pid) {
entry:
  %pid32 = trunc i64 %pid to i32
  %sym = call ptr @__mtrt_darwin_lookup(ptr @.sym_getpgid)
  %r = call i32 %sym(i32 %pid32)
  %mapped = call i64 @__mtrt_darwin_posix_to_raw_i32(i32 %r)
  ret i64 %mapped
}

define i64 @__mtrt_host_getpgrp() {
entry:
  %sym = call ptr @__mtrt_darwin_lookup(ptr @.sym_getpgrp)
  %r = call i32 %sym()
  %mapped = call i64 @__mtrt_darwin_posix_to_raw_i32(i32 %r)
  ret i64 %mapped
}

define i64 @__mtrt_host_getsid(i64 %pid) {
entry:
  %pid32 = trunc i64 %pid to i32
  %sym = call ptr @__mtrt_darwin_lookup(ptr @.sym_getsid)
  %r = call i32 %sym(i32 %pid32)
  %mapped = call i64 @__mtrt_darwin_posix_to_raw_i32(i32 %r)
  ret i64 %mapped
}

define i64 @__mtrt_host_setpgid(i64 %pid, i64 %pgid) {
entry:
  %pid32 = trunc i64 %pid to i32
  %pgid32 = trunc i64 %pgid to i32
  %sym = call ptr @__mtrt_darwin_lookup(ptr @.sym_setpgid)
  %r = call i32 %sym(i32 %pid32, i32 %pgid32)
  %mapped = call i64 @__mtrt_darwin_posix_to_raw_i32(i32 %r)
  ret i64 %mapped
}

define i64 @__mtrt_host_setsid() {
entry:
  %sym = call ptr @__mtrt_darwin_lookup(ptr @.sym_setsid)
  %r = call i32 %sym()
  %mapped = call i64 @__mtrt_darwin_posix_to_raw_i32(i32 %r)
  ret i64 %mapped
}

define i64 @__mtrt_host_umask(i64 %mask) {
entry:
  %mask32 = trunc i64 %mask to i32
  %sym = call ptr @__mtrt_darwin_lookup(ptr @.sym_umask)
  %r = call i32 %sym(i32 %mask32)
  %mapped = call i64 @__mtrt_darwin_posix_to_raw_i32(i32 %r)
  ret i64 %mapped
}
