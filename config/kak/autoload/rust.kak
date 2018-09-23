
hook global BufSetOption filetype=rust %{
    set-option buffer makecmd "cargo build"
    # Don't auto-pair single quotes because rust uses them for lifetimes
    set-option buffer auto_pairs ( ) [ ] { } < > " "
}

