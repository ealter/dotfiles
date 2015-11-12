alias rm='rm -I'
alias mv='mv -i'
alias cp='cp -i'
alias l='ls'
alias delete_merged_local_branches='git branch -d $(git branch --merged | grep -v "^\*")'

export PATH=$HOME/bin:$PATH
export HISTCONTROL=ignorespace:ignoredups
export HISTIGNORE='fg:mm'
export HISTSIZE=50000

if [ -z "$SSH_AUTH_SOCK" ]; then
    export SSH_AUTH_SOCK=~/.ssh/ssh_auth_sock
fi

#Put stuff in .bashrc_local that varies based on particular machines
if [ -f ~/.bashrc_local ]; then
    . ~/.bashrc_local
fi
