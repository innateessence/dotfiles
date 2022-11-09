#!/usr/bin/env bash

for script in ~/.dotfiles/*/mk-symlinks.sh; do
  bash "$script"
done
