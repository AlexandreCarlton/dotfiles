" Completion & Linting (Bundle) Settings

" Syntastic

" Use ']l' and '[l' to cycle through errors (with vim-unimpaired)

" Use nicer symbols (given in the docs).
let g:syntastic_error_symbol = '✗'
let g:syntastic_warning_symbol = '⚠' " Change?

" Disable Python (Python-Mode checks as you type and hence wins here)
let g:syntastic_mode_map = { 'mode': 'active',
                           \ 'active_filetypes': [],
                           \ 'passive_filetypes': [] } " insert 'python'

" Check for errors on startup? Making things slow.
let g:syntastic_check_on_open = 0

" Always display any errors in the location list.
let g:syntastic_always_populate_loc_list = 1

" Automatically open error window when errors detected, close when none are.
let g:syntastic_auto_loc_list = 1

" Set the size of the error window to be smaller.
let g:syntastic_loc_list_height = 5

" Jump to first detected issue when saving/opening a file.
let g:syntastic_auto_jump = 1

" For Fortran, use gfortran as checker
let g:syntastic_fortran_compiler = 'gfortran'

" Use Fortran 95 as standard
let g:syntastic_fortran_compiler_options = '-std=f95'

let g:syntastic_haskell_checkers = ['ghc_mod'] "['hlint']


" UltiSnips
"
" Use to expand snippets - Tab already taken.
" Same mapping as one used to switch between tabstops.
let g:UltiSnipsExpandTrigger =  '<C-j>'

" Add my own snippets by including the custom snippets folder in ~/.vim
"let g:UltiSnipsSnippetDirectories=["UltiSnips", "MyUltiSnips"]


" YouCompleteMe
"
" Completion traversals (to integrate nicely with UltiSnips)
" To match Ultisnips (which uses <tab> for expansion):
" let g:ycm_key_list_previous_completion = ['<C-j>', '<C-n>', '<Down>']
" let g:ycm_key_list_previous_completion = ['<C-k>', '<C-p>', '<Up>']


" Find (backup) file to check for cpp files.
" This script should be copied into the base project folder and configured
" according to the project requirements.
let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'

" Fill location list every time new diagnostic data is generated.
let g:ycm_always_populate_location_list = 1

" Add 'preview' to completeopt, which shows information on completion candidate. 
let g:ycm_add_preview_to_completeopt = 1

" Close 'preview' window after user accepts completion.
let g:ycm_autoclose_preview_window_after_completion = 1

" Close 'preview' window after user leaves insert mode.
let g:ycm_autoclose_preview_window_after_insertion = 1

" Include semantic triggers for languages
" neco-ghc for haskell.
let g:ycm_semantic_triggers = {'haskell': ['.']}


