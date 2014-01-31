setlocal textwidth=0
setlocal makeprg=pdflatex\ %\ &&\ evince\ $(basename\ %\ .tex).pdf\ 2>/dev/null

