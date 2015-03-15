" Alexandre's vimrc, optimised for startup time.
" For more involved editing, use spacemacs - vim is now for quick editing.
" Chuck out all the things that you don't use or kill loading time.
" (Looking at you, UltiSnips)
" Look at Shougo's plugins and vysakh0's dotfiles. - see how he maps unite,
" mimic it with Spacemancs - <leader>u
" Switch to NeoComplete and NeoSnippet - faster and can be enabled on demand.
" Look at vimfiler for nerdtree.
" Prefer bundles that require no external setup.
" Try to place actual settings (like mappings, colour) AFTER plugin initialization.
"
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

let g:bundle_folder='~/.vim/plugged'

call plug#begin(g:bundle_folder)

" C / C++ {{{

Plug 'rhysd/vim-clang-format', { 'for': ['c', 'cpp', 'objc'], 'on': 'ClangFormat' }

" }}}

" CoffeeScript {{{

" Compilation support + Syntax highlighting.
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

" Zenburn
Plug 'jnurmine/Zenburn'

" Jelly Beans
Plug 'nanotech/jellybeans.vim'

" Molokai (Sublime Text)
Plug 'tomasr/molokai'

" Twilight (TextMate)
Plug 'matthewtodd/vim-twilight'

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

" Snippets for snippet engine
" Compatible with ultisnips or neosnippet
" Plug 'honza/vim-snippets'

" Autocompletion for quotes, parens, etc.
Plug 'Raimondi/delimitMate'

" General syntax checker
" Use ']l' and '[l' to cycle through errors (with vim-unimpaired)
Plug 'scrooloose/syntastic' " {{{

" Use nicer symbols (given in the docs).
let g:syntastic_error_symbol = '✗'
let g:syntastic_warning_symbol = '⚠'

" Active mode runs SyntasticCheck on save or opened; passive does not.
let g:syntastic_mode_map = { 'mode': 'passive',
                           \ 'active_filetypes': [],
                           \ 'passive_filetypes': [] }

" Check for errors on startup? Making things slow.
let g:syntastic_check_on_open = 0

" Always display any errors in the location list.
let g:syntastic_always_populate_loc_list = 1

" Automatically open error window when errors detected, close when none are.
let g:syntastic_auto_loc_list = 1

" Set the size of the error window to be smaller.
let g:syntastic_loc_list_height = 5

" Don't jump to first detected issue when saving/opening a file.
let g:syntastic_auto_jump = 0

" For Fortran, use gfortran as checker
let g:syntastic_fortran_compiler = 'gfortran'

" Use Fortran 95 as standard
let g:syntastic_fortran_compiler_options = '-std=f95'

let g:syntastic_haskell_checkers = ['ghc_mod'] "['hlint']
" }}}

" Allows asynchronous execution (great for syntax checkers)
Plug 'Shougo/vimproc.vim', { 'do': 'make -f make_unix.mak' }

" Completion engine - faster startup with Vim, but slower completion
" Use :NeoCompleteEnable if not executed on startup.
Plug 'Shougo/neocomplete.vim' " {{{

" Run on startup?
let g:neocomplete#enable_at_startup = 0

if !exists('g:neocomplete#force_omni_input_patterns')
  let g:neocomplete#force_omni_input_patterns = {}
endif

" (Shift-) Tab Completion
inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<S-TAB>"
" }}}

" Snippets
Plug 'Shougo/neosnippet-snippets'

" Snippet engine - requires NeoComplete enabled
Plug 'Shougo/neosnippet.vim' " {{{
" let g:neosnippet#snippets_directory=g:bundle_folder.'/vim-snippets/snippets'
imap <C-j> <Plug>(neosnippet_expand_or_jump)
smap <C-j> <Plug>(neosnippet_expand_or_jump)
xmap <C-j> <Plug>(neosnippet_expand_target)

" }}}

" End certain strutures automatically.
Plug 'tpope/vim-endwise'

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

" Haskell plugins
Plug 'dag/vim2hs', { 'for' : 'haskell' }

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
Plug 'hail2u/vim-css3-syntax', { 'for': ['html', 'xhtml', 'css'] }

