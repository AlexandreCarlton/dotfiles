#!/bin/env python3
'''Display configurable colours from the config file
to be copy+pasted into ~/.Xresources.'''

from configparser import ConfigParser

XRESOURCES_FILENAME = "~/.Xresources"
CONFIG_FILENAME = "Xresources_colours.cfg"

CONVERSIONS = {
    'black': 'color0',
    'red': 'color1',
    'green': 'color2',
    'yellow': 'color3',
    'blue': 'color4',
    'magenta': 'color5',
    'cyan': 'color6',
    'white': 'color7',
    'bright black': 'color8',
    'bright red': 'color9',
    'bright green': 'color10',
    'bright yellow': 'color11',
    'bright blue': 'color12',
    'bright magenta': 'color13',
    'bright cyan': 'color14',
    'bright white': 'color15'
}


def get_colours(theme):
    '''Replace colours in XRESOURCES with ones in theme.'''
    parser = ConfigParser()
    parser.read(CONFIG_FILENAME)
    if theme not in parser:
        raise ValueError("Theme '{}' not in {}.".format(theme, CONFIG_FILENAME))
    else:
        files = parser[theme]
        converted = {CONVERSIONS.get(colour, colour): value
                     for colour, value in files.items()}
        return converted


def formatted_colours(theme):
    '''Replace given lines in file with keys'''
    colours = get_colours(theme)
    formatted = "\n".join("*{}: {}".format(colour, value)
                          for colour, value in colours.items())
    title = "! {t} theme generated from {f}".format(t=theme, f=CONFIG_FILENAME)
    return "{t}\n{f}".format(t=title, f=formatted)


def main(theme):
    '''Print out formatted colours'''
    colours = formatted_colours(theme)
    print(colours)


if __name__ == '__main__':
    from sys import argv
    if len(argv) < 2:
        raise ValueError("Please supply a valid theme.")
    main(argv[1])
