# git-aliases initialization hook
#
# You can use the following variables in this file:
# * $package       package name
# * $path          package path
# * $dependencies  package dependencies
#
# TODO Remove the really long abbreviations (and substitute them with functions
# or something)

#
# Functions
#

# The name of the current branch
# Back-compatibility wrapper for when this function was defined here in
# the plugin, before being pulled in to core lib/git.zsh as git_current_branch()
# to fix the core -> git plugin dependency.
function current_branch
    git_current_branch
end

# The list of remotes
function current_repository
    if not $_omz_git_git_cmd rev-parse --is-inside-work-tree 2>&1 >/dev/null
        return
    end
    echo ($_omz_git_git_cmd remote -v | cut -d':' -f 2)
end

# Pretty log messages
function _git_log_prettily
    if [ $1 ]
        git log --pretty=$1
    end
end

# Warn if the current branch is a WIP
function work_in_progress
    if git log -n 1 2>/dev/null | grep -q -c "\-\-wip\-\-"
        echo "WIP!!"
    end
end

#
# Aliases
# (sorted alphabetically)
#

abbr -a g 'git'

abbr -a ga 'git add'
abbr -a gaa 'git add --all'
abbr -a gapa 'git add --patch'
abbr -a gau 'git add --update'
abbr -a gap 'git apply'

abbr -a gb 'git branch'
abbr -a gba 'git branch -a'
abbr -a gbd 'git branch -d'
# abbr -a gbda 'git branch --no-color --merged | command grep -vE "^(\*|\s*(master|develop|dev)\s*$)" | command xargs -n 1 git branch -d'
abbr -a gbl 'git blame -b -w'
abbr -a gbnm 'git branch --no-merged'
abbr -a gbr 'git branch --remote'
abbr -a gbs 'git bisect'
abbr -a gbsb 'git bisect bad'
abbr -a gbsg 'git bisect good'
abbr -a gbsr 'git bisect reset'
abbr -a gbss 'git bisect start'

abbr -a gc 'git commit -v'
abbr -a gc! 'git commit -v --amend'
abbr -a gcn! 'git commit -v --no-edit --amend'
abbr -a gca 'git commit -v -a'
abbr -a gca! 'git commit -v -a --amend'
abbr -a gcan! 'git commit -v -a --no-edit --amend'
abbr -a gcans! 'git commit -v -a -s --no-edit --amend'
abbr -a gcam 'git commit -a -m'
abbr -a gcsm 'git commit -s -m'
abbr -a gcb 'git checkout -b'
abbr -a gcf 'git config --list'
abbr -a gcl 'git clone --recursive'
abbr -a gclean 'git clean -fd'
abbr -a gpristine 'git reset --hard; and git clean -dfx'
abbr -a gcm 'git checkout master'
abbr -a gcd 'git checkout develop'
abbr -a gcmsg 'git commit -m'
abbr -a gco 'git checkout'
abbr -a gcount 'git shortlog -sn'
# compdef _git gcount
abbr -a gcp 'git cherry-pick'
abbr -a gcpa 'git cherry-pick --abort'
abbr -a gcpc 'git cherry-pick --continue'
abbr -a gcs 'git commit -S'

abbr -a gd 'git diff'
abbr -a gdca 'git diff --cached'
abbr -a gdcw 'git diff --cached --word-diff'
abbr -a gdct 'git describe --tags `git rev-list --tags --max-count=1`'
abbr -a gdt 'git diff-tree --no-commit-id --name-only -r'
abbr -a gdw 'git diff --word-diff'

# gdv() { git diff -w "$@" | view - }
# compdef _git gdv=git-diff

abbr -a gf 'git fetch'
abbr -a gfa 'git fetch --all --prune'
abbr -a gfo 'git fetch origin'

# function gfg() { git ls-files | grep $@ }
# compdef _grep gfg

abbr -a gg 'git gui citool'
abbr -a gga 'git gui citool --amend'

# function ggf
#     [ count $argv -ne 1 ]; and set -l b="(git_current_branch)"
#     git push --force origin "${b:=$1}"
# end

# function ggfl
#     [ count $argv -ne 1 ]; and set -l b="(git_current_branch)"
#     git push --force-with-lease origin "${b:=$1}"
# end
# # compdef _git ggf=git-checkout

# function ggl
#     if [ count $argv -ne 0 -a count $argv -ne 1 ]
#         git pull origin "${*}"
#     else
#         [ count $argv -eq 0 ]; and set -l b="(git_current_branch)"
#         git pull origin "${b:=$1}"
#     end
# end
# # compdef _git ggl=git-checkout

# function ggp
#     if [ count $argv -ne 0 ]; and [ count $argv -ne 1 ]
#         git push origin "${*}"
#     else
#         [ count $argv -eq 0 ]; and set -l b="(git_current_branch)"
#         git push origin "${b:=$1}"
#     end
# end
# # compdef _git ggp=git-checkout

