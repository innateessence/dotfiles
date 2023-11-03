#!/usr/bin/env bash


PWSH="/mnt/c/Windows/System32/WindowsPowerShell/v1.0/powershell.exe"
PWSH_NOTIFY="/home/jack/.dotfiles/scripts/windows/notify.ps1"
PWSH_NOTIFY=$(wslpath -w $PWSH_NOTIFY)
echo $PWSH_NOTIFY

if [[ $# -eq 2 ]]; then
  $PWSH -ExecutionPolicy Bypass -File "$PWSH_NOTIFY" -ToastTitle "$1" -ToastText "$2"
fi
if [[ $# -eq 1 ]]; then
  $PWSH -ExecutionPolicy Bypass -File "$PWSH_NOTIFY" -ToastTitle "$1"
fi
if [[ $# -eq 0 ]]; then
  echo "Usage: notify <title> <message>"
  exit 1
fi


