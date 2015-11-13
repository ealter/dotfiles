function! WorkSettings()
    nnoremap <leader>fs :call g:EditPairFile('split')<CR>
endfunction

augroup vimrc-work
    au BufNewFile,BufRead ~/pg/* call WorkSettings()
augroup END
