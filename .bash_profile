[[ -f ~/.bashrc ]] && . ~/.bashrc


[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
hash aactivator 2>/dev/null && eval "$(aactivator init)"
