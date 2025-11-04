#!/usr/bin/env zsh

# May come in handy:
# https://unix.stackexchange.com/a/163645/331876

# function preexec(){
#
# }

function __set_hostname_indicator(){
    # Tell me if I'm running Arch Linux
    if [[ $(hostname) == "ArchDesktop" ]]; then
        __HOSTNAME_INDICATOR="%F{cyan}(Arch)%f "
    # elif [[ $(hostname) == "Brendens-MacBook-Pro.local" ]]; then
    #     __HOSTNAME_INDICATOR="(Mac) "
    else
        __HOSTNAME_INDICATOR=""
    fi
}

function __set_arch_indicator(){
    # Tell me if I'm emulating x86_64 on Apple Silicon CPU (Arm64)
    if [[ $(uname -m) == "x86_64" && $(uname) == "Darwin" ]]; then
        __ARCH_INDICATOR="(x64) "
    else
        __ARCH_INDICATOR=""
    fi
}

function __set_cwd_indicator(){
    # Essentially just formats $(pwd) into my preferred short-hand format
    # Store into a global variable to actually use this. This needs to behave like a callback function who's only job is to modify state.
    # This only modifys the shells prompt representation of the current directory in the context of the shells prompt.
    # NOTE: HPWD is a user-defined variable. Nothing unexpected should happen here.
    local IFS="/"
    local arr=($(pwd | sed "s|^$HOME|~|"))  # Parse as array after string substitution
    # local arr=()
    local left_path
    local right_path

    if [[ ${#arr[@]} -ge 4 ]]; then
        right_path="${arr[@]: -1,-2}"
        left_path="${arr[@]: 0:2}"
        __HPWD="$left_path ⇨ $right_path"
    elif [[ ${#arr[@]} -ge 3 ]]; then
        right_path="${arr[@]: -1}"
        left_path="${arr[@]: 0:2}"
        __HPWD="$left_path ⇨ $right_path"
    elif [[ ${#arr[@]} -eq 2 ]]; then
        __HPWD="${arr[@]: 0:2}"
    else
        __HPWD="${arr[1]}"
    fi
}

function __set_venv_indicator(){
    local __VIRTUAL_ENV_ICON="  "
    test -z $VIRTUAL_ENV \
        && __VENV_INDICATOR="" \
        || __VENV_INDICATOR="$__VIRTUAL_ENV_ICON"
}

function __set_vi_indicator(){
    case ${KEYMAP} in
        vicmd)          __VI_INDICATOR="%F{cyan}[N]%f" ;;    # Normal Mode
        main|viiins)    __VI_INDICATOR="%F{yellow}[I]%f" ;;  # Insert Mode
    esac
}

function __set_all_indicators(){
    __set_hostname_indicator
    __set_vi_indicator
    __set_cwd_indicator
    __set_venv_indicator
    __set_arch_indicator
}

function zle-line-init {
    local __EXIT_CODE="%(?.%F{green}.%F{red})%?%f"                  # Colorize exit code. Fetch this before making any other calls
    __set_all_indicators                                            # Update global indicator variables

    PROMPT="$__HOSTNAME_INDICATOR$__ARCH_INDICATOR$__VENV_INDICATOR$__HPWD $__VI_INDICATOR \$ "          # Left prompt
    RPROMPT="$__EXIT_CODE"                                            # Right prompt
    zle reset-prompt
}

zle -N zle-line-init
zle -N zle-keymap-select
