#!/bin/bash

# Set correct time
timedatectl set-ntp true

# Show disks
lsblk

# Disk setup
echo -n "What is the install device (example: /dev/sda): "
read -r device
echo "Installing to $device... (Enter to continue)"
read -r _

echo -n "Would you like to wipe and re-partition the disk $device ? (Y/n): "
read -r wipe

if [ ! "$wipe" = "n" ]; then
    echo "Wiping the partition table..."
    wipefs -a -f "$device"
    sleep 1
fi

clear

echo "Please create /boot /root partitions, and /swap /home if you want. Press ENTER to continue"
read -r _

# Run cfdisk for manual partitioning
cfdisk "$device"

clear

lsblk "$device"
echo ""

# Boot partition
echo -n "Please enter boot partition (example: /dev/sda1): "
read -r boot

# Root partition
echo -n "Please enter root partition (example: /dev/sda2): "
read -r root

# Swap partition
echo -n "Did you create a swap partition? (y/N): "
read -r swap_s
if [ "$swap_s" = "y" ]; then
    echo -n "Please enter swap partition (example: /dev/sda3): "
    read -r swap
fi

# Home partition
echo -n "Did you create a home partition? (y/N): "
read -r home_s
if [ "$home_s" = "y" ]; then
    echo -n "Please enter home partition (example: /dev/sda4): "
    read -r home
fi

# Create root partition
echo "Formatting root partition"
mkfs.ext4 "$root"
echo "Mounting root partition"
mount "$root" /mnt

# Create the boot partition
echo -n "Do you want to use efi or legacy bios? (e/L): "
read -r bios_s
if [ "$bios_s" = "e" ]; then # efi
    echo "Formatting boot partition"
    mkfs.fat -F32 "$boot"
    echo "Mounting boot partition"
    mkdir /mnt/boot/EFI -p
    mount "$boot" /mnt/boot/EFI
else # legacy
    echo "Formatting boot partition"
    mkfs.ext4 "$boot"
    echo "Mounting boot partition"
    mkdir /mnt/boot
    mount "$boot" /mnt/boot  
fi

# Create swap partition
if [ "$swap_s" = "y" ]; then
    echo "Creating swap partition"
    mkswap "$swap"
    echo "Mounting swap partition"
    swapon "$swap"
fi

# Create home partition
if [ "$home_s" = "y" ]; then
    echo "Creating home partition"
    mkfs.ext4 "$home"
    echo "Mounting home partition"
    mkdir /mnt/home
    mount "$home" /mnt/home
fi

# Install
echo "Press ENTER to install required packages"
read -r _
echo "Installing required packages"
pacstrap /mnt base base-devel linux linux-firmware git vim

# Generate fstab entries for mounted partitions
echo "Generating fstab entries for mounted partitions"
genfstab -U /mnt >> /mnt/etc/fstab

# Copy chroot script to /mnt
echo "Copying install script"
cp ~/.dotfiles/arch-setup/chroot.sh /mnt/root/chroot-install.sh

# Set correct permissions for chroot scripts
echo "Setting permissions for chroot script"
chmod +x /mnt/root/chroot-install.sh 

# Change root directory to arch
echo "Change arch root directory to /mnt"
arch-chroot /mnt /root/chroot-install.sh
