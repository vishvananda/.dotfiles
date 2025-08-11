if [ -z "$PS1" ]; then
    exit
fi
. ~/.bashrc
if [ -n "$SSH_CONNECTION" ] && [ -z "$SCREEN_EXIST" ]; then
    export SCREEN_EXIST=1
    if which tmux; then
        tmux -2 -L vish att || tmux -2 -L vish
        logout
    elif which screen; then
        screen -S vish -x || screen -S vish -DRi
        logout
    fi
fi
