" HTML & CSS Bundles

let g:html_context = {
\   'autoload': {
\       'filetypes': ['html', 'xhtml', 'css']
\   }
\ }

" CSS3 Syntax support to built-in CSS syntax
NeoBundleLazy 'hail2u/vim-css3-syntax', g:html_context

" Convert CSS-like syntax ( html > body > p{Text} ) to HTML.
NeoBundleLazy 'mattn/emmet-vim', g:html_context

" HTML5 + inline SVG omnicomplete function, indent and ayntax.
NeoBundleLazy 'othree/html5.vim', g:html_context
