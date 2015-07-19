alias ls='ls -G'
alias ll='ls -lh'
alias la='ls -a'
alias grep='grep --color'
alias qssh='ssh -p 18022 lizhaohai@10.8.0.1'

defaults write -g ApplePressAndHoldEnabled -bool false

export PATH=~/Library/bin:~/Library/go_3rd/bin:/usr/local/share/npm/bin:~/.rvm/bin:/usr/local/sbin:/usr/local/bin:$PATH
export GOPATH=~/Library/go_3rd:/usr/local/Cellar/go/1.4.2/libexec
export NODE_PATH=/usr/local/lib/node_modules
eval "$(boot2docker shellinit 2>/dev/null)"

export PS1='`if [ "$?" == "0" ]; then echo "\[\033[01;32m\]✓"; else echo "\[\033[01;31m\]✗"; fi`\t\[\033[m\] [`if [ "$(id -u)" = "0" ]; then echo "\[\033[01;31m\]"; fi`\u\[\033[m\]@\h:\w] \[\033[32m\]`if [ "$(git status -s 2>/dev/null | head -1)" != "" ]; then echo "\[\033[01;31m\]"; fi``git branch 2>/dev/null | grep ^* | sed "s/^\* \(.*\)$/\1/g"`\[\033[m\]\n\$ '

if [ -f `brew --prefix`/etc/bash_completion ]; then
  . `brew --prefix`/etc/bash_completion
fi
