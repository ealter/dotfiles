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
        vim $(rg -l "$@")
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

run_in_docker() {
    docker run --init --workdir /foo --volume "$(pwd):/foo/" busybox $@
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
