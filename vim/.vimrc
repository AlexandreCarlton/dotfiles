" Try to place actual settings (like mappings, colour) AFTER plugin initialization.
" Automatic installation {{{
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !mkdir -p ~/.vim/autoload
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/build-requirements/plug.vim
    autocmd VimEnter * PlugInstall
endif
" }}}

autocmd FileType vim set foldmethod=marker

" NeoVim-specific settings {{{
if has('nvim')
    runtime! plugin/python_setup.vim
endif
" }}}

call plug#begin()

" Note that certain plugins like NerdTree and Tagbar don't work well lazily -
" need more fiddling.

" CoffeeScript {{{

" Compilation support
Plug 'kchmck/vim-coffee-script', { 'for' : 'coffee' }

" Indent and syntax highlighting
Plug 'mintplant/vim-literate-coffeescript', { 'for' : 'coffee' }

" }}}

" Colours {{{

" Base-16
Plug 'chriskempson/base16-vim'

" Solarized - fork of altercation to fix gitgutter.
Plug 'jwhitley/vim-colors-solarized'

" Tomorrow (Night)
Plug 'chriskempson/tomorrow-theme', { 'rtp': 'vim' }

" GitHub
Plug 'endel/vim-github-colorscheme'

" Zenburn
Plug 'jnurmine/Zenburn'

" Jelly Beans
Plug 'nanotech/jellybeans.vim'

" Molokai (Sublime Text)
Plug 'tomasr/molokai'

" Twilight (TextMate)
Plug 'matthewtodd/vim-twilight'

" Colour view/pick/edit/design/scheme tool.
Plug 'Rykka/colorv.vim', { 'on' : 'ColorV' }

" Use 256 to enable 256-Colour mode
" Use 16 to use Terminal's colours.
set t_Co=256

set background=dark

" For base16 colours, this has to be before colorscheme declaration.
let base16colorspace=256


" Set utf8 as standard encoding and en_US as standard language
set encoding=utf8

" Set unix as standard file type
set fileformats=unix,dos,mac



" }}}

" Code Completion {{{

" Close XML/HTML Tags.
" Plug 'docunext/closetag.vim'

" Snippets for snippet engine (Ultisnips)
Plug 'honza/vim-snippets'

" Autocompletion for quotes, parens, etc.
Plug 'Raimondi/delimitMate'

" General syntax checker
" Use ']l' and '[l' to cycle through errors (with vim-unimpaired)
Plug 'scrooloose/syntastic' " {{{

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
" }}}

" Include snippets on <Tab> completion
Plug 'SirVer/ultisnips' "  {{{

" Use to expand snippets - Tab already taken.
" Same mapping as one used to switch between tabstops.
let g:UltiSnipsExpandTrigger =  '<C-j>'

" Add my own snippets by including the custom snippets folder in ~/.vim
"let g:UltiSnipsSnippetDirectories=["UltiSnips", "MyUltiSnips"]

" }}}

" Allows asynchronous execution (great for syntax checkers)
Plug 'Shougo/vimproc.vim', { 'do': 'make -f make_unix.mak' }

"  Completion engine - faster startup with Vim, but slower completion
" Plug 'Shougo/neocomplete.vim', {
" \     'disabled': !has('lua'),
" \     'vim_version': '7.3.885'
" \ }

" End certain strutures automatically.
Plug 'tpope/vim-endwise'

" Clang-based completion for C-family languages and Python.
" Clang must be at least version 3.3
" Only update when specified; it takes a lot of time.
Plug 'Valloric/YouCompleteMe', { 'do': './install.sh --clang-completer --system-clang --omnisharp-completer', 'frozen' : 1, 'needs' : 'cmake' } " {{{

" Completion traversals (to integrate nicely with UltiSnips)
" To match Ultisnips (which uses <tab> for expansion):
" let g:ycm_key_list_previous_completion = ['<C-j>', '<C-n>', '<Down>']
" let g:ycm_key_list_previous_completion = ['<C-k>', '<C-p>', '<Up>']

" Find (backup) file to check for cpp files.
" This script should be copied into the base project folder and configured according to the project requirements.
let g:ycm_global_ycm_extra_conf = '~/.vim/plugged/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'

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
let g:ycm_semantic_triggers = { 'haskell' : ['.'], 'r' : ['.', '$', 're![_a-zA-Z]+[_\w]*\.'] }

