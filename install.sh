#!/bin/bash

# Install yay
if [[ -e /usr/bin/yay ]]; then
    echo "[INFO] yay detected"    
else
    echo "[INFO] Installing yay"
    cd /opt/
    sudo git clone https://aur.archlinux.org/yay-git.git
    sudo chown -R $(whoami):$(whoami) yay-git/
    cd yay-git
    makepkg -si
fi

# Install packages
echo "[INFO] Installing required packages"
sudo yay -Syu --needed --noconfirm - < ~/.dotfiles/arch-setup/packages.txt

# Create backup folder
mkdir ~/.backup_dotfiles

# Create backup 
mv ~/.config ~/.backup_dotfiles/config
mv ~/.local/share/fonts ~/.backup_dotfiles/fonts
mv ~/.wallpapers ~/.backup_dotfiles/wallpapers

# Copy config files
export XDG_CONFIG_HOME=$HOME/.config
echo "export XDG_CONFIG_HOME=\$HOME/.config" >> ~/.bashrc
cp -r ~/.dotfiles/config ~/.config
cp ~/.dotfiles/home/.* ~/ 2> /dev/null

# Set up fonts
mkdir -p ~/.local/share/fonts
cp -r ~/.dotfiles/fonts ~/.local/share/fonts 
sudo fc-cache -f

# Copy wallpapers
cp -r ~/.dotfiles/wallpapers ~/.wallpapers

# Start dbus
dbus-launch dconf load / < ~/.dotfiles/home/xed.dconf

# Enable lightdm
sudo systemctl enable lightdm.service

# done
neofetch
echo "[INFO] Installation finished"