" HTML5 + inline SVG omnicomplete function, indent and ayntax.
Plug 'othree/html5.vim', { 'for': ['html', 'xhtml'] }

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
" Plug 'jistr/vim-nerdtree-tabs' " {{{
" Don't open NERDtree on Console vim startup
let g:nerdtree_tabs_open_on_console_startup = 0
" }}}

" Display marks in the gutter
Plug 'kshenoy/vim-signature'

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
Plug 'ntpeters/vim-better-whitespace'

" Explore filesystem within Vim.
" Loading NERDTree is expensive, but NERDTreeTabs is not.
" Plug 'scrooloose/nerdtree'


" Diplay vertical lines for each indentation level.
" Plug 'Yggdroot/indentLine'

" }}}

" JavaScript {{{
" General support
Plug 'pangloss/vim-javascript', { 'for' : 'javascript' }

" Tags and omnicompletion.
Plug 'marijnh/tern_for_vim', { 'for' : 'javascript', 'do': 'npm install -g' }

" }}}

" LaTeX {{{
au BufNewFile,BufRead *.tex set filetype=tex

" Set spellcheck on documents
autocmd FileType tex set spell

" LaTeX Plugin
Plug 'LaTeX-Box-Team/LaTeX-Box', {'for': ['plaintex', 'context', 'latex', 'rnoweb', 'tex']} " {{{
" Quickfix window opened automatically if not empty, cursor stays in current
" window
let g:LatexBox_quickfix = 2

" }}}


" }}}

" Mappings {{{
" Aligns text
Plug 'godlygeek/tabular'

" Easier way of navigating - <Leader>ww to activate.
Plug 'Lokaltog/vim-easymotion'

" Easier commenting - <Leader>c<Space> to toggle comment
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

" Change leader to space to allow easier transitioning with spacemacs.
let mapleader=" "

map <Leader>n <plug>NERDTreeTabsToggle<cr>
nnoremap <Leader>tt :TagbarToggle<cr>
nnoremap <Leader>en :NeoCompleteEnable<cr>

" Function Keys
nmap <F5> :SCCompileRun<cr>
nmap <F6> :SCCompile<cr>
nmap <F8> :TagbarToggle<cr>

" }}}

" Markdown {{{

" Set relevant files with markdown extensions to be MarkDown.
au BufNewFile,BufRead *.md,*.mkd set filetype=markdown

" Spell check markdown files.
autocmd FileType markdown set spell

" Markdown runtime files
" godlygeek/tabular MUST come before this.
Plug 'plasticboy/vim-markdown', { 'for' : 'markdown' }

" }}}

" Python {{{

" Completion - Making start-up time slow...
Plug 'davidhalter/jedi-vim', {'for': 'python'} " {{{
" Use NeoComplete
autocmd FileType python setlocal omnifunc=jedi#completions
let g:jedi#auto_initialization = 0
let g:jedi#completions_enabled = 0
let g:jedi#auto_vim_configuration = 0
let g:neocomplete#force_omni_input_patterns.python =
\ '\%([^. \t]\.\|^\s*@\|^\s*from\s.\+import \|^\s*from \|^\s*import \)\w*'
" }}}

" }}}

" SQL (and Declarative Languages) {{{
" Cypher/CQL syntax highlighting
Plug 'neo4j-contrib/cypher-vim-syntax', { 'for' : 'cypher' }

" Set HiveQL scripts to have SQL highlighting if no other style is defined.
au BufRead,BufNewFile *.hql setfiletype sql
" }}}

" Statuslines {{{
" Uses VimScript, integrates with plugins
Plug 'bling/vim-airline' " {{{

" Tabs are stylised like the status line
let g:airline#extensions#tabline#enabled = 1

" Use powerline symbols?
let g:airline_powerline_fonts = 1

" }}}

" Powerline (Remove this later - too heavy) {{{
" let $PYTHONPATH='~/.local/lib/python3.4/site-packages'
" python import sys; sys.path.append('~/.local/lib/python3.4/site-packages')
" python import vim
" python from powerline.vim import setup as powerline_setup
" python powerline_setup()
" python del powerline_setup
" }}}

" Show statusline on all windows
set laststatus=2

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
Plug 'majutsushi/tagbar'

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

" Wrappers {{{

" Convienient single-file compilation
Plug 'xuhdev/SingleCompile', { 'on' : ['SCCompile', 'SCCompileRun'] }

" }}}

" Unite (and plugins that depend on it) {{{
Plug 'Shougo/unite.vim', { 'on' : 'Unite' }

" Use ag or ack if available
"if executable('ag')
  "let g:unite_source_grep_command = 'ag'
  "" let g:source_grep_default_opts = '--line-numbers --nocolor --nogroup'
"elseif executable('ack')
  "let g:unite_source_grep_command = 'ack'
"elseif executable('ack-grep')
  "let g:unite_source_grep_command = 'ack-grep'
"endif

nnoremap <Leader>ua :Unite grep:.<cr>
nnoremap <Leader>uf :Unite -start-insert file_rec/async:!<cr>

" }}}

call plug#end()

" Colorscheme
" HAS to be set after t_Co and background - weird things happen otherwise.
colorscheme solarized
