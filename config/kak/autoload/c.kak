
hook global BufSetOption filetype=c %{
    set-option buffer auto_pairs ( ) [ ] { } '"' '"' "'" "'"
}

