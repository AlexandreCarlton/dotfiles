" Alexandre's vimrc
"
" TODO: Make mappings for formatting
" for example, make a function that calls the relevant format function for the
" current filetype - useful for ClangFormat and gofmt

" Automatic installation {{{
if empty(glob('$XDG_CONFIG_HOME/nvim/autoload/plug.vim'))
    silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
      \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall | source $MYVIMRC
endif
" }}}

set foldmethod=syntax
autocmd FileType vim set foldmethod=marker

" Neovim/Vim settings {{{
if has('nvim')
  runtime! plugin/python_setup.vim
else
  if !isdirectory($XDG_CACHE_HOME . '/vim')
    silent call mkdir($XDG_CACHE_HOME . '/vim', 'p')
  endif
  " Can't share viminfo with Neovim unfortunately.
  set viminfo+=n$XDG_CACHE_HOME/vim/viminfo

  " Directories are automatically created if they do not exist.
  " Set Neovim defaults,as that is ultimately where we're heading.
  if !isdirectory($XDG_DATA_HOME . '/nvim')
    silent call mkdir($XDG_DATA_HOME . '/nvim/swap', 'p')
    silent call mkdir($XDG_DATA_HOME . '/nvim/backup', 'p')
    silent call mkdir($XDG_DATA_HOME . '/nvim/view', 'p')
    silent call mkdir($XDG_DATA_HOME . '/nvim/undo', 'p')
  endif
  set directory=$XDG_DATA_HOME/nvim/swap//
  set backupdir=.,$XDG_DATA_HOME/nvim/backup
  set viewdir=$XDG_DATA_HOME/nvim/view
  set undodir=$XDG_DATA_HOME/nvim/undo
  set runtimepath+=$XDG_CONFIG_HOME/nvim,$XDG_CONFIG_HOME/nvim/after
endif
" }}}
set undofile

let g:bundle_folder='$XDG_CONFIG_HOME/nvim/plugged'
let g:use_glyphs = 0 " Use fancy glyphs?

call plug#begin(g:bundle_folder)

" Syntax {{{
" TODO: Use NeoMake instead of Syntastic once NeoVim is ready.

" Use ']l' and '[l' to cycle through errors (with vim-unimpaired)
Plug 'scrooloose/syntastic' " {{{
" Use nicer symbols (given in the docs).
if g:use_glyphs
    let g:syntastic_error_symbol = '✗'
    let g:syntastic_warning_symbol = '⚠'
else
    let g:syntastic_error_symbol = 'x'
    let g:syntastic_warning_symbol = '!'
endif

" Active mode runs SyntasticCheck on save or opened; passive does not.
let g:syntastic_mode_map = { 'mode': 'active',
                           \ 'active_filetypes': [],
                           \ 'passive_filetypes': ['c', 'cpp'] }
" Check on open.
let g:syntastic_check_on_open = 0
" Check on close.
let g:syntastic_check_on_wq = 0
" Update location-list automatically.
let g:syntastic_always_populate_loc_list = 1
" Automatically open when errors detected, close when none are detected.
let g:syntastic_auto_loc_list = 1
" Set the size of the error window to be smaller.
let g:syntastic_loc_list_height = 5

" Should think about distributing these out.
" let g:syntastic_c_checkers = ['clang_checker', 'gcc']
let g:syntastic_fortran_compiler = 'gfortran'
let g:syntastic_fortran_compiler_options = '-std=f95'
let g:syntastic_haskell_checkers = ['ghc_mod']
" }}}

" Allows asynchronous execution (great for syntax checkers)
Plug 'Shougo/vimproc.vim', { 'do': 'make -f make_unix.mak' }

" }}}

" Ansible {{{

" Syntax highlighting
Plug 'pearofducks/ansible-vim'

" }}}

" C / C++ {{{

" Syntax highlighting
Plug 'octol/vim-cpp-enhanced-highlight', {'for': ['c', 'cpp']}

" }}}

" CMake {{{
autocmd FileType cmake setlocal commentstring=#\ %s
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

