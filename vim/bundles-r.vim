" R Bundles

" Nice mappings and launcher capabilities
let g:install_vimcom = 'sudo R -e "library(devtools); install_github(\"jalvesaq/VimCom\")"'
Plug 'jcfaria/Vim-R-Plugin' , { 'for' : ['r', 'rnoweb'], 'do' : g:install_vimcom }

autocmd FileType r set omnifunc=rcomplete#CompleteR
