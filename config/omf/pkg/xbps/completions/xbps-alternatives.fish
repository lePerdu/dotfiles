# Completions for xbps-alternatives

# Autogenerated from man page /usr/share/man/man1/xbps-alternatives.1
complete -c xbps-alternatives -s C -l config -r \
    --description 'Specifies a path to the XBPS configuration directory.'
complete -c xbps-alternatives -s d -l debug \
    --description 'Enables extra debugging shown to stderr.'
complete -c xbps-alternatives -s g -l group -r -f \
    -a "(xbps-alternatives -l | grep '^\w')" \
    --description 'Alternative group name to match.  To be used with the set mode.'
complete -c xbps-alternatives -s h -l help \
    --description 'Show the help message.'
complete -c xbps-alternatives -s r -l rootdir \
    -a "(__fish_complete_directories '' '' )" \
    --description 'Specifies a full path for the target root directory.'
complete -c xbps-alternatives -s v -l verbose \
    --description 'Enables verbose messages.'
complete -c xbps-alternatives -s V -l version \
    --description 'Show the version information.'

# TODO Filter these by the group specified by -g
complete -c xbps-alternatives -s l -l list -r -f \
    -a "(xbps-alternatives -l | sed -n -e 's/^ - \([^ \t\n]\+\)\( (\(current\))\)\?/\1\t\3/p')" \
    --description 'Lists all current alternative groups or only from PKG, or just a specific gro…'
complete -c xbps-alternatives -s s -l set -r -f \
    -a "(xbps-alternatives -l | sed -n -e 's/^ - \([^ \t\n]\+\)\( (\(current\))\)\?/\1\t\3/p')" \
    --description 'Set alternative groups specified by PKG or just a specific group, if the g Fl…'

