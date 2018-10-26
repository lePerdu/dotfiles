# Kakoune OneDark color scheme
#

face global value default
face global type
face global variable red
face global module
face function yellow
face string green
face keyword blue
face operator magenta
face attribute blue
face comment
face 

nop %sh{
    red="rgb:EF2929"
    dark_red="rgb:CC0000"
    green="rgb:4E9A06"
    light_green="rgb:8AE234"
    yellow="rgb:FCE94F"
    dark_yellow="rgb:C4A000"
    blue="rgb:729FCF"
    purple="rgb:AD7FA8"
    cyan="rgb:06989A"
    white="rgb:D3D7CF"
    black="rgb:2E3436"
    visual_black="default"
    comment_gray="rgb:888a85"
    cursor_gray="rgb:555753"
    gutter_fg_gray="rgb:babdb6"
    visual_gray="rgb:555753"
    menu_gray="rgb:888a85"
    special_brown="rgb:8f5902"
    vertsplit="rgb:d3d7cf"

	echo "
		# For Code
		face global value $dark_yellow
		face global type $yellow
		face global variable $yellow
		face global module $yellow
		face global function $blue
		face global string $green
		face global keyword $red
		face global operator $purple
		face global attribute rgb:ffffff+B
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
		face global BufferPadding $special_brown,default

		face global Search default,$dark_yellow
		face global AutowrapColumn $red,$cursor_gray
	"
}

