" General autocompletion & linting
"
" Close XML/HTML Tags.
NeoBundle 'docunext/closetag.vim'

" Snippets for snippet engine (Ultisnips)
NeoBundle 'honza/vim-snippets'

" Autocompletion for quotes, parens, etc.
NeoBundle 'Raimondi/delimitMate'

" General syntax checker.
NeoBundle 'scrooloose/syntastic'

" Include snippets on <Tab> completion
NeoBundle 'SirVer/ultisnips'

" Allows asynchronous execution (great for syntax checkers)
NeoBundle 'Shougo/vimproc.vim', {
    \ 'build': {
    \       'windows': 'make -f make_mingw32.mak',
    \       'cygwin': 'make -f make_cygwin.mak',
    \       'mac': 'make -f make_mac.mak',
    \       'unix': 'make -f make_unix.mak'
    \   }
    \ }

" End certain strutures automatically.
NeoBundle 'tpope/vim-endwise'

" Clang-based completion for C-family languages and Python.
" In build, cd ~/.vim/bundle/YouCompleteMe  first?
NeoBundle 'Valloric/YouCompleteMe', {
    \   'build' : {
    \       'unix' : './install.sh --clang-completer --system-libclang --omnisharp-completer',
    \       'mac' : './install.sh --clang-completer --system-libclang --omnisharp-completer'
    \    }
    \}
