
""""""""""""""""""""""""""""""""""""""""""""""""""
" NERDTree Tabs                                  "
"                                                "
""""""""""""""""""""""""""""""""""""""""""""""""""

" map so typing it is unnecessary
map <Leader>n <plug>NERDTreeTabsToggle<CR> 

" Open NERDtree on Console vim startup
let g:nerdtree_tabs_open_on_console_startup = 1


""""""""""""""""""""""""""""""""""""""""""""""""""
" Syntastic                                      "
"                                                "
""""""""""""""""""""""""""""""""""""""""""""""""""

" Use ']l' and '[l' to cycle through errors (with vim-unimpaired)

" Check for errors on startup.
let g:syntastic_check_on_open = 1

" Always display any errors in the location list.
let g:syntastic_always_populate_loc_list = 1

" Automatically open error window when errors detected, close when none are.
let g:syntastic_auto_loc_list = 1

" Jump to first detected issue when saving/opening a file.
let g:syntastic_auto_jump = 1

" Use clang as checker
let g:syntastic_cpp_compiler = 'clang++' 

" Use C++11 as standard
let g:syntastic_cpp_compiler_options = ' -std=c++11 -stdlib=libc++' 


""""""""""""""""""""""""""""""""""""""""""""""""""
" TagBar                                         "
"                                                "
""""""""""""""""""""""""""""""""""""""""""""""""""

" Map F8 to toggle TagBar window
nmap <F8> :TagBarToggle<CR>


""""""""""""""""""""""""""""""""""""""""""""""""""
" YouCompleteMe                                  "
"                                                "
""""""""""""""""""""""""""""""""""""""""""""""""""

" Find file to check
let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/YouCompleteMe/cpp/ycm/.ycm_extra_conf.py'
