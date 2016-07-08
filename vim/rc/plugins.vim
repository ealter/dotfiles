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

"cd into the project root directory
map <silent> <unique> <leader>pr <Plug>RooterChangeToRootDirectory
let g:rooter_manual_only = 1

Plug 'tpope/vim-fugitive'

Plug 'ctrlpvim/ctrlp.vim'
call s:smart_source_rc('plugins/ctrlp')

if executable('ag')
    " Use ag over grep
    set grepprg=ag\ --nogroup\ --nocolor
    let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
endif

if (has('lua') && (v:version > 703 || v:version == 703 && has('patch885')))
    Plug 'Shougo/neocomplete.vim'
    call s:smart_source_rc('plugins/neocomplete')
end

Plug 'vim-scripts/matchit.zip'
Plug 'altercation/vim-colors-solarized'
Plug 'jelera/vim-javascript-syntax'
Plug 'airblade/vim-rooter'
Plug 'Shougo/vimproc.vim', { 'do': 'make' }
Plug 'FooSoft/vim-argwrap'
Plug 'michaeljsmith/vim-indent-object'
