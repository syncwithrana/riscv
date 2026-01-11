# ---------- Root Makefile ----------

# Toolchain
RISCV_PREFIX = riscv32-unknown-elf
CC  = $(RISCV_PREFIX)-gcc
GDB = $(RISCV_PREFIX)-gdb

# Flags
CFLAGS = -march=rv32i -mabi=ilp32 -nostdlib -nostartfiles -ffreestanding -g

# Input folder (mandatory)
DIR ?= none

ifeq ($(DIR),none)
$(error Usage: make DIR=<program_folder>)
endif

SRC_DIR   = $(DIR)
BUILD_DIR = build/$(DIR)

SRCS  = $(wildcard $(SRC_DIR)/*.s)
ELFS  = $(patsubst $(SRC_DIR)/%.s,$(BUILD_DIR)/%.elf,$(SRCS))

LINKER = $(SRC_DIR)/linker.ld
GDBSCR = $(SRC_DIR)/*.gdb

# ---------------- Targets ----------------

all: $(ELFS)

$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)

$(BUILD_DIR)/%.elf: $(SRC_DIR)/%.s $(LINKER) | $(BUILD_DIR)
	$(CC) $(CFLAGS) -T $(LINKER) $< -o $@

# Run QEMU (halted, gdb-ready)
run: all
	qemu-system-riscv32 \
		-machine virt \
		-nographic \
		-bios none \
		-kernel $(ELFS) \
		-S -gdb tcp::1234

# Run GDB using folder gdb script
gdb:
	$(GDB) -q $(ELFS) -x $(GDBSCR)

# Kill QEMU using ps | grep (your preferred logic)
kill:
	@PIDS=$$(ps aux | grep qemu-system-riscv32 | grep -v grep | awk '{print $$2}'); \
	if [ -z "$$PIDS" ]; then \
		echo "[INFO] QEMU not running"; \
	else \
		echo "[INFO] Killing QEMU PID(s): $$PIDS"; \
		kill $$PIDS || true; \
	fi

# Force kill (just in case)
kill-force:
	@PIDS=$$(ps aux | grep qemu-system-riscv32 | grep -v grep | awk '{print $$2}'); \
	if [ -n "$$PIDS" ]; then \
		kill -9 $$PIDS || true; \
	fi

# Kill + build + run (daily use)
rerun: kill all run

clean:
	rm -rf $(BUILD_DIR)

.PHONY: all run gdb kill kill-force rerun clean

