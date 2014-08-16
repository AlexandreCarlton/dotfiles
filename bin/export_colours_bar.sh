#!/bin/sh

# Not sure how to better maintain this.
#
# Oh, I know! This is the 'base' script, and it just echoes stuff to the prompt; you can then modify this code later (add a in argb, delete hashtags, etc)

$(xrdb -query |\
    egrep "^(URxvt)?\*(\.)?(color[0-9]+|(fore|back)ground)" |\
    sed -e 's/URxvt\*/\*/g' | sed -e 's/\*//g' |\
    sed -e 's/:[\t ]\+/=/g' |\
    sed -e 's/^/export /g' |\
    sed -e 's/#/#ff/g')

export black=$color0
export red=$color1
export green=$color2
export yellow=$color3
export blue=$color4
export magenta=$color5
export cyan=$color6
export white=$color7
export bright_black=$color8
export bright_red=$color9
export bright_green=$color10
export bright_yellow=$color11
export bright_blue=$color12
export bright_magenta=$color13
export bright_cyan=$color14
export bright_white=$color15
