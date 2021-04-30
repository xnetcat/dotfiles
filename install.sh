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
mkdir ~/.backup_dotfiles 2> /dev/null

# Create backup 
echo "[INFO] Create backup"
mv ~/.config ~/.backup_dotfiles/config 2> /dev/null
mv ~/.local/share/fonts ~/.backup_dotfiles/fonts 2> /dev/null
mv ~/.wallpapers ~/.backup_dotfiles/wallpapers 2> /dev/null

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
dbus-launch dconf load / < ~/.dotfiles/config/xed.dconf

# Start lightdm service
echo "[INFO] Starting lightdm service"
sudo systemctl enable lightdm.service

# Configure docker
echo "[INFO] Configuring docker"
sudo systemctl enable docker.service
sudo systemctl enable containerd.service
sudo usermod -aG docker $USER

# Install ohmyzsh
echo "[INFO] Installing ohmyzsh"
export CHSH="yes"
export RUNZSH="no"
export KEEP_ZSH="no"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Install nvm
echo "[INFO] Installing nvm"
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash

# Copy config files
echo "[INFO] Copy config files"
export XDG_CONFIG_HOME=$HOME/.config
cp -r ~/.dotfiles/config ~/.config 2> /dev/null
cp ~/.dotfiles/home/.* ~/ 2> /dev/null

# Install better discord
echo "[INFO] Installing BetterDiscord"
curl -L https://github.com/BetterDiscord/Installer/releases/latest/download/BetterDiscord-Linux.AppImage -o ~/BetterDiscord-Linux.AppImage
chmod +x ~/BetterDiscord-Linux.AppImage
~/BetterDiscord-Linux.AppImage
while pgrep betterdiscord > /dev/null; do sleep 1; done
rm -rf ~/BetterDiscord-Linux.AppImage

# Configure spicetify
sudo chmod a+wr /opt/spotify
sudo chmod a+wr /opt/spotify/Apps -R
spicetify
spicetify backup apply enable-devtool
spicetify config current_theme Dribbblish color_scheme horizon
spicetify config inject_css 1 replace_colors 1 overwrite_assets 1
spicetify apply

# Remove bash files
echo "[INFO] Removing bash files"
mv .bash* ~/.backup_dotfiles/ 2> /dev/null

# done
neofetch
echo "[INFO] Installation finished"
