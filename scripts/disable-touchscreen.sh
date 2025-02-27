#!/usr/bin/env bash

export PATH="/usr/bin:/bin:/usr/sbin:/sbin"

function is_num(){
  if [[ "$1" =~ ^[0-9]+$ ]]; then
    return 0
  fi
  return 1
}

array=($(xinput list | grep "Wacom HID 4A43" | awk '{print $8}' | tr -d 'id=' | xargs -n1 echo))

has_disabled=false

for item in "${array[@]}"; do
  is_num "$item" && xinput disable "$item" && echo "Disabled xinput id: $item" && has_disabled=true
done

test "$has_disabled" == true && echo "xinput devices disabled by '$0'"
