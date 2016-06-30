#!/bin/sh

. libs-install-from-source.sh

# We install stow, libtool, xz and tar since they're pretty crucial for the rest
install_binary 'stow' '2.2.2'
install_binary 'libtool' '2.4.6'

install_binary 'xz' '5.2.2'
install_binary 'tar' '1.29' \
  CPPFLAGS='-fgnu89-inline'

# If we want Vim using a modern Python we should install one.
install_binary 'python' '2.7.12'
install_binary 'python' '3.5.2'

install_binary 'libevent' '2.0.22'
install_binary 'tmux' '2.2' \
  CFLAGS="-I${PREFIX}/include" \
  LDFLAGS="-L${PREFIX}/lib"

install_binary 'pcre' '8.39' \
  --enable-unicode-properties \
  --enable-pcre16 \
  --enable-pcre32 \
  --enable-pcregrep-libz \
  --enable-pcregrep-libbz2 \
  --enable-jit
install_binary 'the_silver_searcher' '0.32.0'

install_binary 'libiconv' '1.14'
install_binary 'vim' '7.4' \
  --with-features=huge \
  --enable-multibyte \
  --enable-rubyinterp \
  --enable-pythoninterp \
  --with-python-config-dir="${HOME}/.local/lib/python2.7/config" \
  --with-python-config-dir="${HOME}/.local/lib/python3.5/config-3.5m" \
  --enable-luainterp \
  --enable-cscope \
  --disable-gui \
  --without-x
  # --enable-perlinterp # Perl support is weird.

install_binary 'zsh' '5.2'
install_binary 'git' '2.9.0'
install_binary 'nodejs' '6.2.2'
