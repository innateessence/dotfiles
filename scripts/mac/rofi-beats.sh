#!/usr/bin/env bash

# NOTE: This script seemingly MUST use absolute paths (Or otherwise source my dotfiles / muck with $PATH)
# at least in regards to the tool I'm using to key-bind this.

# NOTE: You must include the `yt-dlp` binary in $PATH in the shells environment that executes this script, otherwise Youtube links won't work properly.

# This is just for pleasure and mood improvement.
# Rofi-like menu for 24/7 lofi streams to run in the background.
# Working happier is working better

PATH=$PATH:"/opt/homebrew/bin:/usr/bin"

notification(){
    osascript -e 'display notification "Lofi Radio ☕️🎶" with title "Now Playing:"' > /dev/null 2>&1
}

menu(){
    printf "1. Lofi Girl\n"
    printf "2. Phonk House\n"
    printf "3. Chillhop\n"
    printf "4. Box Lofi\n"
    printf "5. The Bootleg Boy\n"
    printf "6. Radio Spinner\n"
    printf "7. SmoothChill"
}

main() {
    local choice
    choice=$(menu | choose -b ff79c6 -w 48 -n 8 | cut -d. -f1)

    case $choice in
        1)
            notification ;
            mpv --no-video "https://play.streamafrica.net/lofiradio"
            return
            ;;
        2)
            notification ;
            mpv --no-video "http://www.youtube.com/watch?v=ab-WFNS27co"
            return
            ;;
        3)
            notification ;
            mpv --no-video "http://stream.zeno.fm/fyn8eh3h5f8uv"
            return
            ;;
        4)
            notification ;
            mpv --no-video "http://stream.zeno.fm/f3wvbbqmdg8uv"
            return
            ;;
        5)
            notification ;
            mpv --no-video "http://stream.zeno.fm/0r0xa792kwzuv"
            return
            ;;
        6)
            notification ;
            mpv --no-video "https://live.radiospinner.com/lofi-hip-hop-64"
            return
            ;;
        7)
            notification ;
            mpv --no-video "https://media-ssl.musicradio.com/SmoothChill"
            return
            ;;
    esac
}

kill -9 $(pidof mpv) > /dev/null 2>&1 # Kill existing session if running
main
echo '' &> /dev/null  # This is a hack to override the exit code. This will prevent errors from displaying if this script kills `mpv --no-video`