" }}}

" }}}

" Fortran {{{

" Use free-form input (Don't assume everything is offset by 8 spaces)
let fortran_free_source = 1

" Make syntax colouring more precise (albeit slower)
let fortran_more_precise = 1

" }}}

" Git {{{
" Shows git diff in column - better than mhinz/vim-signify
Plug 'airblade/vim-gitgutter'

" Git Wrapper.
Plug 'tpope/vim-fugitive'
" }}}

" Haskell {{{

" Haskell plugins - out of date
Plug 'dag/vim2hs', { 'for' : 'haskell' }
" Plug 'lpil/vim2hs-flexible', { 'for' : 'haskell' }

" Haskell plugin to display error messages
" Needs vimproc.vim and ghc-mod
Plug 'eagletmt/ghcmod-vim', { 'for' : 'haskell' }

" Completion plugin for Haskell using ghc-mod
" Needs ghc-mod
Plug 'eagletmt/neco-ghc', { 'for' : 'haskell' } " {{{

" Show detailed information (type) of symbols
let g:necoghc_enable_detailed_browse = 1

" Use omni-completion (YouCompleteMe)
autocmd FileType haskell set omnifunc=necoghc#omnifunc
" }}}

" Hoogle (Haskell query plugin)
Plug 'Twinside/vim-hoogle', { 'for' : 'haskell' }

" }}}

" HTML / CSS {{{
"
" CSS3 Syntax support to built-in CSS syntax
Plug 'hail2u/vim-css3-syntax', { 'for' : ['html', 'xhtml', 'css'] }

" Convert CSS-like syntax ( html > body > p{Text} ) to HTML.
Plug 'mattn/emmet-vim', { 'for' : ['html', 'xhtml'] } " {{{

" Enable just for html/css
let g:user_emmet_isntall_global = 0
autocmd FileType html,css EmmetInstall

" Change key ( default is <C-y>, )
"let g:user_emmet_leader_key='<C-E>'

" }}}

" HTML5 + inline SVG omnicomplete function, indent and ayntax.
Plug 'othree/html5.vim', { 'for' : ['html', 'xhtml'] }

" }}}

" Interface {{{

" General settings {{{
"
" Make searches case-insensitive.
set ignorecase

" Make searches case-senstive with the inclusion of an upper-case character.
set smartcase

" Highlight search results (<C-l> to clear highlighting)
set hlsearch

" When buffer is abandoned it becomes hidden.
set hidden

" Highlight current row
" Works really nicely with TagBar - press p over a function definition and the
" cursor is sent their (so it is highlighted automatically).
set cursorline

" Highlight nth column as a guideline for maximum space
set colorcolumn=80
" }}}

" Handles csv files.
Plug 'chrisbra/csv.vim', { 'for' : 'csv' }

" Browse the Undo Tree with :UB
Plug 'chrisbra/histwin.vim', { 'on' : 'UB' }

" More options (like diff) when dealing with swp files.
Plug 'chrisbra/Recover.vim'


" Makes NERDTree handle tabs seamlessly.
Plug 'jistr/vim-nerdtree-tabs' " {{{, { 'on' : 'NERDTreeTabsToggle' }
" Don't open NERDtree on Console vim startup
let g:nerdtree_tabs_open_on_console_startup = 0
" }}}

