.section .text
.globl _start

_start:
    li t0, 1          # i = 1
    li t1, 0          # sum = 0
    li t2, 10         # N = 10

loop:
    bgt t0, t2, end  # if i > N, exit loop
    add t1, t1, t0   # sum += i
    addi t0, t0, 1   # i++
    j loop

hang:
    j hang
