target triple = "x86_64-unknown-linux-gnu"

declare void @__poc_program_start(i64, ptr)

define void @_start() #0 {
entry:
  call void asm sideeffect "movq (%rsp), %rdi\0Aleaq 8(%rsp), %rsi\0Acallq __poc_program_start\0Ahlt", "~{rdi},~{rsi},~{rax},~{rcx},~{rdx},~{r8},~{r9},~{r10},~{r11},~{memory},~{dirflag},~{fpsr},~{flags}"()
  unreachable
}

attributes #0 = { naked noreturn nounwind }
