# Kakoune OneDark color scheme
#

evaluate-commands %sh{

    black="rgb:000000"
    red="rgb:e06c75"
    green="rgb:98c379"
    yellow="rgb:d19a66"
    blue="rgb:61aeee"
    magenta="rgb:c678dd"
    cyan="rgb:56b6c2"
    white="rgb:abb2bf"

    # Bright colors (most of these are the same)
    black_bright="rgb:5c6370"
    red_bright="rgb:e06c75"
    green_bright="rgb:98c379"
    yellow_bright="rgb:d19a66"
    blue_bright="rgb:62afee"
    magenta_bright="rgb:c678dd"
    cyan_bright="rgb:56b6c2"
    white_bright="rgb:ffffff"

	comment_gray="$black_bright"

    background="rgb:282c34"
    foreground="$white"
    fg_dark="$background"
    cursor="rgb:528bff"
    guide="rgb:3b4048"
	gutter="rgb:636d83"
    # search="rgb:979daa"
	# search="rgb:4774ce"
	search="rgb:324264"
	visual="rgb:3e4451"
	menu="rgb:3e4452"

	echo "
		# For Code
		face global value $yellow
		face global type $yellow_bright
		face global variable $yellow
		face global module blue
		face global function $blue
		face global string $green
		face global keyword $red
		face global operator $magenta
		face global attribute green
		face global comment $comment_gray+i
		face global meta $magenta
		face global builtin $cyan

		# For markup
		face global title $blue
		face global header $cyan
		face global bold $red
		face global italic $yellow
		face global mono $green
		face global block $magenta
		face global link $cyan
		face global bullet $cyan
		face global list $yellow

		# builtin faces
		face global Default $foreground,$background
		face global PrimarySelection default,$visual
		face global SecondarySelection $white,$visual
		face global PrimaryCursor $fg_dark,$cursor
		face global SecondaryCursor $fg_dark,$white
		face global PrimaryCursorEol $fg_dark,$cyan
		face global SecondaryCursorEol $fg_dark,$white
		face global LineNumbers $gutter,default
		face global LineNumberCursor $gutter,default+b
		face global MenuForeground $blue,$menu
		face global MenuBackground $foreground,$menu
		face global MenuInfo $cyan
		face global Information $cursor,$menu
		face global Error $black,$red
		face global StatusLine $blue,$background
		face global StatusLineMode $yellow,default
		face global StatusLineInfo $blue,default
		face global StatusLineValue $green,default
		face global StatusCursor $black,$cyan
		face global Prompt $green,default
		face global MatchingChar $blue,default+b
		face global BufferPadding $white_bright,$background

		face global Search default,$search
		face global PrimarySelectionSearch default,$visual
		face global PrimarySelectionDefault default,$visual

		face global AutowrapColumn $red,$guide
	"
}

