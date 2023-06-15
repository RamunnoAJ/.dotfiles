# run sudo update
sudo apt update

# install curl
sudo apt install curl

# install nix
curl -L https://nixos.org/nix/install | sh 

# source nix
. ~/.nix-profile/etc/profile.d/nix.sh

# install packages
nix-env -iA \
	nixpkgs.zsh \
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
	nixpkgs.rPackages.npm \
	nixpkgs.nodenv \
	nixpkgs.zoxide 

# use latest version of node
nvm alias default node

# stow
stow git
stow zsh
stow nvim

# add zsh to valid login shells
command -v zsh | sudo tee -a /etc/shells

# use zsh as default shell
sudo chsh -s $(which zsh) $USER

# bundle zsh plugins
antibody bundle < ~/.zsh_plugins.txt > ~/.zsh_plugins.sh

