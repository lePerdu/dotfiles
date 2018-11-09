# Kakoune Material color scheme
#

evaluate-commands %sh{
    primary="rgb:6200ee"
    secondary="rgb:03dac5"

    black="rgb:252525"
    red="rgb:ff5252"
    green="rgb:c3d82c"
    yellow="rgb:ffc135"
    blue="rgb:42a5f5"
    magenta="rgb:d81b60"
    cyan="rgb:00acc1"
    white="rgb:f5f5f5"
    gray="rgb:708284"

    # foreground="rgb:a1b0b8"
    # background="rgb:263238"
    foreground=$white
    background=default
    cursor=$cyan
    comment="rgb:a1b0b8"
    selection="rgb:3a4d56"

    wrap_guide=$black
    indent_guide=$black
    invisible_guide=$black

    search='rgb:23616c'

    gutter_fg=$comment
    gutter_bg=$background

    echo "
        # For Code
        face global value $yellow
        face global type $cyan
        face global variable $yellow
        face global module $blue
        face global function $blue
        face global string $green
        face global keyword $red
        face global operator $magenta
        face global attribute $yellow
        face global comment $comment+i
        face global meta $magenta
        face global builtin $cyan

        # For markup
        face global title $green+bu
        face global header $blue+u
        face global bold default+b
        face global italic default+i
        face global mono $cyan
        face global block $green
        face global link $cyan
        face global bullet $yellow
        face global list $red

        # builtin faces
        face global Default $foreground,$background
        face global PrimarySelection default,$selection+g
        face global SecondarySelection default,$selection+dga
        face global PrimaryCursor $black,$cursor+fg
        face global SecondaryCursor $black,$white+fg
        face global PrimaryCursorEol $black,$blue+fg
        face global SecondaryCursorEol $black,$gray+fg
        face global LineNumbers $gutter_fg,$gutter_bg
        face global LineNumberCursor $foreground,$gutter_bg+b
        face global LineNumbersWrapped $red,$gutter_bg+i
        face global MenuForeground $primary,$black
        face global MenuBackground $foreground,$black
        face global MenuInfo $secondary,$black
        face global Information $primary,$black
        face global Error $black,$red+b
        face global StatusLine $white,$black
        face global StatusLineMode $secondary
        face global StatusLineInfo $primary
        face global StatusLineValue $primary
        face global StatusCursor $black,$cursor
        face global Prompt $foreground,default
        face global MatchingChar $cyan+bf
        face global BufferPadding $red
        face global Whitespace default,default+d

        # For search-highlight
        face global Search default,$search+g
        face global PrimarySelectionSearch default,$selected+g
        face global PrimarySelectionDefault default,$selection+g

        face global AutowrapColumn $red,$wrap_guide
    "
}

