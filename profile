export PATH=~/.local/bin:~/code/my_sys/bin:/usr/local/sbin:$PATH
export EDITOR=nvim

umask 0022
alias ls='ls -G --color=auto'
alias ll='ls -lh --color=auto'
alias la='ls -a --color=auto'
alias vi='nvim'
alias nv='nvim'
alias txa='tmx2 attach'
alias cpl-dev='cpl --server="blade:cpl-lab-service-dev"'

HOSTNAME="$(hostname)"
# not company's environment
if [ "${HOSTNAME#*.google.com}" != "" ]; then
  alias vi='nvim'
  alias vim='nvim'
fi

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

export LC_ALL="en_US.UTF-8"

OS="$(uname)"
case ${OS} in
  Darwin)
    alias ls='ls -G'
    alias ll='ls -lh'
    alias la='ls -a'
    export DOCKER_DEFAULT_PLATFORM=linux/amd64
    ;;
  *)
    ;;
esac

# Homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"
BREW="$(which brew 2>/dev/null)"
if [ "${BREW}" != "" ]; then
  if [ -f `brew --prefix`/etc/bash_completion ]; then
    . `brew --prefix`/etc/bash_completion
  fi
fi
