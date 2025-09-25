### BEGIN STRIPE
# All Stripe related shell configuration
# is at ~/.stripe/shellinit/zshrc and is
# persistently managed by Chef. You shouldn't
# remove this unless you don't want to load
# Stripe specific shell configurations.
#
# Feel free to add your customizations in this
# file (~/.zshrc) after the Stripe config
# is sourced.
if [[ -f ~/.stripe/shellinit/zshrc ]]; then
  source ~/.stripe/shellinit/zshrc
fi
### END STRIPE
# Download and start Znap to manage plugins
[[ -f ~/Git/zsh-snap/znap.zsh ]] ||
    git clone --depth 1 -- \
        https://github.com/marlonrichert/zsh-snap.git ~/Git/zsh-snap

source ~/Git/zsh-snap/znap.zsh

# Disable omz autoupdates and other slow things
DISABLE_AUTO_UPDATE=true
DISABLE_MAGIC_FUNCTIONS=true
DISABLE_COMPFIX=true

# Smarter completion initialization. Only calculate completions once a day.
autoload -Uz compinit
if [ "$(date +'%j')" != "$(stat -f '%Sm' -t '%j' ~/.zcompdump 2>/dev/null)" ]; then
    compinit
else
    compinit -C
fi


znap source ohmyzsh/ohmyzsh

znap prompt sindresorhus/pure
PURE_GIT_UNTRACKED_DIRTY=0
PURE_GIT_PULL=0

znap source zsh-users/zsh-completions
znap source zsh-users/zsh-syntax-highlighting
znap source zsh-users/zsh-history-substring-search

source ~/.bash_profile
source ~/.bashrc

# eval "$(nodenv init -)"
compdef _git stripe-git=git
autoload -z edit-command-line
bindkey -M vicmd v edit-command-line
bindkey "^[[A" history-beginning-search-backward
bindkey "^[[B" history-beginning-search-forward
