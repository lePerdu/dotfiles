# The default filetype detection only includes *.tex
hook global BufCreate .*\.latex %{
    set-option buffer filetype latex
}
