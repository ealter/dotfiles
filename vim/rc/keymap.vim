let mapleader="," " change the leader to be a comma vs slash

" remap kj to escape insert mode (since you'll probably never type this)
inoremap kj <Esc>

" Swap ; and : Convinient
nnoremap ; :
nnoremap : ;

"Compile with 1 step
"imap <leader>w <Esc><leader>w
nnoremap <leader>w <Esc>:wa<Cr>:make<Cr>

"quick insertion of a newline by pressing enter
nnoremap <silent> <CR> :put=repeat([''],v:count)<CR>
autocmd CmdwinEnter * nnoremap <CR> <CR>
autocmd BufReadPost quickfix nnoremap <CR> <CR>

" shortcuts for copying to clipboard
nnoremap <leader>y "+y
vnoremap <leader>y "+y
nnoremap <leader>Y "+yy
nnoremap <leader>p "+p

"Change Y to make sense
nnoremap Y y$

" visual shifting (does not exit Visual mode)
vnoremap < <gv
vnoremap > >gv

nnoremap <silent> <leader><Space> :silent noh<CR>

" shortcut to toggle spelling
nnoremap <leader>s :setlocal spell! spelllang=en_us<CR>

" remap space to insert a single character
nnoremap <silent> <Space> :exec "normal i".nr2char(getchar())."\e"<CR>

" Inserts hard tab in INSERT mode
inoremap <leader><Tab> <C-V><Tab>

" Shows the directory contents in a new split
nnoremap <silent> <leader>ls :new<CR>:r!ls<CR>

" Remove trailing whitespace when saving
autocmd BufWritePre *.{py,js,yaml,tmpl} :%s/\s\+$//e

"Makes splits easier (since s is pretty useless anyway)
nnoremap s <C-W>

"cd to the current directory and then print where you are
nnoremap <leader>cd :cd %:p:h<CR>:pwd<CR>
