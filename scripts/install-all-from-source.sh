#!/bin/sh

. libs-install-from-source.sh

install_binary 'stow' '2.2.2'

install_binary 'xz' '5.2.2'
install_binary 'tar' '1.29'

install_binary 'libevent' '2.0.22'
install_binary 'tmux' '2.2'

install_binary 'pcre' '8.39' \
  --enable-unicode-properties \
  --enable-pcre16 \
  --enable-pcre32 \
  --enable-pcregrep-libz \
  --enable-pcregrep-libbz2
install_binary 'the_silver_searcher' '0.32.0'

install_binary 'vim' '7.4.1916' \
  --with-features=huge \
  --enable-multibyte \
  --enable-rubyinterp \
  --enable-pythoninterp \
  --with-python-config-dir="${HOME}/.local/lib/python2.7/config" \
  --enable-luainterp \
  --enable-cscope \
  --disable-gui \
  --without-x
  # --enable-perlinterp # Perl support is weird.

install_binary 'zsh' '5.2'
