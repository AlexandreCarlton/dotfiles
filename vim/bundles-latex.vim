" LaTeX Bundles

let g:latex_context = {
\     'autoload': {
\         'filetypes': ['plaintex', 'context', 'latex', 'rnoweb']
\     }
\ }

" LaTeX Plugin 
NeoBundleLazy 'LaTeX-Box-Team/LaTeX-Box', g:latex_context

" TeX plugin (requires LaTeX-Box)
" NeoBundleLazy 'coot/atp_vim', g:latex_context
