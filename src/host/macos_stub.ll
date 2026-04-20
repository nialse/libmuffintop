; macOS host bridge for libmuffintop.
; Keeps the runtime in LLVM IR and resolves libSystem entry points
; via dlsym(RTLD_NEXT, ...).

target triple = "arm64-apple-macosx13.0.0"

declare ptr @"\01_dlsym"(ptr, ptr)
declare ptr @"\01___error"()

define ptr @__mtrt_host_resolve(ptr %name) {
entry:
  %sym = call ptr @"\01_dlsym"(ptr inttoptr (i64 -1 to ptr), ptr %name)
  ret ptr %sym
}

define ptr @__mtrt_host_errno_ptr() {
entry:
  %ep = call ptr @"\01___error"()
  ret ptr %ep
}

define i32 @__mtrt_host_platform() {
entry:
  ret i32 2
}
