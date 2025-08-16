#!/bin/bash

BASE_URL="https://raw.githubusercontent.com/abhay-byte/Linux_Setup/dev"

curl -fsSL "$BASE_URL/scripts/install-dependecies.sh" | bash

clear

read -rp "Do you want to install Termux tweaks? (y/n): " tweaks_choice
if [[ "$tweaks_choice" =~ ^[Yy]$ ]]; then
    echo "Installing Termux tweaks..."
    curl -fsSL "$BASE_URL/scripts/termux-tweaks.sh" | bash
else
    echo "Skipping Termux tweaks."
fi