# Completions for xbps-reconfigure

# Autogenerated from man page /usr/share/man/man1/xbps-reconfigure.1
complete -c xbps-reconfigure -s a -l all \
    --description 'Configures all packages.'
complete -c xbps-reconfigure -s C -l config -r \
    --description 'Specifies a path to the XBPS configuration directory.'
complete -c xbps-reconfigure -s d -l debug \
    --description 'Enables extra debugging shown to stderr.'
complete -c xbps-reconfigure -s f -l force \
    --description 'Forcefully reconfigure package even if it was configured previously.'
complete -c xbps-reconfigure -s h -l help \
    --description 'Show the help message.'
complete -c xbps-reconfigure -s i -l ignore -r -f \
    -a "(xbps-query -l | sed -e 's/.. \([ \t\n]\+\)-.*/\1/')" \
    --description 'Ignore PKG when configuring all packages with a, Fl -all.'
complete -c xbps-reconfigure -s r -l rootdir -r \
    --description 'Specifies a path for the target root directory.'
complete -c xbps-reconfigure -s v -l verbose \
    --description 'Enables verbose messages.'
complete -c xbps-reconfigure -s V -l version \
    --description 'Show the version information.  El FILES -tag -width /var/db/xbps/.'

