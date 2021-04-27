#!/bin/bash

# You can call this script like this:
# $./volume.sh up
# $./volume.sh down
# $./volume.sh mute

function send_notification {
	volume=$(amixer get Master | grep '%' | head -n 1 | cut -d '[' -f 2 | cut -d '%' -f 1) > /dev/null
  	bar=$(seq -s "─" 0 $(("$volume" / 3)) | sed 's/[0-9]//g')
	text="    $bar"

	if amixer get Master | grep '%' | grep -oE '[^ ]+$' | grep off > /dev/null; then
		icon="audio-volume-muted"
		text="Muted"
	elif [[ (("$volume" -gt 74)) ]]; then
		icon="audio-volume-high"
	elif [[ (("$volume" -lt 26)) ]]; then
		icon="audio-volume-low"
	else
		icon="audio-volume-medium"
	fi
  	
  	dunstify -i "$icon" -r 5555 -u normal "$text"
}



case $1 in
    up)
    	amixer -D pulse sset Master 5%+ unmute
		send_notification
	;;
    down)
    	amixer -D pulse sset Master 5%- unmute
		send_notification
	;;
    mute)
		amixer -D pulse sset Master toggle-mute
		send_notification
	;;
esac