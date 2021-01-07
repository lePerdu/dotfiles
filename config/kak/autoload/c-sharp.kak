hook global BufCreate .*\.cs %{
    set-option buffer filetype c-sharp
}

# Initialization
# ‾‾‾‾‾‾‾‾‾‾‾‾‾‾

hook global WinSetOption filetype=c-sharp %{
    require-module c-sharp

    # cleanup trailing whitespaces when exiting insert mode
    hook window ModeChange pop:insert:.* -group c-sharp-trim-indent %{ try %{ execute-keys -draft <a-x>s^\h+$<ret>d } }
    hook window InsertChar \n -group c-sharp-indent c-sharp-indent-on-new-line
    hook window InsertChar \{ -group c-sharp-indent c-sharp-indent-on-opening-curly-brace
    hook window InsertChar \} -group c-sharp-indent c-sharp-indent-on-closing-curly-brace

    hook -once -always window WinSetOption filetype=.* %{ remove-hooks window c-sharp-.+ }
}

hook -group c-sharp-highlight global WinSetOption filetype=c-sharp %{
    add-highlighter window/c-sharp ref c-sharp
    hook -once -always window WinSetOption filetype=.* %{ remove-highlighter window/c-sharp}
}


provide-module c-sharp %§

add-highlighter shared/c-sharp regions
add-highlighter shared/c-sharp/code default-region group
# regular string
add-highlighter shared/c-sharp/string region %{(?<!['@$])"} %{(?<!\\)(\\\\)*"} fill string
# verbatim string
# add-highlighter shared/c-sharp/verbatim_string region %{(?<!['$])@"} %{(?<!")("")*"} fill string
# interpolated string
# add-highlighter shared/c-sharp/interp_string region %{(?<!['@])\$"} %{(?<!")("")*"} regions
# add-highlighter shared/c-sharp/interp_string/string default-region fill string
# # TODO Can we highlight like normal inside this region (e.g. with ref c-sharp)
# add-highlighter shared/c-sharp/interp_string/interpolation region -recurse "\{" "\{" "\}" fill Default
add-highlighter shared/c-sharp/comment region /\* \*/ fill comment
add-highlighter shared/c-sharp/line_comment region // $ fill comment

add-highlighter shared/c-sharp/code/ regex "'([^']|\\.)'" 0:value
# floating point literals
add-highlighter shared/c-sharp/code/ regex "\b([0-9_]*\.[0-9_]+|[0-9_]+(\.[0-9_]*)?)([eE][-+]?\d+)?[dDfFmM]?" 0:value
# integer literals
# (includes hexadecimal, binary, and size modifiers)
add-highlighter shared/c-sharp/code/ regex "\b([0-9_]+|0[xX][0-9a-fA-F_]+|0[bB][01_]+)([uU][lL]?|[lL][uU]?)?" 0:value
add-highlighter shared/c-sharp/code/ regex "\b(this|true|false|null)\b" 0:value
add-highlighter shared/c-sharp/code/ regex "\b(void|var|byte|sbyte|short|ushort|int|int|uint|long|ulong|float|double|decimal|bool|char|object|string|dynamic)\b" 0:type
add-highlighter shared/c-sharp/code/ regex "\b(if|else|switch|case|do|for|foreach|in|while|break|continue|default|goto|return|yield|throw|catch|finally|checked|unchecked|fixed|lock)\b" 0:keyword
add-highlighter shared/c-sharp/code/ regex "\b(abstract|async|const|event|extern|in|out|override|internal|private|protected|public|readonly|ref|sealed|static|unsafe|virtual|volatile)\b" 0:attribute
add-highlighter shared/c-sharp/code/ regex "\b(namespace|using|alias)\b" 0:module
add-highlighter shared/c-sharp/code/ regex "\b(class|enum|interface|struct|where)\b" 0:type
add-highlighter shared/c-sharp/code/ regex "\b(await|delegate|is|nameof|new|sizeof|stackalloc)\b" 0:operator
# verbatim identifier
add-highlighter shared/c-sharp/code/ regex "(?<!\w)@\w+\b" 0:Default
# verbatim string

# Commands
# ‾‾‾‾‾‾‾‾

define-command -hidden c-sharp-indent-on-new-line %~
    evaluate-commands -draft -itersel %=
        # preserve previous line indent
        try %{ execute-keys -draft <semicolon>K<a-&> }
        # indent after lines ending with { or (
        try %[ execute-keys -draft k<a-x> <a-k> [{(]\h*$ <ret> j<a-gt> ]
        # cleanup trailing white spaces on the previous line
        try %{ execute-keys -draft k<a-x> s \h+$ <ret>d }
        # align to opening paren of previous line
        try %{ execute-keys -draft [( <a-k> \A\([^\n]+\n[^\n]*\n?\z <ret> s \A\(\h*.|.\z <ret> '<a-;>' & }
        # copy // comments prefix
        try %{ execute-keys -draft <semicolon><c-s>k<a-x> s ^\h*\K/{2,} <ret> y<c-o>P<esc> }
        # indent after a switch's case/default statements
        try %[ execute-keys -draft k<a-x> <a-k> ^\h*(case|default).*:$ <ret> j<a-gt> ]
        # indent after keywords
        try %[ execute-keys -draft <semicolon><a-F>)MB <a-k> \A(if|else|while|for|try|catch)\h*\(.*\)\h*\n\h*\n?\z <ret> s \A|.\z <ret> 1<a-&>1<a-space><a-gt> ]
    =
~

define-command -hidden c-sharp-indent-on-opening-curly-brace %[
    # align indent with opening paren when { is entered on a new line after the closing paren
    try %[ execute-keys -draft -itersel h<a-F>)M <a-k> \A\(.*\)\h*\n\h*\{\z <ret> s \A|.\z <ret> 1<a-&> ]
]

define-command -hidden c-sharp-indent-on-closing-curly-brace %[
    # align to opening curly brace when alone on a line
    try %[ execute-keys -itersel -draft <a-h><a-k>^\h+\}$<ret>hms\A|.\z<ret>1<a-&> ]
]

§