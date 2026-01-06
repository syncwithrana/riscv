# 🧾 RISC-V RV32I — Instructions Cheat Sheet

> **General operand forms**

```
op   rd, rs1, rs2
op   rd, rs1, imm
op   rd, imm(rs1)
op   rs2, imm(rs1)
```

---

## 1️⃣ Arithmetic (Integer Math)

### Register–Register

```
add   rd, rs1, rs2   # rd = rs1 + rs2
sub   rd, rs1, rs2   # rd = rs1 - rs2
```

### Register–Immediate

```
addi  rd, rs1, imm   # rd = rs1 + imm
```

---

## 2️⃣ Logical (Bitwise Operations)

### Register–Register

```
and   rd, rs1, rs2   # bitwise AND
or    rd, rs1, rs2   # bitwise OR
xor   rd, rs1, rs2   # bitwise XOR
```

### Register–Immediate

```
andi  rd, rs1, imm   # rs1 AND imm
ori   rd, rs1, imm   # rs1 OR imm
xori  rd, rs1, imm   # rs1 XOR imm
```

---

## 3️⃣ Shifts (Bit Shifting)

### Register–Register

```
sll   rd, rs1, rs2   # left shift
srl   rd, rs1, rs2   # logical right shift
sra   rd, rs1, rs2   # arithmetic right shift
```

### Register–Immediate

```
slli  rd, rs1, imm   # left shift by imm
srli  rd, rs1, imm   # logical right shift by imm
srai  rd, rs1, imm   # arithmetic right shift by imm
```

---

## 4️⃣ Comparison (Flags Replacement)

### Signed

```
slt   rd, rs1, rs2   # rd = 1 if rs1 < rs2 (signed)
slti  rd, rs1, imm   # signed compare with imm
```

### Unsigned

```
sltu  rd, rs1, rs2   # rd = 1 if rs1 < rs2 (unsigned)
sltiu rd, rs1, imm   # unsigned compare with imm
```

---

## 5️⃣ Memory Loads (Memory → Register)

```
lb    rd, imm(rs1)   # load byte (signed)
lh    rd, imm(rs1)   # load halfword (signed)
lw    rd, imm(rs1)   # load word

lbu   rd, imm(rs1)   # load byte (unsigned)
lhu   rd, imm(rs1)   # load halfword (unsigned)
```

> Address = rs1 + imm

---

## 6️⃣ Memory Stores (Register → Memory)

```
sb    rs2, imm(rs1)  # store byte
sh    rs2, imm(rs1)  # store halfword
sw    rs2, imm(rs1)  # store word
```

> Stores have no destination register

---

## 7️⃣ Branches (Conditional Control Flow)

### Signed

```
beq   rs1, rs2, label   # equal
bne   rs1, rs2, label   # not equal
blt   rs1, rs2, label   # <
bge   rs1, rs2, label   # >=
```

### Unsigned

```
bltu  rs1, rs2, label   # < (unsigned)
bgeu  rs1, rs2, label   # >= (unsigned)
```

---

## 8️⃣ Jumps (Unconditional Control Flow)

```
jal   rd, label         # jump and save return address
jalr  rd, rs1, imm      # indirect jump (rs1 + imm)
```

---

## 9️⃣ Upper Immediate / Address Construction

```
lui   rd, imm           # load upper 20 bits
auipc rd, imm           # PC + upper immediate
```

---

## 🔟 System Instructions

```
ecall                  # system call
ebreak                 # debugger break
```

---

## 🧠 Big Picture

* RV32I = **base integer ISA**
* No flags, no hidden state
* All control flow via branches + jumps
* Most programs use only these instructions

You now have the **complete RV32I reference** in one place.
