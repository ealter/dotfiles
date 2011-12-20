"Load plugins
"runtime bundles/tplugin_vim/macros/tplugin.vim

set autoindent
set cindent "make smartindent if not c
set title "show title in console bar
set sm "show matching braces
set number " show line numbers
set ruler
set showcmd
set wildmenu
syntax on

" Spaces are better than tabs
set expandtab
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

" Turn off annoying error bells
set noerrorbells
set novisualbell
"Make the cursor move as expected with wrapping lines
inoremap <Down> <C-o>gj
inoremap <Up> <C-o>gk

" Swap ; and : Convinient
nnoremap ; :
nnoremap :: ;

"Compile with 1 step
set makeprg=./compile
map <F9> :w<Cr>:make<Cr>

"Remap split movements
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l
map <C-h> <C-w>h

"quick insertion of a newline by pressing enter
nmap <CR> o<Esc>

" shortcuts for copying to clipboard
nmap <leader>y "*y
nmap <leader>Y "*yy
nmap <leader>p "*p

"Press Ctrl-N to turn off highlighting
nmap <silent> <C-N> :silent noh<CR>

",q to reformat paragraph
nnoremap <leader>q gqap

" shortcut to toggle spelling
nmap <leader>s :setlocal spell! spelllang=en_us<CR>

" remap space to append a single character
nnoremap <Space> a_<Esc>r
