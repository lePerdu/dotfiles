set fish_escape_delay_ms 200

# Aliases for human-readable size formats
alias df="df -h"
alias du="du -h"
alias free="free -h"

alias l="ls -lhv"

set -x LESS -isR

if command -q emacsclient
    set -gx EDITOR 'emacsclient -r'
    alias e 'emacsclient -r -n'
else if command -q nvim
    set -gx EDITOR nvim
    alias v nvim
else if command -q vi
    set -gx EDITOR vi
    alias v nvim
else
    set -gx EDITOR nano
end

set -gx VISUAL $EDITOR

alias venv="python3 -m venv"
alias pip="python3 -m pip"

if not contains $HOME/.local/bin $PATH
    set -gxp PATH $HOME/.local/bin
end

# Cargo
if test -d ~/.cargo/bin and not contains $HOME/.cargo/bin $PATH
    set -gxp PATH $HOME/.cargo/bin
end

# ghcup
if test -d ~/.ghcup/bin and not contains $HOME/.ghcup/bin $PATH
    set -gxp PATH $HOME/.cabal/bin $HOME/.ghcup/bin
    set GHCUP_INSTALL_BASE_PREFIX $HOME
end

# opam
if test -d ~/.opam
    source ~/.opam/opam-init/init.fish >/dev/null 2>/dev/null
    or true
end
