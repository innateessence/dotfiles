#!/usr/bin/env bash

function _notify_mac () {
    /usr/bin/osascript -e "display notification \"$2\" with title \"$1\"" > /dev/null
}

_notify_mac "$1" "$2"
