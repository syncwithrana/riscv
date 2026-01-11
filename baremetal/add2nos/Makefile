RISCV_PREFIX = riscv32-unknown-elf

CC      = $(RISCV_PREFIX)-gcc
LD      = $(RISCV_PREFIX)-ld
OBJDUMP = $(RISCV_PREFIX)-objdump

CFLAGS = -march=rv32i -mabi=ilp32 -nostdlib -nostartfiles -ffreestanding

all: add2.elf

add2.elf: add2.s linker.ld
	$(CC) $(CFLAGS) -T linker.ld add2.s -o add2.elf

dump:
	$(OBJDUMP) -d add2.elf

clean:
	rm -f add2.elf
