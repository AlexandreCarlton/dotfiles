" Python (Bundle) Settings

" PyMode

" Disable automatic lint checking as Syntastic's is better (supports python3)
" (However, PyMode does have more checkers & checks as you go)
" Syntastic's loc_list automatically closes and syncs with powerline
let g:pymode_lint = 0

" Automatically check as you write (Syntastic doesn't have this)
let g:pymode_lint_on_fly = 1

" Disable autocompletion as Jedi (used in YouCompleteMe) is better.
let g:pymode_rope_completion = 0

" Disable automatic folding
let g:pymode_folding = 0

" Define checkers
let g:pymode_lint_checkers = ['pylint', 'pyflakes', 'pep8', 'mccabe']

" Set error signs to use same as Syntastic's (when refactoring set directly to
" variable)
let g:pymode_lint_error_symbol = '✗'
let g:pymode_lint_comment_symbol = '⚠'
