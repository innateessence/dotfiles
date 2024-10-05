#!/usr/bin/env bash

function get_local_ip(){
  # NOTE: Theoretically works everywhere except native windows
  ifconfig | grep 'inet' | grep -v 'inet6' | grep -v '127.0.0.1' | awk '{print $2}' | head -n 1 | grep -oE '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}'
}

ip=$(get_local_ip)

python ~/.dotfiles/scripts/mac/wake-on-lan.py "44:8a:5b:ce:70:97" -n "$ip"
