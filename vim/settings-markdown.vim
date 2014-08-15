" Markdown (Bundle) Settings

" Set relevant files with markdown extensions to be MarkDown.
au BufNewFile,BufRead *.md,*.mkd,*markdown set filetype=markdown

" Spell check markdown files.
autocmd FileType markdown set spell
