# $OpenBSD: dot.profile,v 1.7 2020/01/24 02:09:51 okan Exp $
#
# sh/ksh initialization


parse_git_branch() {
      git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

PS1="┌─[\033[32m\u\033[00m@\h]─[\033[32m\]\w\[\033[33m\]\$(parse_git_branch)\[\033[00m\]]\n└─ \$ "

alias vi='vim'
alias bar='scripts/polybar-start.sh > /dev/null 2>&1'

PATH=$HOME/bin:/bin:/sbin:/usr/bin:/usr/sbin:/usr/X11R6/bin:/usr/local/bin:/usr/local/sbin:/usr/games

export PATH PS1

