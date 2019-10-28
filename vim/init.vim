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

" ******* BEGIN FIX AUTOREAD *******
" https://github.com/neovim/neovim/issues/2127
augroup AutoSwap
        autocmd!
        autocmd SwapExists *  call AS_HandleSwapfile(expand('<afile>:p'), v:swapname)
augroup END

function! AS_HandleSwapfile (filename, swapname)
        " if swapfile is older than file itself, just get rid of it
        if getftime(v:swapname) < getftime(a:filename)
                call delete(v:swapname)
                let v:swapchoice = 'e'
        endif
endfunction
autocmd CursorHold,BufWritePost,BufReadPost,BufLeave *
  \ if isdirectory(expand("<amatch>:h")) | let &swapfile = &modified | endif

augroup checktime
    au!
    if !has("gui_running")
        "silent! necessary otherwise throws errors when using command
        "line window.
        autocmd BufEnter,CursorHold,CursorHoldI,CursorMoved,CursorMovedI,FocusGained,BufEnter,FocusLost,WinLeave * checktime
    endif
augroup END
" ******* END FIX AUTOREAD *******
