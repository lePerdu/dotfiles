
source "%val{config}/plugins/plug.kak/rc/plug.kak"

# Have plug.kak manage itself
plug kakoune-git "andreyorst/plug.kak" noload

# Editing helpers
plug "alexherbo2/auto-pairs.kak" %{
    set-option global auto_pairs ( ) [ ] { } ` ` '"' '"' "'" "'"
    hook global WinCreate .* %{ auto-pairs-enable }
}

plug "alexherbo2/move-line.kak" %{
    map global normal "<a-'>" ': move-line-above<ret>'
    map global normal "'" ': move-line-below<ret>'
}

# plug "alexherbo2/search-highlighting.kak" %{
#     hook global WinCreate .* %{ search-highlighter-enable }
# }

plug "alexherbo2/snippets.kak"

plug "Delapouite/kakoune-auto-star"
plug "Delapouite/kakoune-auto-percent"

plug "h-youhei/kakoune-surround" %{
    declare-user-mode surround
    # I don't use view mode that much and view lock mode is more useful anyway
    map global normal v ': enter-user-mode surround<ret>'
    map global surround s ': surround<ret>' -docstring 'surround'
    map global surround c ': change-surround<ret>' -docstring 'change'
    map global surround d ': delete-surround<ret>' -docstring 'delete'
    map global surround t ': select-surrounding-tag<ret>' \
        -docstring 'select tag'
}

# My implementation is better
# TODO Submit PR to this
# plug "https://github.com/alexherbo2/space-indent.kak"

# Commands
plug "alexherbo2/write-parent-directories.kak" %{
    hook global WinCreate .* %{ write-parent-directories-enable }
}
plug "Delapouite/kakoune-cd"
plug "occivink/kakoune-sudo-write"

# Languages
plug "ul/kak-lsp" noload do %{ rustup run stable cargo build --release } %{
    evaluate-commands %sh{
        $kak_config/plugins/kak-lsp/target/release/kak-lsp \
            --kakoune -s $kak_session -c $kak_config/kak-lsp.toml
    }

    # Show hover information
    map global user h ': lsp-hover<ret>' -docstring 'LSP hover'
    map global normal <a-,> ': enter-user-mode lsp<ret>'

    define-command -hidden setup-auto-format %{
        hook window BufWritePre .* lsp-formatting-sync
    }

    hook global WinSetOption filetype=(rust|python||typescript|c|cpp|java) %{
        lsp-auto-signature-help-enable
        set-option window lsp_auto_highlight_references true
        lsp-enable-window
    }

    hook global WinSetOption filetype=(javascript|haskell) %{
        lsp-enable-window
    }
}

# Other
plug "lenormf/kakoune-extra"
plug "Delapouite/kakoune-palette"
# plug "alexherbo2/edit-directory.kak" %{
#     hook global WinCreate .* %{ edit-directory-enable }
# }
plug "https://gitlab.com/Screwtapello/kakoune-state-save"

plug "lePerdu/kakboard" %{
    # Have to custom map <a-d> and <a-c> with the swapped behavior
    set-option global kakboard_copy_keys y
    hook global WinCreate .* %{
        kakboard-enable

        map global normal <a-d> ': kakboard-with-push-clipboard d'
        map global normal <a-c> ': kakboard-with-push-clipboard c'
    }
}

# Colorschemes
# plug "https://github.com/rubberydub/nord-kakoune.git"
# colorscheme onedark
colorscheme onedark
