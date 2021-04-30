#!/bin/bash

if [[ -t 1 ]]; then
    echo "[INFO] You are running in tty, can't procede"
else
    # Install nvm
    echo "[INFO] Installing nvm"
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash

    # Install better discord
    if [[ -t 1 ]]; then
        echo "[INFO] Running in tty can't install better discord"
    else
        echo "[INFO] Installing BetterDiscord"
        curl -L https://github.com/BetterDiscord/Installer/releases/latest/download/BetterDiscord-Linux.AppImage -o ~/BetterDiscord-Linux.AppImage
        chmod +x ~/BetterDiscord-Linux.AppImage
        ~/BetterDiscord-Linux.AppImage
        while pgrep betterdiscord > /dev/null; do sleep 1; done
        rm -rf ~/BetterDiscord-Linux.AppImage
    fi

    # Configure spicetify
    echo "Configuring spicetify"
    sudo chmod a+wr /opt/spotify
    sudo chmod a+wr /opt/spotify/Apps -R
    spicetify
    spicetify config spotify_path /opt/spotify
    spicetify config prefs_path /opt/spotify/prefs
    spicetify backup apply enable-devtool
    spicetify config current_theme Dribbblish color_scheme horizon
    spicetify config inject_css 1 replace_colors 1 overwrite_assets 1
    spicetify apply
fi