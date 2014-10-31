
" Automatic installation {{{
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !mkdir -p ~/.vim/autoload
    silent !curl -fLo ~/.vim/autoload/plug.vim https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall
endif
" }}}

autocmd FileType vim set foldmethod=marker

" Neovim-specific settings {{{
if has('nvim')
    runtime! plugin/python_setup.vim
endif
" }}}

call plug#begin()

" Note that certain plugins like NerdTree and Tagbar don't work well lazily -
" need more fiddling.

" List of bundles.
for file in split(glob('~/.vim/bundles-*.vim'), '\n')
    exe 'source' file
endfor

" Why not?
Plug 'mattn/flappyvird-vim', { 'on': 'FlappyVird' }

call plug#end()

" Bundle & miscellaneous settings.
for file in split(glob('~/.vim/settings-*.vim'), '\n')
    exe 'source' file
endfor
