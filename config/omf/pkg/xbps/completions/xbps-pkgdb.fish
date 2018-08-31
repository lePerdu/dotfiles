# Completions for xbps-pkgdb

complete -c xbps-pkgdb \
    -a "(xbps-query -l | sed -e 's/.. \([^ \t\n]\+\)-.*/\1/')"

# Autogenerated from man page /usr/share/man/man1/xbps-pkgdb.1
complete -c xbps-pkgdb -s a -l all \
    --description 'Process all registered packages, regardless of its state.'
complete -c xbps-pkgdb -s C -l config -r \
    --description 'Specifies a path to the XBPS configuration directory.'
complete -c xbps-pkgdb -s d -l debug \
    --description 'Enables extra debugging shown to stderr.'
complete -c xbps-pkgdb -s h -l help \
    --description 'Show the help message.'
complete -c xbps-pkgdb -s m -l mode -r -f \
    -a "auto manual hold unhold repolock repounlock"\
    --description 'Switches PKGNAME to the specified  mode: automatic or manual installation mod…'
complete -c xbps-pkgdb -s r -l rootdir -r \
    --description 'Specifies a full path for the target root directory.'
complete -c xbps-pkgdb -s u -l update \
    --description 'Updates the pkgdb format to the latest version making the necessary conversio…'
complete -c xbps-pkgdb -s v -l verbose \
    --description 'Enables verbose messages.'
complete -c xbps-pkgdb -s V -l version \
    --description 'Show the version information.  El FILES -tag -width /var/db/xbps/.'
