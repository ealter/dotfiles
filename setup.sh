#!/bin/bash

setup_vim(){
    if [ -d ~/.vim  ] || [ -f ~/.vimrc ] || [ -d ~/.nvim  ] || [ -f ~/.nvimrc ] || [ -d ~/.config/nvim  ]; then
        echo "Vim files already exist. Please backup or remove .(n)vim and .(n)vimrc and .config/nvim"
        return
    fi

    # Get current directory for future use in links
    VIM_SYNC_DIR=$(dirname $0)
    cd $VIM_SYNC_DIR
    VIM_SYNC_DIR=$(pwd)


    # Vim
    ln -s $VIM_SYNC_DIR/vim/init.vim ~/.vimrc
    ln -s $VIM_SYNC_DIR/vim ~/.vim

    # Neovim legacy
    ln -s $VIM_SYNC_DIR/vim/init.vim ~/.nvimrc
    ln -s $VIM_SYNC_DIR/vim ~/.nvim

    # Neovim new
    mkdir -p ${XDG_CONFIG_HOME:=$HOME/.config}
    ln -s $VIM_SYNC_DIR/vim $XDG_CONFIG_HOME/nvim

    # Install all bundles
    echo "Install all bundles"
    vim +PlugInstall +qall
    if hash nvim 2>/dev/null; then
        nvim +PlugInstall +qall
    fi
}
 
setup_other_softlinks(){
    files=".bash_profile .gitconfig .bashrc .zshrc .p10k.zsh .tmux.conf .inputrc .gitignore_global .pdbrc .pythonrc.py"
    printf "Making soft links to $files and .vim and .vimrc \n"
    current_dir=`pwd`
    for file in $files; do
        if [ -f "$HOME/$file" ]; then
            echo "$HOME/$file already exists. Skipping."
        else
            echo "Adding $HOME/$file"
            ln -s "$current_dir/$file" "$HOME/$file"
        fi
    done
    printf "Done.\n\n"
}

setup_neovim_virtualenv(){
    cd vim
    virtualenv --python=python3 virtualenv
    virtualenv/bin/pip install neovim flake8
    cd -
}

setup_vendored_files(){
    if [ ! -f git-completion.bash ]; then
        wget https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash
    fi
    if [ ! -f git-prompt.sh ]; then
        wget https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh
    fi

    if [ ! -f "${HOME}/.zgen" ]; then
        git clone https://github.com/tarjoilija/zgen.git "${HOME}/.zgen"
    fi
}
 
setup_vim
setup_other_softlinks
setup_vendored_files
setup_neovim_virtualenv
