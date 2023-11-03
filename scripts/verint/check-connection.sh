#!/usr/bin/env bash

# This will just notify me if either condition is true. 
# Cond1 - Internet connection is bad.
# Cond2 - tunnel for VPN exists & REDACTED connection is bad. (REDACTED Github)

# (Exits after first true condition to prevent duplicate notifications)
# if both conditions are false, this does nothing.

function notify(){
  # $1 = title
  # $2 = message
  osascript -e "display notification \"$2\" with title \"$1\"" > /dev/null 2>&1
}

function warn_notify(){
  notify "Warning!" "$1" && exit 1
}

function is_vpn_active(){
  # Checks if we are tunneling through the VPN. Does not check connectivity
  ifconfig -a | grep "$VPN_TUNNEL_DEV" &> /dev/null 2>&1
}

function check_connection () {
  timeout 10 ping -c 1 google.com &> /dev/null 2>&1 || warn_notify "Check your internet"
  if is_vpn_active; then
  	echo -e "GET https://REDACTED HTTP/1.1\n\n" | timeout 10 nc REDACTED 443 &> /dev/null 2>&1 || warn_notify "Check your VPN"
  fi
}

source ~/.dotfiles/zsh/exports.zsh
check_connection

