# -------- add2_final.gdb --------
set pagination off
set confirm off
set verbose off
set complaints 0

set architecture riscv:rv32
target remote :1234

# Stop at entry
break _start
continue

# Run until we hit the infinite loop (PC stops changing)
set $prev_pc = 0

while 1
    set $curr_pc = $pc
    if $curr_pc == $prev_pc
        info registers t0 t1 t2
        quit
    end
    set $prev_pc = $curr_pc
    si
end
