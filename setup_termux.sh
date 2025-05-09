#!/data/data/com.termux/files/usr/bin/bash

echo "📦 Updating Termux packages..."
pkg update -y && pkg upgrade -y

echo "📦 Installing essential packages..."
pkg install -y x11-repo
pkg install -y termux-x11-nightly
pkg install -y tur-repo
pkg install -y pulseaudio
pkg install -y proot-distro
pkg install -y wget
pkg install -y git
pkg install -y curl
pkg install -y zsh
pkg install -y vim
pkg install -y unzip
pkg install -y python
pkg install -y nodejs
pkg install -y neofetch
pkg install -y tar

echo "✅ Basic packages installed."

echo "🐚 Installing Oh My Zsh..."
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# ZSH_CUSTOM location
export ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

echo "🔌 Installing Zsh plugins..."

git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
git clone https://github.com/zsh-users/zsh-syntax-highlighting "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
git clone https://github.com/zdharma-continuum/fast-syntax-highlighting.git "$ZSH_CUSTOM/plugins/fast-syntax-highlighting"
git clone --depth 1 -- https://github.com/marlonrichert/zsh-autocomplete.git "$ZSH_CUSTOM/plugins/zsh-autocomplete"

echo "⚙️ Configuring .zshrc..."

# Add plugins and random theme (avoid duplicates)
sed -i 's/plugins=(git)/plugins=(git zsh-autosuggestions zsh-syntax-highlighting fast-syntax-highlighting)/' ~/.zshrc
if ! grep -q 'ZSH_THEME="random"' ~/.zshrc; then
    echo 'ZSH_THEME="random"' >> ~/.zshrc
fi

echo "🖼️ Copying wallpapers (if found)..."
mkdir -p ~/Pictures
if [ -d "./Wallpaper" ]; then
    cp -r ./Wallpaper/* ~/Pictures/
    echo "✅ Wallpapers copied to ~/Pictures."
else
    echo "⚠️ No Wallpaper directory found in current path."
fi

echo "🎉 Termux setup complete! Run 'source ~/.zshrc' or restart Termux to activate ZSH."
