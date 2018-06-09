#!/bin/bash
# This script allows to switch between single and dual monitor using xrandr

# Left (L) and right (R) screens
OUT_L="DVI-I-2"
OUT_R="DVI-I-1"

# if we don't have a file, consider current display mode  is dual (default)
if [ ! -f "/tmp/monitor_mode.dat" ] ; then
  monitor_mode="dual"

# otherwise read the value from the file to determine display mode
else
  monitor_mode=`cat /tmp/monitor_mode.dat`
fi

# If the current display mode is dual, change to single (turn right screen off)
if [ $monitor_mode = "dual" ]; then
        monitor_mode="single"
        xrandr --output $OUT_R --off --output $OUT_L --auto
# If current mode is single, change to dual by turning on right screen
elif [ $monitor_mode = "single" ]; then
        monitor_mode="dual"
        xrandr --output $OUT_R --auto --output $OUT_L --auto --left-of $OUT_R
        feh --bg-scale /home/cyril/Pictures/wallpapers/archlinux_rain.png
fi
# Write new state to the file
echo "${monitor_mode}" > /tmp/monitor_mode.dat
