#!/usr/bin/env bash

# Terminate already running bar instances
killall -q polybar
# Launch bar1 and bar2

if [ $HOSTNAME = "stone" ]; then
	MONITOR=DP-0 NETWORK_DEV=wlp7s0f3u1 polybar --reload main &
	MONITOR=HDMI-0 polybar --reload alt &
fi


if [ $HOSTNAME = "puzzle" ]; then
	MONITOR=eDP1 polybar --reload main &
fi


echo "Bars launched..."
