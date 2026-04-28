; Temporary macOS host bridge for current scaffold behavior.
; This libSystem/dlsym path is quarantined and is not the target architecture.
; Target macOS work should use a direct kernel-primitive path or mark gaps.

target triple = "arm64-apple-macosx13.0.0"

%struct.mtrt_stat64 = type { i64, i64, i64, i32, i32, i32, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64 }

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
@.sym_pipe = private unnamed_addr constant [5 x i8] c"pipe\00"
@.sym_readv = private unnamed_addr constant [6 x i8] c"readv\00"
@.sym_writev = private unnamed_addr constant [7 x i8] c"writev\00"
@.sym_open = private unnamed_addr constant [5 x i8] c"open\00"
@.sym_openat = private unnamed_addr constant [7 x i8] c"openat\00"
@.sym_lseek = private unnamed_addr constant [6 x i8] c"lseek\00"
@.sym_pread = private unnamed_addr constant [6 x i8] c"pread\00"
@.sym_pwrite = private unnamed_addr constant [7 x i8] c"pwrite\00"
@.sym_unlink = private unnamed_addr constant [7 x i8] c"unlink\00"
@.sym_unlinkat = private unnamed_addr constant [9 x i8] c"unlinkat\00"
@.sym_access = private unnamed_addr constant [7 x i8] c"access\00"
@.sym_faccessat = private unnamed_addr constant [10 x i8] c"faccessat\00"
@.sym_chmod = private unnamed_addr constant [6 x i8] c"chmod\00"
@.sym_fchmod = private unnamed_addr constant [7 x i8] c"fchmod\00"
@.sym_fchmodat = private unnamed_addr constant [9 x i8] c"fchmodat\00"
@.sym_link = private unnamed_addr constant [5 x i8] c"link\00"
@.sym_linkat = private unnamed_addr constant [7 x i8] c"linkat\00"
@.sym_mkdir = private unnamed_addr constant [6 x i8] c"mkdir\00"
@.sym_mkdirat = private unnamed_addr constant [8 x i8] c"mkdirat\00"
@.sym_readlink = private unnamed_addr constant [9 x i8] c"readlink\00"
@.sym_readlinkat = private unnamed_addr constant [11 x i8] c"readlinkat\00"
@.sym_rename = private unnamed_addr constant [7 x i8] c"rename\00"
@.sym_renameat = private unnamed_addr constant [9 x i8] c"renameat\00"
@.sym_rmdir = private unnamed_addr constant [6 x i8] c"rmdir\00"
@.sym_symlink = private unnamed_addr constant [8 x i8] c"symlink\00"
@.sym_symlinkat = private unnamed_addr constant [10 x i8] c"symlinkat\00"
@.sym_stat = private unnamed_addr constant [5 x i8] c"stat\00"
@.sym_fstat = private unnamed_addr constant [6 x i8] c"fstat\00"
@.sym_lstat = private unnamed_addr constant [6 x i8] c"lstat\00"
@.sym_fstatat = private unnamed_addr constant [8 x i8] c"fstatat\00"

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

define i64 @__mtrt_host_pipe(ptr %fds) {
entry:
  %is_null = icmp eq ptr %fds, null
  br i1 %is_null, label %fault, label %call_pipe

fault:
  ret i64 -14

call_pipe:
  %sym = call ptr @__mtrt_darwin_lookup(ptr @.sym_pipe)
  %r = call i32 %sym(ptr %fds)
  %mapped = call i64 @__mtrt_darwin_posix_to_raw_i32(i32 %r)
  ret i64 %mapped
}

define i64 @__mtrt_host_readv(i64 %fd, ptr %iov, i64 %iovcnt) {
entry:
  %fd32 = trunc i64 %fd to i32
  %iovcnt32 = trunc i64 %iovcnt to i32
  %sym = call ptr @__mtrt_darwin_lookup(ptr @.sym_readv)
  %r = call i64 %sym(i32 %fd32, ptr %iov, i32 %iovcnt32)
  %mapped = call i64 @__mtrt_darwin_posix_to_raw_i64(i64 %r)
  ret i64 %mapped
}

