" Interface (Bundle) Settings

" NERDTree
"
" Set width to be almost half its default.
let g:NERDTreeWinSize = 15


" NERDTree Tabs
"
" map so typing it is unnecessary
map <Leader>n <plug>NERDTreeTabsToggle<cr> 

" Don't open NERDtree on Console vim startup
let g:nerdtree_tabs_open_on_console_startup = 0


" Startify
"
" When opening a file from start, hop into the directory.
let g:startify_change_to_dir = 1

" Close Startify when opening something in NERDTree
autocmd FileType startify setlocal buftype=


" TagBar
"
" Map F8 to toggle TagBar window
nmap <F8> :TagBarToggle<cr>


" Unite
"
" File searching like ctrlp
nnoremap <C-p> :<C-u>Unite -start-insert file_rec/async:!<cr>


" General settings
"
" Set line numbers
set number

" Make searches case-insensitive.
set ignorecase

" Make searches case-senstive with the inclusion of an upper-case character.
set smartcase

" Highlight search results (<C-l> to clear highlighting)
set hlsearch

" When buffer is abandoned it becomes hidden.
set hidden
