.file   "func1.c"
.text
.globl func1
func1:
pushq   %rbp
movq    %rsp, %rbp
movl    $0, %eax
jmp     func2

