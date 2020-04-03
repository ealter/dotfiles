" Functions {{
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
" }} Functions


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

" Plugins I'm not currently using, but might reenable
" Plug 'ctrlpvim/ctrlp.vim'  " Fuzzy file search

"cd into the project root directory
noremap <silent> <leader>pr :Rooter<CR>
let g:rooter_manual_only = 1

call s:smart_source_rc('plugins/ctrlp')

if executable('ag')
    " Use ag over grep
    set grepprg=ag\ --nogroup\ --nocolor
    let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
endif

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
    call s:smart_source_rc('plugins/neocomplete')
end

set updatetime=250
