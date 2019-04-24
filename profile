alias ls='ls -G --color=auto'
alias ll='ls -lh --color=auto'
alias la='ls -a --color=auto'

NVIM=`which nvim 2>/dev/null`
if [ "${NVIM}" != "" ]; then
  alias vi='nvim'
  alias vim='nvim'
fi

export PS1='`if [ "$?" == "0" ]; then echo "\[\033[01;32m\]✓"; else echo "\[\033[01;31m\]✗"; fi`\t\[\033[m\] [`if [ "$(id -u)" = "0" ]; then echo "\[\033[01;31m\]"; fi`\u\[\033[m\]@\h:\w] \[\033[32m\]`if [ "$(git status -s 2>/dev/null | head -1)" != "" ]; then echo "\[\033[01;31m\]"; fi``git branch 2>/dev/null | grep ^* | sed "s/^\* \(.*\)$/\1/g"`\[\033[m\]\n\$ '

OS=`uname`
case ${OS} in
  Darwin)
    alias ls='ls -G'
    alias ll='ls -lh'
    alias la='ls -a'
    ;;
  *)
    ;;
esac

BREW=`which brew 2>/dev/null`
if [ "${BREW}" != "" ]; then
  if [ -f `brew --prefix`/etc/bash_completion ]; then
    . `brew --prefix`/etc/bash_completion
  fi
fi

# Docker
if [ ! -f unix:///var/run/docker.sock ]; then
  ping -c 1 localhost:2375 >/dev/null 2>&1 && export DOCKER_HOST='tcp://localhost:2375'
fi

# Go
export GOPATH=~/.local:~/code

export PATH=~/.local/bin:~/code/my_sys/bin:/usr/local/sbin:$PATH

umask 0022
