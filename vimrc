
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
for file in split(glob('~/.vim/bundles-*.vim'), '\n')
    exe 'source' file
endfor

syntax on
filetype plugin indent on

" Check for any uninstalled bundles on startup.
NeoBundleCheck

" Bundle & miscellaneous settings.
for file in split(glob('~/.vim/settings-*.vim'), '\n')
    exe 'source' file
endfor
