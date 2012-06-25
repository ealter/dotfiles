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
    ln -s "$current_dir" "$HOME/.vim"
    printf "Done.\n\n"
}
 
printf """
Eliot's Vimrc
@author: Ammar Khaku (akhaku)
Requires Vim7
 
"""
move_old_vim_files
setup_vim_softlinks

