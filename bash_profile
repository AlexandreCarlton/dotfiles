
EDITOR=vim

if [ -d ~/.shell_prompt.sh ]; then
    source ~/.shell_prompt.sh
fi

alias ls="ls -Glah"

alias ack=ack-grep

cs() { cd "$1" && ls; }
