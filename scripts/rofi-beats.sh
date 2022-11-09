#!/usr/bin/env bash

# NOTE: This script seemingly MUST use absolute paths
# at least in regards to the tool I'm using to key-bind this.

# This is just for pleasure and mood improvement.
# Rofi-like menu for 24/7 lofi streams to run in the background.
# Working happier is working better

notification(){
  /usr/bin/osascript -e 'display notification "Lofi Radio ☕️🎶" with title "Now Playing:"' > /dev/null 2>&1
}

menu(){
	printf "1. Lofi Girl\n"
	printf "2. Chillhop\n"
	printf "3. Box Lofi\n"
	printf "4. The Bootleg Boy\n"
	printf "5. Radio Spinner\n"
	printf "6. SmoothChill"
}

main() {
  local choice
	choice=$(menu | /usr/local/bin/choose -b ff79c6 -w 48 -n 7 | cut -d. -f1)

	case $choice in
		1)
			notification ;
				/usr/local/bin/mpv "https://play.streamafrica.net/lofiradio"
			return
			;;
		2)
			notification ;
				/usr/local/bin/mpv "http://stream.zeno.fm/fyn8eh3h5f8uv"
			return
			;;
		3)
			notification ;
				/usr/local/bin/mpv "http://stream.zeno.fm/f3wvbbqmdg8uv"
			return
			;;
		4)
			notification ;
				/usr/local/bin/mpv "http://stream.zeno.fm/0r0xa792kwzuv"
			return
			;;
		5)
			notification ;
				/usr/local/bin/mpv "https://live.radiospinner.com/lofi-hip-hop-64"
			return
			;;
		6)
			notification ;
				/usr/local/bin/mpv "https://media-ssl.musicradio.com/SmoothChill"
			return
			;;
	esac
}

kill $(/usr/local/bin/pidof mpv) > /dev/null 2>&1 # Kill existing session if running
main