define i64 @__mtrt_host_writev(i64 %fd, ptr %iov, i64 %iovcnt) {
entry:
  %fd32 = trunc i64 %fd to i32
  %iovcnt32 = trunc i64 %iovcnt to i32
  %sym = call ptr @__mtrt_darwin_lookup(ptr @.sym_writev)
  %r = call i64 %sym(i32 %fd32, ptr %iov, i32 %iovcnt32)
  %mapped = call i64 @__mtrt_darwin_posix_to_raw_i64(i64 %r)
  ret i64 %mapped
}

define i64 @__mtrt_host_open(ptr %path, i64 %flags, i64 %mode) {
entry:
  %flags32 = trunc i64 %flags to i32
  %mode32 = trunc i64 %mode to i32
  %mapped_flags = call i32 @__mtrt_darwin_open_flags_from_target(i32 %flags32)
  %sym = call ptr @__mtrt_darwin_lookup(ptr @.sym_open)
  %r = call i32 %sym(ptr %path, i32 %mapped_flags, i32 %mode32)
  %mapped = call i64 @__mtrt_darwin_posix_to_raw_i32(i32 %r)
  ret i64 %mapped
}

define i64 @__mtrt_host_openat(i64 %dirfd, ptr %path, i64 %flags, i64 %mode) {
entry:
  %dirfd32 = call i32 @__mtrt_darwin_dirfd_from_target(i64 %dirfd)
  %flags32 = trunc i64 %flags to i32
  %mode32 = trunc i64 %mode to i32
  %mapped_flags = call i32 @__mtrt_darwin_open_flags_from_target(i32 %flags32)
  %sym = call ptr @__mtrt_darwin_lookup(ptr @.sym_openat)
  %r = call i32 %sym(i32 %dirfd32, ptr %path, i32 %mapped_flags, i32 %mode32)
  %mapped = call i64 @__mtrt_darwin_posix_to_raw_i32(i32 %r)
  ret i64 %mapped
}

define i64 @__mtrt_host_lseek(i64 %fd, i64 %offset, i64 %whence) {
entry:
  %fd32 = trunc i64 %fd to i32
  %whence32 = trunc i64 %whence to i32
  %sym = call ptr @__mtrt_darwin_lookup(ptr @.sym_lseek)
  %r = call i64 %sym(i32 %fd32, i64 %offset, i32 %whence32)
  %mapped = call i64 @__mtrt_darwin_posix_to_raw_i64(i64 %r)
  ret i64 %mapped
}

define i64 @__mtrt_host_pread(i64 %fd, ptr %buf, i64 %count, i64 %offset) {
entry:
  %fd32 = trunc i64 %fd to i32
  %sym = call ptr @__mtrt_darwin_lookup(ptr @.sym_pread)
  %r = call i64 %sym(i32 %fd32, ptr %buf, i64 %count, i64 %offset)
  %mapped = call i64 @__mtrt_darwin_posix_to_raw_i64(i64 %r)
  ret i64 %mapped
}

define i64 @__mtrt_host_pwrite(i64 %fd, ptr %buf, i64 %count, i64 %offset) {
entry:
  %fd32 = trunc i64 %fd to i32
  %sym = call ptr @__mtrt_darwin_lookup(ptr @.sym_pwrite)
  %r = call i64 %sym(i32 %fd32, ptr %buf, i64 %count, i64 %offset)
  %mapped = call i64 @__mtrt_darwin_posix_to_raw_i64(i64 %r)
  ret i64 %mapped
}

define i64 @__mtrt_host_unlink(ptr %path) {
entry:
  %sym = call ptr @__mtrt_darwin_lookup(ptr @.sym_unlink)
  %r = call i32 %sym(ptr %path)
  %mapped = call i64 @__mtrt_darwin_posix_to_raw_i32(i32 %r)
  ret i64 %mapped
}

