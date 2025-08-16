#!/bin/bash

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
    sed -i 's/plugins=(.*)/plugins=(git zsh-autosuggestions zsh-syntax-highlighting fast-syntax-highlighting zsh-autocomplete)/' ~/.zshrc
else
    echo 'plugins=(git zsh-autosuggestions zsh-syntax-highlighting fast-syntax-highlighting zsh-autocomplete)' >> ~/.zshrc
fi

# Add random theme if not already set
if ! grep -q 'ZSH_THEME="random"' ~/.zshrc; then
    echo 'ZSH_THEME="random"' >> ~/.zshrc
fi

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

echo "🔤 Installing JetBrainsMono Nerd Font..."
mkdir -p ~/.termux
curl -fsSL https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.zip -o /tmp/JetBrainsMono.zip
unzip -o /tmp/JetBrainsMono.zip -d /tmp/JetBrainsMono
cp /tmp/JetBrainsMono/*.ttf ~/.termux/font.ttf

echo "⚡ Configuring fastfetch on startup..."
if [ -n "$ZSH_VERSION" ]; then
    RCFILE="$HOME/.zshrc"
else
    RCFILE="$HOME/.bashrc"
fi

if ! grep -q 'clear' "$RCFILE"; then
    echo 'clear' >> "$RCFILE"
fi
if ! grep -q 'fastfetch' "$RCFILE"; then
    echo 'fastfetch --separator "─"' >> "$RCFILE"
fi


