#!/bin/bash

#======================#
#     Configuration    #
#======================#

# List of official repo packages (install via pacman)
pacman_packages=(
  neofetch fastfetch firefox vlc git zsh neovim hyprland
  networkmanager qbittorrent discord libreoffice obs-studio
  github-cli grub ly kitty htop nvtop thunar bluez bluez-utils 
  blueman adobe-source-code-pro-fonts noto-fonts-emoji
  otf-font-awesome ttf-droid ttf-fira-code ttf-fantasque-nerd
  ttf-jetbrains-mono ttf-jetbrains-mono-nerd ttf-victor-mono
  noto-fonts xdg-desktop-portal-hyprland waybar 
  swww brightnessctl pavucontrol pamixer wl-clipboard
  playerctl ttf-jetbrains-mono ttf-jetbrains-mono-nerd
  noto-fonts noto-fonts-emoji otf-font-awesome blueman-gtk 
  network-manager-applet
)

# List of AUR packages (install via yay)
aur_packages=(
  google-chrome visual-studio-code-bin nvidia-dkms nvidia-utils
  jetbrains-toolbox postman-bin joplin-desktop
  heroic-games-launcher-bin huiontablet
  rofi-wayland
)

#======================#
#     Time & Locale    #
#======================#

echo "Setting timezone to Asia/Kolkata..."
sudo ln -sf /usr/share/zoneinfo/Asia/Kolkata /etc/localtime
sudo timedatectl set-timezone Asia/Kolkata

echo "Configuring locale to en_US.UTF-8..."
sudo sed -i 's/^#en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen
sudo locale-gen
echo "LANG=en_US.UTF-8" | sudo tee /etc/locale.conf
export LANG=en_US.UTF-8

#======================#
#    Pacman Config     #
#======================#

echo "Modifying /etc/pacman.conf ..."
sudo cp /etc/pacman.conf /etc/pacman.conf.bak
sudo sed -i '/^\\\[options\\\\]/a ILoveCandy' /etc/pacman.conf

if grep -q "^#ParallelDownloads" /etc/pacman.conf; then
  sudo sed -i 's/^#ParallelDownloads.*/ParallelDownloads = 20/' /etc/pacman.conf
elif ! grep -q "^ParallelDownloads" /etc/pacman.conf; then
  sudo sed -i '/^\\\[options\\\\]/a ParallelDownloads = 20' /etc/pacman.conf
fi

#======================#
#   Yay Installation   #
#======================#

install_yay() {
  if ! command -v yay &> /dev/null; then
    echo "yay not found. Installing yay..."
    sudo pacman -S --noconfirm --needed base-devel git
    git clone https://aur.archlinux.org/yay.git
    cd yay || exit
    makepkg -si --noconfirm
    cd .. && rm -rf yay
  else
    echo "yay is already installed."
  fi
}

#======================#
#   Package Install    #
#======================#

echo "Updating system..."
sudo pacman -Syu --noconfirm

echo "Installing pacman packages..."
for pkg in "${pacman_packages[@]}"; do
  sudo pacman -S --noconfirm --needed "$pkg"
done

install_yay

echo "Installing AUR packages..."
for pkg in "${aur_packages[@]}"; do
  yay -S --noconfirm "$pkg"
done

#======================#
#    Network Setup     #
#======================#
#!/bin/bash

echo "Configuring NetworkManager..."

# Install NetworkManager if not already installed
if ! pacman -Qi networkmanager &> /dev/null; then
    echo "Installing NetworkManager..."
    sudo pacman -S --noconfirm networkmanager
fi

# Enable and start the NetworkManager service
echo "Enabling and starting NetworkManager service..."
sudo systemctl enable NetworkManager.service
sudo systemctl start NetworkManager.service

# Optional: Check status
echo "Checking NetworkManager status..."
systemctl status NetworkManager.service | grep Active

# Optional: Set up a default connection (manual)
read -p "Do you want to list available Wi-Fi networks? (y/n): " list_wifi
if [[ "$list_wifi" =~ ^[Yy]$ ]]; then
    nmcli device wifi list
    read -p "Enter Wi-Fi SSID: " ssid
    read -sp "Enter Wi-Fi Password: " wifi_pass
    echo
    nmcli dev wifi connect "$ssid" password "$wifi_pass"
fi

echo "NetworkManager setup complete."

#======================#
#    bluetooth-setup   #
#======================#

echo "Enabling Bluetooth services..."
sudo systemctl enable bluetooth.service
sudo systemctl start bluetooth.service

