" Vundle settings
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


" Solarized Color Scheme
Bundle 'altercation/vim-colors-solarized'

" Statusline using VimScript (not Python like Powerline)
Bundle 'bling/vim-airline'      

" Handles csv files.
Bundle 'chrisbra/csv.vim'       

" Haskell plugins
Bundle 'dag/vim2hs'

" Close XML/HTML Tags - not great.
Bundle 'docunext/closetag.vim'

" Haskell plugin
Bundle 'eagletmt/ghcmod-vim'

" Completion plugin for Haskell using ghc-mod
Bundle 'eagletmt/neco-ghc'

" Shell prompt generator. 
" Bundle 'edkolev/promptline.vim' 

" GitHub Color Scheme
Bundle 'endel/vim-github-colorscheme'

" Aligns text.
Bundle 'godlygeek/tabular'      

" Makes NERDTree handle tabs seamlessly.
Bundle 'jistr/vim-nerdtree-tabs'

" Add CoffeeScript compilation support
Bundle 'kchmck/vim-coffee-script'

" Superior Lisp Interaction Mode for Vim
Bundle 'kovisoft/slimv'

" Statusline using Python
" Bundle 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}

" Easily browse tags of source files.
" Bundle 'majutsushi/tagbar'

" Twilight Color Scheme (TextMate)
Bundle 'matthewtodd/vim-twilight'

" CoffeeScript indent and syntax highlighting
Bundle 'mintplant/vim-literate-coffeescript'

" JavaScript support
Bundle 'pangloss/vim-javascript'

" Autocompletion for quotes, parens, etc.
Bundle 'Raimondi/delimitMate'

" Easier commenting.
Bundle 'scrooloose/nerdcommenter'

" Explore filesystem within Vim.
Bundle 'scrooloose/nerdtree'    

" Syntax checker.
Bundle 'scrooloose/syntastic'   

" Molokai Color Scheme (Sublime Text)
Bundle 'tomasr/molokai'

" Git wrapper.
Bundle 'tpope/vim-fugitive'     

" End certain strutures automatically.
Bundle 'tpope/vim-endwise'      

" Markdown runtime viles
Bundle 'tpope/vim-markdown'

" Defaults everyone can agree on.
Bundle 'tpope/vim-sensible'     

" Easily change surroundings (e.g. tags) in pairs.
Bundle 'tpope/vim-surround'     

" Code Completion.
Bundle 'Valloric/YouCompleteMe'


syntax on
filetype plugin indent on 

" End Vundle settings.


" General Settings not found in vim-sensible.

colorscheme molokai " Use default colorscheme for Sublime Text
set number          " Set Line numbers
set t_Co=256        " Enable 256-Colour mode
set tabstop=4       " Number of spaces <Tab> counts for.
set softtabstop=4   " Number of spaces <Tab> counts when inserting <Tab>
set shiftwidth=4    " Indent/oudent by 4 columns.
set expandtab       " Always use spaces instead of tabs.
set ignorecase      " Make searches case-insensitive.


" Plugin settings.


" Syntastic settings
"
" Use clang as checker
let g:syntastic_cpp_compiler = 'clang++' 
" Use C++11 as standard
let g:syntastic_cpp_compiler_options = ' -std=c++11 -stdlib=libc++' 


" NERDTree Tabs settings
"
" map so typing it is unnecessary
map <Leader>n <plug>NERDTreeTabsToggle<CR> 
" Open NERDtree on Console vim startup
let g:nerdtree_tabs_open_on_console_startup = 1


" YouCompleteMe settings
"
" Find file to check
let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/YouCompleteMe/cpp/ycm/.ycm_extra_conf.py'
 

" TagBar settings
"
" Map F8 to toggle TagBar window
nmap <F8> :TagBarToggle<CR>
