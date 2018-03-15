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

run_in_docker() {
    docker run --init --workdir /foo --volume "$(pwd):/foo/" busybox $@
}

merge_master() {
    branch="$(git rev-parse --abbrev-ref HEAD)"
    git checkout master && git pull && git merge --no-ff "$branch" && git push origin HEAD

    if git config "branch.$branch.reviewnumber" > /dev/null; then
        review-branch --submit "$branch"
    fi
}

export HISTCONTROL=ignorespace:ignoredups
export HISTIGNORE='fg:mm'
export HISTSIZE=50000

if [ -z "$SSH_AUTH_SOCK" ]; then
    export SSH_AUTH_SOCK=~/.ssh/ssh_auth_sock
fi

set -o vi
export PYTHONSTARTUP=~/.pythonrc.py
alias fix_ssh_auth='export $(tmux show-environment | grep \^SSH_AUTH_SOCK=)'

source ~/dotfiles/git_completion.bash

#Put stuff in .bashrc_local that varies based on particular machines
if [ -f ~/.bashrc_local ]; then
    . ~/.bashrc_local
fi

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/bin:$HOME/.rvm/bin:$HOME/.cargo/bin:./node_modules/.bin"
