" General autocompletion & linting
"
" Close XML/HTML Tags.
" Plug 'docunext/closetag.vim'

" Snippets for snippet engine (Ultisnips)
Plug 'honza/vim-snippets'

" Autocompletion for quotes, parens, etc.
Plug 'Raimondi/delimitMate'

" General syntax checker.
Plug 'scrooloose/syntastic'

" Include snippets on <Tab> completion
Plug 'SirVer/ultisnips'

" Allows asynchronous execution (great for syntax checkers)
Plug 'Shougo/vimproc.vim', { 'do': 'make -f make_unix.mak' }

" Completion engine - faster startup with Vim, but slower completion
" Plug 'Shougo/neocomplete.vim', {
" \     'disabled': !has('lua'),
" \     'vim_version': '7.3.885'
" \ }

" End certain strutures automatically.
Plug 'tpope/vim-endwise'

" Clang-based completion for C-family languages and Python.
" Clang must be at least version 3.3
" Only update when specified; it takes a lot of time.
Plug 'Valloric/YouCompleteMe', { 'do': './install.sh --clang-completer --system-libclang --omnisharp-completer', 'frozen' : 1 }
