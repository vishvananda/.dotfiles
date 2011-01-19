#!/usr/bin/env bash
DST=${1:-"`pwd`"}
ABSPATH="$(cd "${0%/*}" 2>/dev/null; echo "$PWD"/"${0##*/}")"
SRC=`dirname $ABSPATH`

function link {
 rm $DST/$1
 ln -s $SRC/$1 $DST/$1
}

link .vimrc
link .bashrc
link .bash_profile
link .screenrc
link .gitconfig
link .vim
