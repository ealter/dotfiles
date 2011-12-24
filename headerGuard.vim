"Generates a header guard using the current file name
"It converts spaces into underscores, capitalizes the name, and appends
"the string '_INCLUDED'
"Example
"   'blah.h' becomes 'BLAH_INCLUDED'
function HeaderGuard()
  let filename = fnamemodify(@%, ':t:r') "get the basename
  let filename = substitute(toupper(filename), "\s", '_', "g")
  let headerguard = filename . '_INCLUDED'
  let failed = append(line('.'), '#endif')
  let failed = append(line('.'), "")
  let failed = append(line('.'), '#define ' . headerguard)
  let failed = append(line('.'), '#ifndef ' . headerguard)
  "Move down to the whitespace
  normal 3j
endfunction
