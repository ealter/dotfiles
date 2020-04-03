let g:go_fmt_command = "goimports"
" Since gd goes to definition and 's' is mapped to ctrl-w, let's make sd work
" like ctrl-w d (go to definition in a split)
nmap sd <Plug>(go-def-split)
