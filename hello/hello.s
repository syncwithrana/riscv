.section .data
msg:
    .ascii "Hello RISC-V from Ubuntu\n"
len = . - msg

.section .text
.globl _start
_start:
    li a0, 1          # stdout
    la a1, msg        # buffer
    li a2, len        # length
    li a7, 64         # sys_write
    ecall

    li a0, 0
    li a7, 93         # sys_exit
    ecall
