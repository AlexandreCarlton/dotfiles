" Alexandre's vimrc
" Somewhat optimised for quick startup.
"
" TODO: Make mappings for formatting
" for example, make a function that calls the relevant format function for the
" current filetype - useful for ClangFormat and gofmt

" Automatic installation {{{
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !mkdir -p ~/.vim/autoload
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    source ~/.vimrc
    PlugInstall
endif
" }}}

set foldmethod=syntax
autocmd FileType vim set foldmethod=marker

" NeoVim-specific settings {{{
if has('nvim')
  runtime! plugin/python_setup.vim
endif
" }}}

let g:bundle_folder='~/.vim/plugged'
let g:use_powerline = 0 " Use fancy glyphs?
let g:use_neocomplete = 1 " Off means we have YouCompleteMe

call plug#begin(g:bundle_folder)

" Syntax {{{

" Use ']l' and '[l' to cycle through errors (with vim-unimpaired)
Plug 'scrooloose/syntastic' " {{{
" Use nicer symbols (given in the docs).
if g:use_powerline
    let g:syntastic_error_symbol = '✗'
    let g:syntastic_warning_symbol = '⚠'
else
    let g:syntastic_error_symbol = 'x'
    let g:syntastic_warning_symbol = '!'
endif

" Active mode runs SyntasticCheck on save or opened; passive does not.
let g:syntastic_mode_map = { 'mode': 'passive',
                           \ 'active_filetypes': [],
                           \ 'passive_filetypes': [] }
let g:syntastic_check_on_open = 0
let g:syntastic_always_populate_loc_list = 1
" Automatically open when errors detected, close when none are detected.
let g:syntastic_auto_loc_list = 1
" Set the size of the error window to be smaller.
let g:syntastic_loc_list_height = 5

" Should think about distributing these out.
" For Fortran, use gfortran as checker
" let g:syntastic_c_checkers = ['clang_checker', 'gcc']
let g:syntastic_fortran_compiler = 'gfortran'
let g:syntastic_fortran_compiler_options = '-std=f95'
let g:syntastic_haskell_checkers = ['ghc_mod']
" }}}

" Allows asynchronous execution (great for syntax checkers)
Plug 'Shougo/vimproc.vim', { 'do': 'make -f make_unix.mak' }
" }}}

" C / C++ {{{

Plug 'rhysd/vim-clang-format', { 'for': ['c', 'cpp', 'objc'], 'on': 'ClangFormat' }



" }}}

" CoffeeScript {{{

" Compilation support + Syntax highlighting.
Plug 'kchmck/vim-coffee-script', {'for': 'coffee'}

" Indent and syntax highlighting
Plug 'mintplant/vim-literate-coffeescript', {'for': 'coffee'}

" }}}

" Colours {{{

" Needs respective setting in Xresources if using xterm or urxvt.
Plug 'chriskempson/base16-vim' " {{{
let base16colorspace=256
let g:base16_shell_path='~/.config/base16/shell'
" }}}

" Base16 has some weird deviations (compare Solarized), hence these plugins.
Plug 'altercation/vim-colors-solarized'
Plug 'jnurmine/Zenburn'
Plug 'nanotech/jellybeans.vim'
Plug 'whatyouhide/vim-gotham'
Plug 'tomasr/molokai'
Plug 'matthewtodd/vim-twilight'
Plug 'chriskempson/vim-tomorrow-theme'
Plug 'NLKNguyen/papercolor-theme'

" Use 256 to enable 256-Colour mode
" Use 16 to use Terminal's colours.
set t_Co=256

set background=dark

" Set utf8 as standard encoding and en_US as standard language
set encoding=utf-8
scriptencoding utf-8

" Set unix as standard file type
set fileformats=unix,dos,mac

" }}}

" Completion {{{

" Autocompletion for quotes, parens, etc.
Plug 'Raimondi/delimitMate'

" Completion engine - faster startup with Vim, but slower completion
" Use :NeoCompleteEnable if not executed on startup.
if g:use_neocomplete
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

  imap <C-j> <Plug>(neosnippet_expand_or_jump)
  smap <C-j> <Plug>(neosnippet_expand_or_jump)
  xmap <C-j> <Plug>(neosnippet_expand_target)

  " }}}
else
  let ycm_options = '--clang-completer --gocode-completer --omnisharp-completer ' .
                  \ '--system-libclang --system-boost'
  Plug 'Valloric/YouCompleteMe', {'do': './install.sh ' . ycm_options, 'frozen': 1 } "{{{
  let g:ycm_global_ycm_extra_conf = g:bundle_folder . '/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'
  let g:ycm_always_populate_location_list = 1
  let g:ycm_add_preview_to_completeopt = 1
  let g:ycm_autoclose_preview_window_after_completion = 1
  let g:ycm_autoclose_preview_window_after_insertion = 1
  let g:ycm_confirm_extra_conf = 0
  let g:ycm_semantic_triggers = {'haskell': ['.'], 'r': ['.', '$', 're![_a-zA-Z]+[_\w]*\.']}
   " }}}

   " Snippets produced along side YouCompleteMe
  Plug 'SirVer/UltiSnips' " {{{
  let g:UltiSnipsExpandTrigger = '<C-j>'
  " }}}
