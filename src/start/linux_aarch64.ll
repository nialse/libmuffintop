target triple = "aarch64-unknown-linux-gnu"

declare void @__poc_program_start(i64, ptr)

define void @_start() #0 {
entry:
  call void asm sideeffect "ldr x0, [sp]\0Aadd x1, sp, #8\0Abl __poc_program_start\0Abrk #0", "~{x0},~{x1},~{x30},~{memory}"()
  unreachable
}

attributes #0 = { naked noreturn nounwind }
