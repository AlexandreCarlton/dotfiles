" Alexandre's vimrc
"
" TODO: Simplify to lua, strip out most plugins

" Add treesitter then a 'syntax highlighting' for anything not covered.

" Automatic installation {{{
if empty(glob('$HOME/.config/nvim/autoload/plug.vim'))
    silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
      \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall | source $MYVIMRC
endif
" }}}

autocmd FileType vim set foldmethod=marker

" Neovim/Vim settings
runtime! plugin/python_setup.vim

set undofile
" Where we save bookmarks and history.
let g:netrw_home='$HOME/.cache/nvim'

call plug#begin('$HOME/.config/nvim/plugged')

" When neovim 0.6 arrives we should move to treesitter
" See https://github.com/nvim-treesitter/nvim-treesitter#supported-languages
" Languages (Syntax) {{{

" Ansible
Plug 'pearofducks/ansible-vim'

" C / C++
Plug 'octol/vim-cpp-enhanced-highlight', {'for': ['c', 'cpp']}

" Cmake
autocmd FileType cmake setlocal commentstring=#\ %s

" Docker (+ snippets)
Plug 'ekalinin/Dockerfile.vim'

" Fish
Plug 'dag/vim-fish', {'for': 'fish'}

" Git
Plug 'tpope/vim-git'

" Haskell ( + indentation)
Plug 'neovimhaskell/haskell-vim', {'for': 'haskell'}

" i3
Plug 'mboughaba/i3config.vim'

" JavaScript
Plug 'pangloss/vim-javascript', { 'for' : 'javascript' }

" JSON5
Plug 'gutenye/json5.vim'

" Kotlin
Plug 'udalov/kotlin-vim'

" LaTeX
Plug 'lervag/vimtex' " {{{
let g:tex_flavor = 'latex'
au BufNewFile,BufRead *.tex set filetype=tex
autocmd FileType tex set spell
" }}}

" Markdown
Plug 'plasticboy/vim-markdown', { 'for' : 'markdown' } " {{{
let g:vim_markdown_folding_disabled = 1
" Set relevant files with markdown extensions to be MarkDown.
au BufNewFile,BufRead *.md,*.mkd set filetype=markdown
" Spell check markdown files.
autocmd FileType markdown set spell
" }}}

" Mediawiki
Plug 'chikamichi/mediawiki.vim'

" Nginx
Plug 'chr4/nginx.vim'

" Python PEP-8 indent
Plug 'hynek/vim-python-pep8-indent', {'for': 'python'}

" Rust
Plug 'rust-lang/rust.vim', {'for': 'rust'}

" TypeScript
Plug 'leafgarland/typescript-vim', {'for': 'typescript'}

" }}}

" Colours {{{

Plug 'altercation/vim-colors-solarized'

" Set utf8 as standard encoding and en_US as standard language
set encoding=utf-8
scriptencoding utf-8

" Set unix as standard file type
set fileformats=unix,dos,mac

" }}}

" Completion {{{

" Autocompletion for quotes, parens, etc.
Plug 'raimondi/delimitMate' " {{{
let g:delimitMate_expand_cr = 1
" }}}

" LSP client for editor-agnostic support.
" TODO: Look into neovim's inbuilt support when 0.5.0
Plug 'autozimu/LanguageClient-neovim', { 'branch': 'next', 'do': 'bash install.sh' }

" Let w0rp/ale handle diagnostics
let g:LanguageClient_diagnosticsEnable = 0

" Other LSPs:
" haskell-ide-engine
let g:LanguageClient_serverCommands = {
    \ 'go': ['gopls'],
    \ 'python': ['pyls'],
    \ 'sh': ['bash-language-server', 'start'],
    \ }

" Mimimalist autocompletion framework - leverages omnifunc (augmented by LanguageClient-neovim).
Plug 'lifepillar/vim-mucomplete' " {{{

" Recommended basic setup
set completeopt+=menuone,noselect
set completeopt-=preview
set shortmess+=c
set belloff+=ctrlg

let g:mucomplete#enable_auto_at_startup = 1

" The default is 2, we want this immediately
let g:mucomplete#minimum_prefix_length = 2

" Recommended when using LanguageClient-neovim
let g:mucomplete#completion_delay = 10
let g:mucomplete#reopen_immediately = 0
" }}}

" End certain strutures automatically.
Plug 'tpope/vim-endwise'

" }}}

" Git {{{

" Shows git diff in column - better than mhinz/vim-signify
Plug 'airblade/vim-gitgutter' " {{{
let g:gitgutter_sign_removed = '-'
let g:gitgutter_sign_modified_removed = '~-'
" }}}

" Git Wrapper.
Plug 'tpope/vim-fugitive'

" Enable spell-check on git commits
autocmd Filetype gitcommit set spell

" }}}

" Interface {{{

" Exclude quickfix list from buffer navigation.
augroup qf
  autocmd!
  autocmd FileType qf set nobuflisted
augroup END

" Use Australian spelling if enabled
set spelllang=en_au

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
set cursorline

" Peek at the Undo tree.
Plug 'mbbill/undotree', {'on': 'UndotreeToggle'}

" More options (like diff) when dealing with swp files.
Plug 'chrisbra/Recover.vim'

" Display marks in the gutter
Plug 'kshenoy/vim-signature'

" Intelligent number toggling.
Plug 'myusuf3/numbers.vim', " {{{

" Odd things happen without this.
set number
" List of items to exclude from being numbered.
let g:numbers_exclude = ['undotree']

" }}}

