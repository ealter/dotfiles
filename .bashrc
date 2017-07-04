alias mv='mv -i'
alias cp='cp -i'
alias l='ls'
# On linux, --color exists, but on macs it does not
if ls --color > /dev/null 2>&1; then
    alias ls='ls --color'
else
    alias ls='ls -G'
fi

alias delete_merged_local_branches='git branch -d $(git branch --merged | grep -v "^\*" | grep -v master)'
alias gg='git grep --line-number'

gv() {
    # Open the search files in vim
    vim $(git grep -l "$@")
}

gbranch() {
    git fetch origin

    if git rev-parse --verify origin/dev > /dev/null 2>&1; then
        # Yelp wifi sometimes uses dev and sometimes uses master. This runs if origin/dev exists.
        remote=origin/dev
    else
        remote=origin/master
    fi

    git checkout $remote -b "$1"
}

export HISTCONTROL=ignorespace:ignoredups
export HISTIGNORE='fg:mm'
export HISTSIZE=50000

if [ -z "$SSH_AUTH_SOCK" ]; then
    export SSH_AUTH_SOCK=~/.ssh/ssh_auth_sock
fi

set -o vi
export PYTHONSTARTUP=~/.pythonrc.py

#Put stuff in .bashrc_local that varies based on particular machines
if [ -f ~/.bashrc_local ]; then
    . ~/.bashrc_local
fi

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/bin:$HOME/.rvm/bin:$HOME/.cargo/bin"
