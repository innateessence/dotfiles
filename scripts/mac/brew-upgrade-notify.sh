#!/usr/bin/env bash

NOTIFY=/Users/jack/.dotfiles/scripts/mac/notify.sh
OUTDATED_PKGS=$(/opt/homebrew/bin/brew upgrade -n)
OUTDATED_PKGS_COUNT=$(echo "$OUTDATED_PKGS"| grep -c '\->')
if [[ $OUTDATED_PKGS_COUNT -gt 0 ]]; then
  $NOTIFY "Brew Upgrade" "Outdated Pkgs: $OUTDATED_PKGS_COUNT" || $NOTIFY "CronJob" "Failed to check brew upgrades"
fi
