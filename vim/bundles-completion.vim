" General autocompletion & linting
"
" Close XML/HTML Tags.
" NeoBundle 'docunext/closetag.vim'

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
\   'build': {
\       'windows': 'make -f make_mingw32.mak',
\       'cygwin': 'make -f make_cygwin.mak',
\       'mac': 'make -f make_mac.mak',
\       'unix': 'make -f make_unix.mak'
\   }
\ }

" Completion engine - faster startup with Vim, but slower completion
" NeoBundle 'Shougo/neocomplete.vim', {
" \     'disabled': !has('lua'),
" \     'vim_version': '7.3.885'
" \ }

" End certain strutures automatically.
NeoBundle 'tpope/vim-endwise'

" Clang-based completion for C-family languages and Python.
" Clang must be at least version 3.3
NeoBundle 'Valloric/YouCompleteMe', {
\   'build_commands': 'cmake',
\   'build': {
\       'unix': './install.sh --clang-completer --system-libclang --omnisharp-completer',
\       'mac': './install.sh --clang-completer --system-libclang --omnisharp-completer'
\   },
\   'disabled': !has('python'),
\   'vim_version': '7.3.584'
\}
