# Kakoune OneDark color scheme
#

evaluate-commands %sh{
	red="rgb:e06c75"
	dark_red="rgb:be5046"
	green="rgb:98c379"
	yellow="rgb:e5c07b"
	dark_yellow="rgb:d19a66"
	blue="rgb:61afef"
	purple="rgb:c678dd"
	cyan="rgb:56b6c2"
	white="rgb:abb2bf"
	black="rgb:282c34"

	comment_gray="rgb:5c6370"
	gutter_fg_gray="rgb:4b5263"
	cursor_gray="rgb:2c323c"
	visual_gray="rgb:3e4452"
	menu_gray="rgb:3e4452"
	special_gray="rgb:3b4048"
	vertsplit="rgb:181a1f"

	echo "
		# For Code
		face global value $dark_yellow
		face global type $yellow
		face global variable $yellow
		face global module blue
		face global function $blue
		face global string $green
		face global keyword $red
		face global operator $purple
		face global attribute green
		face global comment $comment_gray+i
		face global meta $purple
		face global builtin $cyan

		# For markup
		face global title blue
		face global header cyan
		face global bold red
		face global italic yellow
		face global mono green
		face global block magenta
		face global link cyan
		face global bullet cyan
		face global list yellow

		# builtin faces
		face global Default default,$black
		face global PrimarySelection default,$visual_gray
		face global SecondarySelection $white,$visual_gray
		face global PrimaryCursor $black,$blue
		face global SecondaryCursor $black,$white
		face global PrimaryCursorEol $black,$cyan
		face global SecondaryCursorEol $black,$cyan
		face global LineNumbers $gutter_fg_gray,default
		face global LineNumberCursor $gutter_fg_gray,default+b
		face global MenuForeground white,$menu_gray
		face global MenuBackground $menu_gray,white
		face global MenuInfo cyan
		face global Information $black,$dark_yellow
		face global Error $black,$red
		face global StatusLine $blue,default
		face global StatusLineMode yellow,default
		face global StatusLineInfo blue,default
		face global StatusLineValue green,default
		face global StatusCursor black,cyan
		face global Prompt $green,default
		face global MatchingChar $blue,default+b
		face global BufferPadding $special_gray,default

		face global Search default,$dark_yellow
		face global AutowrapColumn $red,$cursor_gray
	"
}

