#!/bin/bash
su - joe -c 'export DISPLAY=:0;feh --bg-scale ~/wallpapers/wallpaper.jpg'
pkill -USR1 polybar
