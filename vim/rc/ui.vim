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
