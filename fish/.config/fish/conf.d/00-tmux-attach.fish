# Attach to existing tmux session if not already in one, or create one if one does not exist.
# doing this early prevents the original shell from executing everything
# beneath until the user detaches.
if ! set -q TMUX;
  and test "$TERM" != linux;
  and test "$TERMINAL_EMULATOR" != 'JetBrains-JediTerm'
	# if the session 'alexandre' already exists, tmux attaches to it; otherwise, it creates a new one.
  tmux new-session -A -s alexandre
end
