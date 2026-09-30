. ~/.bashrc

clocfmt() {
  find "${1:-.}" -type f \( -name '*.cpp' -o -name '*.h' \) \
    -exec clang-format --style=file {} + |
    cloc --quiet --csv --stdin-name=combined.cpp - |
    awk -F, '$2=="SUM" { print $5 }'
}

if [[ $- == *i* ]]; then
  if [ -n "$SSH_CONNECTION" ] && [ -z "$SCREEN_EXIST" ]; then
    export SCREEN_EXIST=1
    if which tmux; then
        "$HOME/.local/bin/attach-vish-tmux"
        logout
    elif which screen; then
        screen -S vish -x || screen -S vish -DRi
        logout
    fi
  fi
fi
. "$HOME/.cargo/env"
