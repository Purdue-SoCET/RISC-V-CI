#!/bin/bash

echo "Moving fusesoc libs to $GITHUB_WORKSPACE"
mv /work/fusesoc.conf $GITHUB_WORKSPACE
mv /work/fusesoc_libraries $GITHUB_WORKSPACE

set -e

echo "SoCET RISC-V CI container"

# if ! command -v riscv64-unknown-elf-gcc &> /dev/null; then
#     echo "riscv64-unknown-elf-gcc not found"
#     exit 1
# fi

# export PATH="/opt/riscv/bin:${PATH}"
# export RISCV="/opt/riscv"
# export RISCV_PREFIX="riscv64-unknown-elf-"

echo "Starting Tests..."

while IFS='' read -r target
do
  echo "Running target: $target"
  if $target; then
    echo "Target complete: $target"
  else
    echo "Target failed: $target"
    exit 1
  fi
done <<<"$INPUT_TARGETS"

echo "...Tests Complete"
