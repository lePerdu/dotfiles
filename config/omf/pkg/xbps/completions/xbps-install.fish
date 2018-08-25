# Completions for xbps-install

# TODO Show descriptions too
complete -c xbps-install \
    -a "(xbps-query -Rs '' | sed -e 's/^\[.\] \([^ \t\n]\+\)-.*/\1/')"

# Autogenerated from man page /usr/share/man/man1/xbps-install.1 (and added to
# manually)
complete -c xbps-install -s A -l automatic \
    --description 'Enables automatic installation mode.'
complete -c xbps-install -s C -l config -r \
    -a "(__fish_complete_directories '' '')" \
    --description 'Specifies a path to the XBPS configuration directory.'
complete -c xbps-install -s c -l cachedir -r \
    -a "(__fish_complete_directories '' '')" \
    --description 'Specifies a path to the cache directory, where binary packages are stored.'
complete -c xbps-install -s d -l debug \
    --description 'Enables extra debugging shown to stderr.'
complete -c xbps-install -s f -l force \
    --description 'Force downgrade installation.'
complete -c xbps-install -s h -l help \
    --description 'Show the help message.'
complete -c xbps-install -s i -l ignore-conf-repos \
    --description 'Ignore repositories defined in configuration files.'
complete -c xbps-install -s M -l memory-sync \
    --description 'For remote repositories, the data is fetched and stored in memory for the current operation.'
complete -c xbps-install -s n -l dry-run \
    --description 'Dry-run mode. Show what actions would be done but don\'t do anything.'
complete -c xbps-install -s R \
    --description 'Enable repository mode.'
complete -c xbps-install -l repository -r \
    -a "(__fish_complete_directories '' '')" \
    --description 'Appends the specified repository to the top of the list.'
complete -c xbps-install -s r -l rootdir -r \
    -a "(__fish_complete_directories '' '')" \
    --description 'Specifies a full path for the target root directory.'
complete -c xbps-install -s S -l sync \
    --description 'Synchronize remote repository index files.'
complete -c xbps-install -s U -l unpack-only \
    --description 'If set, packages to be installed or upgraded in the transaction won\'t be configured, jjust unpacked.'
complete -c xbps-install -s u -l update \
    --description 'Performs a full system upgrade.'
complete -c xbps-install -s v -l verbose \
    --description 'Enables verbose messages.'
complete -c xbps-install -s y -l yes \
    --description 'Assume yes to all questions and avoid interactive questions.'
complete -c xbps-install -s V -l version \
    --description 'Show the version information.'

