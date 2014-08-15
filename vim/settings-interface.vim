" Interface (Bundle) Settings

" NERDTree
"
" Set width to be almost half its default.
" let g:NERDTreeWinSize = 15


" NERDTree Tabs
" Don't open NERDtree on Console vim startup
let g:nerdtree_tabs_open_on_console_startup = 0


" Startify
"
" When opening a file from start, hop into the directory.
let g:startify_change_to_dir = 1

" Close Startify when opening something in NERDTree
autocmd FileType startify setlocal buftype=


" Unite
"
" File searching like ctrlp
nnoremap <C-p> :<C-u>Unite -start-insert file_rec/async:!<cr>


" Numbers.vim
"
" Odd things happen without this.
set number
" List of items to exclude from being numbered.
let g:numbers_exclude = ['unite', 'tagbar', 'startify', 'gundo', 'vimshell', 'w3m']


" General settings
"
" Make searches case-insensitive.
set ignorecase

" Make searches case-senstive with the inclusion of an upper-case character.
set smartcase

" Highlight search results (<C-l> to clear highlighting)
set hlsearch

" When buffer is abandoned it becomes hidden.
set hidden

" Highlight current row
" Works really nicely with TagBar - press p over a function definition and the
" cursor is sent their (so it is highlighted automatically).
set cursorline

" Highlight nth column as a guideline for maximum space
set colorcolumn=80
