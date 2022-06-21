export PATH=~/.local/bin:~/code/my_sys/bin:/usr/local/sbin:$PATH

umask 0022
alias ls='ls -G --color=auto'
alias ll='ls -lh --color=auto'
alias la='ls -a --color=auto'

export LC_ALL="en_US.UTF-8"

function git_branch_name()
{
  git_status=$(git status -s 2>/dev/null | head -1)
  if [ "$git_status" != "" ]
  then
    color="\033[01;31m"
  else
    color="\033[01;32m"
  fi

  branch=$(git branch 2>/dev/null | grep '^*' | sed "s/^\* \(.*\)$/\1/g")
  if [ "$branch" = "" ]
  then
    :
  else
    echo "on ${color}${branch}\033[m"
  fi
}

if [ "$SHELL" = "/bin/zsh" ]
then
  setopt prompt_subst
  export PS1='%(?.%F{green}✓.%F{red}✗)%f%D{%H:%M:%S} [%n@%m:%~] $(git_branch_name)
%# '
else
  export PS1='`if [ "$?" == "0" ]; then echo "\[\033[01;32m\]✓"; else echo "\[\033[01;31m\]✗"; fi`\t\[\033[m\] [`if [ "$(id -u)" = "0" ]; then echo "\[\033[01;31m\]"; fi`\u\[\033[m\]@\h:\w] \[\033[32m\]`if [ "$(git status -s 2>/dev/null | head -1)" != "" ]; then echo "\[\033[01;31m\]"; fi``git branch 2>/dev/null | grep ^* | sed "s/^\* \(.*\)$/\1/g"`\[\033[m\]\n\$ '
fi

# macOS
if [ `uname` = "Darwin" ]; then
  export DOCKER_DEFAULT_PLATFORM=linux/amd64
fi

# Google Env
if [ "`lsb_release -cs 2>/dev/null`" = "rodete" ]; then
  true;
fi

# Homebrew
if [ -e /opt/homebrew/bin/brew ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
  BREW="$(which brew 2>/dev/null)"
  if [ -f `brew --prefix`/etc/bash_completion ]; then
    . `brew --prefix`/etc/bash_completion
  fi
fi

# Go
export GOPATH=~/.local
export PATH=$PATH:$GOPATH/bin

if [ "$(which nvim)" != "nvim not found" ]; then
  export EDITOR=nvim
  alias vi='nvim'
  alias nv='nvim'
fi

if [ "$(which lsb_release)" != "lsb_release not found" ]; then
  if [ $(lsb_release -rs) = "rodete" ]; then
    alias txa='tmx2 attach'
    alias cpl-dev='cpl --server="blade:cpl-lab-service-dev"'
  fi
fi
