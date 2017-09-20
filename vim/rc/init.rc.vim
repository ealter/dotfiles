set nocompatible

set title "show title in console bar
set number " show line numbers
set hlsearch "do highlighting
set ruler
set ignorecase
set smartcase
set incsearch "Incremental search
set showcmd
set cmdheight=2 " avoid 'Press Enter to continue'
set wildmenu
set wildmode=longest,list,full
set ttyfast
set showmatch "show matching brackets
syntax on

set bs=indent,eol,start " allow backspacing over everything in insert mode
set wildignore=*.o,*.ui,*.uo,*.exe,.git,*.pdf,*.hi,*.pyc,*/build/*,*/htdocs/*

"Undoing is awesome
if(has('persistent_undo'))
  set undodir=$HOME/.vim/undodir
  set undofile
endif

"Move the swap files to their own directory
set dir=$HOME/.vim/vim_swap//,/var/tmp//,/tmp//,.
set backupdir=$HOME/.vim/backup//,/var/tmp//,/tmp//,.
set backup

" When editing a file, always jump to the last cursor position
autocmd BufReadPost *
\ if line("'\"") > 0 && line ("'\"") <= line("$") |
\   exe "normal! g'\"" |
\ endif

"Hell yeh paste mode!
au InsertLeave * set nopaste

filetype plugin on
filetype indent plugin on

set completeopt=menuone,longest,preview
set complete-=i

autocmd BufNewFile,BufRead *.elm setf elm

let g:python3_host_prog = $HOME."/.vim/virtualenv/bin/python"
