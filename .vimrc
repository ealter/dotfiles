call pathogen#infect()

set autoindent
set smartindent
set title "show title in console bar
set sm "show matching braces
set number " show line numbers
set hls "do highlighting
set ruler
set smartcase
set incsearch "Incremental search
set hlsearch
set showcmd
set ignorecase
set wildmenu
syntax on

" Spaces are better than tabs
set expandtab
au BufRead,BufNewFile Makefile set ts=4 sw=4 noexpandtab
set smarttab
set tabstop=2
set shiftwidth=2

set bs=indent,eol,start		" allow backspacing over everything in insert mode

"We like 80 columns
set textwidth=80

"show matching brackets
set showmatch

"break away from vi compatibility
set nocompatible

if has("gui_running")
  set guicursor=a:blinkon0
endif

" Only do this part when compiled with support for autocommands
if has("autocmd")
  augroup redhat
    " When editing a file, always jump to the last cursor position
    autocmd BufReadPost *
    \ if line("'\"") > 0 && line ("'\"") <= line("$") |
    \   exe "normal! g'\"" |
    \ endif
  augroup END
endif

let mapleader="," " change the leader to be a comma vs slash

"Highlight lines over 80 chars
nnoremap <Leader>H :call<SID>LongLineHLToggle()<cr>
highlight OverLength ctermbg=darkred ctermfg=white guibg=#FFD9D9

"Credit goes to http://stackoverflow.com/a/1919805/614644
fun! s:LongLineHLToggle()
  if !exists('w:longlinehl')
    match OverLength /\%>80v.\+/
    let w:longlinehl = 1
    echo "Long lines highlighted"
  else
    match none
    unl w:longlinehl
    echo "Long lines unhighlighted"
  endif
endfunction

" remap kj to escape insert mode (since you'll probably never type this)
inoremap kj <Esc>
" more likely that you'd type this one, but it allows you to mash the 2 keys
inoremap jk <Esc>

" Turn off annoying error bells
set noerrorbells
set novisualbell

"Make the cursor move as expected with wrapping lines
"nnoremap j gj
"nnoremap k gk

" Swap ; and : Convinient
nnoremap ; :
nnoremap :: ;

"Compile with 1 step
"set makeprg=./compile
set makeprg=make
imap <F9> <Esc><F9>
noremap <F9> <Esc>:w<Cr>:make<Cr>

"Remap split movements
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l
noremap <C-h> <C-w>h

"quick insertion of a newline by pressing enter
nnoremap <silent> <CR> :put=''<CR>

" shortcuts for copying to clipboard
nnoremap <leader>y "+y
nnoremap <leader>Y "+yy
nnoremap <leader>p "+p

"Change Y to make sense
nnoremap Y y$

" visual shifting (does not exit Visual mode)
vnoremap < <gv
vnoremap > >gv

"Press Ctrl-N to turn off highlighting
nnoremap <silent> <leader><Space> :silent noh<CR>

" shortcut to toggle spelling
nnoremap <leader>s :setlocal spell! spelllang=en_us<CR>

" remap space to insert a single character
nnoremap <silent> <Space> :exec "normal i".nr2char(getchar())."\e"<CR>

" Inserts hard tab in INSERT mode
inoremap <leader><Tab> <C-V><Tab>

"" Split vertical window and switch to it
nnoremap <leader>v <C-w>v<C-w>l

"" Split horizontal window and switch to it
nnoremap <leader>h :split<CR>

"" Strip all trailing whitespace in the current file
nnoremap <silent> <leader>W :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>

"File type specific

set wildignore=*.o,*.ui,*.uo,*.exe

"C, C++, Java
autocmd Filetype c,cpp,java set cindent 

"impcore
au BufNewFile,BufRead *.imp set filetype=lisp

"PLUGINS
source $HOME/vim/headerGuard.vim

set background=dark
if !has('gui_running')
  set t_Co=256
  "let g:solarized_termcolors=256
endif
colorscheme solarized

"Functions
fun! <SID>StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfun

autocmd FileType c,cpp,java,php,python,javascript, autocmd BufWritePre <buffer> :call <SID>StripTrailingWhitespaces()

