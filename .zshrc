# load zgen
source "${HOME}/.zgen/zgen.zsh"

# if the init scipt doesn't exist
if ! zgen saved; then
    echo "Creating a zgen save"

    zgen oh-my-zsh

    # plugins
    # zgen oh-my-zsh plugins/gitfast
    zgen load zsh-users/zsh-syntax-highlighting

    # bulk load
    zgen loadall <<EOPLUGINS
        zsh-users/zsh-history-substring-search
EOPLUGINS
    # ^ can't indent this EOPLUGINS

    # completions
    zgen load zsh-users/zsh-completions src

    # theme
    zgen oh-my-zsh themes/arrow

    # save all to init script
    zgen save
fi

export ZGEN_RESET_ON_CHANGE=(${HOME}/.zshrc ${HOME}/.zshrc.local)

# Turn off the git part of the prompt because it's very slow.
export RPROMPT=''

source ~/.bash_profile
source ~/.bashrc
eval "$(nodenv init -)"
