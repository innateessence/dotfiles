#!/usr/bin/env bash


function is_low_power_mode_active() {
    local is_on
    is_on=$(pmset -g | grep "lowpowermode" | grep -o -E "[0-9]")
    if [[ "$is_on" == "1" ]]; then
        return 0
    elif [[ "$is_on" == "0" ]]; then
        return 1
    else
        echo "Error: Could not determine if low power mode is active"
        exit 1
    fi
}

function set_low_power_mode(){
    pmset -a lowpowermode 1 && echo "Low power mode enabled"
}

function set_high_power_mode(){
    pmset -a lowpowermode 0 && echo "Low power mode disabled"
}

function toggle_power_mode(){
    if is_low_power_mode_active; then
        set_high_power_mode
    else
        set_low_power_mode
    fi
}

function runtime_check() {
    if [[ $(uname) != "Darwin" ]]; then
        echo "This script is only meant to be run on MacOS"
        exit 1
    fi
    if ! command -v pmset &>/dev/null; then
        echo "pmset not found. This script is only meant to be run on MacOS"
        exit 1
    fi
    if [[ $(whoami) != "root" ]]; then
        echo "This script must be run as root"
        exit 1
    fi
}

runtime_check
toggle_power_mode
