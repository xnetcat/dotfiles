# create ~/Pictures/Screenshots folder
mkdir -p ~/Pictures/Screenshots

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
yay -S --noconfirm --needed - < ~/.dotfiles/packages/required

# Install ui packages
echo "[INFO] Installing ui packages"
yay -S --noconfirm --needed - < ~/.dotfiles/packages/ui

# Install tools
echo "[INFO] Installing tools"
yay -S --noconfirm --needed - < ~/.dotfiles/packages/tools

# Install apps
echo "[INFO] Installing apps"
yay -S --noconfirm --needed - < ~/.dotfiles/packages/apps

# Create backup folder
echo "[INFO] Create backup folder"
rm -rf ~/.backup_dotfiles 2> /dev/null
mkdir ~/.backup_dotfiles 2> /dev/null

# Create backup 
echo "[INFO] Create backup"
mv ~/.config ~/.backup_dotfiles/config 2> /dev/null
mv ~/.wallpapers ~/.backup_dotfiles/wallpapers 2> /dev/null

# Copy wallpapers
echo "[INFO] Copying wallpapers"
cp -r ~/.dotfiles/wallpapers ~/.wallpapers

# Copy config files
echo "[INFO] Copying config files"
export XDG_CONFIG_HOME=$HOME/.config
cp -r ~/.dotfiles/config ~/.config 2> /dev/null
cp ~/.dotfiles/home/.* ~/ 2> /dev/null
chmod -R +x ~/.config/polybar/scripts
chmod -R +x ~/.config/sxhkd/scripts
chmod +x ~/.config/bspwm/bspwmrc
chmod +x ~/.config/polybar/launch.sh
chown -R $USER:$USER ~/.local
chown -R $USER:$USER ~/.config
chown $USER:$USER ~/.gtkrc-2.0

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
echo "GRUB_THEME=\"/usr/share/grub/themes/dracula/theme.txt\"" | sudo tee -a /etc/default/grub > /dev/null
sudo grub-mkconfig -o /boot/grub/grub.cfg

# Change default shell
echo "[INFO] Changing shell to zsh"
chsh -s /usr/bin/zsh $USER

# Remove bash files
echo "[INFO] Removing bash files"
mv .bash* ~/.backup_dotfiles/ 2> /dev/null

# Reset font cache
echo "[INFO] Resetting font cache"
fc-cache -f

# done
neofetch
echo "[INFO] Installation finished"