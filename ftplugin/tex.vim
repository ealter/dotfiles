if executable("qpdfview")
    let pdfViewer="qpdfview"
elseif executable("evince")
    let pdfViewer="evince"
endif

let &l:makeprg="pdflatex % && "
let &l:makeprg .= pdfViewer
let &l:makeprg .= " $(basename % .tex).pdf 2>/dev/null"

