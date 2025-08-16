#!/bin/bash

BASE_URL="https://raw.githubusercontent.com/YourUser/YourRepo/main"

echo "Installing Necessary Packages..."

# Add extra repositories (no confirmation)
yes | pkg install tur-repo root-repo x11-repo science-repo

# Update and upgrade Termux packages automatically
yes | pkg update
yes | pkg upgrade

# Install required packages without prompts
yes | pkg install termux-x11-nightly pulseaudio proot-distro wget git curl vim

read -rp "Do you want to install Termux tweaks? (y/n): " tweaks_choice
if [[ "$tweaks_choice" =~ ^[Yy]$ ]]; then
    echo "Installing Termux tweaks..."
    bash termux-tweaks.sh
else
    echo "Skipping Termux tweaks."
fi

echo "Select your Linux distribution:"
echo "1) Native Termux"
echo "2) Arch Linux"
echo "3) Debian"
read -rp "Enter choice [1-3]: " distro_choice

case "$distro_choice" in
    1)
        echo "Running native Termux installation..."
        bash native-install.sh
        ;;
    2)
        echo "You selected Arch Linux. Add your Arch install script here."
        ;;
    3)
        echo "You selected Debian. Add your Debian install script here."
        ;;
    *)
        echo "Invalid choice. Please enter 1, 2, or 3."
        exit 1
        ;;
esac


