#!/usr/bin/env bash

SCRIPT_DIRS=("$HOME/.dotfiles/scripts" "$HOME/work/scripts")
EXTENSIONS=('sh' 'py')
FILE_PATHS=()

function not_in_menu(){
    for path in "${FILE_PATHS[@]}"
    do
        if [ "$path" == "$1" ]
        then
          echo "$path is already in the menu"
          return 1
        fi
    done
    return 0
}

function build_menu(){
    local idx=0
    for ext in "${EXTENSIONS[@]}"; do
        for script_path in ${SCRIPT_DIRS[@]}; do
            for file in $(find $script_path -type f -name "*.$ext"); do
                if test -x "$file" && not_in_menu "$file"; then
                    FILE_PATHS+=($file)
                    idx=$((idx+1))
                fi
            done
        done
    done
}

function print_menu(){
    local idx=0
    for menu_path in "${FILE_PATHS[@]}"; do
        echo "$idx. $menu_path"
        idx=$((idx+1))
    done
}

function get_choice_idx(){
    local choice="$1"
    local choice_idx=0
    for menu_path in "${FILE_PATHS[@]}"; do
        if [[ "$menu_path" == "$choice" ]]; then
            echo $choice_idx
            return 0
        fi
        choice_idx=$((choice_idx+1))
    done
    return 1
}

function menu_name_to_choice(){
    local string=$1
    local result="${string#*\. }"
    echo "$result" | tr -d '\\'
}

function Main(){
    build_menu
    local choice
    choice=$(print_menu | choose -b ff79c6 -w 48 -n 8 | cut -d' ' -f2-)
    local choice_idx
    choice_idx=$(get_choice_idx "$choice")
    "${FILE_PATHS[$choice_idx]}"
}

Main