# function ggpnp
#     if [ count $argv -eq 0 ]
#         ggl; and ggp
#     else
#         ggl "${*}"; and ggp "${*}"
#     end
# end
# # compdef _git ggpnp=git-checkout

# function ggu
#     [ count $argv -ne 1 ]; and set -l b="(git_current_branch)"
#     git pull --rebase origin "${b:=$1}"
# end
# # compdef _git ggu=git-checkout

abbr -a ggpur 'ggu'
# compdef _git ggpur=git-checkout

abbr -a ggpull 'git pull origin (git_current_branch)'
# compdef _git ggpull=git-checkout

abbr -a ggpush 'git push origin (git_current_branch)'
# compdef _git ggpush=git-checkout

abbr -a ggsup 'git branch --set-upstream-to=origin/(git_current_branch)'
abbr -a gpsup 'git push --set-upstream origin (git_current_branch)'

abbr -a ghh 'git help'

abbr -a gignore 'git update-index --assume-unchanged'
abbr -a gignored 'git ls-files -v | grep "^[[:lower:]]"'
abbr -a git-svn-dcommit-push 'git svn dcommit; and git push github master:svntrunk'
# compdef _git git-svn-dcommit-push=git

abbr -a gk '\gitk --all --branches'
# compdef _git gk='gitk'
abbr -a gke '\gitk --all (git log -g --pretty=%h)'
# compdef _git gke='gitk'

abbr -a gl 'git pull'
abbr -a glg 'git log --stat'
abbr -a glgp 'git log --stat -p'
abbr -a glgg 'git log --graph'
abbr -a glgga 'git log --graph --decorate --all'
abbr -a glgm 'git log --graph --max-count=10'
abbr -a glo 'git log --oneline --decorate'
abbr -a glol "git log --graph --pretty='%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
abbr -a glola "git log --graph --pretty='%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --all"
abbr -a glog 'git log --oneline --decorate --graph'
abbr -a gloga 'git log --oneline --decorate --graph --all'
abbr -a glp "_git_log_prettily"
# compdef _git glp=git-log

abbr -a gm 'git merge'
abbr -a gmom 'git merge origin/master'
abbr -a gmt 'git mergetool --no-prompt'
abbr -a gmtvim 'git mergetool --no-prompt --tool=vimdiff'
abbr -a gmum 'git merge upstream/master'
abbr -a gma 'git merge --abort'

abbr -a gp 'git push'
abbr -a gpd 'git push --dry-run'
abbr -a gpoat 'git push origin --all; and git push origin --tags'
# compdef _git gpoat=git-push
abbr -a gpu 'git push upstream'
abbr -a gpv 'git push -v'

abbr -a gr 'git remote'
abbr -a gra 'git remote add'
abbr -a grb 'git rebase'
abbr -a grba 'git rebase --abort'
abbr -a grbc 'git rebase --continue'
abbr -a grbi 'git rebase -i'
abbr -a grbm 'git rebase master'
abbr -a grbs 'git rebase --skip'
abbr -a grh 'git reset HEAD'
abbr -a grhh 'git reset HEAD --hard'
abbr -a grmv 'git remote rename'
abbr -a grrm 'git remote remove'
abbr -a grset 'git remote set-url'
abbr -a grt 'cd (git rev-parse --show-toplevel; or echo ".")'
abbr -a gru 'git reset --'
abbr -a grup 'git remote update'
abbr -a grv 'git remote -v'

abbr -a gsb 'git status -sb'
abbr -a gsd 'git svn dcommit'
abbr -a gsi 'git submodule init'
abbr -a gsps 'git show --pretty=short --show-signature'
abbr -a gsr 'git svn rebase'
abbr -a gss 'git status -s'
abbr -a gst 'git status'
abbr -a gsta 'git stash save'
abbr -a gstaa 'git stash apply'
abbr -a gstc 'git stash clear'
abbr -a gstd 'git stash drop'
abbr -a gstl 'git stash list'
abbr -a gstp 'git stash pop'
abbr -a gsts 'git stash show -p'
abbr -a gsu 'git submodule update'

abbr -a gts 'git tag -s'
abbr -a gtv 'git tag | sort -V'

abbr -a gunignore 'git update-index --no-assume-unchanged'
abbr -a gunwip 'git log -n 1 | grep -q -c "\-\-wip\-\-"; and git reset HEAD~1'
abbr -a gup 'git pull --rebase'
abbr -a gupv 'git pull --rebase -v'
abbr -a glum 'git pull upstream master'

abbr -a gwch 'git whatchanged -p --abbrev-commit --pretty=medium'
abbr -a gwip 'git add -A; git rm (git ls-files --deleted) 2> /dev/null; git commit --no-verify -m "--wip-- [skip ci]"'
