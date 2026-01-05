# -------------------------------
# Toolchain
# -------------------------------
CC      := riscv64-linux-gnu-gcc
QEMU    := qemu-riscv64
CFLAGS  := -nostdlib -static

# -------------------------------
# Default target
# -------------------------------
.DEFAULT_GOAL := help

# -------------------------------
# Pattern rule:
# make path/to/file.s
# -------------------------------
%: %.s
	@echo ">>> Building $<"
	@mkdir -p build/$(dir $*)
	$(CC) $(CFLAGS) $< -o build/$*
	@echo ">>> Running build/$*"
	$(QEMU) build/$*

# -------------------------------
# Help
# -------------------------------
help:
	@echo "Usage:"
	@echo "  make path/to/file.s"
	@echo ""
	@echo "Example:"
	@echo "  make add/add2nos.s"
