#!/bin/bash

echo "[*] Updating Pacman repositories and performing a full upgrade"
sudo pacman --noconfirm -Syu
echo "[*] Retrieving GPG key for Cower author"
gpg --recv-keys --keyserver hkp://pgp.mit.edu 1EB2638FF56C0C53
echo "[*] Installing some packages (wget, git, vim) we might need"
sudo pacman --noconfirm -S wget git vim

echo "[*] Retrieving Cower from the AUR"
wget https://aur.archlinux.org/cgit/aur.git/snapshot/cower.tar.gz -O /tmp/cower.tar.gz
echo "[*] Installing Cower"
cd /tmp
tar xzvf cower.tar.gz
cd cower
makepkg -s
sudo pacman --noconfirm -U *.tar.xz

echo "[*] Retrieving Pacaur from the AUR"
wget https://aur.archlinux.org/cgit/aur.git/snapshot/pacaur.tar.gz -O /tmp/pacaur.tar.gz
echo "[*] Installing Pacaur"
cd /tmp
tar xzvf pacaur.tar.gz
cd pacaur
makepkg -s
sudo pacman --noconfirm -U *.tar.xz

# Official repo
echo "[*] Installing a bunch of packages that we want"
pacaur --noconfirm -S gtk3 gtkmm xorg xorg-xinit xf86-video-vmware open-vm-tools open-vm-tools-dkms mlocate feh openssh

# AUR
pacaur --noconfirm -S i3-gaps termite-git terminess-powerline-font-git

# Create SSH key
ssh-keygen -t rsa -b 4096 -C "joe@`hostname`"
eval $(ssh-agent -s)

