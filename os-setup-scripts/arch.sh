#!/bin/bash

local BLACK="\[\033[0;30m\]"
local BLACKBOLD="\[\033[1;30m\]"
local RED="\[\033[0;31m\]"
local REDBOLD="\[\033[1;31m\]"
local GREEN="\[\033[0;32m\]"
local GREENBOLD="\[\033[1;32m\]"
local YELLOW="\[\033[0;33m\]"
local YELLOWBOLD="\[\033[1;33m\]"
local BLUE="\[\033[0;34m\]"
local BLUEBOLD="\[\033[1;34m\]"
local PURPLE="\[\033[0;35m\]"
local PURPLEBOLD="\[\033[1;35m\]"
local CYAN="\[\033[0;36m\]"
local CYANBOLD="\[\033[1;36m\]"
local WHITE="\[\033[0;37m\]"
local WHITEBOLD="\[\033[1;37m\]"
local RESET="\[\033[00m\]"

echo "[*] ${BLUE}Updating Pacman repositories and performing a full upgrade${RESET}"
sudo pacman --noconfirm -Syu
echo "[*] ${BLUE}Retrieving GPG key for Cower author${RESET}"
gpg --recv-keys --keyserver hkp://pgp.mit.edu 1EB2638FF56C0C53
echo "[*] ${BLUE}Installing some packages (wget, git, vim) we might need${RESET}"
sudo pacman --noconfirm -S wget git vim

echo "[*] ${BLUE}Retrieving Cower from the AUR${RESET}"
wget https://aur.archlinux.org/cgit/aur.git/snapshot/cower.tar.gz -O /tmp/cower.tar.gz
echo "[*] ${BLUE}Installing Cower${RESET}"
cd /tmp
tar xzvf cower.tar.gz
cd cower
makepkg -s
sudo pacman --noconfirm -U *.tar.xz

echo "[*] ${BLUE}Retrieving Pacaur from the AUR${RESET}"
wget https://aur.archlinux.org/cgit/aur.git/snapshot/pacaur.tar.gz -O /tmp/pacaur.tar.gz
echo "[*] ${BLUE}Installing Pacaur${RESET}"
cd /tmp
tar xzvf pacaur.tar.gz
cd pacaur
makepkg -s
sudo pacman --noconfirm -U *.tar.xz

# Official repo
echo "[*] ${BLUE}Installing a bunch of packages that we want${RESET}"
pacaur --noconfirm -S gtk3 gtkmm xorg xorg-xinit xf86-video-vmware open-vm-tools mlocate feh openssh compton 

# AUR
pacaur --noconfirm -S i3-gaps termite-git terminess-powerline-font-git ttf-font-awesome polybar-git open-vm-tools-dkms

# Create SSH key
echo "[*] ${BLUE}Creating SSH key${RESET}"
ssh-keygen -t rsa -b 4096 -C "joe@`hostname`"
eval $(ssh-agent -s)

