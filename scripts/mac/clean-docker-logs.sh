#!/usr/bin/env bash

# I am aware this can be handled via configuration instead.
# But sometimes, a script that solves the problem better.
# This CAN cause issues if this runs while docker is appending logs to the file.
# It is possibly that if you use this, `docker logs` will throw an error due to a partial log entry being present.
# Don't use this if you don't know what you're doing.

VERBOSE=true
LOG_PATH='/Users/jack/Library/Containers/com.docker.docker/Data/log/host'

function wipe_log(){
    # $1: log file path
    # example usage:
    #   wipe_log "$LOG_PATH/monitor.log.0" true
    local log_file="$1"
    if [ "$VERBOSE" = true ]; then
        echo "Wiping log file: $log_file"
        du -sh "$log_file"
    fi

    truncate -s 0 "$log_file"
}

function Main(){
    for log_file in "$LOG_PATH"/* ; do
        wipe_log "$log_file"
    done

    du -sh "$LOG_PATH"
}

Main
