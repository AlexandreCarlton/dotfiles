" Haskell (Bundle) Settings


" neco-ghc
"
" Show detailed information (type) of symbols
let g:necoghc_enable_detailed_browse = 1

" Use omni-completion (YouCompleteMe)
autocmd FileType haskell set omnifunc=necoghc#omnifunc
