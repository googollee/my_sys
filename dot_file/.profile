alias ls='ls -G'
alias ll='ls -lh'
alias la='ls -a'
alias grep='grep --color'
alias qssh='ssh -p 18022 lizhaohai@10.8.0.1'
alias cdssh='ssh qboxserver@192.168.20.101'

defaults write -g ApplePressAndHoldEnabled -bool false

export PATH=~/Library/bin:~/Library/go_3rd/bin:/usr/local/share/npm/bin:~/.rvm/bin:/usr/local/sbin:/usr/local/bin:$PATH
export GOPATH=~/Library/go_3rd
export HOMEBREW_BOTTLE_DOMAIN=http://7xkcej.dl1.z0.glb.clouddn.com
export NODE_PATH=/usr/local/lib/node_modules
export MONGO=127.0.0.1:27017
export REDIS=127.0.0.1:6379
eval "$(docker-machine env docker)"

export PS1='`if [ "$?" == "0" ]; then echo "\[\033[01;32m\]✓"; else echo "\[\033[01;31m\]✗"; fi`\t\[\033[m\] [`if [ "$(id -u)" = "0" ]; then echo "\[\033[01;31m\]"; fi`\u\[\033[m\]@\h:\w] \[\033[32m\]`if [ "$(git status -s 2>/dev/null | head -1)" != "" ]; then echo "\[\033[01;31m\]"; fi``git branch 2>/dev/null | grep ^* | sed "s/^\* \(.*\)$/\1/g"`\[\033[m\]\n\$ '

if [ -f `brew --prefix`/etc/bash_completion ]; then
  . `brew --prefix`/etc/bash_completion
fi
