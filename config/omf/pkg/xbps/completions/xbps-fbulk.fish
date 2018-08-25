# Completions for xbps-fbulk

# Autogenerated from man page /usr/share/man/man1/xbps-fbulk.1
complete -c xbps-fbulk -s a -l arch -r -f \
    --description 'Set a different target architecture, useful for cross compiling.'
complete -c xbps-fbulk -s j -r -f \
    --description 'Set number of parallel builds running at the same time.  By default set to 1.'
complete -c xbps-fbulk -s l -l logdir -r \
    --description 'Set the log directory.  By default set to `log. <pid>`.'
complete -c xbps-fbulk -s d -l debug \
    --description 'Enables extra debugging shown to stderr.'
complete -c xbps-fbulk -s h -l help \
    --description 'Show the help message.'
complete -c xbps-fbulk -s v -l verbose \
    --description 'Enables verbose messages.'
complete -c xbps-fbulk -s V -l version \
    --description 'Show the version information.'

