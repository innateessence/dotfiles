#!/usr/bin/env bash
#
function get_timestamp(){
    log show --style syslog --predicate 'process == "loginwindow"' --debug --info --last 4h | grep "LUIAuthenticationServiceProvider" | grep "activateWithUserName:sessionUnlocked" | tail -n 1 | awk '{print $1,$2}'
}

function update_timestamp(){
    echo "$LAST_TIMESTAMP" > "$FILE_PATH"
}

FILE_PATH="/Users/jack/.last_unlocked_timestamp"
if [[ ! -f "$FILE_PATH" ]]; then
    touch "$FILE_PATH"
    update_timestamp
fi

LAST_TIMESTAMP="$(get_timestamp)"
FILE_CONTENTS="$(cat "$FILE_PATH")"

if [[ -z "$LAST_TIMESTAMP" ]]; then
    echo "No timestamp found"
    exit 1
fi
if [[ "$FILE_CONTENTS" != "$LAST_TIMESTAMP" ]]; then
    echo "Killing screensaver"
    kill -9 "$(ps aux | grep -E '[Ll]egacy[ Ss]creen[ Ss]aver' | awk '{print $2}')"
    update_timestamp
fi
