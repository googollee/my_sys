alias ls='ls -G'
alias ll='ls -lh'
alias la='ls -a'
alias grep='grep --color'
alias pc='proxychains4'

alias nas='ssh admin@192.168.1.233'
alias exfe='ssh lzh@exfe.com'
alias shuady='ssh lzh@shuady.cn'
alias nycdev='ssh zli@nycdev01.fwmrm.net'
alias pekdev='ssh zli@pekdev201.dev.fwmrm.net'
alias googol='ssh googol.im'

defaults write -g ApplePressAndHoldEnabled -bool false

export PATH=~/Library/bin:~/Library/go_3rd/bin:~/.gem/ruby/2.0.0/bin:/usr/local/share/npm/bin:$PATH
export GOPATH=~/Library/go_3rd:$GOPATH
export DOCKER_HOST=tcp://
export NODE_PATH=/usr/local/lib/node_modules

export PS1='@\t [\w] \[\033[32m\]`git branch 2>/dev/null | grep ^* | sed "s/^\* \(.*\)$/on branch \1/g"`\[\033[31m\]\n\n\[\033[m\]`if [ $? == 0 ]; then echo 😃; else echo 😓; fi` \u@\h`if [ "$(id -u)" = "0" ]; then echo "# "; else echo "$ "; fi`'

if [ -f `brew --prefix`/etc/bash_completion ]; then
  . `brew --prefix`/etc/bash_completion
fi

go () {
  if [ "$1" == "-g" ]; then
    shift
    command go $*
    return
  fi
  local PWD=`pwd`
  if [ "$1" == "cover" ]; then
    shift
    local t="/tmp/go-cover.$$.tmp"
    GOPATH=$PWD:$GOPATH command go test -coverprofile=$t $* && GOPATH=$PWD:$GOPATH command go tool cover -html=$t && rm $t
    return
  fi
  GOPATH=$PWD:$GOPATH command go $*
  return
}
