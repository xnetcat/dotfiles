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
echo "[INFO] Create backup folder"
mkdir ~/.backup_dotfiles

# Create backup 
echo "[INFO] Create backup"
mv ~/.config ~/.backup_dotfiles/config
mv ~/.local/share/fonts ~/.backup_dotfiles/fonts
mv ~/.wallpapers ~/.backup_dotfiles/wallpapers

# Copy config files
echo "[INFO] Copy config files"
export XDG_CONFIG_HOME=$HOME/.config
cp -r ~/.dotfiles/config ~/.config
cp ~/.dotfiles/home/.* ~/ 2> /dev/null

# Set up fonts
echo "[INFO] Setting up fonts"
mkdir -p ~/.local/share/fonts
cp -r ~/.dotfiles/fonts ~/.local/share/fonts 
sudo fc-cache -f

# Copy wallpapers
echo "[INFO] Copying wallpapers"
cp -r ~/.dotfiles/wallpapers ~/.wallpapers

# Start dbus
echo "[INFO] Starting dbus"
dbus-launch dconf load / < ~/.dotfiles/home/xed.dconf

# Enable lightdm
echo "[INFO] Enabling lightdm"
sudo systemctl enable lightdm.service

# Install ohmyzsh
echo "[INFO] Installing ohmyzsh"
export CHSH="yes"
export RUNZSH="no"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# done
neofetch
echo "[INFO] Installation finished"
