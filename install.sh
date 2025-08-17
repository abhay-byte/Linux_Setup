#!/bin/bash

BASE_URL="https://raw.githubusercontent.com/abhay-byte/Linux_Setup/dev"

curl -fsSL "$BASE_URL/scripts/install-dependecies.sh" | bash

read -rp "Do you want to install Termux tweaks? (y/n): " tweaks_choice
if [[ "$tweaks_choice" =~ ^[Yy]$ ]]; then
    echo "Installing Termux tweaks..."
    curl -fsSL "$BASE_URL/scripts/termux-tweaks.sh" | bash
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
        curl -fsSL "$BASE_URL/scripts/native-install.sh" | bash
        ;;
    2)
        echo "Running Arch Linux installation..."
        curl -fsSL "$BASE_URL/scripts/arch-install.sh" | bash
        ;;
    3)
        echo "Running Debian installation..."
        curl -fsSL "$BASE_URL/scripts/debian-install.sh" | bash
        ;;
    *)
        echo "Invalid choice. Please enter 1, 2, or 3."
        exit 1
        ;;
esac


