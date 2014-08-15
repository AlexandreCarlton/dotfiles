" Mapping (Bundle) Settings
" Includes plugin mappings so they can be easily changed in one place.


" Rapidly these keys (instead of Esc) to go Normal mode.
inoremap jk <Esc>
inoremap kj <Esc>

" When wrapping is enabled, move down by row not by line.
nnoremap j gj
nnoremap k gk

" Allow for easier window navigation
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l
map <C-h> <C-w>h

" Sublime-style autoindent
imap {<CR> {<CR>}<C-o>O

" Change leader to something saner.
let mapleader=","
" let localleader=" "

map <Leader>n <plug>NERDTreeTabsToggle<cr> 

" Function Keys 
nmap <F5> :SCCompileRun<cr>
nmap <F8> :TagbarToggle<cr>
