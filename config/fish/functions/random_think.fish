
function random_think
    set -l cow_dir
    for dir in /usr{,/local}/share/{cows,cowsay}
        if test -d $dir
            set cow_dir $dir
            break
        end
    end

    set -l cows $cow_dir/*.cow
    set -l n (math 'scale=0;'(random)'%'(count $cows)'+1')
    if test (math (random)'%2') -eq 0
        cowthink -f $cows[$n]
    else
        cowsay -f $cows[$n]
    end
end

