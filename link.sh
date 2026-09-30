#!/usr/bin/env bash
DST=${1:-$HOME}
ABSPATH="$(cd "${0%/*}" 2>/dev/null; echo "$PWD"/"${0##*/}")"
SRC=`dirname $ABSPATH`

function link {
 rm -f "$DST/$1"
 ln -s "$SRC/$1" "$DST/$1"
}

link .vimrc
link .bashrc
link .bash_profile
link .git-completion.bash
link .tmux.conf
link .screenrc
link .gitconfig
link .vim
link .bazaar

link .gitignore_global
mkdir -p "$DST/.local/bin" "$DST/.config/nvim"
link .local/bin/attach-vish-tmux
link .config/nvim/init.vim
