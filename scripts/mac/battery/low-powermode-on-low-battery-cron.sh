#!/usr/bin/env bash

# This script is meant to be consumed in a cronjob to automate
# switching power modes based on battery percentage.

DEFAULT_TARGET_MIN_PERCENTAGE=25

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

function get_battery_percentage() {
    local percentage
    percentage=$(pmset -g batt | grep -o -E "[0-9]+%" | cut -d% -f1)
    echo "$percentage"
}

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

function Main(){
    runtime_check
    target_min_percentage=${1:-$DEFAULT_TARGET_MIN_PERCENTAGE}
    current_percentage=$(get_battery_percentage)
    if is_low_power_mode_active; then
        echo "Low power mode is already active"
        exit 0
    fi

    if [[ "$current_percentage" -le "$target_min_percentage" ]]; then
        set_low_power_mode
    else
        echo "Battery percentage is above target minimum"
        exit 0
    fi
}

Main "$@"
