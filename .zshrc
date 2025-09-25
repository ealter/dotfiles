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

source ~/.bashrc

# eval "$(nodenv init -)"
compdef _git stripe-git=git
autoload -z edit-command-line
bindkey -M vicmd v edit-command-line
bindkey "^[[A" history-beginning-search-backward
bindkey "^[[B" history-beginning-search-forward

# ---- Various aliases ------

alias mv='mv -i'
alias cp='cp -i'
alias l='ls'
# On linux, --color exists, but on macs it does not
if ls --color > /dev/null 2>&1; then
    alias ls='ls --color=auto'
else
    alias ls='ls -G'
fi

alias delete_merged_local_branches='git branch -d $(git branch --merged | grep -v "^\*" | grep -v master)'
alias gg='git grep --line-number'
alias apush='git commit -a --amend --no-edit && git push -f origin HEAD'
alias groot='cd "$(git rev-parse --show-toplevel)"'

# Prefer neovim if it is installed
if hash nvim 2>/dev/null; then
    alias vim='nvim'
fi

gv() {
    # Open the search files in vim
    if command -v rg &> /dev/null; then
        vim $(rg -l "$@" | sort)
    else
        vim $(git grep -l "$@")
    fi
}

gbranch() {
    git fetch origin
    git checkout origin/master -b "$1"
}

remove_python_imports() {
    files=$(git diff HEAD --name-only | grep '\.py$')

    if [ -z "$files" ]; then
        exit 0
    fi

    for file in $files; do
        flake8_output=$(flake8 "$file" | grep 'imported but unused')
        if [ ! -z "$flake8_output" ]; then
            sed -i $(echo "$flake8_output" | cut -d: -f2 | xargs -n1 -I {} echo {}d | tr '\n' ';') "$file"
        fi
    done
}

merge_master() {(
    set -e
    branch="$(git rev-parse --abbrev-ref HEAD)"
    reviewnumber=$(git config "branch.$branch.reviewnumber") || true
    git checkout master
    git pull
    git merge --no-ff "$branch" --no-edit
    git push origin HEAD
)}

if [ -z "$SSH_AUTH_SOCK" ]; then
    export SSH_AUTH_SOCK=~/.ssh/ssh_auth_sock
fi

set -o vi
export PYTHONSTARTUP=~/.pythonrc.py
alias fix_ssh_auth='export $(tmux show-environment | grep \^SSH_AUTH_SOCK=)'

if test -n "$BASH_VERSION"; then
    export HISTCONTROL=ignorespace:ignoredups
    export HISTIGNORE='fg'
    export HISTSIZE=50000

    if [ -f ~/dotfiles/git-completion.bash ]; then
        . ~/dotfiles/git-completion.bash
    fi

    if [ -f ~/dotfiles/git-prompt.sh ]; then
        . ~/dotfiles/git-prompt.sh
        PS1='\h:\W$(__git_ps1 " (%s)")\$ '
    fi
elif test -n "$ZSH_VERSION"; then
    setopt HIST_IGNORE_SPACE
    export HISTORY_IGNORE='(fg)'
fi

#Put stuff in .bashrc_local that varies based on particular machines
if [ -f ~/.bashrc_local ]; then
    . ~/.bashrc_local
fi

# Add RVM and golang to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/bin:$HOME/.rvm/bin:$HOME/.cargo/bin:$HOME/go/bin"
