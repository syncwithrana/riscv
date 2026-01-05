.section .text
.globl _start

_start:
    # write(fd=1, buf=&char, len=1)
    addi sp, sp, -16
    li t0, '7'
    sb t0, 0(sp)

    li a0, 1          # stdout
    mv a1, sp         # buffer
    li a2, 1          # length
    li a7, 64         # sys_write
    ecall

    # exit
    li a0, 0
    li a7, 93
    ecall
