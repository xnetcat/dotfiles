#!/bin/bash

# Install nvm
echo "[INFO] Installing nvm"
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash

# Install better discord
echo "[INFO] Installing BetterDiscord"
curl -L https://github.com/BetterDiscord/Installer/releases/latest/download/BetterDiscord-Linux.AppImage -o ~/BetterDiscord-Linux.AppImage
chmod +x ~/BetterDiscord-Linux.AppImage
~/BetterDiscord-Linux.AppImage
while pgrep betterdiscord > /dev/null; do sleep 1; done
rm -rf ~/BetterDiscord-Linux.AppImage

# Configure spicetify
echo "[INFO] Configuring spicetify"
sudo chmod a+wr /opt/spotify
sudo chmod a+wr /opt/spotify/Apps -R
spicetify
spicetify config spotify_path /opt/spotify
spicetify config prefs_path ~/.config/spotify/prefs
spicetify backup apply enable-devtool
spicetify config extensions dribbblish.js
spicetify config current_theme Dribbblish color_scheme horizon
spicetify config inject_css 1 replace_colors 1 overwrite_assets 1
spicetify apply

# Install rust
echp "[INFO] Installing rust"
rustup toolchain install stable