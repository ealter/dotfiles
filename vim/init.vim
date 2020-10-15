" A lot of inspiration from Shougo

" Note: Skip initialization for vim-tiny or vim-small.
if !1 | finish | endif

" Auto install vim-plug
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall
endif

" ----- Basic settings -----
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

set autoread  " Auto reload files when there's no conflict

" Spaces are better than tabs
set autoindent
set expandtab
set smarttab
set tabstop=4
set shiftwidth=4

" ------ Key mappings -----
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

nnoremap <silent> <leader>r :ArgWrap<CR>

"Replace the current word with the first spelling suggestion
nnoremap z- z=1<CR><CR>

" ----- Plugins -----
call plug#begin()

Plug 'tpope/vim-fugitive'  " Git integration
Plug 'vim-scripts/matchit.zip'  " Match complex things with '%'
Plug 'altercation/vim-colors-solarized'  " Color scheme
Plug 'jelera/vim-javascript-syntax'  " Moar js syntax highlighting
Plug 'airblade/vim-rooter'  " Change directory to the project root
Plug 'FooSoft/vim-argwrap'  " Format functions between multiline and single line
Plug 'michaeljsmith/vim-indent-object'  " Add a text object based on the indent level (ai, ii, aI)
" Plug 'rust-lang/rust.vim'  " Rust syntax highlighting
Plug 'airblade/vim-gitgutter'  " Adds + and - to the gutter depending on which lines have been changed in git
Plug 'tpope/vim-commentary'  " gc to comment or uncomment a block of code
Plug 'tpope/vim-surround'  " Makes it easy to edit html tags and surround text with tags
Plug 'tpope/vim-vinegar'  " Better netrw file browsing
Plug 'maxmellon/vim-jsx-pretty' " Format jsx

" vim-go doesn't support vim versions before 8.0.1
if has('nvim') || v:version >= 801
    augroup Golang
        Plug 'fatih/vim-go'

        let g:go_highlight_functions = 1
        let g:go_highlight_methods = 1
        let g:go_highlight_fields = 1
        let g:go_highlight_types = 1
        let g:go_highlight_operators = 1
        let g:go_highlight_build_constraints = 1
        let g:go_highlight_extra_types = 1
        let g:go_highlight_string_spellcheck = 1
        let g:go_fmt_command = "goimports"
        let g:go_addtags_transform = "snakecase"
    augroup END
endif

if executable('yarn')
    Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install'  }
else
    Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() } }
endif

"cd into the project root directory
noremap <silent> <leader>pr :Rooter<CR>
let g:rooter_manual_only = 1

if executable('gopls')
    " Installation: go get golang.org/x/tools/gopls
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    augroup ALE
      Plug 'w0rp/ale'
      let g:ale_ruby_rubocop_executable = 'scripts/bin/rubocop'
      let g:ale_fix_on_save = 1
      let g:ale_lint_on_save = 1
      let g:ale_linters = {
        \'javascript': ['prettier', 'eslint'],
        \'javascript.jsx': ['prettier', 'eslint'],
      \}
      let g:ale_fixers = {
        \'javascript': ['prettier', 'eslint'],
        \'javascript.jsx': ['prettier', 'eslint'],
        \'ruby': ['rubocop'],
      \}
    augroup END
elseif has('python3') && has('nvim')
    Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
    let g:deoplete#enable_at_startup = 1
elseif (has('lua') && (v:version > 703 || v:version == 703 && has('patch885')))
    Plug 'Shougo/neocomplete.vim'

    let g:acp_enableAtStartup = 0
    let g:neocomplete#enable_at_startup = 1
    let g:neocomplete#enable_smart_case = 1
    let g:neocomplete#sources#syntax#min_keyword_length = 3
    let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'
    let g:neocomplete#enable_prefetch = 1

    if !exists('g:neocomplete#sources#omni#input_patterns')
        let g:neocomplete#sources#omni#input_patterns = {}
    endif
    let g:neocomplete#sources#omni#input_patterns.python = ''
    let g:neocomplete#sources#omni#input_patterns.ruby = ''

    inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
end

set updatetime=250

call plug#end()

" ----- UI -----
if has("gui_running")
  set guicursor=a:blinkon0
endif

" Turn off annoying error bells
set noerrorbells
set novisualbell

if !has('gui_running')
  set t_Co=256
  let g:solarized_termcolors=256
else
  set guioptions+=LlRrb
  set guioptions-=LlRrb "Get rid of all scroll bars in gvim
endif

set background=dark
let g:solarized_termtrans = 1
colorscheme solarized

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
