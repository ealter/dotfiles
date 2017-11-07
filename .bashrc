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

# Prefer neovim if it is installed
if hash nvim 2>/dev/null; then
    alias vim='nvim'
fi

gv() {
    # Open the search files in vim
    vim $(git grep -l "$@")
}

gbranch() {
    git fetch origin
    git checkout origin/master -b "$1"
}

export HISTCONTROL=ignorespace:ignoredups
export HISTIGNORE='fg:mm'
export HISTSIZE=50000

if [ -z "$SSH_AUTH_SOCK" ]; then
    export SSH_AUTH_SOCK=~/.ssh/ssh_auth_sock
fi

set -o vi
export PYTHONSTARTUP=~/.pythonrc.py

source ~/dotfiles/git_completion.bash

#Put stuff in .bashrc_local that varies based on particular machines
if [ -f ~/.bashrc_local ]; then
    . ~/.bashrc_local
fi

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/bin:$HOME/.rvm/bin:$HOME/.cargo/bin:./node_modules/.bin"
