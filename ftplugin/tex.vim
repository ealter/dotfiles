setlocal textwidth=0
set makeprg=pdflatex\ %\ &&\ evince\ $(basename\ %\ .tex).pdf\ 2>/dev/null

