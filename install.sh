# run sudo update
sudo apt update

# install curl
sudo apt install curl
#install zsh
sudo apt install zsh
# install nix
curl -L https://nixos.org/nix/install | sh
# install nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash

# source nix
. ~/.nix-profile/etc/profile.d/nix.sh

# install packages
nix-env -iA \
	nixpkgs.zsh \
	nixpkgs.oh-my-zsh \
	nixpkgs.ansible \
	nixpkgs.go \
	nixpkgs.glow \
	nixpkgs.neofetch \
	nixpkgs.btop \
	nixpkgs.xclip \
	nixpkgs.antibody \
	nixpkgs.git \
	nixpkgs.neovim \
	nixpkgs.tmux \
	nixpkgs.stow \
	nixpkgs.yarn \
	nixpkgs.fzf \
	nixpkgs.ripgrep \
	nixpkgs.bat \
	nixpkgs.direnv \
	nixpkgs.nodenv \
	nixpkgs.zoxide

# Creates directories if not exists
mkdir -p ~/projects
mkdir -p ~/work
mkdir -p ~/study
mkdir -p ~/personal

# install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# stow
stow git
stow zsh
stow nvim
stow tmux
stow scripts

# move .zshrc.example to .zshrc
mv ~/.zshrc.example ~/.zshrc

# install tmux plugin manager
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# source tmux.conf
tmux source-file ~/.tmux.conf

# add zsh to valid login shells
command -v zsh | sudo tee -a /etc/shells

# use zsh as default shell
sudo chsh -s $(which zsh) $USER

# bundle zsh plugins
antibody bundle < ~/.zsh_plugins.txt > ~/.zsh_plugins.sh

# source zshrc
source ~/.zshrc

# install nvm latest version of node
nvm install --lts
nvm alias defaul node