endif

" End certain strutures automatically.
Plug 'tpope/vim-endwise'

" }}}

" Fish {{{

Plug 'dag/vim-fish', {'for': 'fish'}

" }}}

" Fortran {{{

" Use free-form input (Don't assume everything is offset by 8 spaces)
let fortran_free_source = 1

" Make syntax colouring more precise (albeit slower)
let fortran_more_precise = 1

" }}}

" Git {{{

" Shows git diff in column - better than mhinz/vim-signify
Plug 'airblade/vim-gitgutter' " {{{
let g:gitgutter_sign_removed = '-'
let g:gitgutter_sign_modified_removed = '~-'
" }}}

" Git Wrapper.
Plug 'tpope/vim-fugitive'

" }}}

" Go {{{
" Batteries included go support (including completion)
Plug 'fatih/vim-go', {'for': 'go'}
" }}}

" Haskell {{{

" Haskell plugins
Plug 'dag/vim2hs', {'for': 'haskell'}

" Haskell plugin to display error messages
" Needs vimproc.vim and ghc-mod
Plug 'eagletmt/ghcmod-vim', {'for': 'haskell'}

" Completion plugin for Haskell using ghc-mod
Plug 'eagletmt/neco-ghc', {'for': 'haskell'} " {{{
let g:necoghc_enable_detailed_browse = 1
autocmd FileType haskell set omnifunc=necoghc#omnifunc " YouCompleteMe/NeoComplete
" }}}

" Hoogle (Haskell query plugin)
Plug 'Twinside/vim-hoogle', {'for': 'haskell'}

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

" Display marks in the gutter
Plug 'kshenoy/vim-signature'

" Intelligent number toggling.
Plug 'myusuf3/numbers.vim', " {{{

" Odd things happen without this.
set number
" List of items to exclude from being numbered.
let g:numbers_exclude = ['unite', 'tagbar', 'startify', 'gundo', 'vimshell', 'w3m']

" }}}

" Show trailing whitespace - fix with :StripWhitespace
Plug 'ntpeters/vim-better-whitespace' " {{{
let g:better_whitespace_filetypes_blacklist = ['vimfiler', 'unite', 'vim-plug']
" }}}

" }}}

" JavaScript {{{

" General support
Plug 'pangloss/vim-javascript', { 'for' : 'javascript' }

" JS Tags and omnicompletion.
Plug 'marijnh/tern_for_vim', { 'for' : 'javascript', 'do': 'npm install' } " {{{
autocmd FileType javascript set omnifunc=tern#Complete
" }}}

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
" e.g. ]b for next buffer
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

nnoremap <Leader>tt :TagbarToggle<cr>
nnoremap <Leader>ts :SyntasticToggleMode<cr>
nnoremap <Leader>en :NeoCompleteEnable<cr>
nnoremap <Leader>tggh :GitGutterLineHighlightsToggle<cr>
nnoremap <Leader>rc :VimuxPromptCommand<cr>
nnoremap <Leader>rl :VimuxRunLastCommand<cr>
nnoremap <Leader>ua :Unite grep:.<cr>
nnoremap <Leader>uf :Unite -start-insert file_rec/async:!<cr>
nnoremap <Leader>f :VimFilerExplorer<cr>

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

" Python Completion - Already supplied by YouCompleteMe
if g:use_neocomplete
  Plug 'davidhalter/jedi-vim', {'for': 'python'} " {{{
  " Use NeoComplete
  autocmd FileType python setlocal omnifunc=jedi#completions
  let g:jedi#auto_initialization = 0
  let g:jedi#completions_enabled = 0
  let g:jedi#auto_vim_configuration = 0
  let g:neocomplete#force_omni_input_patterns.python =
  \ '\%([^. \t]\.\|^\s*@\|^\s*from\s.\+import \|^\s*from \|^\s*import \)\w*'
  " }}}
endif

" }}}

" Puppet {{{
Plug 'rodjek/vim-puppet'
" }}}

" Rust {{{
Plug 'rust-lang/rust.vim', {'for': 'rust'}
" }}}

" SQL (and Declarative Languages) {{{
" Cypher/CQL syntax highlighting
Plug 'neo4j-contrib/cypher-vim-syntax', { 'for' : 'cypher' }

" Set HiveQL scripts to have SQL highlighting if no other style is defined.
au BufRead,BufNewFile *.hql setfiletype sql
" }}}

" Statusline {{{

" Better buffertab
Plug 'ap/vim-buftabline' " {{{
let g:buftabline_show = 1 " Only show if there are 2 or more buffers.
" }}}

