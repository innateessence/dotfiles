#!/usr/bin/env zsh

# This houses 'private' functions that are exclusively used as helpers to other dotfiles.

# One liners
function _is_mac(){ _is_equal $(uname -s) "Darwin" ; }
function _is_arch_linux(){ command -pv pacman &> /dev/null ; }
function _is_equal(){ test $1 = $2 ; }
function _is_vpn_active(){ ifconfig -a | grep $VPN_TUNNEL_DEV &> /dev/null ; }

function _get_jira_id(){ branch | grep -ioE "Vii-[0-9]+" ; }
function _get_latest_release_branch(){ git branch | grep -E 'VII[0-9\.]+-release' | tail -n 1 | tr -d ' ' ; }
function _get_repo_name(){ git config --get remote.origin.url | sed -e 's/^git@.*:\([[:graph:]]*\).git/\1/' ; }

function _open_repo(){ _browser_open $(_get_repo_url) &> /dev/null ; }
function _has_internet_access(){ timeout $NETWORK_CHECK_SHELL_TIMEOUT ping -c 1 google.com &> /dev/null ; }

function _is_wsl(){
  if [ -e /proc/version ]; then
    if $(grep -i microsoft /proc/version &>/dev/null) ; then
      return 0
    fi
  fi
  return 1
}


function _is_dir_empty(){
  local DIR
  DIR="$1"
    if [ -d "$DIR" ]
    then
      if [ "$(ls -A $DIR)" ]; then
        return 1  # Not empty
      else
        return 0  # Empty
      fi
    else
      return 2  # No directory found
    fi
}

function _browser_open(){
  for url in $@; do
    if _is_wsl; then
       $BROWSER $url &> /dev/null
    else
      python -m webbrowser $url &> /dev/null
    fi
  done
}

function _determine_shell(){
  local shells
  shells=(zsh bash)
  for shell in "${shells[@]}"; do
    if [[ "$SHELL" == *"$shell" ]]; then;
      echo "$shell" && break
    fi
  done
}

function _determine_rc_file(){
  local shell
  local rc_file
  shell="$(_determine_shell)"
  rc_file="$HOME"/."$shell"rc
  if [ ! -f "$rc_file" ]; then
    warn "$rc_file does not exist"
  fi
  echo $rc_file
}

function _get_ip(){
  local ip
  ip=$(curl -s ifconfig.me/ip)
  retcode=$?
  if [ $retcode -eq 0 ]; then
    echo $ip
  fi
  return $retcode
}


function _get_repo_url(){
  local remote_url
  remote_url="$(git config --get remote.origin.url || git config --get remote.upstream.url)"
  if [[ $remote_url != "https://"* ]]; then
    remote_url=$(echo $remote_url | sed "s/:/\//g" | sed "s/git@/https:\/\//g")
  fi
  echo $remote_url
}
