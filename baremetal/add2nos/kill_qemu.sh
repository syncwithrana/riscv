#!/usr/bin/env bash

PROC="qemu-system-riscv32"

# Get PID(s) using ps + grep, excluding the grep process itself
PIDS=$(ps aux | grep "$PROC" | grep -v grep | awk '{print $2}')

if [ -z "$PIDS" ]; then
    echo "[INFO] $PROC not running"
    exit 0
fi

echo "[INFO] Found $PROC PID(s): $PIDS"

# Graceful kill first
kill $PIDS

sleep 1

# Check again
REMAINING=$(ps aux | grep "$PROC" | grep -v grep)

if [ -n "$REMAINING" ]; then
    echo "[WARN] Still running, force killing..."
    kill -9 $PIDS
else
    echo "[OK] $PROC stopped"
fi
