#!/bin/bash

echo "[*] Configuring vim"
cp ~/git/dotfiles/vim/.vimrc ~/.vimrc
~/git/dotfiles/vim/install-vundle.sh

echo "[*] Configuring i3"
mkdir -p ~/.config/i3/
cp ~/git/dotfiles/i3/config ~/.config/i3/config

echo "[*] Configuring Termite"
mkdir -p ~/.config/termite
cp ~/git/dotfiles/terminals/termite/config ~/.config/termite/config

echo "[*] Configuring Polybar"
mkdir -p ~/.config/polybar
cp ~/git/dotfiles/polybar/* ~/.config/polybar

echo "[*] Configuring Compton"
cp ~/git/dotfiles/compton/compton.conf ~/.config/compton.conf

echo "[*] Copying resources"
cp -R ~/git/dotfiles/resources ~/.resources

echo "[*] Configuring zsh"
cp ~/git/dotfiles/zsh/.zshrc ~/

echo "[*] Configuring gtk"
mkdir -p ~/.config/gtk-3.0
echo "vte-terminal { padding: 10px 10px 10px 10px; }" > ~/.config/gtk-3.0/gtk.css

