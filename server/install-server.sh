#!/bin/bash

# Server Setup Script
# Installs minimal config for Neovim, Tmux, and Zsh without heavy frameworks.

set -e

echo ">>> Starting Server Setup..."

# 1. Install Dependencies (Debian/Ubuntu assumed)
if command -v apt-get &> /dev/null; then
    echo ">>> Installing dependencies via apt..."
    sudo apt-get update
    sudo apt-get install -y zsh tmux git curl unzip ripgrep fd-find
elif command -v yum &> /dev/null; then
    echo ">>> Installing dependencies via yum..."
    sudo yum install -y zsh tmux git curl unzip ripgrep fd-find
else
    echo ">>> Package manager not found. Please ensure zsh, tmux, git, curl are installed."
fi

# 1.1 Install Latest Neovim (from source/release, to avoid old apt versions)
echo ">>> Installing latest Neovim..."
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz
sudo rm -rf /opt/nvim
sudo tar -C /opt -xzf nvim-linux64.tar.gz
# Create a symbolic link so 'nvim' is in the path
if [ -L /usr/local/bin/nvim ]; then
    sudo rm /usr/local/bin/nvim
fi
sudo ln -s /opt/nvim-linux64/bin/nvim /usr/local/bin/nvim
rm nvim-linux64.tar.gz

# 2. Setup Zsh
echo ">>> Setting up Zsh..."
if [ -f ~/.zshrc ]; then
    mv ~/.zshrc ~/.zshrc.bak.$(date +%s)
    echo "Backing up existing .zshrc"
fi
cp server/.zshrc ~/.zshrc

# 3. Setup Tmux
echo ">>> Setting up Tmux..."
if [ -f ~/.tmux.conf ]; then
    mv ~/.tmux.conf ~/.tmux.conf.bak.$(date +%s)
fi
cp server/.tmux.conf ~/.tmux.conf

# 4. Setup Neovim
echo ">>> Setting up Neovim..."
mkdir -p ~/.config/nvim
if [ -f ~/.config/nvim/init.lua ]; then
    mv ~/.config/nvim/init.lua ~/.config/nvim/init.lua.bak.$(date +%s)
fi
cp server/init.lua ~/.config/nvim/init.lua

# 5. Set Shell
if [ "$SHELL" != "$(which zsh)" ]; then
    echo ">>> Changing default shell to zsh..."
    chsh -s $(which zsh)
fi

echo ">>> Setup Complete! Restart your shell or run 'zsh'."
