#!/bin/bash

# Install packages
echo "[INFO] Installing required packages"
sudo pacman -S $(cat ~/.dotfiles/arch-setup/packages.minimal)

# Create xinitrc
echo "[INFO] Creating .xinitrc"
echo "exec dwm" >> ~/.xinitrc

# Install suckless utils
echo "[INFO] Installing suckless utils"
cd ~/.dotfiles/suckless
chmod +x ~/.dotfiles/suckless/build.sh
~/.dotfiles/suckless/build.sh

# done
neofetch
echo "[INFO] Installation finished"
