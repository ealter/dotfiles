#!/bin/sh
 
move_old_vim_files(){
if [ -e "$HOME/.vim" ]; then
    echo "Moving old .vim to .vim-old"
    mv "$HOME/.vim" "$HOME/.vim-old"
fi
 
if [ -e "$HOME/.vimrc" ]; then
    echo "Moving old .vimrc to .vimrc-old"
    mv "$HOME/.vimrc" "$HOME/.vimrc-old"
fi
 
}
 
setup_vim_softlinks(){
    printf "Making soft links to .vim and .vimrc\n"
    current_dir=`pwd`
    ln -s "$current_dir/.vimrc" "$HOME/.vimrc"
    ln -s "$current_dir/.vim" "$HOME/.vim"
    mkdir -p "$current_dir/.vim/undodir"
    mkdir -p "$current_dir/.vim/vim_swap"
    mkdir -p "$current_dir/.vim/backup"
    printf "Done.\n\n"
}
 
printf """
Eliot's Vimrc
@author: Ammar Khaku (akhaku)
Requires Vim7
 
"""
move_old_vim_files
setup_vim_softlinks
git submodule init
git submodule update

