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

# Updates
echo "[INFO] Searching for updates"
yay -Syu

# Install packages
echo "[INFO] Installing required packages"
while read -r package; do
    echo "[INFO] Installing $package"
    yay -S --needed --noconfirm "$package"
done < ~/.dotfiles/arch-setup/packages.txt

# Create backup folder
echo "[INFO] Create backup folder"
rm -rf ~/.backup_dotfiles 2> /dev/null
mkdir ~/.backup_dotfiles 2> /dev/null

# Create backup 
echo "[INFO] Create backup"
mv ~/.config ~/.backup_dotfiles/config 2> /dev/null
mv ~/.local/share/fonts ~/.backup_dotfiles/fonts 2> /dev/null
mv ~/.wallpapers ~/.backup_dotfiles/wallpapers 2> /dev/null

# Set up fonts
echo "[INFO] Setting up fonts"
mkdir -p ~/.local/share/fonts
cp -r ~/.dotfiles/fonts/* ~/.local/share/fonts 
fc-cache -f -v

# Copy wallpapers
echo "[INFO] Copying wallpapers"
cp -r ~/.dotfiles/wallpapers ~/.wallpapers

# Copy config files
echo "[INFO] Copying config files"
export XDG_CONFIG_HOME=$HOME/.config
cp -R ~/.dotfiles/config ~/.config 2> /dev/null
cp ~/.dotfiles/home/.* ~/ 2> /dev/null
chmod -R +x ~/.config/bspwm/scripts
chmod -R +x ~/.config/polybar/scripts
chmod -R +x ~/.config/sxhkd/scripts
chmod -R +x ~/.config/bspwm/bspwmrc
chown -R $USER:$USER ~/.local
chown -R $USER:$USER ~/.config
chown $USER:$USER ~/.gtkrc-2.0
chmod +x ~/.config/polybar/launch.sh
chmod +x ~/.config/rofi/powermenu.sh

# Copy etc config
echo "[INFO] Copying etc"
sudo cp -f -r ~/.dotfiles/etc/* /etc

# Start dbus
echo "[INFO] Starting dbus"
dbus-launch dconf load / < ~/.dotfiles/config/xed.dconf

# Start lightdm service
echo "[INFO] Starting lightdm service"
sudo systemctl enable lightdm.service

# Configure docker
echo "[INFO] Configuring docker"
sudo systemctl enable docker.service
sudo systemctl enable containerd.service
sudo usermod -aG docker $USER

# Change grub theme
echo "[INFO] Changing grub theme"
sudo ~/.dotfiles/grub/install.sh

# Change default shell
echo "[INFO] Changing shell to zsh"
chsh -s /usr/bin/zsh

# Remove bash files
echo "[INFO] Removing bash files"
mv .bash* ~/.backup_dotfiles/ 2> /dev/null

# done
neofetch
echo "[INFO] Installation finished"
