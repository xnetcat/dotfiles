#!/bin/bash

# Set zoneinfo
echo -n "Please enter you zoneinfo (example: Europe/Warsaw): "
read -r zoneinfo
ln -sf /usr/share/zoneinfo/$zoneinfo /etc/localtime

echo -n "Please configure you locale, press ENTER to continue"
read -r _

# Set locale
vim /etc/locale.gen

echo "Press ENTER to continue"
read -r _

echo -n "Please enter locale that you specified (example: en_US.UTF-8): "
read -r  locale
echo "Setting locale"
echo "LANG=$locale" >> /etc/locale.conf

# Generate locales
echo "Generating locales"
locale-gen

# Hostname
echo -n "Do you want to change hostname? (Y/n): "
read -r hostname_s
if [ ! "$hostname_s" = "n" ]; then
    echo -n "Please enter your hostname: "
    read -r new_hostname
    echo "Setting new hostname"
    echo "$new_hostname" > /etc/hostname
fi

# Root password
echo -n "Do you want to change root password? (Y/n): "
read -r root_s
if [ ! "$root_s" = "n" ]; then
    echo "Setting root password"
    passwd
fi

# Install network manager and grub
echo "Installing networkmanager and grub"
pacman -S networkmanager grub

# Start network manager on start
echo "Setting network manager to run on start"
systemctl enable NetworkManager

# Add user
echo -n "Please enter username for new user: "
read -r new_username
useradd -m -G wheel,video,audio,storage "$new_username"

# Set password for user
echo "Setting password for user"
passwd "$new_username"

cat > /etc/sudoers << EOF
%wheel ALL=(ALL) ALL
root ALL=(ALL) ALL
Defaults !tty_tickets
@includedir /etc/sudoers.d
EOF

# Configure grub
echo -n "Are you using efi or legacy bios? (e/L): "
read -r bios_s
echo "Configuring grub"
if [ "$bios_s" = "e" ]; then # efi bios
    pacman -S efibootmgr
    echo "Installing grub"
    grub-install --target=x86_64-efi --efi-directory=/boot/EFI --bootloader-id=GRUB
    echo "Generating grub config"
    grub-mkconfig -o /boot/grub/grub.cfg
else # legacy bios
    echo -n "Please enter the install device for grub (example: /dev/sda): "
    read -r grub_s
    echo "Installing grub"
    grub-install "$grub_s"
    echo "Generating grub config"
    grub-mkconfig -o /boot/grub/grub.cfg
fi

echo "Installation has finished, you can now unmount and reboot"
echo "Check if there were any errors, GL&HF"