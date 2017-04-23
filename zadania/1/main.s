.file   "main.c"
.text
.globl main
.globl _start
.globl end_program
.type   main, @function
_start:
main:
pushq   %rbp
movq    %rsp, %rbp
movl    $0, %eax
call    func1

end_program:
movl    %eax, %ebx
movl    $1, %eax
int     $0x80
leave
