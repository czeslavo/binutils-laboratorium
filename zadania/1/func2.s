.file   "func2.c"
.text
.globl func2
func2:

mov     $13, %edx
mov     $message, %ecx
mov     $1, %ebx
mov     $4, %eax
int     $0x80

jmp     end_program
.data
message:
    .ascii "Hello World!\n"
