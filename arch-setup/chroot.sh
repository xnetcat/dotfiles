#!/bin/bash

# Set zoneinfo
echo -n "Please enter you zoneinfo (example /usr/share/zoneinfo/Europe/Warsaw): "
read -r zoneinfo
ln -sf "$zoneinfo" /etc/localtime

# Sync hardware clock
echo "[INFO] Setting hardware clock"
hwclock --systohc

echo -n "Please configure you locale, press ENTER to continue"
read -r _

# Set locale
vim /etc/locale.gen

echo "Press ENTER to continue"
read -r _

echo -n "Please enter locale that you specified (example: en_US.UTF-8): "
read -r  locale
echo "[INFO] Setting locale"
echo "LANG=$locale" >> /etc/locale.conf

# Generate locales
echo "[INFO] Generating locales"
locale-gen

# Set keyboard
echo -n "Do you want to set keyboard layout? (y/N): "
read -r keyboard_s
if [ "$keyboard_s" = "y" ]; then
    echo -n "Do you want to see all possible keyboard layouts? (y/N): "
    read -r layouts_s
    if [ "$layouts_s" = "y" ]; then
        localectl list-keymaps
    fi
    echo -n "Please enter you keymap (example: us): "
    read -r keymap
    echo "[INFO] Setting new keymap"
    localectl set-keymap --noconvert "$keymap"
fi

# Hostname
echo -n "Do you want to change hostname? (Y/n): "
read -r keyboard_s
if [ ! "$keyboard_s" = "n" ]; then
    echo -n "Please enter your hostname: "
    read -r new_hostname
    echo "[INFO] Setting new hostname"
    echo "$new_hostname" > /etc/hostname
fi

# Root password
echo -n "Do you want to change root password? (Y/n): "
read -r root_s
if [ ! "$root_s" = "n" ]; then
    echo "[INFO] Setting root password"
    passwd
fi

# Install network manager and grub
echo "[INFO] Installing networkmanager and grub"
pacman -S networkmanager grub

# Start network manager on start
echo "[INFO] Setting network manager to run on start"
systemctl enable NetworkManager

# Add user
echo -n "Please enter username for new user: "
read -r new_username
useradd -m -G wheel,video,audio,storage "$new_username"

# Set password for user
echo "[INFO] Setting password for user"
passwd "$new_username"

# Prevent user from entering sudo passwords for new terminals !! this is not really safe, i am just lazy !!
echo "[INFO] Prevent user from entering sudo passwords for new terminals"
echo "$(echo 'Defaults !tty_tickets'; cat /etc/sudoers)" > /etc/sudoers

# Allow users to execute any command
echo "[INFO] Setting permissions for wheel group"
echo "$(echo '%wheel ALL=(ALL) ALL'; cat /etc/sudoers)" > /etc/sudoers

# Configure grub
echo -n "Are you using efi or legacy bios? (e/L): "
read -r bios_s
echo "[INFO] Configuring grub"
if [ "$bios_s" = "e" ]; then # efi bios
    pacman -S efibootmgr
    echo "[INFO] Installing grub"
    grub-install --target=x86_64-efi --efi-directory=/boot/EFI --bootloader-id=GRUB
    echo "[INFO] Generating grub config"
    grub-mkconfig -o /boot/grub/grub.cfg
else # legacy bios
    echo -n "Please enter the install device for grub (example: /dev/sda): "
    read -r grub_s
    echo "[INFO] Installing grub"
    grub-install "$grub_s"
    echo "[INFO] Generating grub config"
    grub-mkconfig -o /boot/grub/grub.cfg
fi

# end
exit
echo "Installation has finished, you can now unmount and reboot"
echo "Look if there were any errors, GL&HF"
