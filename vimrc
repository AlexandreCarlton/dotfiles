" Look into vim-plug 
" Seems cleaner and faster - it's just a single file.
" Load on command as well- so only loads nerdtree if you call :NERDTreeToggle
" (and obviously executes it).
"
" Find way to just download plugin manager in here instead of adding a git
" submodule.

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

call neobundle#begin(expand('~/.vim/bundle/'))

" Let NeoBundle manage NeoBundle.
" Required:
NeoBundleFetch 'Shougo/neobundle.vim'

" :NeoBundleList          - list configured bundles
" :NeoBundleInstall(!)    - install (update) bundles
" :NeoBundleClean(!)      - confirm (or auto-approve) remove of unused bundles

" List of bundles.
for file in split(glob('~/.vim/bundles-*.vim'), '\n')
    exe 'source' file
endfor

" Why not?
NeoBundleLazy 'mattn/flappyvird-vim'

call neobundle#end()

" Required:
filetype plugin indent on

" Check for any uninstalled bundles on startup.
" NeoBundleCheck

" Bundle & miscellaneous settings.
for file in split(glob('~/.vim/settings-*.vim'), '\n')
    exe 'source' file
endfor
