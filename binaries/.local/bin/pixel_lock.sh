#!/bin/sh

# Takes a screenshot, pixelates it and uses it as an image for i3lock.

# Dependencies:
# - GraphicsMagick (faster than ImageMagick
# - i3lock
# - scrot


screenshot=$(mktemp --tmpdir XXXX.png)
scrot "${screenshot}"
gm mogrify -scale 10% -scale 1005% "${screenshot}"
i3lock --ignore-empty-password \
       --no-unlock-indicator \
       --nofork \
       --image="$screenshot"
rm "$screenshot"
