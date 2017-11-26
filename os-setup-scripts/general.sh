#!/bin/bash

echo "[*] Configuring vim"
ln -s ~/git/dotfiles/vim/.vimrc ~/.vimrc
~/git/dotfiles/vim/install-vundle.sh

echo "[*] Configuring i3"
mkdir -p ~/.config/i3/
ln -s ~/git/dotfiles/i3/config ~/.config/i3/config

echo "[*] Configuring Termite"
mkdir -p ~/.config/termite
ln -s ~/git/dotfiles/terminals/termite/config ~/.config/termite/config

echo "[*] Configuring Polybar"
ln -s ~/git/dotfiles/polybar ~/.config/polybar

echo "[*] Configuring Compton"
ln -s ~/git/dotfiles/compton/compton.conf ~/.config/compton.conf

echo "[*] Copying resources"
ln -s ~/git/dotfiles/resources ~/.resources

echo "[*] Configuring zsh"
ln -s ~/git/dotfiles/zsh/.zshrc ~/

echo "[*] Configuring gtk"
mkdir -p ~/.config/gtk-3.0
echo "vte-terminal { padding: 10px 10px 10px 10px; }" > ~/.config/gtk-3.0/gtk.css

#echo "[*] Installing gef for gdb"
#wget -q -O- https://github.com/hugsy/gef/raw/master/gef.sh | sh

echo "[*] Setting i3 as the default window manager"
echo 'exec i3' > ~/.xinitrc
