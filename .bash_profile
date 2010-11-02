if [ -n "$SSH_CONNECTION" ] && [ -z "$SCREEN_EXIST" ]; then
    export SCREEN_EXIST=1
    screen -DRi
fi
