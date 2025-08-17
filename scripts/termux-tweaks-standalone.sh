#!/bin/bash

BASE_URL="https://raw.githubusercontent.com/abhay-byte/Linux_Setup/dev"

curl -fsSL "$BASE_URL/scripts/install-dependecies.sh" | sh

echo -n "Do you want to install Termux tweaks? (y/n): "
read tweaks_choice
case "$tweaks_choice" in
    [Yy]*)
        echo "Installing Termux tweaks..."
        bash <(curl -fsSL "$BASE_URL/scripts/termux-tweaks.sh")
        ;;
    *)
        echo "Skipping Termux tweaks."
        ;;
esac
