" Colour & Fonts (Bundle) Settings


" Use 256 to enable 256-Colour mode
" Use 16 to use Terminal's colours.
set t_Co=256

set background=dark

" For base16 colours, this has to be before colorscheme declaration.
let base16colorspace=256

" Colorscheme
" HAS to be set after t_Co and background - weird things happen otherwise.
colorscheme solarized

" Set utf8 as standard encoding and en_US as standard language
set encoding=utf8

" Set unix as standard file type
set fileformats=unix,dos,mac

