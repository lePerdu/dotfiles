abbr g git

abbr gb git branch
abbr gba git branch --all
abbr gbd git branch -d
abbr gbD git branch -D

abbr gbdr 'git branch -vv | grep \': gone\' | awk \'{ print $1 }\' | xargs -n 1 git branch -D'

abbr gcl git clone

abbr gst git status

abbr gf git fetch

abbr gd git diff
abbr gdca git diff --cached

abbr gco git checkout

abbr gw git switch
abbr gwc git switch -c

abbr gl git pull
abbr gp git push
abbr gp! git push --force

abbr glg git log
abbr glgs git log --stat

abbr gc git commit -v
abbr gc! git commit -v --amend

abbr ga git add
abbr gapa git add --patch
abbr grm git rm

abbr grs git restore

abbr gm git merge
abbr gma git merge --abort

abbr grb git rebase
abbr grbi git rebase --interactive
abbr grbc git rebase --continue
abbr grba git rebase --abort

abbr grv git remote -v

abbr gsta git stash
abbr gstm git stash push -m
abbr gstl git stash list
abbr gstp git stash pop
abbr gstap git stash apply
abbr gsts git stash show -p
abbr gstd git stash drop

abbr gcp git cherry-pick
abbr gcpc git cherry-pick --continue
abbr gcps git cherry-pick --skip
abbr gcpa git cherry-pick --abort

abbr gwt git worktree
abbr gwta git worktree add
abbr gwtr git worktree remove
abbr gwtl git worktree list