" Set utf8 as standard encoding and en_US as standard language
set encoding=utf-8
scriptencoding utf-8

" Set unix as standard file type
set fileformats=unix,dos,mac

" }}}

" Completion {{{

" Autocompletion for quotes, parens, etc.
Plug 'jiangmiao/auto-pairs'

" Options
" --clang-completer (C/C++)
" --omnisharp-completer (C#)
" --gocode-completer (Go)
" --tern-completer (Javascript)
" --racer-completer (Rust)
" --system-libclang (Use system libclang instead of downloading other binary)
" --system-boost (Use system boost instead of downloading)
let ycm_options = '--clang-completer ' .
                \ '--tern-completer ' .
                \ '--system-libclang --system-boost'
Plug 'Valloric/YouCompleteMe', {'do': 'python2 install.py ' . ycm_options, 'on': []} "{{{
let g:ycm_always_populate_location_list = 1
let g:ycm_add_preview_to_completeopt = 1
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_confirm_extra_conf = 0
let g:ycm_semantic_triggers = {'haskell': ['.'], 'r': ['.', '$', 're![_a-zA-Z]+[_\w]*\.']}
" Run ctags --fields=+l and YCM will look at tags files.
" let g:ycm_collect_identifiers_from_tags_files = 1
 " }}}

" Generate .ycm_extra_conf.py
" IDEA: On git pull, generate one if it doesn't exist (and is supported, e.g.
" CMakeLists exist).
" Run config_gen.py <PROJECT_DIR> or :YcmGenerateConfig
Plug 'rdnetto/YCM-Generator', {'branch': 'stable', 'on': 'YcmGenerateConfig'}


 " Snippets produced along side YouCompleteMe
Plug 'SirVer/UltiSnips', {'on': []} " {{{
let g:UltiSnipsExpandTrigger = '<C-j>'
" }}}

Plug 'honza/vim-snippets'

" Load YCM and UltiSnips on first insert.
" TODO: Make this into a function so I can activate on demand.
" augroup load_us_ycm
"   autocmd!
"   autocmd InsertEnter * call plug#load('UltiSnips', 'YouCompleteMe')
"                      \| call youcompleteme#Enable() | autocmd! load_us_ycm
" augroup END

" End certain strutures automatically.
Plug 'tpope/vim-endwise'

" }}}

" Shell {{{

" Set default shell; plugins may not work if using fish as user-shell.
set shell=/bin/sh

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

" Syntax highlighting
Plug 'tpope/vim-git'

" }}}

" Go {{{
" Batteries included go support (including completion)
Plug 'fatih/vim-go', {'for': 'go'}
" }}}

" Haskell {{{
" Check out begriffs/haskell-vim-now for configs / haskell packages.

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

" Highlight searches as you type in a pattern.
set incsearch

" Don't highlight previous search results.
set nohlsearch

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

" Peek at the Undo tree.
Plug 'mbbill/undotree', {'on': 'UndotreeToggle'}

" More options (like diff) when dealing with swp files.
Plug 'chrisbra/Recover.vim'

" Display marks in the gutter
Plug 'kshenoy/vim-signature'

" Automatically format with what's available
Plug 'Chiel92/vim-autoformat', {'on': 'Autoformat'}

" Intelligent number toggling.
Plug 'myusuf3/numbers.vim', " {{{

" Odd things happen without this.
set number
" List of items to exclude from being numbered.
let g:numbers_exclude = ['unite', 'tagbar', 'startify', 'gundo', 'vimshell', 'w3m']

" }}}

" Listen to ~/.editorconfig to set indenting styles for different languages.
" Also includes trimming whitespace, etc.
Plug 'editorconfig/editorconfig-vim' " {{{

let g:EditorConfig_exclude_patterns = ['fugitive://.*']

if executable('editorconfig')
  " Requires editor-config-core-c, get it from the AUR or linuxbrew
  let g:EditorConfig_core_mode = 'external_command'
else
  " If unavailable, set to python_external
  let g:EditorConfig_core_mode = 'python_external'
endif

" }}}

" }}}

" JavaScript {{{