#======================#
#      rofi-setup      #
#======================#

echo "Creating default config for rofi-wayland..."
mkdir -p ~/.config/rofi

# Optional: Provide a basic rofi config
cat <<EOF > ~/.config/rofi/config.rasi
configuration {
  modi: "drun,run,window";
  show-icons: true;
  font: "monospace 12";
  location: 0;
  fullscreen: false;
}
EOF

echo "Rofi-wayland has been installed and configured."

# Optional: Add a launcher keybind setup reminder
echo "Tip: You can bind rofi-wayland to a key in Hyprland like this:"
echo 'bind = $mod, R, exec, rofi-wayland -show drun'


#======================#
#     Oh My Zsh        #
#======================#

read -p "Do you want to install Oh My Zsh? (y/n): " answer
if [[ "$answer" =~ ^[Yy]$ ]]; then
  echo "Installing Oh My Zsh..."
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

  echo "Installing zsh plugins..."
  ZSH_CUSTOM=${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}
  git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_CUSTOM/plugins/zsh-autosuggestions
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
  git clone https://github.com/zdharma-continuum/fast-syntax-highlighting.git $ZSH_CUSTOM/plugins/fast-syntax-highlighting
  git clone --depth 1 https://github.com/marlonrichert/zsh-autocomplete.git $ZSH_CUSTOM/plugins/zsh-autocomplete

  echo "Configuring plugins in .zshrc..."
  sed -i 's/plugins=(git)/plugins=(git zsh-autosuggestions zsh-syntax-highlighting fast-syntax-highlighting)/' ~/.zshrc

  echo "Setting random Zsh theme..."
  sed -i 's/^ZSH_THEME=.*/ZSH_THEME="random"/' ~/.zshrc || echo 'ZSH_THEME="random"' >> ~/.zshrc
  source ~/.zshrc

else
  echo "Skipping Oh My Zsh installation."
fi

#======================#
#      LY Setup        #
#======================#

echo "Setting LY login theme to 'hell-fire'..."
sudo sed -i 's/^theme = .*/theme = hell-fire/' /etc/ly/config.ini
sudo systemctl enable ly.service
sudo systemctl start ly.service

#======================#
#     Wallpapers       #
#======================#

echo "Copying wallpapers to your Pictures folder..."
mkdir -p ~/Pictures
cp -r ./Wallpaper/* ~/Pictures/

#======================#
#  Hyprland Setup      #
#======================#

read -p "Do you want to install the Arch-Hyprland setup from JaKooLit? (y/n): " answer
if [[ "$answer" =~ ^[Yy]$ ]]; then
  echo "Cloning and running Arch-Hyprland installer..."
  git clone --depth=1 https://github.com/JaKooLit/Arch-Hyprland.git ~/Arch-Hyprland
  cd ~/Arch-Hyprland || { echo "Failed to enter directory"; exit 1; }
  chmod +x install.sh
  ./install.sh
else
  echo "Default Arch-Hyprland setup."
  
  # Power menu script
  mkdir -p ~/.config/hypr/scripts
  cat << 'EOF' > ~/.config/hypr/scripts/power-menu.sh
#!/bin/bash

if command -v rofi &> /dev/null; then
  MENU="rofi -dmenu -p Power"
elif command -v wofi &> /dev/null; then
  MENU="wofi --show dmenu -p Power"
else
  echo "No launcher (rofi or wofi) found!"
  exit 1
fi

CHOICE=$(echo -e "⏻ Shutdown\n Reboot\n Logout\n Lock" | $MENU)

case "$CHOICE" in
  *Shutdown) systemctl poweroff ;;
  *Reboot) systemctl reboot ;;
  *Logout) hyprctl dispatch exit ;; 
  *Lock) [[ -x /usr/bin/swaylock ]] && swaylock || echo "Install swaylock to use lock" ;; 
  *) exit 0 ;; 
esac
EOF
  chmod +x ~/.config/hypr/scripts/power-menu.sh

  # Keybind for power menu
  cat << 'EOF' >> ~/.config/hypr/hyprland.conf
bind = SUPER, P, exec, ~/.config/hypr/scripts/power-menu.sh
EOF

  # Set borders to no borders
  echo "Setting Hyprland to have no borders on all windows..."
  echo "borderless = true" >> ~/.config/hypr/hyprland.conf

  echo "✅ Hyprland setup completed!"
  echo "➡ Power menu bound to SUPER + P"
  echo "➡ Windows set to no borders"
fi

#======================#
#       Done!          #
#======================#

echo "🎉 All setup steps completed successfully!"
