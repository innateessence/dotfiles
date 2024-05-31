#!/usr/bin/env zsh

# One-liners (Generic)

function msg(){ echo `tput bold; tput setaf 2`"[+] ${*}"`tput sgr0`; }
function info(){ echo `tput bold; tput setaf 3`"[*] ${*}"`tput sgr0`; }
function warn(){ echo >&2 `tput bold; tput setaf 1`"[!] WARN: ${*}"`tput sgr0`; }
function error(){ echo >&2 `tput bold; tput setaf 1`"[-] ERROR: ${*}"`tput sgr0` ; exit 1; }
function command_exists(){ command -v "$1" &> /dev/null; }
function file_exists() { [[ -a "$1" ]] ; }
function directory_exists() { [[ -d "$1" ]] ; }
function work() { source $DOTFILES_DIR/zsh/work-functions.zsh ; }
function get_dir() { echo $( dirname "$(realpath "$1")" ) ; } # A better version of `dirname`
function beep_me(){ for i in {0..${1:-25}}; do printf "\a" && sleep 0.1 ; done ; }
function pids_mem(){ ps -p $1 -o rss | grep -v "RSS" | numfmt --to=iec ; } # gets (real) resident memory usage of a process

# One-liners (Misc)
function lsports(){ netstat -Watnlv | grep LISTEN | awk '{"ps -ww -o args= -p " $9 | getline procname;colred="\033[01;31m";colclr="\033[0m"; print colred "proto: " colclr $1 colred " | addr.port: " colclr $4 colred " | pid: " colclr $9 colred " | name: " colclr procname;  }' | column -t -s "|" ; }
# function lsportprogs(){ lsports | grep -o -E "name:.+" | sed 's/name: //g' | sort | uniq | sed 's/--.*//g' ; }
function gen_pass(){ echo $(base64 < /dev/urandom | tr -d 'O0Il1+/' | head -c 16) | clip ; }
# function has_connections(){ has_internet_access && has_git_access || return 1 ; }
function outdated_pkgs(){ info "Outdated Packages:" $(__outdated_pkgs) ; }

# --------- #
# Functions #
# --------- #

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

function jopen(){
    if [[ $# -eq 0 ]]; then
        # if run with no args, just open the current branches story
        __browser_open $JIRA_URL/browse/$(__get_jira_id)
    else
        for jira_id in $@; do
            # Handle passing in the ID as just an int
            if __is_number $jira_id ; then
                jira_id="$JIRA_DEFAULT_PROJECT-$jira_id"
            fi
            __browser_open $JIRA_URL/browse/$jira_id
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
    old_cwd=$(pwd) || $HOME
    rc_file="$(__determine_rc_file)"
    source "$rc_file"
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
    if __has_internet_access; then
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
#   if __is_vpn_active; then
#     if __has_git_access; then
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

function notify(){
    if __is_mac; then
        __notify_mac "$1" "$2"
    fi
    # TODO: Add support for WSL
}

function untar(){
    while [ ${#} != 0 ];
    do if [ -f "${1}" ]; then
            case "${1}" in
                *.tar);         tar xfv  "${1}";  shift ;;
                *.tar.xz);      tar xfv  "${1}";  shift ;;
                *.tar.bz2);     tar xjvf "${1}";  shift ;;
                *.tbz2);        tar xjvf "${1}";  shift ;;
                *.tar.gz);      tar xzvf "${1}";  shift ;;
                *.tgz);         tar xzvf "${1}";  shift ;;
                *.bz2);         bunzip2  "${1}";  shift ;;
                *.rar);         rar x    "${1}";  shift ;;
                *.gz);          gunzip   "${1}";  shift ;;
                *.zip);         unzip    "${1}";  shift ;;
                *.Z);         uncompress "${1}";  shift ;;
                *.7z);          7z x     "${1}";  shift ;;
                *) echo "$1 cannot be extracted via $0"; shift
            esac;
        else;
            echo "$1 is not a valid file";
            shift;
        fi;
    done
}


