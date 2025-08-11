# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# don't overwrite GNU Midnight Commander's setting of `ignorespace'.
HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoredups
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-*color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
        # We have color support; assume it's compliant with Ecma-48
        # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
        # a case would tend to support setf rather than setaf.)
        color_prompt=yes
    else
        color_prompt=
    fi
fi

function git_branch {
  git branch --no-color 2> /dev/null | egrep '^\*' | sed -e 's/^* //'
}

function git_dirty {
  # only tracks modifications, not unknown files needing adds
    if [ -z "`git status -s | awk '{print $1}' | grep '[ADMTUR]'`" ] ; then
        return 1
    else
        return 0
    fi
}

function dirty_git_prompt {
    branch=`git_branch`
    if [ -z "${branch}" ] ; then
        return
    fi
    git_dirty && echo " (${branch})"
}

function clean_git_prompt {
    branch=`git_branch`
    if [ -z "${branch}" ] ; then
        return
    fi
    git_dirty || echo " (${branch})"
}

function vagrant_status {
    return
    if [ -e './VagrantFile' ]; then
        st=`vagrant status | grep default | awk '{print substr($0, index($0, $2))}'`
        echo " [${st}]"
    fi
}

function vm_status {
    branch=`git_branch`
    if [ -n "${branch}" ] ; then
        return
    fi
    st=$(powervm 2>/dev/null)
    if [ "$st" != "" ]; then
        echo " [${st}]"
    fi
}

if [ "$color_prompt" = yes ]; then

    PS1='⚡${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\[\033[01;31m\]$(dirty_git_prompt)\[\033[01;32m\]$(clean_git_prompt)\[\033[00m\]\[\033[01;35m\]$(vagrant_status)\[\033[00m\]\[\033[01;35m\]$(vm_status)\[\033[00m\]\\$ '
else
    PS1='☁${debian_chroot:+($debian_chroot)}\u@\h:\w$(git_branch)$(vagrant_status)\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

check_cursor_position() {
    # Skip check if input is from a paste
    if [[ $- == *i* ]] && [[ "$(readlink /proc/$$/fd/0)" != /dev/tty ]]; then
        return
    fi
    trap '' INT TERM HUP QUIT
    # Save current cursor position
    echo -en "\033[6n" # Ask for the cursor position
    read -sdR CURPOS   # Read the response
    CURPOS=${CURPOS#*\[} # Extract the row and column (e.g., "12;34")
    CURCOL=${CURPOS#*;} # Extract the column number
    if [ "$CURCOL" != "1" ]; then
        echo # Insert a newline if we're not at the start of the line
    fi
    trap - INT TERM HUP QUIT
}

PROMPT_COMMAND=check_cursor_position

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
#alias ll='ls -l'
#alias la='ls -A'
#alias l='ls -CF'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

. ~/.git-completion.bash

export HISTTIMEFORMAT='%Y-%m-%d %H:%M:%S - '

shopt -s histappend
# PROMPT_COMMAND='history -n;history -a'
HISTSIZE=100000
HISTFILESIZE=100000
shopt -s cmdhist

# mac specific settings
export PATH=/usr/local/share/python:/usr/local/bin:/usr/local/sbin:$PATH
export EDITOR="vi"
export CLICOLOR=1
export LSCOLORS=ExGxcxdxCxegedabagacad

# better back and forward search
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'

# make term pass ctrl sequences to vi properly
stty -ixon

alias ix="curl -n -F 'f:1=<-' http://ix.io"

# Predictable SSH authentication socket location.
SOCK="/tmp/ssh-agent-$USER-screen"
if test $SSH_AUTH_SOCK && [ $SSH_AUTH_SOCK != $SOCK ]
then
    rm -f /tmp/ssh-agent-$USER-screen
    ln -sf $SSH_AUTH_SOCK $SOCK
    export SSH_AUTH_SOCK=$SOCK
fi

alias adm="OS_USERNAME=admin OS_TENANT_NAME=admin OS_PASSWORD=secrete"

alias sshvm="ssh-add; ssh dev"


# Added by `rbenv init` on Sun Nov  3 18:09:33 PST 2024
eval "$(rbenv init - --no-rehash bash)"
. "$HOME/.cargo/env"
export BASH_SILENCE_DEPRECATION_WARNING=1
export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"
