#!/usr/bin/env bash

# This one doesn't create symlinks.
# This just copies the changes from WSL over to the windows filesystem for convenience

win_dest="/mnt/c/Users/Jack/scripts"

if ! test -e $win_dest; then
  mkdir $win_dest
fi
cp -av ./* $win_dest
