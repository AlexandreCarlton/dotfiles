
""""""""""""""""""""""""""""""""""""""""""""""""""
" Vundle settings                                "
"                                                "
""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible
filetype off
set rtp+=~/.vim/bundle/vundle
call vundle#rc()

" Let Vundle manage Vundle. (NTS: Consider using NeoBundle)
Bundle 'gmarik/vundle'

" :BundleList          - list configured bundles
" :BundleInstall(!)    - install (update) bundles
" :BundleSearch(!) foo - search (or refresh cache first) for foo
" :BundleClean(!)      - confirm (or auto-approve) remove of unused bundles

" List of bundles.
source ~/.vim/vundle-list.vim

syntax on
filetype plugin indent on 

" Bundle settings
source ~/.vim/vundle-settings.vim


""""""""""""""""""""""""""""""""""""""""""""""""""
" Colors & Fonts                                 "
"                                                "
""""""""""""""""""""""""""""""""""""""""""""""""""

colorscheme molokai

" Enable 256-Colour mode
set t_Co=256

" Set utf8 as standard encoding and en_US as standard language
set encoding=utf8

" Set unix as standard file type
set fileformats=unix,dos,mac


""""""""""""""""""""""""""""""""""""""""""""""""""
" User Interface                                 "
"                                                "
""""""""""""""""""""""""""""""""""""""""""""""""""
" Set line numbers
set number          

" Make searches case-insensitive.
set ignorecase      

" Make searches case-senstive with the inclusion of an upper-case character.
set smartcase

" Highlight search results (C-L to clear highlighting)
set hlsearch

" Remove the pop up menu (if visible) after moving in Insert mode.
autocmd CursorMovedI * if pumvisible() == 0|silent! pclose|endif

" Remove the pop up menu (if visible) when leaving Insert mode.
autocmd InsertLeave * if pumvisible() == 0|silent! pclose|endif


""""""""""""""""""""""""""""""""""""""""""""""""""
" Text, Tab & Indent                             "
"                                                "
""""""""""""""""""""""""""""""""""""""""""""""""""

" Number of spaces <Tab> counts for.
set tabstop=4

" Number of spaces <Tab> counts when inserting <Tab>
set softtabstop=4

" Indent/oudent by 4 columns.
set shiftwidth=4

" Always use spaces instead of tabs.
set expandtab

" Smart autoindenting when starting a new line.
set smartindent
