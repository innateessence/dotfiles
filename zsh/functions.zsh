#!/usr/bin/env zsh

# One-liners (Generic)

function msg(){ echo `tput bold; tput setaf 2`"[+] ${*}"`tput sgr0`; }
function info(){ echo `tput bold; tput setaf 3`"[*] ${*}"`tput sgr0`; }
function warn(){ echo >&2 `tput bold; tput setaf 1`"[!] WARN: ${*}"`tput sgr0`; }
function error(){ echo >&2 `tput bold; tput setaf 1`"[-] ERROR: ${*}"`tput sgr0` ; exit 1; }
function command_exists(){ command -v "$1" &> /dev/null; }

# One-liners (Misc)
function lsports(){ netstat -Watnlv | grep LISTEN | awk '{"ps -ww -o args= -p " $9 | getline procname;colred="\033[01;31m";colclr="\033[0m"; print colred "proto: " colclr $1 colred " | addr.port: " colclr $4 colred " | pid: " colclr $9 colred " | name: " colclr procname;  }' | column -t -s "|" ; }
function gen-pass(){ echo $(base64 < /dev/urandom | tr -d 'O0Il1+/' | head -c 16) | xclip -i ; echo "[+] Copied password to clipboard"}
# function has_connections(){ has_internet_access && has_git_access || return 1 ; }

# --------- #
# Functions #
# --------- #

# function rvim(){
#   # Lunarvim for rust. since I've been having... issues
#   local DEFAULT_RUNTIME_DIR
#   local DEFAULT_CONFIG_DIR
#   local DEFAULT_CACHE_DIR

#   DEFAULT_RUNTIME_DIR="$LUNARVIM_RUNTIME_DIR"
#   DEFAULT_CONFIG_DIR="$LUNARVIM_CONFIG_DIR"
#   DEFAULT_CACHE_DIR="$LUNARVIM_CACHE_DIR"

#   export LUNARVIM_RUNTIME_DIR="$HOME/.local/share/rustvim"
#   export LUNARVIM_CONFIG_DIR="$HOME/.config/rvim"
#   export LUNARVIM_CACHE_DIR="$HOME/.cache/rvim"

#   test -e "$LUNARVIM_RUNTIME_DIR" || mkdir -p "$LUNARVIM_RUNTIME_DIR"
#   test -e "$LUNARVIM_CONFIG_DIR" || mkdir -p "$LUNARVIM_CONFIG_DIR"
#   test -e "$LUNARVIM_CACHE_DIR" || mkdir -p "$LUNARVIM_CACHE_DIR"

#   echo $LUNARVIM_CONFIG_DIR

#   nvim -u "$LUNARVIM_RUNTIME_DIR/lvim/init.lua" $@

#   test -z "$DEFAULT_RUNTIME_DIR" && unset "LUNARVIM_RUNTIME_DIR" || export LUNARVIM_RUNTIME_DIR="$DEFAULT_RUNTIME_DIR"
#   test -z "$DEFAULT_CONFIG_DIR" && unset "LUNARVIM_CONFIG_DIR" || export LUNARVIM_CONFIG_DIR="$DEFAULT_CONFIG_DIR"
#   test -z "$DEFAULT_CACHE_DIR" && unset "LUNARVIM_CACHE_DIR" || export LUNARVIM_CACHE_DIR="$DEFAULT_CACHE_DIR"

# }

function contains() {
    string="$1"
    substring="$2"
    if test "${string#*$substring}" != "$string"
    then
        return 0    # $substring is in $string
    else
        return 1    # $substring is not in $string
    fi
}

