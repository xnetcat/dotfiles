# dotfiles

Basic arch setup

## Setup arch

```bash
pacman -Sy git
git clone https://github.com/xnetcat/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
chmod +x ./arch-setup.sh
./arch-setup.sh
```

## Setup

```sh
git clone https://github.com/xnetcat/dotfiles.git ~/.dotfiles 
cd ~/.dotfiles
./install.sh
```

## Hotkeys

### wm independent hotkeys

- `super + Return` - open terminal emulator
- `super + d` - open program launcher 
- `super + ctrl + d` - show open window
- `super + shift + d` - show ssh sessions
- `super + shift + e` - open power menu
- `super + Escape` - reload sxhkd

### Bspwm

- `super + alt + q` - quit bspwm
- `super + alt + r` - restart bspwm
- `super + q` - kill node
- `super + m` - alternate between the tiled and monocle layout
- `super + y` - send the newest marked node to the newest preselected node
- `super + g` - swap the current node and the biggest window

### State

- `super + t` - set the window state to tiled
- `super + shift + t` - set the window state to pseudo_tiled
- `super + s` - set the window state to floating
- `super + f` - set the window state to fullscreen
- `super + ctrl + m` - set node flag to marked
- `super + ctrl + x` - set node flag to locked
- `super + ctrl + y` - set node flag to sticky
- `super + ctrl + z` - set node flag to private

### Focus/Swap

- `super + h` - focus the node in the west
- `super + j` - focus the node in the south
- `super + k` - focus the node in the north
- `super + l` - focus the node in the east
- `super + p` - focus the parent node
- `super + b` - focus the brother node
- `super + .` - focus the first node
- `super + ,` - focus the second node
- `super + c` - focus the next window in the current desktop 
- `super + shift + c` - focus the previous window in the current desktop
- `super + [` - focus the next window in the current monitor 
- `super + ]` - focus the previous window in the current monitor
- ``super + ` `` - focus the last node
- `super + Tab` - focus the last desktop
- `super + o` - focus the older node in the focus history
- `super + i` - focus the newer node in the focus history
- `super + 1-9` - focus the given desktop
- `super + shift + 1-9` - send to the given desktop
- `super + shift + h` - swap current node with the node in the west
- `super + shift + j` - swap current node with the node in the south
- `super + shift + k` - swap current node with the node in the north
- `super + shift + l` - swap current node with the node in the east

### Preselect

- `super + ctrl + h` - preselect west direction
- `super + ctrl + j` - preselect south direction
- `super + ctrl + k` - preselect north direction
- `super + ctrl + l` - preselect east direction
- `super + ctrl + 1-9` - preselect with the given ratio
- `super + ctrl + space` - cancel the preselection for the focused node
- `super + ctrl + shift + space` - cancel the preselection for the focused desktop

### Move/Resize

- `super + alt + h` - expand a window by moving left side outward
- `super + alt + j` - expand a window by moving bottom side outward
- `super + alt + k` - expand a window by moving top side outward
- `super + alt + l` - expand a window by moving right side outward
- `super + alt + shift + h` - contract a window by moving left side inwards
- `super + alt + shift + j` - contract a window by moving bottom side inwards
- `super + alt + shift + k` - contract a window by moving top side inwards
- `super + alt + shift + l` - contract a window by moving right side inwards
- `super + Left` - move a floating window left
- `super + Bottom` - move a floating window down
- `super + Up` - move a floating window up
- `super + Right` - move a floating window right

### Special hotkeys

- `XF86AudioRaiseVolume` - Raise Volume
- `XF86AudioLowerVolume` - Lower Volume
- `XF86AudioRaiseVolume + XF86AudioLowerVolume` - Mute volume
- `XF86AudioPlay` - Command the player to toggle between play/pause
- `XF86AudioPause` - Command the player to stop
- `XF86AudioNext` - Command the player to skip to the next track
- `XF86AudioPrev` - Command the player to skip to the previous track
- `Print` - Screenshot (saved to ~/Pictures)
- `super + Print` - open screenshot menu
- `super + w` - open brave
- `super + n` - open file explorer
- `super + F1` - open help message