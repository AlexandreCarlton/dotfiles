" Bundles using (c)tags, revolving around TagBar.

" Piece de resistance
" Easily browse tags of source files.
NeoBundle 'majutsushi/tagbar', {
\     'external_commands': 'ctags',
\     'vim_version': '7.0'
\ }

" CoffeeScript support
" `gem install CoffeeTags` also must be done.
NeoBundleLazy 'lukaszkorecki/CoffeeTags', {
\    'autoload': {
\       'filename_patterns': ['\.coffee$']
\    }
\ }
