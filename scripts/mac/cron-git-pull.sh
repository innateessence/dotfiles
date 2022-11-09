#!/usr/bin/env bash

cd "$1" || echo "[!] Invalid path supplied: $1"
ssh-agent bash -c 'ssh-add $HOME/.ssh/id_rsa && git pull --ff-only'

