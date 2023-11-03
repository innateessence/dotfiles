#!/usr/bin/env bash

TELEGRAM_DOWNLOAD_DIR="$HOME/Downloads/Telegram Downloads"
TELEGRAM_PICTURE_DIR="$HOME/Pictures/Telegram Pictures"

function is_picture_file(){
    /opt/homebrew/bin/magick identify -quiet -format "%m" "$1" &> /dev/null
}

function move_images(){
    for f in "$TELEGRAM_DOWNLOAD_DIR"/*; do
        if is_picture_file "$f"; then
            mv "$f" "$TELEGRAM_PICTURE_DIR"
            echo "mv $f -> $TELEGRAM_PICTURE_DIR"
        fi
    done
}

function error(){
  echo "$@"
  exit 1
}

if ! command -v /opt/homebrew/bin/magick &> /dev/null; then
    echo "magick not found"
    exit 1
fi

cd "$TELEGRAM_DOWNLOAD_DIR" || error "cd $TELEGRAM_DOWNLOAD_DIR failed"
move_images
