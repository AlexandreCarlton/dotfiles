# This is sourced after conf.d/*.

# We wrap stty within `--is-interactive` as fisher will hang otherwise.
if status --is-interactive

  # Tweak the pure theme (requires fisher - https://git.io/fisher)
  # brblack is invisible in solarized (dark), so we set the pure theme's colors differently.
  set -g pure_color_git_branch (set_color normal)
  set -g pure_color_git_dirty (set_color normal)
  # Use green for success; magenta is too similar to red.
  set -g pure_color_prompt_on_success (set_color green)

  for aliases in $HOME/.config/fish/aliases/*
    source $aliases
  end

  # Disable Ctrl-S freezing the terminal
  stty -ixon
end