define i64 @__mtrt_host_unlinkat(i64 %dirfd, ptr %path, i64 %flags) {
entry:
  %dirfd32 = call i32 @__mtrt_darwin_dirfd_from_target(i64 %dirfd)
  %flags32 = trunc i64 %flags to i32
  %sym = call ptr @__mtrt_darwin_lookup(ptr @.sym_unlinkat)
  %r = call i32 %sym(i32 %dirfd32, ptr %path, i32 %flags32)
  %mapped = call i64 @__mtrt_darwin_posix_to_raw_i32(i32 %r)
  ret i64 %mapped
}

define i64 @__mtrt_host_access(ptr %path, i64 %mode) {
entry:
  %mode32 = trunc i64 %mode to i32
  %sym = call ptr @__mtrt_darwin_lookup(ptr @.sym_access)
  %r = call i32 %sym(ptr %path, i32 %mode32)
  %mapped = call i64 @__mtrt_darwin_posix_to_raw_i32(i32 %r)
  ret i64 %mapped
}

define i64 @__mtrt_host_faccessat(i64 %dirfd, ptr %path, i64 %mode, i64 %flags) {
entry:
  %dirfd32 = call i32 @__mtrt_darwin_dirfd_from_target(i64 %dirfd)
  %mode32 = trunc i64 %mode to i32
  %flags32 = trunc i64 %flags to i32
  %sym = call ptr @__mtrt_darwin_lookup(ptr @.sym_faccessat)
  %r = call i32 %sym(i32 %dirfd32, ptr %path, i32 %mode32, i32 %flags32)
  %mapped = call i64 @__mtrt_darwin_posix_to_raw_i32(i32 %r)
  ret i64 %mapped
}

define i64 @__mtrt_host_chmod(ptr %path, i64 %mode) {
entry:
  %mode32 = trunc i64 %mode to i32
  %sym = call ptr @__mtrt_darwin_lookup(ptr @.sym_chmod)
  %r = call i32 %sym(ptr %path, i32 %mode32)
  %mapped = call i64 @__mtrt_darwin_posix_to_raw_i32(i32 %r)
  ret i64 %mapped
}

define i64 @__mtrt_host_fchmod(i64 %fd, i64 %mode) {
entry:
  %fd32 = trunc i64 %fd to i32
  %mode32 = trunc i64 %mode to i32
  %sym = call ptr @__mtrt_darwin_lookup(ptr @.sym_fchmod)
  %r = call i32 %sym(i32 %fd32, i32 %mode32)
  %mapped = call i64 @__mtrt_darwin_posix_to_raw_i32(i32 %r)
  ret i64 %mapped
}

define i64 @__mtrt_host_fchmodat(i64 %dirfd, ptr %path, i64 %mode, i64 %flags) {
entry:
  %dirfd32 = call i32 @__mtrt_darwin_dirfd_from_target(i64 %dirfd)
  %mode32 = trunc i64 %mode to i32
  %flags32 = trunc i64 %flags to i32
  %sym = call ptr @__mtrt_darwin_lookup(ptr @.sym_fchmodat)
  %r = call i32 %sym(i32 %dirfd32, ptr %path, i32 %mode32, i32 %flags32)
  %mapped = call i64 @__mtrt_darwin_posix_to_raw_i32(i32 %r)
  ret i64 %mapped
}

define i64 @__mtrt_host_link(ptr %oldpath, ptr %newpath) {
entry:
  %sym = call ptr @__mtrt_darwin_lookup(ptr @.sym_link)
  %r = call i32 %sym(ptr %oldpath, ptr %newpath)
  %mapped = call i64 @__mtrt_darwin_posix_to_raw_i32(i32 %r)
  ret i64 %mapped
}

