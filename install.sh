# run sudo update
sudo apt update

# install curl
sudo apt install curl

#install zsh
sudo apt install zsh

# install nix
curl -L https://nixos.org/nix/install | sh 

# source nix
. ~/.nix-profile/etc/profile.d/nix.sh

# install packages
nix-env -iA \
	nixpkgs.zsh \
	nixpkgs.oh-my-zsh \
	nixpkgs.antibody \
	nixpkgs.git \
	nixpkgs.lazygit \
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

# install nvm latest version of node
nvm install node

# use latest version of node
nvm alias default node

# install eslint and prettier globally
npm install -g eslint prettier

# install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# stow
stow git
stow zsh
stow nvim
stow tmux

# move .zshrc.example to .zshrc
mv ~/.zshrc.example ~/.zshrc

# source tmux.conf
tmux source-file ~/.tmux.conf

# add zsh to valid login shells
command -v zsh | sudo tee -a /etc/shells

# use zsh as default shell
sudo chsh -s $(which zsh) $USER

# bundle zsh plugins
antibody bundle < ~/.zsh_plugins.txt > ~/.zsh_plugins.sh
