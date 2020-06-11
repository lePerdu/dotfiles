set fish_escape_delay_ms 200

# Aliases for human-readable size formats
alias df="df -h"
alias du="du -h"
alias free="free -h"

alias l="ls -lh"

abbr v kak

set -x LESS -isFR

if command -sq hub
    alias git=hub
end

# if command -sq stack
#     for c in ghc ghci runghc runhaskell
#         alias $c="stack $c --"
#     end
# end

# alias venv="python3 -m venv"
# alias pip="python3 -m pip"

# set sudope_sequence
# bind \e\e sudope

if command -sq luarocks
    fenv (luarocks path)
end

if command -sq sccache
    set -x RUSTC_WRAPPER sccache
end

# Start wayfire on tty1
# if [ (tty) = /dev/tty1 ]
#     exec env XDG_SESSION_TYPE=wayland wayfire
# end

# soruce ~/.local/share/omf/themes/pure/conf.d/pure.fish

# set pure_symbol_prompt '❯'
# set pure_symbol_reverse_prompt '❮'
# set pure_right_prompt 'C'
# set pure_symbol_git_unpulled_commits '⇣'
# set pure_symbol_git_unpushed_commits '⇡'
# set pure_symbol_git_dirty '*'
# set pure_symbol_title_bar_separator '—'

# set pure_threshold_command_duration 5
# set pure_separate_prompt_on_error false
# set pure_begin_prompt_with_current_directory false
# set pure_reverse_prompt_symbol_in_vimode true
