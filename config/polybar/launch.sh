#!/usr/bin/env bash

# Terminate already running bar instances
killall -q polybar
killall -q zscroll

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch Polybar
polybar top -c ~/.config/polybar/config.ini &
