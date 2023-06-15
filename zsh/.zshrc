# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Export nvm completion settings for lukechilds/zsh-nvm plugin
# Note: This must be exported before the plugin is bundled
export NVM_DIR=${HOME}/.nvm
export NVM_COMPLETION=true

# source plugins
source ~/.zsh_plugins.sh

# aliases
alias update-antibody='antibody bundle < $HOME/.zsh_plugins.txt > $HOME/.zsh_plugins.zsh'
alias list-npm-globals='npm list -g --depth=0'
alias ls='ls -al --color'
alias vim='nvim'
alias cat='bat'
alias gcob='git branch | fzf | xargs git checkout'
alias vimrc='vim ${HOME}/.dotfiles/nvim/.config/nvim/init.lua'

# FZF
export FZF_DEFAULT_COMMAND="rg --files --hidden --glob '!.git/*'"
export FZF_DEFAULT_OPTS="--height 40% --layout=reverse --border --margin=1 --padding=1"

export BAT_THEME="gruvbox-dark"

# Nix
if [ -e ~/.nix-profile/etc/profile.d/nix.sh ]; then . ~/.nix-profile/etc/profile.d/nix.sh; fi 

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# source nvim plugins
source ~/.config/nvim/init.lua

if [ -e /home/ramunno/.nix-profile/etc/profile.d/nix.sh ]; then . /home/ramunno/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

if [ -e /home/agustin/.nix-profile/etc/profile.d/nix.sh ]; then . /home/agustin/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer
