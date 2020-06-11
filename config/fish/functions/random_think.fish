function random_think
    set -l allcows (cowsay -l | tail -n+2 | string split ' ')
    set -l cowfile (random choice $allcows)
    set -l cowopts (random choice b d g p s t w y)
    if [ (random 0 1) = 1 ]
        cowsay -n -$cowopts -f $cowfile $argv
    else
        cowthink -n -$cowopts -f $cowfile $argv
    end
end
