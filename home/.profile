# Vars for some bugs and applications
export QT_QPA_PLATFORMTHEME="qt5ct"
export _JAVA_AWT_WM_NONREPARENTING=1
export AWT_TOOLKIT=MToolkit

# Environment variables
export SHELL=/usr/bin/zsh
export TERMINAL=alacritty
export BROWSER=google-chrome-stable
export EDITOR=code
export OPENER=xdg-open

# Set XDG Directories
export XDG_DATA_HOME="$HOME"/.local/share
export XDG_CONFIG_HOME="$HOME"/.config
export XDG_CACHE_HOME="$HOME"/.cache
export XDG_DATA_DIRS="/usr/local/share:/usr/share"
export XDG_CONFIG_DIRS="/etc/xdg"

export PATH="$HOME"/.local/bin:"$PATH"