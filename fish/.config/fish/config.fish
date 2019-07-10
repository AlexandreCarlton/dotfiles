# This is sourced after conf.d/*.

# Tweak the pure theme (requires fisher - https://git.io/fisher)
# brblack is invisible in solarized (dark), so we set the pure theme's colors differently.
set -g pure_color_git_branch (set_color normal)
set -g pure_color_git_dirty (set_color normal)

for aliases in $HOME/.config/fish/aliases/*
  source $aliases
end

stty -ixon
