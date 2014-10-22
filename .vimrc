call pathogen#infect()

set nocompatible "break away from vi compatibility

set title "show title in console bar
set number " show line numbers
set hlsearch "do highlighting
set ruler
set smartcase
set incsearch "Incremental search
set showcmd
set cmdheight=2 " avoid 'Press Enter to continue'set wildmenu
set ttyfast
set showmatch "show matching brackets
syntax on

" Spaces are better than tabs
set autoindent
set smartindent
set expandtab
au BufRead,BufNewFile Makefile set ts=4 sw=4 noexpandtab
set smarttab
set tabstop=4
set shiftwidth=4

set bs=indent,eol,start " allow backspacing over everything in insert mode

set list
set listchars=tab:▸\ 

if has("gui_running")
  set guicursor=a:blinkon0
endif

" When editing a file, always jump to the last cursor position
autocmd BufReadPost *
\ if line("'\"") > 0 && line ("'\"") <= line("$") |
\   exe "normal! g'\"" |
\ endif

let mapleader="," " change the leader to be a comma vs slash

"Highlight lines over 80 chars
set textwidth=80 "We like 80 columns
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

" Swap ; and : Convinient
nnoremap ; :
nnoremap :: ;

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

"" Strip all trailing whitespace in the current file
"nnoremap <silent> <leader>W :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>

"Makes splits easier (since s is pretty useless anyway)
nnoremap s <C-W>

"Hell yeh paste mode!
au InsertLeave * set nopaste

"cd into the project root directory
map <silent> <unique> <Leader>pr <Plug>RooterChangeToRootDirectory
let g:rooter_manual_only = 1

"cd to the current directory and then print where you are
nnoremap <leader>cd :cd %:p:h<CR>:pwd<CR>

" Remove trailing whitespace on ,tw
nnoremap <silent> <leader>tw :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>

"File type specific

set wildignore=*.o,*.ui,*.uo,*.exe,.git,*.pdf,*.hi,*.pyc

filetype plugin on
filetype indent plugin on

"C, C++, Java
autocmd Filetype c,cpp,java set cindent 
autocmd BufNewFile,BufRead *.elm setf elm

autocmd BufNewFile,BufRead *.elm set makeprg=google-chrome\ 'http://localhost:8000/%'

"random filetypes
au BufNewFile,BufRead *.imp set filetype=lisp
au BufNewFile,BufRead *.pde set filetype=java
autocmd BufNewFile,BufRead *.pde set makeprg=processing-java\ --sketch=`pwd`\ --output=$(mktemp\ -d)\ --run\ --force

"Undoing is awesome
if(has('persistent_undo'))
  set undodir=$HOME/.vim/undodir
  set undofile
endif

"Move the swap files to their own directory
set dir=$HOME/.vim/vim_swap//,/var/tmp//,/tmp//,.
set backupdir=$HOME/.vim/backup//,/var/tmp//,/tmp//,.
set backup

let g:SuperTabDefaultCompletionType = "context"
set completeopt=menuone,longest,preview
set complete-=i

set background=dark
if !has('gui_running')
  set t_Co=256
  let g:solarized_termcolors=256
else
  set guioptions+=LlRrb 
  set guioptions-=LlRrb "Get rid of all scroll bars in gvim
endif
colorscheme solarized

if(has('lua'))
    let g:acp_enableAtStartup = 0
    " Use neocomplete.
    let g:neocomplete#enable_at_startup = 1
    " Use smartcase.
    let g:neocomplete#enable_smart_case = 1
    " Set minimum syntax keyword length.
    let g:neocomplete#sources#syntax#min_keyword_length = 3
    let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

    inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
endif

