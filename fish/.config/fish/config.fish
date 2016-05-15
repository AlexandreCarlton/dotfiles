# TODO: Find a way to actually check the function exists, not the file itself.
if test ! -s $HOME/.config/fish/functions/fisher.fish
  curl -fLo $HOME/.config/fish/functions/fisher.fish --create-dirs \
    https://raw.githubusercontent.com/fisherman/fisherman/master/fisher.fish
  if test -s $HOME/.config/fish/fishfile
    fisher update
  end
end
