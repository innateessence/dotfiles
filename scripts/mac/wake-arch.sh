#!/usr/bin/env bash

python ~/.dotfiles/scripts/mac/wake-on-lan.py "44:8a:5b:ce:70:97" -n '192.168.1.209'
# NOTE: interface (aka -n) needs to be the address of the device sending the packet
