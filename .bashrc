alias rm='rm -I'
alias mv='mv -i'
alias cp='cp -i'
alias l='ls'

export PATH=$HOME/bin:$PATH
export HISTCONTROL=ignorespace:ignoredups
export HISTIGNORE='fg:mm'
export HISTSIZE=50000

#Put stuff in .bashrc_local that varies based on particular machines
if [ -f ~/.bashrc_local ]; then
    . ~/.bashrc_local
fi
