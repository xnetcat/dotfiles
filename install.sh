#!/bin/bash

# Install packages
echo "[INFO] Installing required packages"
while read -r package; do
    echo "[INFO] Installing $package"
    pacman -S --noconfirm "$package"
done < ~/.dotfiles/arch-setup/packages.minimal

# Link config
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
