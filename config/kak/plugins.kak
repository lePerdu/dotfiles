source "%val{config}/plugins/plug.kak/rc/plug.kak"

# Have plug.kak manage itself
plug "andreyorst/plug.kak" noload

# Editing helpers
plug "alexherbo2/auto-pairs.kak" %{
    set-option global auto_pairs ( ) [ ] { } ` ` '"' '"' "'" "'"
}

plug "alexherbo2/move-line.kak" %{
    map global normal "<a-'>" ': move-line-above<ret>'
    map global normal "'" ': move-line-below<ret>'
}

plug "andreyorst/smarttab.kak" defer smarttab %{
    set-option global softtabstop %opt{tabstop}
    hook global BufSetOption tabstop=.* %{
        set-option buffer softtabstop %opt{tabstop}
    }
} %{
    # Set based on indentwidth
    hook global BufSetOption indentwidth=0 noexpandtab
    hook global BufSetOption indentwidth=[1-9].* expandtab

    # Do this by default
	hook global WinCreate .* expandtab
}

plug "alexherbo2/search-highlighting.kak"

# plug "alexherbo2/snippets.kak"

plug "Delapouite/kakoune-auto-star"
plug "Delapouite/kakoune-auto-percent"

# TODO Try to make a better version that does some fancy multiple cursor stuff
# OR have it be implicit, based on selection size / context
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

# Commands

# plug "alexherbo2/write-parent-directories.kak" %{
#     hook global WinCreate .* %{ write-parent-directories-enable }
# }

# plug "Delapouite/kakoune-cd"
plug "occivink/kakoune-sudo-write"

# Languages
plug "ul/kak-lsp" noload do %{ cargo +stable build --release } %{
    evaluate-commands %sh{
        $kak_config/plugins/kak-lsp/target/release/kak-lsp \
            --kakoune -s $kak_session -c $kak_config/kak-lsp.toml
    }

    # Show hover information
    map global user h ': lsp-hover<ret>' -docstring 'LSP hover'
    map global normal <a-,> ': enter-user-mode lsp<ret>'

    # Keep this in sync with indentwidth
    # TODO Make an issue on the project for this?
    hook global WinSetOption indentwidth=0 %{
        set-option window lsp_insert_spaces false
    }

    hook global WinSetOption indentwidth=[1-9].* %{
        set-option window lsp_insert_spaces true
    }

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
plug "lenormf/kakoune-extra" subset %{
    # This project is not being maintained anymore, but there are a couple
    # nice things in it
    # TODO Move these into my own config / a new plugin / new plugins

    autodownload.kak
    # autosplit.kak
    # cdmenu.kak
    comnotes.kak
    dictcomplete.kak
    # dvtm.kak
    # fzf.kak
    # fzy.kak
    # grepmenu.kak
    # hatch_terminal.kak
    idsession.kak
    # lineindent.kak
    # overstrike.kak
    # readline.kak
    # searchmarks.kak
    # syntastic.kak
    # tldr.kak
    # utils.kak
    # vcs.kak
    # versioncheck.kak
} %{
    hook global KakBegin .* idsession
}

# plug "Delapouite/kakoune-palette"

plug "https://gitlab.com/Screwtapello/kakoune-state-save"

plug "lePerdu/kakboard" %{
    # Have to custom map <a-d> and <a-c> with the swapped behavior
    set-option global kakboard_copy_keys y
    hook global WinCreate .* %{
        kakboard-enable

        map global normal <a-d> ': kakboard-with-push-clipboard d<ret>'
        map global normal <a-c> ': kakboard-with-push-clipboard c<ret>'
    }
}

# Colorschemes
# plug "https://github.com/rubberydub/nord-kakoune.git"
# colorscheme onedark
colorscheme onedark
