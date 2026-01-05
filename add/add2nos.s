.section .data
nl: .ascii "\n"

.section .text
.globl _start

# -------------------------------------------------
# main: PRINT ONLY
# -------------------------------------------------
_start:
    call compute        # a0 = result

    addi a0, a0, '0'    # single digit only

    addi sp, sp, -16
    sb a0, 0(sp)

    li a0, 1
    mv a1, sp
    li a2, 1
    li a7, 64
    ecall

    li a0, 1
    la a1, nl
    li a2, 1
    li a7, 64
    ecall

    li a0, 0
    li a7, 93
    ecall

# -------------------------------------------------
# compute: NON-LEAF → MUST save ra
# -------------------------------------------------
compute:
    addi sp, sp, -16
    sd ra, 8(sp)

    li a0, 3
    li a1, 4
    call add            # overwrites ra

    ld ra, 8(sp)
    addi sp, sp, 16
    ret

# -------------------------------------------------
# add: LEAF → no stack needed
# -------------------------------------------------
add:
    add a0, a0, a1
    ret
