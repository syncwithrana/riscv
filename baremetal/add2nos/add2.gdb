set architecture riscv:rv32
target remote :1234

break hang

commands
    info registers t0 t1 t2
    quit
end

continue

