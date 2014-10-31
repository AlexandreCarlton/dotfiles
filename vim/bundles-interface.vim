" Interface Bundles

" Handles csv files.
Plug 'chrisbra/csv.vim', { 'for' : 'csv' }

" Browse the Undo Tree with :UB
Plug 'chrisbra/histwin.vim', { 'on' : 'UB' }

" More options (like diff) when dealing with swp files.
Plug 'chrisbra/Recover.vim'

" Shell prompt generator.
Plug 'edkolev/promptline.vim', { 'on' : 'PromptlineSnapshot' }

" Makes NERDTree handle tabs seamlessly.
Plug 'jistr/vim-nerdtree-tabs' ", { 'on' : 'NERDTreeTabsToggle' }

" Nice start screen (Table of Contents)
" Plug 'mhinz/vim-startify'

" Intelligent number toggling.
Plug 'myusuf3/numbers.vim'

" Visually display indent levels in Vim (to highlight tabs)
" Plug 'nathanaelkane/vim-indent-guides'

" Show trailing whitespace - fix with :StripWhitespace
Plug 'ntpeters/vim-better-whitespace', { 'on' : 'StripWhitespace' }

" Explore filesystem within Vim.
" Loading NERDTree is expensive, but NERDTreeTabs is not.
Plug 'scrooloose/nerdtree' ", { 'on' : 'NERDTreeTabsToggle' }

" Fuzzy file finder
Plug 'Shougo/unite.vim', { 'on' : 'Unite' }

" Diplay vertical lines for each indentation level.
" Plug 'Yggdroot/indentLine'
