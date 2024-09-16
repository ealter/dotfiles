# Download and start Znap to manage plugins
[[ -f ~/Git/zsh-snap/znap.zsh ]] ||
    git clone --depth 1 -- \
        https://github.com/marlonrichert/zsh-snap.git ~/Git/zsh-snap

source ~/Git/zsh-snap/znap.zsh

znap source ohmyzsh/ohmyzsh

znap prompt sindresorhus/pure
PURE_GIT_UNTRACKED_DIRTY=0
PURE_GIT_PULL=0

znap install zsh-users/zsh-completions
znap install zsh-users/zsh-syntax-highlighting
znap install zsh-users/zsh-history-substring-search

source ~/.bash_profile
source ~/.bashrc

eval "$(nodenv init -)"
compdef _git stripe-git=git
autoload -z edit-command-line
bindkey -M vicmd v edit-command-line
bindkey "^[[A" history-beginning-search-backward
bindkey "^[[B" history-beginning-search-forward
