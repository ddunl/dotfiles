#!/usr/bin/env bash

# Terminate already running bar instances
killall -q polybar
# Launch bar1 and bar2

if [ $HOSTNAME = "stone" ]; then
	MONITOR=DP-0 polybar --reload main &
	MONITOR=HDMI-0 polybar --reload alt &
fi


echo "Bars launched..."
