" Interface Bundles

" Handles csv files.
NeoBundleLazy 'chrisbra/csv.vim', {
\     'autoload': {
\         'filetypes': ['csv']
\     }
\ }

" Browse the Undo Tree with :UB
NeoBundle 'chrisbra/histwin.vim'

" More options (like diff) when dealing with swp files.
NeoBundle 'chrisbra/Recover.vim'

" Shell prompt generator.
NeoBundleLazy 'edkolev/promptline.vim'

" Makes NERDTree handle tabs seamlessly.
NeoBundle 'jistr/vim-nerdtree-tabs'

" Nice start screen (Table of Contents)
" NeoBundle 'mhinz/vim-startify'

" Intelligent number toggling.
NeoBundle 'myusuf3/numbers.vim'

" Visually display indent levels in Vim (to highlight tabs)
" NeoBundle 'nathanaelkane/vim-indent-guides'

" Show trailing whitespace - fix with :StripWhitespace
NeoBundle 'ntpeters/vim-better-whitespace'

" Explore filesystem within Vim.
NeoBundle 'scrooloose/nerdtree'

" Fuzzy file finder
NeoBundle 'Shougo/unite.vim'

" Diplay vertical lines for each indentation level.
" NeoBundle 'Yggdroot/indentLine'
