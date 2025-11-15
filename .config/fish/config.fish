if status is-interactive
    set -U fish_greeting ""
    alias ls='eza -al --color=always --group-directories-first'
    function sudo
        faillock --user swapnanil --reset
        command sudo $argv
    end
end