define i64 @__mtrt_host_linkat(i64 %olddirfd, ptr %oldpath, i64 %newdirfd, ptr %newpath, i64 %flags) {
entry:
  %olddirfd32 = call i32 @__mtrt_darwin_dirfd_from_target(i64 %olddirfd)
  %newdirfd32 = call i32 @__mtrt_darwin_dirfd_from_target(i64 %newdirfd)
  %flags32 = trunc i64 %flags to i32
  %sym = call ptr @__mtrt_darwin_lookup(ptr @.sym_linkat)
  %r = call i32 %sym(i32 %olddirfd32, ptr %oldpath, i32 %newdirfd32, ptr %newpath, i32 %flags32)
  %mapped = call i64 @__mtrt_darwin_posix_to_raw_i32(i32 %r)
  ret i64 %mapped
}

define i64 @__mtrt_host_mkdir(ptr %path, i64 %mode) {
entry:
  %mode32 = trunc i64 %mode to i32
  %sym = call ptr @__mtrt_darwin_lookup(ptr @.sym_mkdir)
  %r = call i32 %sym(ptr %path, i32 %mode32)
  %mapped = call i64 @__mtrt_darwin_posix_to_raw_i32(i32 %r)
  ret i64 %mapped
}

define i64 @__mtrt_host_mkdirat(i64 %dirfd, ptr %path, i64 %mode) {
entry:
  %dirfd32 = call i32 @__mtrt_darwin_dirfd_from_target(i64 %dirfd)
  %mode32 = trunc i64 %mode to i32
  %sym = call ptr @__mtrt_darwin_lookup(ptr @.sym_mkdirat)
  %r = call i32 %sym(i32 %dirfd32, ptr %path, i32 %mode32)
  %mapped = call i64 @__mtrt_darwin_posix_to_raw_i32(i32 %r)
  ret i64 %mapped
}

define i64 @__mtrt_host_readlink(ptr %path, ptr %buf, i64 %size) {
entry:
  %sym = call ptr @__mtrt_darwin_lookup(ptr @.sym_readlink)
  %r = call i64 %sym(ptr %path, ptr %buf, i64 %size)
  %mapped = call i64 @__mtrt_darwin_posix_to_raw_i64(i64 %r)
  ret i64 %mapped
}

define i64 @__mtrt_host_readlinkat(i64 %dirfd, ptr %path, ptr %buf, i64 %size) {
entry:
  %dirfd32 = call i32 @__mtrt_darwin_dirfd_from_target(i64 %dirfd)
  %sym = call ptr @__mtrt_darwin_lookup(ptr @.sym_readlinkat)
  %r = call i64 %sym(i32 %dirfd32, ptr %path, ptr %buf, i64 %size)
  %mapped = call i64 @__mtrt_darwin_posix_to_raw_i64(i64 %r)
  ret i64 %mapped
}

define i64 @__mtrt_host_rename(ptr %oldpath, ptr %newpath) {
entry:
  %sym = call ptr @__mtrt_darwin_lookup(ptr @.sym_rename)
  %r = call i32 %sym(ptr %oldpath, ptr %newpath)
  %mapped = call i64 @__mtrt_darwin_posix_to_raw_i32(i32 %r)
  ret i64 %mapped
}

define i64 @__mtrt_host_renameat(i64 %olddirfd, ptr %oldpath, i64 %newdirfd, ptr %newpath) {
entry:
  %olddirfd32 = call i32 @__mtrt_darwin_dirfd_from_target(i64 %olddirfd)
  %newdirfd32 = call i32 @__mtrt_darwin_dirfd_from_target(i64 %newdirfd)
  %sym = call ptr @__mtrt_darwin_lookup(ptr @.sym_renameat)
  %r = call i32 %sym(i32 %olddirfd32, ptr %oldpath, i32 %newdirfd32, ptr %newpath)
  %mapped = call i64 @__mtrt_darwin_posix_to_raw_i32(i32 %r)
  ret i64 %mapped
}

define i64 @__mtrt_host_rmdir(ptr %path) {
entry:
  %sym = call ptr @__mtrt_darwin_lookup(ptr @.sym_rmdir)
  %r = call i32 %sym(ptr %path)
  %mapped = call i64 @__mtrt_darwin_posix_to_raw_i32(i32 %r)
  ret i64 %mapped
}

