#!/bin/bash

set -e

echo "SoCET RISC-V CI container"

if ! command -v riscv64-unknown-elf-gcc &> /dev/null; then
    echo "riscv64-unknown-elf-gcc not found"
    exit 1
fi

export PATH="/opt/riscv/bin:${PATH}"
export RISCV="/opt/riscv"
export RISCV_PREFIX="riscv64-unknown-elf-"

exec "$@"