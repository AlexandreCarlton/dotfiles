" Haskell Bundles

let g:haskell_context = {
\   'autoload': {
\       'filetypes': ['haskell']
\   }
\ }

" Haskell plugins
NeoBundleLazy 'dag/vim2hs', g:haskell_context

" Haskell plugin to display error messages
NeoBundleLazy 'eagletmt/ghcmod-vim', {
\     'autoload': {
\         'filetypes': ['haskell']
\     },
\     'depends': 'Shougo/vimproc.vim',
\     'external_commands': 'ghc-mod'
\ }

" Completion plugin for Haskell using ghc-mod
NeoBundleLazy 'eagletmt/neco-ghc' , {
\   'autoload': {
\       'filetypes': ['haskell']
\   },
\   'external_commands': 'ghc-mod',
\   'rtp': 'necoghc'
\ }

" Hoogle (Haskell query plugin)
NeoBundleLazy 'Twinside/vim-hoogle', g:haskell_context
