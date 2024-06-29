#!/usr/bin/env bash

file=${1-ones}

function write(){
  dd if=/dev/zero bs=4M count=1 2> /dev/null | tr "\0" "\377" > "$file" # Write 1 GB of ones
}

function verify(){
  while IFS= read -r line; do
    if [[ "$line" != "11111111" ]]; then
      echo "Error: $line"
      exit 1
    fi
  done < "$file"
}

function Main(){
  write
  verify
  echo "All ones verified successfully!"
}

Main
