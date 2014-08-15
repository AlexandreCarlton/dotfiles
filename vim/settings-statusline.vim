" Statusline (Bundle) Settings
" Only one should ba active at any time.


" Use powerline symbols?
let g:airline_powerline_fonts = 1


" Vim-Airline
"
" Override automatically selected theme.
" let g:airline_theme = 'solarized'

" Tabs are stylised like the status line
let g:airline#extensions#tabline#enabled = 1


" Use powerline font symbols?

if ! g:airline_powerline_fonts
    "let g:airline_left_sep = '»'
    "let g:airline_left_sep = '▶'
    let g:airline_left_sep = ''
    "let g:airline_right_sep = '«'
    "let g:airline_right_sep = '◀'
    let g:airline_right_sep = ''
    "let g:airline_symbols.linenr = '␊'
    "let g:airline_symbols.linenr = '␤'
    "let g:airline_symbols.linenr = '¶'
    let g:airline_symbols.linenr = 'L'
    "let g:airline_symbols.branch = '⎇'
    let g:airline_symbols.branch = 'B'
    "let g:airline_symbols.paste = 'ρ'
    "let g:airline_symbols.paste = 'Þ'
    "let g:airline_symbols.paste = '∥'
    let g:airline_symbols.paste = 'P'
    "let g:airline_symbols.whitespace = 'Ξ'
    let g:airline_symbols.whitespace = ' '
endif
