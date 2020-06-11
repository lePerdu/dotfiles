define-command -docstring 'write all buffers and quit current client' \
write-quit-all %{
    write-all
    quit
}

# Fuzzy find
define-command -params 1 \
    -shell-script-candidates 'fd' \
find %{
    edit %arg{1}
}

# Bindings for common commands
map global user w ': write<ret>'
map global user W ': write!<ret>'
map global user z ': write-quit-all<ret>'
map global user q ': quit!<ret>'
map global user e ':edit '
map global user f ':find '

# Don't copy on delete by default
map global normal d <a-d>
map global normal <a-d> d
map global normal c <a-c>
map global normal <a-c> c

# Non-shifted <a-j> moves the cursor to the joining point and shiften <a-J>
# moves the cursor
map global normal <a-j> <a-J>
map global normal <a-J> <a-j>

# Falling-back wrapper around comment-line
# TODO Put this and try-comment-block into a plugin
define-command -hidden try-comment-line %{
    try %{
        comment-line
    } catch %{
        execute-keys "<a-x><a-s>_"
        comment-block
    }
}

# Mappings for (un)commenting code
# Each style falls backs to the other if it is not defined
map global user c ': try comment-line catch try-comment-line<ret>' \
    -docstring 'Comment line(s)'
map global user C ': try comment-block catch comment-line<ret>' \
     -docstring 'Comment block'

# Use <tab> and <s-tab> during completion
hook global InsertCompletionShow .* %{
    try %{
        # this command temporarily removes cursors preceded by whitespace;
        # if there are no cursors left, it raises an error, does not
        # continue to execute the mapping commands, and the error is eaten
        # by the `try` command so no warning appears.
        execute-keys -draft 'h<a-K>\h<ret>'
        map window insert <tab> <c-n>
        map window insert <s-tab> <c-p>
    }
}

hook global InsertCompletionHide .* %{
    unmap window insert <tab> <c-n>
    unmap window insert <s-tab> <c-p>
}
