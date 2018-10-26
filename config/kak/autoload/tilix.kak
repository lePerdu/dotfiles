# Tilix split commands

hook global KakBegin .* %{
    evaluate-commands %sh{
        if [ -n "$TILIX_ID" ]; then
            echo "alias global new tilix-new-horizontal"
            echo "alias global vnew tilix-new-vertical"
            echo "alias global focus tilix-focus"
        fi
    }
}

## Temporarily override the default client creation command
define-command -hidden tilix-new-impl -params 1.. %{
    evaluate-commands %sh{
        if [ -z "$TILIX_ID" ]; then
            echo "echo -markup {Error}This command must be run in a tilix session"
            exit
        fi

        session_type="$1"
        shift
        [ $# -gt 0 ] && kakoune_params="-e '$@'"
        tilix -a "$session_type" -e \
            "env TMPDIR='${TMPDIR}' kak -c ${kak_session} ${kakoune_params}" \
            </dev/null >/dev/null 2>&1 &
    }
}

define-command tilix-new-horizontal -params .. -command-completion \
        -docstring "Split the current pane horizontally to the right" %{
    tilix-new-impl 'session-add-right' %arg{@}
}

define-command tilix-new-vertical -params .. -command-completion \
        -docstring "Split the current pane vertically below" %{
    tilix-new-impl 'session-add-down' %arg{@}
}

define-command tilix-focus -params 1 -docstring "" %{
    echo "Unimplemented"
}

