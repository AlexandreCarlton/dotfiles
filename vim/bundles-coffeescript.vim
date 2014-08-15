" Coffeescript Bundles

let g:coffee_context = {
\   'autoload': {
\       'filename_patterns': ['\.coffee$']
\   }
\ }


" Add CoffeeScript compilation support
NeoBundleLazy 'kchmck/vim-coffee-script', g:coffee_context

" CoffeeScript indent and syntax highlighting
NeoBundleLazy 'mintplant/vim-literate-coffeescript', g:coffee_context