" Nice start screen (Table of Contents)
" Plug 'mhinz/vim-startify' " {{{
" When opening a file from start, hop into the directory.
let g:startify_change_to_dir = 1

" Close Startify when opening something in NERDTree
autocmd FileType startify setlocal buftype=

" }}}

" Intelligent number toggling.
Plug 'myusuf3/numbers.vim', " {{{

" Odd things happen without this.
set number
" List of items to exclude from being numbered.
let g:numbers_exclude = ['unite', 'tagbar', 'startify', 'gundo', 'vimshell', 'w3m']

" }}}

" Visually display indent levels in Vim (to highlight tabs)
" Plug 'nathanaelkane/vim-indent-guides'

" Show trailing whitespace - fix with :StripWhitespace
Plug 'ntpeters/vim-better-whitespace', { 'on' : 'StripWhitespace' }

" Explore filesystem within Vim.
" Loading NERDTree is expensive, but NERDTreeTabs is not.
Plug 'scrooloose/nerdtree' ", { 'on' : 'NERDTreeTabsToggle' }

" Fuzzy file finder
Plug 'Shougo/unite.vim', { 'on' : 'Unite' }, " {{{
" File searching like ctrlp
nnoremap <C-p> :<C-u>Unite -start-insert file_rec/async:!<cr>
" }}}

" Diplay vertical lines for each indentation level.
" Plug 'Yggdroot/indentLine'

" }}}

" JavaScript {{{
" General support
Plug 'pangloss/vim-javascript', { 'for' : 'javascript' }

" Tags and omnicompletion.
Plug 'marijnh/tern_for_vim', { 'for' : 'javascript', 'do': 'npm install', 'needs': 'npm' }

" }}}

" LaTeX {{{
au BufNewFile,BufRead *.tex set filetype=tex

" Set spellcheck on documents
autocmd FileType tex set spell

" LaTeX Plugin
Plug 'LaTeX-Box-Team/LaTeX-Box', { 'for' : ['plaintex', 'context', 'latex', 'rnoweb'] } " {{{
" Enable asynchronous compilation using vimserver
let g:LatexBox_latexmk_async = 1

" Make Latexmk compile as necessary without hanging vim
" Be sure to have LatexBox_quickfix=2 when enabled
let g:LatexBox_latexmk_preview_continuously = 1

" Quickfix window opened automaticaly if not empty, cursor stays in current
" window
let g:LatexBox_quickfix = 2

" }}}

" TeX plugin (requires LaTeX-Box)
" Plug 'coot/atp_vim', { 'for' : ['plaintex', 'context', 'latex', 'rnoweb'] }

" }}}

" Lisp {{{

" Superior Lisp Interaction Mode for Vim
Plug 'kovisoft/slimv', { 'for': ['lisp', 'scheme', 'clojure'] }

" }}}

" Mappings {{{
" Aligns text
Plug 'godlygeek/tabular', { 'on' : ['Tabularize', 'AddTabularPattern'] }

" Easier way of navigating
Plug 'Lokaltog/vim-easymotion'

" Easier commenting.
Plug 'scrooloose/nerdcommenter'

" Defaults everyone can agree on.
Plug 'tpope/vim-sensible'

" Easily change surroundings (e.g. tags) in pairs.
Plug 'tpope/vim-surround'

" Nicer mappings using ']' and '[' for 'next' and 'previous'
Plug 'tpope/vim-unimpaired'

" Rapidly these keys (instead of Esc) to go Normal mode.
inoremap jk <Esc>
inoremap kj <Esc>

" When wrapping is enabled, move down by row not by line.
nnoremap j gj
nnoremap k gk

" Centre the found match.
nnoremap n nzz

" Allow for easier window navigation
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l
map <C-h> <C-w>h

" Sublime-style autoindent
imap {<CR> {<CR>}<C-o>O

" Change leader to something saner.
let mapleader=","
" let localleader=" "

map <Leader>n <plug>NERDTreeTabsToggle<cr>

" Function Keys
nmap <F5> :SCCompileRun<cr>
nmap <F6> :SCCompile<cr>
nmap <F8> :TagbarToggle<cr>

" }}}

" Markdown {{{

" Set relevant files with markdown extensions to be MarkDown.
au BufNewFile,BufRead *.md,*.mkd,*markdown set filetype=markdown

" Spell check markdown files.
autocmd FileType markdown set spell

" Markdown runtime files
Plug 'tpope/vim-markdown', { 'for' : 'markdown' }

" }}}

" Python (surprisingly few) {{{

" Python for static analysis, code completion (Disabled due to lack of Python3
" support)
" Plug 'klen/python-mode', { 'for' : 'python' } {{{

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

" }}}

" }}}

" R {{{

" Nice mappings and launcher capabilities
let g:install_vimcom = 'sudo R -e "library(devtools); install_github(\"jalvesaq/VimCom\")"'
Plug 'jcfaria/Vim-R-Plugin' , { 'for' : ['r', 'rnoweb'], 'do' : g:install_vimcom , 'needs' : 'R' }

autocmd FileType r set omnifunc=rcomplete#CompleteR

" }}}

" SQL (and Declarative) Bundles {{{
" Cypher/CQL syntax highlighting
Plug 'neo4j-contrib/cypher-vim-syntax', { 'for' : 'cypher' }

" Set HiveQL scripts to have SQL highlighting if no other style is defined.
au BufRead,BufNewFile *.hql setfiletype sql
" }}}

" Statuslines {{{
" Uses VimScript, integrates with plugins
Plug 'bling/vim-airline' " {{{
" Use powerline symbols?
let g:airline_powerline_fonts = 1

" Override automatically selected theme.
" let g:airline_theme = 'solarized'

" Tabs are stylised like the status line
let g:airline#extensions#tabline#enabled = 1

" Use powerline font symbols?
if ! g:airline_powerline_fonts
    "let g:airline_left_sep = '»'
    "let g:airline_left_sep = '▶'
    let g:airline_left_sep = ''
    "let g:airline_right_sep = '«'
    "let g:airline_right_sep = '◀'
    let g:airline_right_sep = ''
    "let g:airline_symbols.linenr = '␊'
    "let g:airline_symbols.linenr = '␤'
    "let g:airline_symbols.linenr = '¶'
    let g:airline_symbols.linenr = 'L'
    "let g:airline_symbols.branch = '⎇'
    let g:airline_symbols.branch = 'B'
    "let g:airline_symbols.paste = 'ρ'
    "let g:airline_symbols.paste = 'Þ'
    "let g:airline_symbols.paste = '∥'
    let g:airline_symbols.paste = 'P'
    "let g:airline_symbols.whitespace = 'Ξ'
    let g:airline_symbols.whitespace = ' '
endif

" }}}

" Shows list of buffers in command bar
" Plug 'bling/vim-bufferline'

" Statusline using Python, difficult to configure (and heavyweight)
" Plug 'Lokaltog/powerline', { 'rtp' : 'powerline/bindings/vim/' }

" Minimal statusline
" Plug 'itchyny/lightline.vim'

" Shell prompt generator.
Plug 'edkolev/promptline.vim', { 'on' : 'PromptlineSnapshot' }

" }}}

" Tab / Indent {{{
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

" }}}

" Tags {{{
" Piece de resistance
" Easily browse tags of source files.
" Reguires ctags and vim >= 7.0
Plug 'majutsushi/tagbar', { 'needs' : ['jsctags', 'hasktags'] }

" CoffeeScript support
" `gem install CoffeeTags` also must be done.
Plug 'lukaszkorecki/CoffeeTags', { 'for' : 'coffee', 'do' : 'gem install CoffeeTags', 'needs' : 'gem' }

" Haskell (requires hasktags) {{{
let g:tagbar_type_haskell = {
    \ 'ctagsbin'  : 'hasktags',
    \ 'ctagsargs' : '-x -c -o-',
    \ 'kinds'     : [
        \  'm:modules:0:1',
        \  'd:data: 0:1',
        \  'd_gadt: data gadt:0:1',
        \  't:type names:0:1',
        \  'nt:new types:0:1',
        \  'c:classes:0:1',
        \  'cons:constructors:1:1',
        \  'c_gadt:constructor gadt:1:1',
        \  'c_a:constructor accessors:1:1',
        \  'ft:function types:1:1',
        \  'fi:function implementations:0:1',
        \  'o:others:0:1'
    \ ],
    \ 'sro'        : '.',
    \ 'kind2scope' : {
        \ 'm' : 'module',
        \ 'c' : 'class',
        \ 'd' : 'data',
        \ 't' : 'type'
    \ },
    \ 'scope2kind' : {
        \ 'module' : 'm',
        \ 'class'  : 'c',
        \ 'data'   : 'd',
        \ 'type'   : 't'
    \ }
\ }

" }}}

" }}}

" Unite {{{

" Place NeoBundle update messages in Unite buffer.
" Unite -log -wrap neobundle/update

" Manage colorschemes
Plug 'ujihisa/unite-colorscheme', { 'on' : 'Unite' }

" }}}

" Wrappers {{{
" Coveragepy Wrapper
Plug 'alfredodeza/coveragepy.vim', { 'on' : 'Coveragepy' }

" Convienient single-file compilation
Plug 'xuhdev/SingleCompile', { 'on' : ['SCCompile', 'SCCompileRun'] }

" Ack wrapper - replaced by Unite.
" Plug 'mileszs/ack.vim'

" }}}

" Why not?
Plug 'mattn/flappyvird-vim', { 'on': 'FlappyVird' }

" Testing
" Plug 'junegunn/vader.vim'

call plug#end()

" Colorscheme
" HAS to be set after t_Co and background - weird things happen otherwise.
colorscheme solarized

