#!/bin/bash

setxkbmap gb
xrdb -load ~/.Xresources
picom -b --experimental-backends --config ~/.config/picom.conf
feh --bg-scale ~/wallpapers/wallpaper.jpg
polybar &
xeventbind resolution /home/joe/.resources/udev-resize.sh &
