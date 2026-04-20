; Linux host bridge for libmuffintop.
; Keeps the runtime in LLVM IR and resolves libc/libpthread/libdl entry points
; via dlsym(RTLD_NEXT, ...).

target triple = "x86_64-unknown-linux-gnu"

@.sym___errno_location = private unnamed_addr constant [17 x i8] c"__errno_location\00"

declare ptr @dlsym(ptr, ptr)

define ptr @__mtrt_host_resolve(ptr %name) {
entry:
  %sym = call ptr @dlsym(ptr inttoptr (i64 -1 to ptr), ptr %name)
  ret ptr %sym
}

define ptr @__mtrt_host_errno_ptr() {
entry:
  %sym = call ptr @dlsym(ptr inttoptr (i64 -1 to ptr), ptr @.sym___errno_location)
  %ep = call ptr %sym()
  ret ptr %ep
}

define i32 @__mtrt_host_platform() {
entry:
  ret i32 1
}
