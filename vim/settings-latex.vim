" LaTeX (Bundle) Settings


" LaTeX-Box

" Enable asynchronous compilation using vimserver
let g:LatexBox_latexmk_async = 1

" Make Latexmk compile as necessary without hanging vim
" Be sure to have LatexBox_quickfix=2 when enabled
let g:LatexBox_latexmk_preview_continuously = 1

" Quickfix window opened automaticaly if not empty, cursor stays in current
" window
let g:LatexBox_quickfix = 2

au BufNewFile,BufRead *.tex set filetype=tex

" Set spellcheck on documents
autocmd FileType tex set spell
