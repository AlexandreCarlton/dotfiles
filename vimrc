
""""""""""""""""""""""""""""""""""""""""""""""""""
" NeoBundle settings                                "
"                                                "
""""""""""""""""""""""""""""""""""""""""""""""""""
if has('vim_starting')

	" Use Vim instead of Vi.
	set nocompatible

	" Enable NeoBundle commands.
	set runtimepath+=~/.vim/bundle/neobundle.vim
endif

call neobundle#rc(expand('~/.vim/bundle/'))

" Let NeoBundle manage NeoBundle.

NeoBundle 'Shougo/neobundle.vim'

" :NeoBundleList          - list configured bundles
" :NeoBundleInstall(!)    - install (update) bundles
" :NeoBundleClean(!)      - confirm (or auto-approve) remove of unused bundles

" List of bundles.
source ~/.vim/bundle-list.vim
"NeoBundle 'tomasr/molokai'

syntax on
filetype plugin indent on

" Check for any uninstalled bundles on startup.
NeoBundleCheck

" Bundle settings
source ~/.vim/bundle-settings.vim

source ~/.vim/settings-tab.vim

source ~/.vim/settings-mapping.vim