" Listen to ~/.editorconfig to set indenting styles for different languages.
" Also includes trimming whitespace, etc.
Plug 'editorconfig/editorconfig-vim' " {{{

let g:EditorConfig_exclude_patterns = ['fugitive://.*', 'tarfile::.*']

" Color the column corresponding the maximum line length (+1)
let g:EditorConfig_max_line_indicator = 'line'

" Support for this was removed; see #121 on editorconfig-vim for any update.
if executable('editorconfig')
  " Requires editorconfig-core-c
  let g:EditorConfig_core_mode = 'external_command'
endif

" Don't the current line if it was already longer than the allowed width when
" the user started editing it.
set formatoptions+=l

" }}}

" Execute unix shell commands from Vim.
Plug 'tpope/vim-eunuch', {'on': ['Remove', 'Unlink', 'Move', 'Rename', 'Chmod',
                               \ 'Mkdir', 'Find', 'Locate', 'Wall',
                               \ 'SudoWrite', 'SudoEdit']}
" }}}

" Mappings {{{

" Align text with 'gaip='
Plug 'junegunn/vim-easy-align', {'on': ['<Plug>EasyAlign', 'EasyAlign']} " {{{
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

" Better sed with Subvert
" Allows changing of snake, mixed and camel case.
Plug 'tpope/vim-abolish'

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

" Change leader to space to allow easier transitioning with spacemacs.
let mapleader=" "

" Press 'q' to close quickfix/location lists, similar to VimFiler/TagBar
autocmd FileType qf map <buffer> q :quit<cr>

" Plugin mappings - keybindings are influenced by the first thing I think of
" when trying to use it
nnoremap <Leader>/ :Grepper<cr>
nnoremap <Leader>* :Grepper -cword -noprompt<cr>
nnoremap <Leader>ud :UndotreeToggle<cr>
nnoremap <Leader>fe :Vexplore<cr>
nnoremap <Leader>ff :FZF<cr>

nmap <C-]> <Plug>(lcn-definition)
nmap K <Plug>(lcn-hover)

" }}}

" Searching (& Exploring) {{{

" Augment built-in directory browser; press '~' to go home.
Plug 'tpope/vim-vinegar' " {{{

" Use a tree-style view.
let g:netrw_liststyle = 3

" }}}

" Fuzy searh finder
" Due to its frankly shocking directory layout, we use our package manager to
" download fzf.
Plug 'junegunn/fzf.vim'

" Grep things easily, autodetects tools
" Asynchronous support with neovim
Plug 'mhinz/vim-grepper' " {{{

" All we need is ripgrep.
let g:grepper = { 'tools': ['rg'] }

" }}}

" }}}

" Statusline {{{

" Better buffertab
Plug 'ap/vim-buftabline' " {{{
let g:buftabline_show = 2 " Always show buffers (less disjointed on enter)
let g:buftabline_numbers = 1 " Show buffer numbers in label
let g:buftabline_indicators = 1 " Show buffer state in label
" }}}

" Even more lightweight and configurable than airline
" Get bufferline in the tabline
Plug 'itchyny/lightline.vim' " {{{

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
    \     ['lineinfo'],
    \     ['percent'],
    \     ['fileformat', 'fileencoding', 'filetype'],
    \   ]
    \ },
    \ 'component': {
    \   'lineinfo': '%3l:%-2c',
    \   'readonly': '%{&readonly ? "RO" : ""}',
    \   'fileencoding': '%{strlen(&fenc) ? &fenc : &enc}',
    \   'filename': '%{expand("%:p:.")}',
    \   'filetype': '%{strlen(&ft) ? &ft : "no ft"}',
    \ },
    \ 'component_function': {
    \   'mode': 'MyMode',
    \   'fugitive': 'MyFugitive',
    \   'gitgutter': 'MyGitGutter',
    \ },
    \ 'separator': { 'left': '', 'right': '' },
    \ 'subseparator': { 'left': '|', 'right': '|' }
    \ }

" Lightline functions {{{
function! MyFugitive()
  if exists('*fugitive#head')
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
  return lightline#mode() == 'COMMAND' ? 'C' :
       \ lightline#mode() == 'INSERT' ? 'I' :
       \ lightline#mode() == 'NORMAL' ? 'N' :
       \ lightline#mode() == 'REPLACE' ? 'R' :
       \ lightline#mode() == 'SELECT' ? 'S' :
       \ lightline#mode() == 'S-BLOCK' ? 'S' :
       \ lightline#mode() == 'S-LINE' ? 'S' :
       \ lightline#mode() == 'TERMINAL' ? 'T' :
       \ lightline#mode() == 'VISUAL' ? 'V' :
       \ lightline#mode() == 'V-BLOCK' ? 'V' :
       \ lightline#mode() == 'V-LINE' ? 'V' :
       \ lightline#mode()
endfunction

" }}}

" }}}

" Show statusline on all windows - done by sensible
set laststatus=2

" }}}

" }}}

" Tmux {{{

" Send make commands to Tmux pane
Plug 'tpope/vim-dispatch', {'on': ['Make', 'Dispatch', 'Start'] }

" }}}

call plug#end()

" Colorscheme {{{

" HAS to be set after t_Co and background - weird things happen otherwise.

" Use 256 to enable 256-Colour mode
" Use 16 to use Terminal's colours.
set t_Co=256
set background=dark
silent! colorscheme solarized
let g:lightline.colorscheme = 'solarized'
" Ensure gutter has same column as background
highlight clear SignColumn
" }}}
