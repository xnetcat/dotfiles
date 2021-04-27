
#!/bin/bash

# You can call this script like this:
# $./volume.sh up
# $./volume.sh down
# $./volume.sh mute

function get_volume {
    amixer get Master | grep '%' | head -n 1 | cut -d '[' -f 2 | cut -d '%' -f 1
}

function is_mute {
    amixer get Master | grep '%' | grep -oE '[^ ]+$' | grep off > /dev/null
}

function send_notification {
    volume=`get_volume`
    bar=$(seq -s "─" $(($volume / 5)) | sed 's/[0-9]//g')
    dunstify -i audio-volume-muted-blocking -t 8 -r 2593 -u normal "    $bar"
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
	if is_mute ; then
	    dunstify -i audio-volume-muted -t 8 -r 2593 -u normal "Mute"
	else
	    send_notification
	fi
	;;
esac