#!/bin/sh

# Takes a screenshot, pixelates it and uses it as an image for i3lock.

# Dependencies:
# - ImageMagick (convert, import)
# - i3lock
# - scrot (optional - faster screenshot, look into -thumb - already scales down.)


screenshot=/tmp/screenshot.png
screenshot_thumb=/tmp/screenshot-thumb.png
screenshot_pixelated=/tmp/screenshot-pixelated.png

SCALE=10


if [ -x /usr/bin/scrot ]; then
    scrot --thumb="$SCALE" "$screenshot"
else
    import -window root "$screenshot"
    convert -scale "$SCALE%" "$screenshot" "$screenshot_thumb"
fi

convert -scale "$(( 10000 / $SCALE ))%" "$screenshot_thumb" "$screenshot_pixelated"

i3lock --ignore-empty-password \
       --no-unlock-indicator \
       --nofork \
       --image="$screenshot_pixelated"
