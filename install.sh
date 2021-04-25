#!/bin/bash

# Install yay

# Install packages
echo "[INFO] Installing required packages"
sudo yay -Syu --needed --noconfirm - < ~/.dotfiles/arch-setup/packages.txt

# Create backup folder
mkdir ~/.backup_dotfiles

# Create backup 
mv -rf ~/.config ~/.backup_dotfiles/config
mv -rf ~/.local/share/fonts ~/.backup_dotfiles/fonts

# Copy config files
export XDG_CONFIG_HOME=$HOME/.config
echo "export XDG_CONFIG_HOME=\$HOME/.config" >> ~/.bashrc
cp -R ~/.dotfiles/config ~/.config 

# Set up fonts
mkdir -p ~/.local/share/fonts
cp -R ~/.dotfiles/fonts ~/.local/share/fonts 
sudo fc-cache -v -f

# Start dbus
dbus-launch dconf load / < ~/.dotfiles/home/xed.dconf

# Enable lightdm
sudo systemctl enable lightdm.service

# done
neofetch
echo "[INFO] Installation finished"
