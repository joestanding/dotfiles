#!/bin/bash

setxkbmap gb
xrdb -load ~/.Xresources
compton -b -c
feh --bg-scale ~/wallpapers/wallpaper.jpg
polybar mint &
xeventbind resolution /home/joe/.resources/udev-resize.sh &
