#!/bin/bash

#======================#
#     Configuration    #
#======================#

pacman_packages=(
  neofetch firefox vlc git zsh neovim
  networkmanager qbittorrent discord libreoffice obs-studio
  kitty htop thunar bluez bluez-utils
  noto-fonts ttf-fira-code ttf-jetbrains-mono
  xfce4 xfce4-goodies xterm lxdm
)

aur_packages=(
  google-chrome visual-studio-code-bin jetbrains-toolbox
  postman-bin joplin-desktop
)

#======================#
#  Time & Locale Setup #
#======================#

echo "Setting timezone to Asia/Kolkata..."
ln -sf /usr/share/zoneinfo/Asia/Kolkata /etc/localtime
hwclock --systohc || true

echo "Generating locale..."
sed -i 's/^#en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" > /etc/locale.conf
export LANG=en_US.UTF-8

#======================#
#     Pacman Config    #
#======================#

echo "Enabling ILoveCandy and ParallelDownloads..."
cp /etc/pacman.conf /etc/pacman.conf.bak
sed -i '/^\[options\]/a ILoveCandy' /etc/pacman.conf
sed -i 's/^#ParallelDownloads.*/ParallelDownloads = 5/' /etc/pacman.conf

#======================#
#   Package Install    #
#======================#

echo "Updating system..."
pacman -Syu --noconfirm

echo "Installing base packages..."
for pkg in "${pacman_packages[@]}"; do
  pacman -S --noconfirm --needed "$pkg"
done

#======================#
#   Yay Installation   #
#======================#

if ! command -v yay &> /dev/null; then
  echo "Installing yay AUR helper..."
  pacman -S --noconfirm --needed base-devel
  git clone https://aur.archlinux.org/yay.git
  cd yay
  makepkg -si --noconfirm
  cd ..
  rm -rf yay
fi

#======================#
#  AUR Package Install #
#======================#

for pkg in "${aur_packages[@]}"; do
  yay -S --noconfirm "$pkg"
done

#======================#
#    XFCE Autostart    #
#======================#

echo "Setting up XFCE startup..."
mkdir -p ~/.vnc
echo "startxfce4" > ~/.vnc/xstartup
chmod +x ~/.vnc/xstartup

#======================#
#   Oh My Zsh Setup    #
#======================#

read -p "Install Oh My Zsh? (y/n): " answer
if [[ "$answer" =~ ^[Yy]$ ]]; then
  echo "Installing Oh My Zsh..."
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

  ZSH_CUSTOM=${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}
  git clone https://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions
  git clone https://github.com/zsh-users/zsh-syntax-highlighting $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
  git clone --depth 1 https://github.com/marlonrichert/zsh-autocomplete $ZSH_CUSTOM/plugins/zsh-autocomplete

  sed -i 's/plugins=(git)/plugins=(git zsh-autosuggestions zsh-syntax-highlighting zsh-autocomplete)/' ~/.zshrc
  sed -i 's/^ZSH_THEME=.*/ZSH_THEME="random"/' ~/.zshrc
  source ~/.zshrc
fi

#======================#
#   Power Menu Setup   #
#======================#

mkdir -p ~/.local/bin
cat << 'EOF' > ~/.local/bin/power-menu
#!/bin/bash

CHOICE=$(echo -e "⏻ Shutdown\n Reboot\n Logout\n Lock" | dmenu -p "Power")

case "$CHOICE" in
  *Shutdown) pkill -u $(whoami) ;;
  *Reboot) echo "Use Termux to reboot manually." ;;
  *Logout) pkill -KILL -u $(whoami) ;;
  *Lock) echo "Locking not supported in this setup." ;;
  *) exit 0 ;;
esac
EOF

chmod +x ~/.local/bin/power-menu

echo "You can run power-menu by typing 'power-menu' from any terminal."

#======================#
#   Final Notes        #
#======================#

echo "✅ XFCE setup complete in your Termux arch64 chroot!"
echo "➡ Start VNC with: vncserver"
echo "➡ Stop VNC with: vncserver -kill :1"