function ve(){
    # Quick and dirty virtualenv manager
    local VIRTUAL_ENVS_DIR="$HOME/.virtualenvs"
    local TARGET_VIRTUALENV
    if test $VIRTUAL_ENV; then
        TARGET_VIRTUALENV=$(basename $VIRTUAL_ENV)
    else
        TARGET_VIRTUALENV=$DEFAULT_VIRTUALENV
    fi
    local COMMAND_QUEUE=()  # A hacky way to create a queue of commands to run after parsing args

    local function is_in_ve(){ test "$VIRTUAL_ENV" ; }
    local function ve_exists(){ directory_exists "$VIRTUAL_ENVS_DIR/$TARGET_VIRTUALENV" ; }
    local function mk_ve(){ ve_exists && rm_ve ; python -m venv "$VIRTUAL_ENVS_DIR/$TARGET_VIRTUALENV" && msg "Created VirtualEnv $TARGET_VIRTUALENV" ; }
    local function mk_ve_if_not_exists(){ if ! ve_exists; then mk_ve; fi }
    local function rm_ve(){ rm -rf "$VIRTUAL_ENVS_DIR/$TARGET_VIRTUALENV" && msg "Removed VirtualEnv $TARGET_VIRTUALENV" ; }
    local function deactivate_ve(){ is_in_ve && deactivate && info "Deactivated VirtualEnv" && unset VIRTUAL_ENV ; }
    local function toggle_ve(){ is_in_ve && deactivate_ve || activate_ve ; }
    local function activate_ve(){ ! is_in_ve && mk_ve_if_not_exists && source "$VIRTUAL_ENVS_DIR/$TARGET_VIRTUALENV/bin/activate" && info "Activated VirtualEnv: $TARGET_VIRTUALENV" ; }
    local function ve_info(){ info "Current VirtualEnv: $(basename $VIRTUAL_ENV)" ; }
    local function print_help(){
        echo "Usage: ve [options]"
        echo
        echo "Options:"
        echo "  -n | --name <virtualenv_name>   Set the name of the virtualenv to use"
        echo "  -mk| --make                     Create the virtualenv if it doesn't exist"
        echo "  -rm| --remove                   Remove the virtualenv"
        echo "  -d | --deactivate               Deactivate virtualenv"
        echo "  -a | --activate                 Activate virtualenv (defaults to default ve)"
        echo "  -i | --info                     Get info about current virtualenv"
        echo "  -h | --help                     Print this help text"
    }

    function list_ves(){
        for f in $VIRTUAL_ENVS_DIR/*; do
            if [ -d "$f" ]; then
                if [[ "$f" == "$VIRTUAL_ENV" ]]; then
                    info $(basename "$f")
                else
                    echo "    $(basename $f)"
                fi
            fi
        done
    }

    if [ ${#} -eq 0 ]; then
        mk_ve_if_not_exists
        toggle_ve
    fi

    while [ ${#} != 0 ]; do
        case "$1" in
            -n|--name)
                shift
                TARGET_VIRTUALENV="$1"
                shift
                ;;
            -mk|--make)
                COMMAND_QUEUE+=("mk_ve")
                shift
                ;;
            -rm|--remove)
                COMMAND_QUEUE+=("rm_ve")
                shift
                ;;
            -d|--deactivate)
                COMMAND_QUEUE+=("deactivate_ve")
                shift
                ;;
            -a|--activate)
                COMMAND_QUEUE+=("activate_ve")
                shift
                ;;
            -l|--list)
                list_ves
                shift
                ;;
            -i|--info)
                ve_info
                shift
                ;;
            -h |--help)
                print_help
                return
                ;;
            *)
                warn "Unknown argument: $1"
                shift
                ;;
        esac
    done

    for command in "${COMMAND_QUEUE[@]}"; do
        "$command"
    done

}

function wait_until_up(){
    local url="${1:-http://icanhazip.com}"
    local max_retries=${2:-60}
    if __is_up $url; then
        msg "$url is up"
        return 0
    else
        warn "$url is not up"
        for i in $(seq 1 $max_retries); do
            sleep 1
            if __is_up $url; then
                msg "$url is up"
                return 0
            fi
        done
        warn "Timed out waiting for $url to be up"
        return 1
    fi
}


function is_mouse_wiggling(){
    if __is_mouse_wiggling; then
        echo "Yes"
    else
        echo "No"
    fi
}


function nvim-install(){
    local target_file="nvim-macos.tar.gz"
    local target_version="0.9.0"
    local target_arch=""
    local url="https://github.com/neovim/neovim/releases/download/v$target_version/$target_file"
    echo "[*] Downloading $url"
    curl -LO $url
    echo "[*] Installing nvim"
    tar xvf $target_file
    cp -r nvim-macos/* ~/.local
    echo "[*] Cleaning up"
    rm -rf nvim-macos
    rm $target_file
}


# function mk-vpn(){
#     docker run -it --rm --cap-add=NET_ADMIN -p 1194:1194/udp -p 80:8080/tcp \
#         -e HOST_ADDR=$(curl -s https://api.ipify.org) \
#         --name dockovpn alekslitvinenk/openvpn"
# }
