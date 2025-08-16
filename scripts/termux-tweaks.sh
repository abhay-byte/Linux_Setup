#!/bin/bash

#to install - curl -fsSL https://raw.githubusercontent.com/abhay-byte/Linux_Setup/refs/heads/dev/scripts/termux-tweaks-standalone.sh | bash

clear

echo "🐚 Installing Oh My Zsh..."
# Run Oh My Zsh installer non-interactively
RUNZSH=no CHSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Ensure ZSH_CUSTOM is set
export ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

echo "🔌 Installing Zsh plugins..."

git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
git clone https://github.com/zsh-users/zsh-syntax-highlighting "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
git clone https://github.com/zdharma-continuum/fast-syntax-highlighting.git "$ZSH_CUSTOM/plugins/fast-syntax-highlighting"
git clone --depth 1 https://github.com/marlonrichert/zsh-autocomplete.git "$ZSH_CUSTOM/plugins/zsh-autocomplete"

echo "⚙️ Configuring .zshrc..."
# Update plugins line to include all plugins (avoid duplicates)
if grep -q "plugins=" ~/.zshrc; then
    sed -i 's/plugins=(.*)/plugins=(git zsh-autosuggestions zsh-syntax-highlighting fast-syntax-highlighting)/' ~/.zshrc
else
    echo 'plugins=(git zsh-autosuggestions zsh-syntax-highlighting fast-syntax-highlighting)' >> ~/.zshrc
fi

# Add random theme if not already set
echo "🎨 Setting Oh My Zsh theme to random..."
sed -i 's/^ZSH_THEME=.*$/ZSH_THEME="random"/' ~/.zshrc


echo "🐚 Setting Zsh as default shell..."
chsh -s zshzs

echo "Zsh configuration complete. Restart Termux or run 'zsh' to start using it."


echo "🎨Applying GitHub Dark color scheme..."
mkdir -p ~/.termux
cat > ~/.termux/colors.properties << 'EOF'
foreground=#c9d1d9
background=#0d1117
cursor=#c9d1d9
color0=#484f58
color1=#ff7b72
color2=#3fb950
color3=#d29922
color4=#58a6ff
color5=#bc8cff
color6=#39c5cf
color7=#b1bac4
color8=#6e7681
color9=#ffa198
color10=#56d364
color11=#e3b341
color12=#79c0ff
color13=#d2a8ff
color14=#56d4dd
color15=#f0f6fc
EOF

echo "🔤 Installing FiraCode Nerd Font..."
mkdir -p ~/.termux

# Temporary folder for font download and extraction
TMPFONT="$HOME/tmpfont"
mkdir -p "$TMPFONT" && cd "$TMPFONT"

# Download Meslo Nerd Font (better for icons)
curl -fsSL -o meslo.zip \
  https://github.com/ryanoasis/nerd-fonts/releases/latest/download/Meslo.zip

# Extract only the Regular font directly into ~/.termux
mkdir -p ~/.termux
unzip -jo meslo.zip "*Regular.ttf" -d ~/.termux

# Pick one font and rename to font.ttf (overwrite any previous font)
FONTFILE=$(ls ~/.termux/*Regular.ttf | head -n 1)
mv "$FONTFILE" ~/.termux/font.ttf

# Clean up zip file
rm meslo.zip

echo "🎨 Meslo Nerd Font installed as Termux default."
echo "🔄 Restart Termux to apply the new font."


echo "🔄 Reloading Termux settings..."
termux-reload-settings

echo > $PREFIX/etc/motd
rm -f $PREFIX/etc/motd

echo "⚡ Configuring fastfetch on startup..."

cd ~/.local/share
git clone https://github.com/LierB/fastfetch

# Detect shell RC file
if [ -n "$ZSH_VERSION" ]; then
    RCFILE="$HOME/.zshrc"
elif [ -n "$BASH_VERSION" ]; then
    RCFILE="$HOME/.bashrc"
else
    RCFILE="$HOME/.profile"
fi

# Append clear if not already present
grep -qxF 'clear' "$RCFILE" || echo 'clear' >> "$RCFILE"

# Append fastfetch startup command if not already present
grep -qxF 'fastfetch --config ~/.local/share/fastfetch/presets/groups.jsonc' "$RCFILE" || \
    echo 'fastfetch --config ~/.local/share/fastfetch/presets/groups.jsonc' >> "$RCFILE"

echo "✅ Fastfetch configured to run on startup in $RCFILE"