# Quickly toggle primary virtualenv
function ve(){
  if [ $VIRTUAL_ENV ]; then
    deactivate
  else
    if [ $# -eq 1 ]; then
      if contains "$1" "activate"; then
        source "$1"
      else
        source "$DEFAULT_DIR/ve/bin/activate"
      fi
    fi
  fi
}

function jopen(){
  if [[ $# -eq 0 ]]; then
    # if run with no args, just open the current branches story
    _browser_open https://kanasoftware.jira.com/browse/$(_get_jira_id)
  else
    for jira_id in $@; do
      # Handle passing in the ID as just an int
      if ! [[ $jira_id =~ 'VII' ]]; then
        jira_id="VII-$jira_id"
      fi
      _browser_open https://kanasoftware.jira.com/browse/$jira_id
    done
  fi
}

# function to figure out what I was working on last week (aka where I leftoff last)
function leftoff(){
  info $(branch)
  git diff --name-only HEAD HEAD~1 | grep -v locale | sed "s/^/   /"
  echo
  info 'Consider running `propen` and `jopen` for additional context'
}

function get_cpu_count(){ 
  # Gets the current CPU count without needing `nproc` binary
  if [ -f /proc/cpuinfo ]; then
    grep 'processor' /proc/cpuinfo | uniq | wc -l; 
  else
    sysctl -n hw.ncpu  # Mac doesn't have /proc/cpuinfo
  fi
}

function help(){ 
  # Simple wrapper for colorized help text / colorized man page.
  # Auto-magically determines to display help text or a man page.
  if command_exists "$@"; then
    if "$@" --help &> /dev/null; then
      "$@" --help 2>&1 | bat --plain --language=help --theme="default"
    else
      man "$@"
    fi
  else
    man "$@"
  fi
}

function lvim-reinstall(){
  # Lets automate the process of reinstalling Lvim in case I break it again.
  local uninstall
  local install_url
  uninstall="$HOME/.local/share/lunarvim/lvim/utils/installer/uninstall.sh"
  install_url="https://raw.githubusercontent.com/lunarvim/lunarvim/master/utils/installer/install.sh"

  info "Leaving VirtualEnv" &&
  deactivate && \
  info "Uninstalling LunarVim" && \
  $uninstall && \
  info "Installing LunarVim" && \
  bash <(curl -s $install_url) -y && \
  msg "Installed LunarVim" && \
  lvim-update && \
  lvim +checkhealth && info "Please review changes between new and old config in ~/.config" || warn "Failed to finish reinstalling LunarVim"
}

function branches(){
  # List local branches in order of most recent commit
  local count
  local format
  count=${1:-10}
  format='%(HEAD)%(color:yellow)%(refname:short)|%(color:bold green)%(committerdate:relative)|%(color:blue)%(subject)|%(color:magenta)%(authorname)%(color:reset)'
  git for-each-ref --count=$count --sort=-committerdate refs/heads/ --format=$format --color=always | column -ts'|'
}

function reload(){
  # Quickly reload current shell config
  local old_cwd
  local rc_file
  old_cwd=$(pwd)
  rc_file="$(_determine_rc_file)"
  source $rc_file
  cd "$old_cwd"
}

function mkquickcd(){
  # Makes various aliases to quickly `cd` into various dotfile directories.
  local filename
  for dotfiledir in ~/.dotfiles/*
  do if [[ -d "$dotfiledir" ]]; then
    filename=($(echo "$dotfiledir" | tr "/" " "))
    filename=$filename[-1]
    alias "cd.$filename"="cd $dotfiledir"
  fi; done
}


function has_internet_access(){
  local retval=0
  if _has_internet_access; then
    msg "Internet OK"
    retval=0
  else
    warn "Internet BAD"
    retval=1
  fi
  return $retval
}

# function has_git_access(){
#   local retval=0
#   if _is_vpn_active; then
#     if _has_git_access; then
#       msg "Git OK"
#       retval=0
#     else
#       warn "Git BAD"
#       retval=1
#     fi
#   else
#     warn "Not tunneling through VPN"
#   fi
#   return $retval

# }

function untar(){
  while [ ${#} != 0 ]; do if [ -f "${1}" ]; then case "${1}" in
    *.tar);         tar xfv  "${1}";  shift;;
    *.tar.xz);      tar xfv  "${1}";  shift;;
    *.tar.bz2);     tar xjvf "${1}";  shift;;
    *.tbz2);        tar xjvf "${1}";  shift;;
    *.tar.gz);      tar xzvf "${1}";  shift;;
    *.tgz);         tar xzvf "${1}";  shift;;
    *.bz2);         bunzip2  "${1}";  shift;;
    *.rar);         rar x    "${1}";  shift;;
    *.gz);          gunzip   "${1}";  shift;;
    *.zip);         unzip    "${1}";  shift;;
    *.Z);         uncompress "${1}";  shift;;
    *.7z);          7z x     "${1}";  shift;;
    *) echo "$1 cannot be extracted via $0"; shift
  esac; else; echo "$1 is not a valid file"; shift; fi; done
}

# function pkg_from(){
#   retval=$(pacman -F "$1" | head -n 1 | sed 's/.*is owned by .*\///g' | sed 's/.*\///g' | sed 's/ .*//g')
#   test $retval && echo $retval && return
#   retval=$(pacman -Ql | grep "$1" | head -n 1 | sed "s/ .*//g")
#   retval=$(pacman -Q "$retval")
#   echo $retval
#   return

# }

# function missing_files(){
#   pkgs=($(pacman -Ql | sed 's/.* //g'))
#   for pkg in $pkgs[@]; do
#     if ! test -e "$pkg"; then
#       echo "$pkg - $(pkg_from "$pkg")"
#     fi
#   done
# }
