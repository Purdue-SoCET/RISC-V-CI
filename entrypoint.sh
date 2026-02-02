#!/bin/bash

echo "Moving fusesoc libs to $GITHUB_WORKSPACE"
mv /work/fusesoc.conf $GITHUB_WORKSPACE
mv /work/fusesoc_libraries $GITHUB_WORKSPACE

# going to overwrite riscv-tests for the sake of the testing
# we don't want to rebuild the tests everytime we run a workflow
rm -rf $GITHUB_WORKSPACE/riscv-tests
mv /opt/riscv/target/share/riscv-tests $GITHUB_WORKSPACE

set -e

echo "SoCET RISC-V CI container"

if ! command -v riscv64-unknown-elf-gcc &> /dev/null; then
    echo "riscv64-unknown-elf-gcc not found"
    exit 1
fi

export PATH="/opt/riscv/bin:${PATH}"
export RISCV="/opt/riscv"
export RISCV_PREFIX="riscv64-unknown-elf-"

echo "Starting Tests..."

while IFS='' read -r target
do
  echo "Running target: $target"
  # for run_tests.py runner, this will find failing outputs
  if $target | tee >(grep --color "FAILED" > output.txt); then
    if grep --color "FAILED" output.txt;
      echo "Target failed: $target"
      exit 1

    echo "Target complete: $target"
  else
    echo "Target failed: $target"
    exit 1
  fi
done <<<"$INPUT_TARGETS"

echo "...Tests Complete"
