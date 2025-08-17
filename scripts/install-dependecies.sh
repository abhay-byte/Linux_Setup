#!/bin/bash

clear

echo "Installing Necessary Packages..."

yes | pkg install tur-repo root-repo x11-repo science-repo

yes | pkg update

yes | pkg upgrade

yes | pkg install x11-repo termux-x11-nightly tur-repo pulseaudio proot-distro wget git curl zsh vim unzip python nodejs tar fastfetch