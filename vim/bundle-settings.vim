
""""""""""""""""""""""""""""""""""""""""""""""""""
" Airline                                        "
"                                                "
""""""""""""""""""""""""""""""""""""""""""""""""""

" Use powerline font symbols
let g:airline_powerline_fonts = 1

" Specify theme
let g:airline_theme = 'wombat'


""""""""""""""""""""""""""""""""""""""""""""""""""
" Emmet                                          "
"                                                "
""""""""""""""""""""""""""""""""""""""""""""""""""

" Enable just for html/css
let g:user_emmet_isntall_global = 0
autocmd FileType html,css EmmetInstall

" Change key ( default is <C-y>, )
let g:user_emmet_leader_key='<C-e>'

""""""""""""""""""""""""""""""""""""""""""""""""""
" LaTeX-Box                                      "
"                                                "
""""""""""""""""""""""""""""""""""""""""""""""""""

" Enable asynchronous compilation using vimserver
let g:LatexBox_latexmk_async = 1

" Make Latexmk compile as necessary without hanging vim
" Be sure to have LatexBox_quickfix=2 when enabled
let g:LatexBox_latexmk_preview_continuously = 1

" Quickfix window opened automaticaly if not empty, cursor stays in current
" window
let g:LatexBox_quickfix = 2

""""""""""""""""""""""""""""""""""""""""""""""""""
" neco-ghc                                       "
"                                                "
""""""""""""""""""""""""""""""""""""""""""""""""""

" Show detailed information (type) of symbols
let g:necoghc_enable_detailed_browse = 1

" Use omni-completion (YouCompleteMe)
autocmd FileType haskell set omnifunc=necoghc#omnifunc

" Allow YouCompleteMe to suggest completion
let g:ycm_semantic_triggers = {'haskell' : ['.']}


""""""""""""""""""""""""""""""""""""""""""""""""""
" NERDTree                                       "
"                                                "
""""""""""""""""""""""""""""""""""""""""""""""""""

" Set width to be almost half its default.
let g:NERDTreeWinSize = 15


""""""""""""""""""""""""""""""""""""""""""""""""""
" NERDTree Tabs                                  "
"                                                "
""""""""""""""""""""""""""""""""""""""""""""""""""

" map so typing it is unnecessary
map <Leader>n <plug>NERDTreeTabsToggle<cr> 

" Don't open NERDtree on Console vim startup
let g:nerdtree_tabs_open_on_console_startup = 0


""""""""""""""""""""""""""""""""""""""""""""""""""
" Python-Mode                                    "
"                                                "
""""""""""""""""""""""""""""""""""""""""""""""""""

" Disable automatic lint checking as Syntastic's is better (supports python3)
" (However, PyMode does have more checkers & checks as you go)
" Syntastic's loc_list automatically closes and syncs with powerline
let g:pymode_lint = 0

" Automatically check as you write (Syntastic doesn't have this)
let g:pymode_lint_on_fly = 1

" Disable autocompletion as Jedi (used in YouCompleteMe) is better.
let g:pymode_rope_completion = 0

" Disable automatic folding
let g:pymode_folding = 0

" Define checkers
let g:pymode_lint_checkers = ['pylint', 'pyflakes', 'pep8', 'mccabe']

" Set error signs to use same as Syntastic's (when refactoring set directly to
" variable)
let g:pymode_lint_error_symbol = '✗'
let g:pymode_lint_comment_symbol = '⚠'

""""""""""""""""""""""""""""""""""""""""""""""""""
" Syntastic                                      "
"                                                "
""""""""""""""""""""""""""""""""""""""""""""""""""

" Use ']l' and '[l' to cycle through errors (with vim-unimpaired)

" Use nicer symbols (given in the docs).
let g:syntastic_error_symbol = '✗'
let g:syntastic_warning_symbol = '⚠' " Change?

" Disable Python (Python-Mode checks as you type and hence wins here)
let g:syntastic_mode_map = { 'mode': 'active',
                           \ 'active_filetypes': [],
                           \ 'passive_filetypes': [] } " insert 'python'

" Check for errors on startup.
let g:syntastic_check_on_open = 1

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

"let g:syntastic_haskell_checkers = ['hlint']


""""""""""""""""""""""""""""""""""""""""""""""""""
" Startify                                       "
"                                                "
""""""""""""""""""""""""""""""""""""""""""""""""""

" When opening a file from start, hop into the directory.
let g:startify_change_to_dir = 1

" Close Startify when opening something in NERDTree
autocmd FileType startify setlocal buftype=


""""""""""""""""""""""""""""""""""""""""""""""""""
" TagBar                                         "
"                                                "
""""""""""""""""""""""""""""""""""""""""""""""""""

" Map F8 to toggle TagBar window
nmap <F8> :TagBarToggle<cr>


""""""""""""""""""""""""""""""""""""""""""""""""""
" UltiSnips                                      "
"                                                "
""""""""""""""""""""""""""""""""""""""""""""""""""

" Use to expand snippets - Tab already taken.
" Same mapping as one used to switch between tabstops.
let g:UltiSnipsExpandTrigger =  '<C-j>'

" Add my own snippets by including the custom snippets folder in ~/.vim
"let g:UltiSnipsSnippetDirectories=["UltiSnips", "MyUltiSnips"]


""""""""""""""""""""""""""""""""""""""""""""""""""
" Unite                                          "
"                                                "
""""""""""""""""""""""""""""""""""""""""""""""""""

" File searching like ctrlp
nnoremap <C-p> :<C-u>Unite -start-insert file_rec/async:!<cr>


""""""""""""""""""""""""""""""""""""""""""""""""""
" YouCompleteMe                                  "
"                                                "
""""""""""""""""""""""""""""""""""""""""""""""""""

" Find file to check for cpp files.
let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/YouCompleteMe/cpp/ycm/.ycm_extra_conf.py'

" Fill location list every time new diagnostic data is generated.
let g:ycm_always_populate_location_list = 1

" Add 'preview' to completeopt, which shows information on completion candidate. 
let g:ycm_add_preview_to_completeopt = 1

" Close 'preview' window after user accepts completion.
let g:ycm_autoclose_preview_window_after_completion = 1

" Close 'preview' window after user leaves insert mode.
let g:ycm_autoclose_preview_window_after_insertion = 1