" Even more lightweight and configurable than airline
" Get bufferline in the tabline
Plug 'itchyny/lightline.vim' " {{{

" Don't use tagbar for now; it's slow and I can't justify using it.
" Don't set colorscheme here; set it with the actual colorscheme down below
" to facilitate switching.
let g:lightline = {
    \ 'enable': {
    \   'tabline': 0
    \ },
    \ 'active': {
    \   'left': [
    \     ['mode', 'paste', 'readonly'],
    \     ['fugitive', 'gitgutter', 'filename']
    \   ],
    \   'right': [
    \     ['syntastic', 'lineinfo'],
    \     ['percent'],
    \     ['fileformat', 'fileencoding', 'filetype'],
    \   ]
    \ },
    \ 'component': {
    \   'lineinfo': '%3l:%-2c',
    \   'readonly': '%{&readonly ? "RO" : ""}',
    \   'fileencoding': '%{strlen(&fenc) ? &fenc : &enc}',
    \   'filetype': '%{strlen(&ft) ? &ft : "no ft"}',
    \   'tagbar': '%{exists("*tagbar#currenttag") ? tagbar#currenttag("%s", "", "f") : ""}',
    \ },
    \ 'component_expand': {
    \   'syntastic': 'SyntasticStatuslineFlag',
    \ },
    \ 'component_function': {
    \   'mode': 'MyMode',
    \   'fugitive': 'MyFugitive',
    \   'gitgutter': 'MyGitGutter',
    \ },
    \ 'component_type': {
    \   'syntastic': 'error',
    \ },
    \ 'separator': { 'left': '', 'right': '' },
    \ 'subseparator': { 'left': '|', 'right': '|' }
    \ }

" Lightline functions {{{
function! MyFugitive()
  if expand('%:t') !~? 'Tagbar' && &ft !~? 'vimfiler' && exists('*fugitive#head')
    let head = fugitive#head()
    return strlen(head) ? head : ''
  return ''
endfunction

function! MyGitGutter()
  if exists('*GitGutterGetHunkSummary')
    let hunks = GitGutterGetHunkSummary()
    if hunks != [0, 0, 0]
      return g:gitgutter_sign_added . hunks[0] .
      \ ' ' . g:gitgutter_sign_modified . hunks[1] .
      \ ' ' . g:gitgutter_sign_removed . hunks[2]
    else
      return ''
    endif
  else
    return ''
  endif
endfunction

function! MyMode()
  let fname = expand('%:t')
  return fname == '__Tagbar__' ? 'Tagbar' :
       \ lightline#mode() == 'NORMAL' ? 'N' :
       \ lightline#mode() == 'INSERT' ? 'I' :
       \ lightline#mode() == 'VISUAL' ? 'V' :
       \ lightline#mode() == 'V-LINE' ? 'V' :
       \ lightline#mode() == 'V-BLOCK' ? 'V' :
       \ lightline#mode() == 'REPLACE' ? 'R' :
       \ &ft == 'unite' ? 'Unite' :
       \ &ft == 'vimfiler' ? 'VimFiler' :
       \ lightline#mode()
endfunction
" }}}

" }}}

" Show statusline on all windows
set laststatus=2

" }}}

" Systemd {{{

" Systemd syntax
Plug 'Matt-Deacalion/vim-systemd-syntax' ", {'for': 'systemd'}

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

" Easily browse tags of source files (generated on the fly).
" Reguires ctags and vim >= 7.0
Plug 'majutsushi/tagbar', {'on': 'TagbarToggle'}

" CoffeeScript support
" `gem install CoffeeTags` also must be done.
Plug 'lukaszkorecki/CoffeeTags', {'for': 'coffee', 'do': 'gem install CoffeeTags'}

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

" Tmux {{{

" Send commands to Tmux pane
Plug 'benmills/vimux', {'on': ['VimuxPromptCommand', 'VimuxRunLastCommand'] }

" Syntax highlighting
Plug 'Keithbsmiley/tmux.vim'

" }}}

" Unite (and plugins that depend on it) {{{
Plug 'Shougo/unite.vim'

Plug 'Shougo/vimfiler.vim', {'on': 'VimFilerExplorer'}
let g:vimfiler_as_default_explorer = 1

" Use ag or ack if available
"if executable('ag')
  "let g:unite_source_grep_command = 'ag'
  "" let g:source_grep_default_opts = '--line-numbers --nocolor --nogroup'
"elseif executable('ack')
  "let g:unite_source_grep_command = 'ack'
"elseif executable('ack-grep')
  "let g:unite_source_grep_command = 'ack-grep'
"endif


" }}}

call plug#end()

" Colorscheme {{{
"
" For base16 colours, this has to be before colorscheme declaration.
" ONLY IF using  base16-shell.

" HAS to be set after t_Co and background - weird things happen otherwise.
colorscheme solarized
let g:lightline.colorscheme = 'solarized'

" }}}
