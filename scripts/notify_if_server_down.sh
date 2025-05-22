#!/usr/bin/env bash

NOTIFY="/bin/bash /Users/jack/.dotfiles/scripts/mac/notify.sh"

server=$1
server_name=$2
if ping google.com -c 3 &> /dev/null; then
    if ! ping "$server" -c 3 &> /dev/null; then
        $NOTIFY "Warning!" "Server $server_name is down"
    fi
fi
