set fish_escape_delay_ms 200

# Aliases for human-readable size formats
alias df="df -h"
alias du="du -h"
alias free="free -h"

alias l="ls -lhv"

set -x LESS -isR

if command -q emacsclient
    set -x EDITOR 'emacsclient -r'
    alias e 'emacsclient -r -n'
else if command -q nvim
    set -x EDITOR nvim
    alias v nvim
else if command -q vi
    set -x EDITOR vi
    alias v nvim
else
    set -x EDITOR nano
end

set -x VISUAL $EDITOR

alias venv="python3 -m venv"
alias pip="python3 -m pip"

contains $HOME/.local/bin $PATH
or set -gx PATH $PATH $HOME/.local/bin




