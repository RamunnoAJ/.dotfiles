#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="${DOTFILES_DIR:-$HOME/.dotfiles}"

# 1) Base mínima (solo curl + git para bootstrap)
sudo apt-get update
sudo apt-get install -y --no-install-recommends curl git ca-certificates

# 2) Nix (si no está)
if [ ! -d "$HOME/.nix-profile" ]; then
  curl -L https://nixos.org/nix/install | sh
fi

# Cargar entorno nix en este script
. "$HOME/.nix-profile/etc/profile.d/nix.sh"

# 3) Paquetes
nix-env -iA \
  nixpkgs.zsh \
  nixpkgs.oh-my-zsh \
  nixpkgs.ansible \
  nixpkgs.go \
  nixpkgs.neofetch \
  nixpkgs.btop \
  nixpkgs.xclip \
  nixpkgs.antibody \
  nixpkgs.neovim \
  nixpkgs.tmux \
  nixpkgs.stow \
  nixpkgs.yarn \
  nixpkgs.fzf \
  nixpkgs.ripgrep \
  nixpkgs.bat \
  nixpkgs.direnv \
  nixpkgs.zoxide

# 4) Directorios
mkdir -p "$HOME"/{projects,work,workspaces,study,personal} "$HOME/.config"

# 5) Stow (siempre explícito: target HOME, source repo)
# Requiere ejecutar desde el repo o setear DOTFILES_DIR.
stow -d "$DOTFILES_DIR" -t "$HOME" git zsh nvim tmux scripts

# 6) TPM idempotente
if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
  git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
fi

# 7) Zsh como shell default (asegurar /etc/shells)
ZSH_PATH="$(command -v zsh)"
if ! grep -qx "$ZSH_PATH" /etc/shells; then
  echo "$ZSH_PATH" | sudo tee -a /etc/shells >/dev/null
fi
sudo chsh -s "$ZSH_PATH" "$USER"

# 8) Antibody bundle idempotente
if [ -f "$HOME/.zsh_plugins.txt" ]; then
  antibody bundle < "$HOME/.zsh_plugins.txt" > "$HOME/.zsh_plugins.sh"
fi

# 9) NVM (si querés seguir con nvm)
if [ ! -d "$HOME/.nvm" ]; then
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash
fi
export NVM_DIR="$HOME/.nvm"
# shellcheck disable=SC1091
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"

nvm install --lts
nvm alias default 'lts/*'