" General support
Plug 'pangloss/vim-javascript', { 'for' : 'javascript' }

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

" Align text with 'gaip='
Plug 'junegunn/vim-easy-align' " {{{
" Start interactive EasyAlign in visual mode.
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for motion/text object.
nmap ga <Plug>(EasyAlign)
" }}}

" Easier way of navigating - s{char}{char}, ; to go to next match.
Plug 'justinmk/vim-sneak' "{{{
" Act like Easy-motion.
let g:sneak#streak = 1
"}}}

" Use gcc to toggle comments.
Plug 'tpope/vim-commentary' ", {'on': '<Plug>Commentary'}

" Defaults everyone can agree on.
Plug 'tpope/vim-sensible'

" Easily change surroundings (e.g. tags) in pairs.
Plug 'tpope/vim-surround'

" Nicer mappings using ']' and '[' for 'next' and 'previous'
" e.g. ]b for next buffer
Plug 'tpope/vim-unimpaired'

" Rapidly press these keys (instead of Esc) to go Normal mode.
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

" Change leader to space to allow easier transitioning with spacemacs.
let mapleader=" "

" Buffers; alternatively, [b or ]b
nnoremap <Leader>bn :bnext<cr>
nnoremap <Leader>bp :bprevious<cr>
nnoremap <Leader>bd :bdelete<cr>

nnoremap <Leader>tt :TagbarToggle<cr>
nnoremap <Leader>ts :SyntasticToggleMode<cr>
nnoremap <Leader>en :NeoCompleteEnable<cr>
nnoremap <Leader>tggh :GitGutterLineHighlightsToggle<cr>
nnoremap <Leader>rc :VimuxPromptCommand<cr>
nnoremap <Leader>rl :VimuxRunLastCommand<cr>
nnoremap <Leader>ua :Unite grep:.<cr>
nnoremap <Leader>uf :Unite -start-insert file_rec/async:!<cr>
nnoremap <Leader>f :VimFilerExplorer<cr>
nnoremap <Leader>yf :YcmCompleter FixIt<cr>
" Consider nnoremap <buffer> <silent> <C-]> :YcmCompleter GoTo<cr>
nnoremap <Leader>yg :YcmCompleter GoTo<cr>

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

Plug 'hynek/vim-python-pep8-indent', {'for': 'python'}

" }}}

" Rust {{{
Plug 'rust-lang/rust.vim', {'for': 'rust'}
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
  endif
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

" Show statusline on all windows - done by sensible
set laststatus=2

" }}}

" Systemd {{{

au BufNewFile,BufRead *.service set filetype=cfg

au BufNewFile,BufRead *.socket set filetype=cfg

" }}}

" Tags {{{

" Easily browse tags of source files (generated on the fly).
" Reguires ctags and vim >= 7.0
Plug 'majutsushi/tagbar', {'on': 'TagbarToggle'}

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

" Send make commands to Tmux pane
Plug 'tpope/vim-dispatch', {'on': ['Make', 'Dispatch', 'Start'] }

" Syntax highlighting
Plug 'Keithbsmiley/tmux.vim'

" }}}

" Unite (and plugins that depend on it) {{{
Plug 'Shougo/unite.vim', {'on': ['Unite', 'VimFilerExplorer']}

Plug 'Shougo/vimfiler.vim', {'on': 'VimFilerExplorer'}
let g:vimfiler_as_default_explorer = 1

" Use ag or ack if available
" if executable('ag')
"   let g:unite_source_grep_command = 'ag'
"   let g:source_grep_default_opts = '--line-numbers --nocolor --nogroup'
" elseif executable('ack')
"   let g:unite_source_grep_command = 'ack'
" elseif executable('ack-grep')
"   let g:unite_source_grep_command = 'ack-grep'
" endif


" }}}

call plug#end()

" Colorscheme {{{

" HAS to be set after t_Co and background - weird things happen otherwise.

" Use 256 to enable 256-Colour mode
" Use 16 to use Terminal's colours.
set t_Co=256
set background=dark
colorscheme solarized
let g:lightline.colorscheme = 'solarized'

" }}}