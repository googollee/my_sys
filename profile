OS=`uname`
case ${OS} in
  Darwin)
    alias ls='ls -G'
    export LC_ALL=en_US.UTF-8
    export LANG=en_US.UTF-8
    ;;
esac

alias ll='ls -lh'
alias la='ls -a'
alias grep='grep --color'

export PATH=~/local/bin:$PATH
export GOPATH=~/local

export PS1='`if [ "$?" == "0" ]; then echo "\[\033[01;32m\]✓"; else echo "\[\033[01;31m\]✗"; fi`\t\[\033[m\] [`if [ "$(id -u)" = "0" ]; then echo "\[\033[01;31m\]"; fi`\u\[\033[m\]@\h:\w] \[\033[32m\]`if [ "$(git status -s 2>/dev/null | head -1)" != "" ]; then echo "\[\033[01;31m\]"; fi``git branch 2>/dev/null | grep ^* | sed "s/^\* \(.*\)$/\1/g"`\[\033[m\]\n\$ '

BREW=`which brew`
if [ "${BREW}" != "" ]; then
  if [ -f `brew --prefix`/etc/bash_completion ]; then
    . `brew --prefix`/etc/bash_completion
  fi
fi
