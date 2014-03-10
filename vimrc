
""""""""""""""""""""""""""""""""""""""""""""""""""
" NeoBundle settings                                "
"                                                "
""""""""""""""""""""""""""""""""""""""""""""""""""
if has('vim_starting')

	" Use Vim instead of Vi.
	set nocompatible

	" Enable NeoBundle commands.
	set runtimepath+=~/.vim/bundle/neobundle.vim
endif

call neobundle#rc(expand('~/.vim/bundle/'))

" Let NeoBundle manage NeoBundle.

NeoBundle 'Shougo/neobundle.vim'

" :NeoBundleList          - list configured bundles
" :NeoBundleInstall(!)    - install (update) bundles
" :NeoBundleClean(!)      - confirm (or auto-approve) remove of unused bundles

" List of bundles.
source ~/.vim/bundle-list.vim

syntax on
filetype plugin indent on

" Check for any uninstalled bundles on startup.
NeoBundleCheck

" Bundle settings
source ~/.vim/bundle-settings.vim


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

" Highlight search results (<C-l> to clear highlighting)
set hlsearch

" When buffer is abandoned it becomes hidden.
set hidden


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


""""""""""""""""""""""""""""""""""""""""""""""""""
" Mappings                                       "
"                                                "
""""""""""""""""""""""""""""""""""""""""""""""""""

" Rapidly these keys (instead of Esc) to go Normal mode.
inoremap jk <Esc>
inoremap kj <Esc>

" When wrapping is enabled, move down by row not by line.
nnoremap j gj
nnoremap k gk

" Use free-form input (Don't assume everything is offset by 8 spaces)
let fortran_free_source = 1

" Make syntax colouring more precise (albeit slower)
let fortran_more_precise = 1
