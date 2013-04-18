alias ls='ls -G'
alias ll='ls -lh'
alias la='ls -a'
alias grep='grep --color'
alias sshnas='ssh admin@192.168.1.108'
alias amazon_test='ssh lzh@ec2-54-251-27-175.ap-southeast-1.compute.amazonaws.com'

defaults write -g ApplePressAndHoldEnabled -bool false

export GOPATH=/Users/googol/Library/go_3rd/

export PATH=~/Library/bin:$GOPATH/bin:/usr/local/bin:/usr/local/sbin:$PATH
export PYTHONPATH=~/Library/python/2.6

export PS1='@\t [\w] \[\033[32m\]`git branch 2>/dev/null | grep ^* | sed "s/^\* \(.*\)$/on branch \1/g"`\[\033[31m\]`git status 2>/dev/null | grep "git add" | head -1 | sed "s/.*/*/g"`\n\n\[\033[m\]`if [ $? = 0 ]; then echo 😃; else echo 😓; fi` \u@\h`if [ "$(id -u)" = "0" ]; then echo "# "; else echo "$ "; fi`'

if [ -f `brew --prefix`/etc/bash_completion ]; then
  . `brew --prefix`/etc/bash_completion
fi

[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"
