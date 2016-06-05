# [Neo]Vim config

This configuration makes no effort to check if the correct version of Vim is
installed; it is assumed you have the latest one.

If you do not have root access and need to install it, you can manually install
it:

```bash
git clone https://github.com/vim/vim.git
cd vim
./configure --prefix="${HOME}/.local" \
  --with-features=huge \
  --enable-multibyte \
  --enable-rubyinterp \
  --enable-pythoninterp \
  --with-python-config-dir="${HOME}/.local/lib/python2.7/config" \
  --enable-cscope \
  --enable-gui=no
make
make install
```

(Notice that I don't enable perl; I'm pretty sure I don't use an extension that requires it.)

If you get an error like:

```
checking size of off_t... configure: error: in `/home/alexandre/Code/vim/src':
configure: error: cannot compute sizeof (off_t)
See `config.log' for more details.
```

You should be able to resolve it with iconv:

```bash
wget http://ftp.gnu.org/pub/gnu/libiconv/libiconv-1.14.tar.gz
tar xvzf libiconv-1.14.tar.gz
cd libiconv-1.14
./configure --prefix="${HOME}/.local"
make
make install
```

Ensure that `${HOME}/.local/lib` is in your `${PATH}`.
