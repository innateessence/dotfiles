#!/usr/bin/env zsh

# This houses 'private' functions that are exclusively used as helpers to other dotfiles.

# One liners
function __is_mac(){ __is_equal $(uname -s) "Darwin" ; }
function __is_arch_linux(){ command -pv pacman &> /dev/null ; }
function __is_ubuntu(){ uname -v | grep -i -o 'Ubuntu' &> /dev/null }
function __is_equal(){ test $1 = $2 ; }
function __is_vpn_active(){ ifconfig -a | grep $VPN_TUNNEL_DEV &> /dev/null ; }
function __is_in_tmux(){ test -n "$TMUX" ; }

function __get_jira_id(){ branch | grep -ioE "$JIRA_DEFAULT_PROJECT-[0-9]+" ; }
function __get_latest_release_branch(){ git branch | grep -E 'VII[0-9\.]+-release' | tail -n 1 | tr -d ' ' ; }
function __get_repo_name(){ git config --get remote.origin.url | sed -e 's/^git@.*:\([[:graph:]]*\).git/\1/' ; }

function __open_repo(){ __browser_open $(__get_repo_url) &> /dev/null ; }
function __has_internet_access(){ timeout $NETWORK_CHECK_SHELL_TIMEOUT ping -c 1 google.com &> /dev/null ; }
function __git_push() { git push --set-upstream origin $(gb) ;}
function __is_number(){ [[ $1 =~ ^[0-9]+$ ]] ; }

function __is_wsl(){
    if [ -e /proc/version ]; then
        if $(grep -i microsoft /proc/version &>/dev/null) ; then
            return 0
        fi
    fi
    return 1
}


function __lsports_mac(){
    # NOTE: TCP only
    netstat -Watnlv | grep LISTEN | awk '{"ps -ww -o args= -p " $9 | getline procname;colred="\033[01;31m";colclr="\033[0m"; print colred "proto: " colclr $1 colred " | addr.port: " colclr $4 colred " | pid: " colclr $9 colred " | name: " colclr procname;  }' | column -t -s "|"
}

function __lsports_linux(){
    # NOTE: TCP only
    sudo netstat -Watnlvep | grep LISTEN | awk '{
      pid = $9;
      # Extract the numeric PID part from pid/command format (if it exists)
      split(pid, pid_parts, "/");
      pid_num = pid_parts[1];

      if (pid_num > 0) {
        cmd="ps -ww -o args= -p " pid_num;
        cmd | getline procname;
        close(cmd);
        colred="\033[01;31m";
        colclr="\033[0m";
        print colred "proto: " colclr $1 colred " | addr.port: " colclr $4 colred " | pid: " colclr pid_num colred " | name: " colclr procname;
      } else {
        colred="\033[01;31m";
        colclr="\033[0m";
        print colred "proto: " colclr $1 colred " | addr.port: " colclr $4 colred " | pid: " colclr pid colred " | name: " colclr "N/A";
      }
    }' | column -t -s "|"
}



function __is_dir_empty(){
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

function __browser_open(){
    for url in $@; do
        if __is_wsl; then
            $BROWSER $url &> /dev/null
        else
            python -m webbrowser $url &> /dev/null
        fi
    done
}

function __determine_shell(){
    local shells
    shells=(zsh bash)
    for shell in "${shells[@]}"; do
        if [[ "$SHELL" == *"$shell" ]]; then
            echo "$shell"
            return
        fi
    done
}

function __determine_rc_file(){
    local shell
    local rc_file
    shell="$(__determine_shell)"
    rc_file="$HOME"/."$shell"rc
    if [ ! -f "$rc_file" ]; then
        warn "$rc_file does not exist"
    fi
    echo $rc_file
}

function __get_ip(){
    local ip
    ip=$(curl -s ifconfig.me/ip)
    retcode=$?
    if [ $retcode -eq 0 ]; then
        echo $ip
    fi
    return $retcode
}


function __get_repo_url(){
    local remote_url
    remote_url="$(git config --get remote.origin.url || git config --get remote.upstream.url)"
    if [[ $remote_url != "https://"* ]]; then
        remote_url=$(echo $remote_url | sed "s/:/\//g" | sed "s/git@/https:\/\//g" | sed "s/\.git//g")
    fi
    echo $remote_url
}

function __outdated_pkgs(){
    if __is_mac; then
        brew upgrade -n 2>&1 | grep '\->' | wc -l | tr -d ' '
    elif __is_arch_linux; then
        pacman -Qu | wc -l | tr -d ' '
    fi
}

function __notify_mac(){
    # $1 = title
    # $2 = message
    /usr/bin/osascript -e "display notification \"$2\" with title \"$1\"" > /dev/null 2>&1
}

function __get_http_code(){
    local url="$1"
    local follow_redirects="${2:-false}"
    local response
    if $follow_redirects; then
        response=$(curl -L --write-out '%{http_code}' -I --silent --output /dev/null $url)
    else
        response=$(curl --write-out '%{http_code}' -I --silent --output /dev/null $url)
    fi
    echo $response
}

function __is_up(){
    local url="$1"
    local resp_code=$(__get_http_code $url)
    echo $resp_code | grep -E "2[0-9][0-9]|3[0-9][0-9]" &> /dev/null && return 0
    return 1
}

function __write_to_current_stdin(){
    print -z "$1"
}

function __pidsof(){
    # Custom function for searching running processes and yielding the PID of the results
    local name="$1"
    local pids

    if __is_mac; then
      pids=($(ps -e | grep "$1" | grep -v grep | awk '{print $1}' | tr '\n' ' '))
    else
      pids=($(ps a | grep "$1" | grep -v grep | awk '{print $1}' | tr '\n' ' '))
    fi

    for pid in $pids; do
        echo $pid
    done
}

function __is_mouse_wiggling(){
    test $(__pidsof 'mouse-wiggle.py')
}

function __mac_updates(){
    softwareupdate -l -a 2>&1 | grep -i 'update available'
    brew outdated | grep -i 'outdated'
}

function __mac_last_unlock_time(){
    log show --style syslog --predicate 'process == "loginwindow"' --debug --info --last 4h | grep "LUIAuthenticationServiceProvider" | grep "activateWithUserName:sessionUnlocked" | tail -n 1 | awk '{print $1,$2}'
}

function __is_picture_file(){
    magick identify -quiet -format "%m" "$1" &> /dev/null
}

function __git_has_uncommitted_changes(){
    test -n "$(git status --porcelain)"
}

function __cd_to_finder(){
    cd "$(osascript -e 'tell app "Finder" to POSIX path of (insertion location as alias)')"
}
