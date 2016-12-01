#!/bin/bash

# Install git
sudo pacman -S git

# Install pacaur
mkdir ~/git/
cd ~/git/
git clone https://aur.archlinux.org/pacaur
makepkg -si

# Install various crap
pacaur -S rofi gvim-git htop sysstat ttf-inconsolata ttf-font-awesome dmenu
