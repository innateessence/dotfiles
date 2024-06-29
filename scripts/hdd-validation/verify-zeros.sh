#!/usr/bin/env bash

file=${1-zeros}

function write(){
  dd if=/dev/zero bs=4M count=1 2> /dev/null  > "$file" # Write 1 GB of zeros
}

function verify(){
  while IFS= read -r line; do
    if [[ "$line" != "00000000" ]]; then
      echo "Error: $line"
      exit 1
    fi
  done < "$file"
}

function Main(){
  write
  verify
  echo "All zeros verified successfully!"
}

Main
