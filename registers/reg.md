# RISC-V Integer Registers — Complete Unified Mental Model

RISC-V defines **32 integer registers**, named **x0–x31**. All integer registers have the same width (RV32 = 32-bit, RV64 = 64-bit). What gives these registers meaning is the **ABI (Application Binary Interface)**, which assigns clear roles and contracts.

---

## Big Picture (Everything Reduced)

* **zero** → constant & comparisons
* **ra** → control flow (return address)
* **sp** → stack & memory management
* **a*** → function arguments & returns
* **t*** → temporary computation
* **s*** → long-lived values (persistence)
* **gp** → global data (system/runtime)
* **tp** → thread-local data (system/runtime)

This single model explains the entire RISC-V register philosophy.

---

## zero (x0) — Constant & Flag Replacement

* Always reads as `0`
* Writes are ignored by hardware

**Why it exists**:

* Eliminates move instruction
* Eliminates flags register
* Eliminates constant-0 hardware

**Common uses**:

```
add  t0, t1, zero     # copy register
addi t0, zero, 10    # load immediate
beq  t0, zero, done  # compare
add  t0, zero, zero  # clear register
```

**Key idea**: RISC-V replaces flags with **explicit values + zero**.

---

## ra (x1) — Return Address (Control Flow)

* Holds the return address after a function call

**Written by**:

```
jal ra, function
```

**Returned by**:

```
ret    # alias for: jalr zero, ra, 0
```

**Rules**:

* Every function call overwrites `ra`
* Non-leaf functions must save `ra` on the stack

**Why it exists**:

* Explicit, visible control flow
* No hidden call stack state

---

## sp (x2) — Stack Pointer (Memory Extension)

* Points to the top of the current stack frame
* Same width as integer registers

**Rules**:

* Stack grows downward
* Must be **16-byte aligned** at function calls
* Only the function that modifies `sp` restores it

**Push / Pop pattern**:

```
# push
addi sp, sp, -4
sw   t0, 0(sp)

# pop
lw   t0, 0(sp)
addi sp, sp, 4
```

**Used for**:

* Saving `ra`
* Saving `s*` registers
* Local variables
* Extra arguments (>8)
* Recursion

---

## a0–a7 (x10–x17) — Arguments & Return Values

* Function interface registers

**Rules**:

* Up to **8 arguments** passed in `a0–a7`
* Up to **2 return values** in `a0–a1`
* Caller-saved

**Example**:

```
# caller
li a0, 5
li a1, 7
jal ra, add

# callee
add:
  add a0, a0, a1
  ret
```

More than two return values are returned via memory (stack or caller-allocated space).

---

## t0–t6 — Temporary Registers (Where Computation Lives)

* t0–t2 → x5–x7
* t3–t6 → x28–x31

**Purpose**:

* Scratch registers for computation

**Rules**:

* Caller-saved
* Freely clobbered
* Never trusted across function calls

**Typical usage**:

```
add t0, a0, a1
sub t1, a2, a3
mul t2, t0, t1
mv  a0, t2
```

Ideal for leaf functions due to zero save/restore overhead.

---

## s0–s11 — Saved Registers (Persistence)

* s0 / fp → x8
* s1 → x9
* s2–s11 → x18–x27

**Purpose**:

* Long-lived values that must survive function calls

**Core rule (ABI contract)**:
If a function modifies an `s*` register, it **must save and restore it**.

**Typical pattern**:

```
addi sp, sp, -16
sw   s0, 8(sp)

mv s0, a0
jal ra, other_func

lw   s0, 8(sp)
addi sp, sp, 16
ret
```

`s0` is often used as the **frame pointer (fp)**.

---

## gp (x3) — Global Pointer

* Points to global/static data
* Used by compiler and linker
* Rarely accessed manually

---

## tp (x4) — Thread Pointer

* Points to thread-local storage (TLS)
* Used by OS / RTOS
* Usually invisible in bare-metal single-thread programs

---

## Why It Feels Like “Only 30 Registers”

Actively used in normal code:

* zero (1)
* ra (1)
* sp (1)
* a* (8)
* t* (7)
* s* (12)

Total = **30**

The remaining two (`gp`, `tp`) are system-managed.

---

## Ultimate ABI Contract (Everything Simplified)

* a* → enter / exit
* t* → compute
* s* → remember
* ra → return
* sp → store
* zero → compare

No flags. No hidden state. Clear ownership. Clean design.