define i64 @__mtrt_host_symlink(ptr %target, ptr %linkpath) {
entry:
  %sym = call ptr @__mtrt_darwin_lookup(ptr @.sym_symlink)
  %r = call i32 %sym(ptr %target, ptr %linkpath)
  %mapped = call i64 @__mtrt_darwin_posix_to_raw_i32(i32 %r)
  ret i64 %mapped
}

define i64 @__mtrt_host_symlinkat(ptr %target, i64 %newdirfd, ptr %linkpath) {
entry:
  %newdirfd32 = call i32 @__mtrt_darwin_dirfd_from_target(i64 %newdirfd)
  %sym = call ptr @__mtrt_darwin_lookup(ptr @.sym_symlinkat)
  %r = call i32 %sym(ptr %target, i32 %newdirfd32, ptr %linkpath)
  %mapped = call i64 @__mtrt_darwin_posix_to_raw_i32(i32 %r)
  ret i64 %mapped
}

define i64 @__mtrt_host_stat(ptr %path, ptr %buf) {
entry:
  %is_null = icmp eq ptr %buf, null
  br i1 %is_null, label %fault, label %call_stat

fault:
  ret i64 -14

call_stat:
  %native = alloca [144 x i8], align 8
  %sym = call ptr @__mtrt_darwin_lookup(ptr @.sym_stat)
  %r = call i32 %sym(ptr %path, ptr %native)
  %mapped = call i64 @__mtrt_darwin_posix_to_raw_i32(i32 %r)
  %ok = icmp eq i64 %mapped, 0
  br i1 %ok, label %store, label %done

store:
  call void @__mtrt_darwin_store_stat64(ptr %buf, ptr %native)
  ret i64 0

done:
  ret i64 %mapped
}

define i64 @__mtrt_host_fstat(i64 %fd, ptr %buf) {
entry:
  %is_null = icmp eq ptr %buf, null
  br i1 %is_null, label %fault, label %call_fstat

fault:
  ret i64 -14

call_fstat:
  %fd32 = trunc i64 %fd to i32
  %native = alloca [144 x i8], align 8
  %sym = call ptr @__mtrt_darwin_lookup(ptr @.sym_fstat)
  %r = call i32 %sym(i32 %fd32, ptr %native)
  %mapped = call i64 @__mtrt_darwin_posix_to_raw_i32(i32 %r)
  %ok = icmp eq i64 %mapped, 0
  br i1 %ok, label %store, label %done

store:
  call void @__mtrt_darwin_store_stat64(ptr %buf, ptr %native)
  ret i64 0

done:
  ret i64 %mapped
}

define i64 @__mtrt_host_lstat(ptr %path, ptr %buf) {
entry:
  %is_null = icmp eq ptr %buf, null
  br i1 %is_null, label %fault, label %call_lstat

fault:
  ret i64 -14

call_lstat:
  %native = alloca [144 x i8], align 8
  %sym = call ptr @__mtrt_darwin_lookup(ptr @.sym_lstat)
  %r = call i32 %sym(ptr %path, ptr %native)
  %mapped = call i64 @__mtrt_darwin_posix_to_raw_i32(i32 %r)
  %ok = icmp eq i64 %mapped, 0
  br i1 %ok, label %store, label %done

store:
  call void @__mtrt_darwin_store_stat64(ptr %buf, ptr %native)
  ret i64 0

done:
  ret i64 %mapped
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
  %sym = call ptr @__mtrt_darwin_lookup(ptr @.sym_fstatat)
  %r = call i32 %sym(i32 %dirfd32, ptr %path, ptr %native, i32 %flags32)
  %mapped = call i64 @__mtrt_darwin_posix_to_raw_i32(i32 %r)
  %ok = icmp eq i64 %mapped, 0
  br i1 %ok, label %store, label %done

store:
  call void @__mtrt_darwin_store_stat64(ptr %buf, ptr %native)
  ret i64 0

done:
  ret i64 %mapped
}
