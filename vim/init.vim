" A lot of inspiration from Shougo

" Note: Skip initialization for vim-tiny or vim-small.
if !1 | finish | endif

function! s:smart_source_rc(name)
    call s:source_rc(a:name . '.vim')
    call s:source_rc(a:name . '.local.vim')
endfunction

function! s:source_rc(path)
  let l:f_path = fnameescape(expand('~/.vim/rc/' . a:path))
  if filereadable(l:f_path)
      execute 'source' . l:f_path
  endif
endfunction

" Auto install vim-plug
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall
endif

call s:source_rc('init.rc.vim')
call s:smart_source_rc('keymap')
call plug#begin()
call s:smart_source_rc('plugins')
call plug#end()
call s:smart_source_rc('edit')
call s:smart_source_rc('ui')
call s:smart_source_rc('yelp')
