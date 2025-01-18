#!/usr/bin/env bash

function command_exists () {
    command -v "$1" &> /dev/null
}

function get_local_ip(){
    if command_exists ip; then
        ip route get 192.168.1.1 | head -n 1 | grep -o -E '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | tail -n 1
    elif command_exists ifconfig; then
        ifconfig | grep 'inet' | grep -v 'inet6' | grep -v '127.0.0.1' | awk '{print $2}' | head -n 1 | grep -oE '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}'
    fi
}

ip=$(get_local_ip)
echo "sending magic packet from: $ip"

python ~/.dotfiles/scripts/mac/wake-on-lan.py "44:8a:5b:ce:70:97" -n "$ip"
