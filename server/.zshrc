# Server Zsh Config - Lightweight & Fast

# --- Minimal Prompt (RobbyRussell styleish) ---
autoload -Uz vcs_info
precmd() { vcs_info }
zstyle ':vcs_info:git:*' formats ' git:(%F{red}%b%f)'
setopt PROMPT_SUBST
PROMPT='%F{cyan}➜%f %F{green}%c%f${vcs_info_msg_0_} %F{yellow}✗%f '
# Note: The '✗' is static here as a separator, logic to change color on error is heavier, keeping it simple.

# --- History ---
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt APPEND_HISTORY
setopt SHARE_HISTORY
setopt INC_APPEND_HISTORY

# --- Options ---
setopt AUTO_CD
setopt EXTENDED_GLOB

# --- Aliases (Ported from your setup) ---
alias ls='ls --color=auto'
alias ll='ls -alF'
alias grep='grep --color=auto'
alias cat='batcat 2>/dev/null || cat' # Try batcat (debian) or fall back

alias vim='nvim'
alias v='nvim'
alias vimrc='nvim ~/.config/nvim/init.lua'
alias zshrc='nvim ~/.zshrc'
alias t='tmux'
alias ta='tmux attach -t'
alias tn='tmux new -s'

alias gst='git status'
alias gco='git checkout'
alias gl='git pull'
alias gp='git push'
alias gd='git diff'

# --- Path & Exports ---
export EDITOR='nvim'
export PATH=$HOME/.local/bin:$PATH

# --- FZF (Use system fzf if available) ---
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# --- Tmux Auto-start (Optional - uncomment to enable) ---
# if [ -z "$TMUX" ] && [ -n "$SSH_CONNECTION" ]; then
#   tmux attach -t default || tmux new -s default
# fi
