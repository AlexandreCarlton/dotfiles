
""""""""""""""""""""""""""""""""""""""""""""""""""
" Color Schemes                                  "
"                                                "
""""""""""""""""""""""""""""""""""""""""""""""""""

" Solarized
NeoBundle 'altercation/vim-colors-solarized'

" Tomorrow (Night)
NeoBundle 'ChrisKempson/Tomorrow-Theme'

" GitHub
NeoBundle 'endel/vim-github-colorscheme'

" Zenburn
NeoBundle 'jnurmine/Zenburn'

" Jelly Beans
NeoBundle 'nanotech/jellybeans.vim'

" Molokai (Sublime Text)
NeoBundle 'tomasr/molokai'

" Twilight (TextMate)
NeoBundle 'matthewtodd/vim-twilight'


""""""""""""""""""""""""""""""""""""""""""""""""""
" Interface                                      "
"                                                "
""""""""""""""""""""""""""""""""""""""""""""""""""

" Handles csv files.
NeoBundle 'chrisbra/csv.vim'

" Browse the Undo Tree with :UB
NeoBundle 'chrisbra/histwin.vim'

" Shell prompt generator.
NeoBundle 'edkolev/promptline.vim'

" Replace Python operators with nice symbols.
" NeoBundle 'ehamberg/vim-cute-python'

" Makes NERDTree handle tabs seamlessly.
NeoBundle 'jistr/vim-nerdtree-tabs'

" Easily browse tags of source files.
" NeoBundle 'majutsushi/tagbar'

" Nice start screen (Table of Contents)
NeoBundle 'mhinz/vim-startify'

" Indicates added, modified or deleted lines based on VCS (e.g. git)
NeoBundle 'mhinz/vim-signify'

" Explore filesystem within Vim.
NeoBundle 'scrooloose/nerdtree'

" Replace haskell operators with nice symbols.
" NeoBundle 'Twinside/vim-haskellConceal'

" Diplay vertical lines for each indentation level.
NeoBundle 'Yggdroot/indentLine'


""""""""""""""""""""""""""""""""""""""""""""""""""
" Statuslines                                    "
"                                                "
""""""""""""""""""""""""""""""""""""""""""""""""""

" Statusline using VimScript, relies on other plugins
" NeoBundle 'bling/vim-airline'

" Shows list of buffers in command bar
" NeoBundle 'bling/vim-bufferline'

" Statusline using Python, difficult to configure
NeoBundle 'Lokaltog/powerline', {
    \   'rtp' : 'powerline/bindings/vim/'
    \}

" Minimal statusline
" NeoBundle 'itchyny/lightline.vim'


""""""""""""""""""""""""""""""""""""""""""""""""""
" Language Support                               "
"                                                "
""""""""""""""""""""""""""""""""""""""""""""""""""

" TeX plugin (requires LaTeX-Box)
NeoBundle 'coot/atp_vim'

" Haskell plugins
NeoBundle 'dag/vim2hs'

" CSS3 Syntax support to built-in CSS syntax
NeoBundle 'hail2u/vim-css3-syntax'

" Add CoffeeScript compilation support
NeoBundle 'kchmck/vim-coffee-script'

" Superior Lisp Interaction Mode for Vim
NeoBundle 'kovisoft/slimv'

" LaTeX Plugin - clashes with tabular as it has the same tag (:h tabular)
NeoBundle 'LaTeX-Box-Team/LaTeX-Box'

" CoffeeScript indent and syntax highlighting
NeoBundle 'mintplant/vim-literate-coffeescript'

" JavaScript support
NeoBundle 'pangloss/vim-javascript'

" Markdown runtime files
NeoBundle 'tpope/vim-markdown'


""""""""""""""""""""""""""""""""""""""""""""""""""
" Lint Tools & Code Completion                   "
"                                                "
""""""""""""""""""""""""""""""""""""""""""""""""""

" Close XML/HTML Tags.
NeoBundle 'docunext/closetag.vim'

" Haskell plugin to display error messages
NeoBundle 'eagletmt/ghcmod-vim'

" Completion plugin for Haskell using ghc-mod
NeoBundle 'eagletmt/neco-ghc'

" General completion plugin using <Tab>
" NeoBundle 'ervandew/supertab'

" Python for static analysis, code completion
NeoBundle 'klen/python-mode'

" Convert CSS-like syntax ( html > body > p{Text} ) to HTML. 
NeoBundle 'mattn/emmet-vim'

" Autocompletion for quotes, parens, etc.
NeoBundle 'Raimondi/delimitMate'

" General syntax checker.
NeoBundle 'scrooloose/syntastic'

" Allows asynchronous execution (great for syntax checkers)
NeoBundle 'Shougo/vimproc.vim', {
    \ 'build': {
    \       'windows': 'make -f make_mingw32.mak',
    \       'cygwin': 'make -f make_cygwin.mak',
    \       'mac': 'make -f make_mac.mak',
    \       'unix': 'make -f make_unix.mak'
    \   }
    \ }

" Clang-based completion for C-family languages and Python.
NeoBundle 'Valloric/YouCompleteMe', {
    \   'build' : {
    \       'unix' : 'cd ~/.vim/bundle/YouCompleteMe && ./install.sh --clang-completer --system-libclang --omnisharp-completer',
    \       'mac' : 'cd ~/.vim/bundle/YouCompleteMe && ./install.sh --clang-completer --system-libclang --omnisharp-completer'
    \    }
    \}



""""""""""""""""""""""""""""""""""""""""""""""""""
" Shortcuts & Mappings                           "
"                                                "
""""""""""""""""""""""""""""""""""""""""""""""""""

" Aligns text - conflicts with LaTeX-Box
" NeoBundle 'godlygeek/tabular'

" Ack wrapper.
NeoBundle 'mileszs/ack.vim'

" Easier commenting.
NeoBundle 'scrooloose/nerdcommenter'

" Fuzzy file finder
NeoBundle 'Shougo/unite.vim'

" Include snippets on <Tab> completion
NeoBundle 'SirVer/ultisnips'

" Git wrapper.
NeoBundle 'tpope/vim-fugitive'

" Defaults everyone can agree on.
NeoBundle 'tpope/vim-sensible'

" Easily change surroundings (e.g. tags) in pairs.
NeoBundle 'tpope/vim-surround'

" End certain strutures automatically.
NeoBundle 'tpope/vim-endwise'

" Nicer mappings using ']' and '[' for 'next' and 'previous'
NeoBundle 'tpope/vim-unimpaired'

" Convienient single-file compilation
NeoBundle 'xuhdev/SingleCompile'
