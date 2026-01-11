.section .text
.global _start

_start:
    li t0, 5        # first number
    li t1, 7        # second number
    add t2, t0, t1  # t2 = 12

hang:
    j hang           # infinite loop (so GDB can inspect)
