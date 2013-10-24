alias ls='ls -G'
alias ll='ls -lh'
alias la='ls -a'
alias grep='grep --color'
alias pc='proxychains4'
alias ss='shadowsocks-local -p 8964 -k fuckgfw -m aes-256-cfb -s googol.im -l 8964'

alias nas='ssh admin@10.2.33.108'
alias amazon_test='ssh lzh@ec2-54-251-27-175.ap-southeast-1.compute.amazonaws.com'
alias panda='ssh lzh@panda.0d0f.com'
alias 0d0f='ssh lzh@0d0f.com'
alias exfe='ssh lzh@exfe.com'
alias shuady='ssh lzh@shuady.cn'

defaults write -g ApplePressAndHoldEnabled -bool false

export PATH=/usr/local/bin:/usr/local/sbin:~/Library/bin:~/Library/go_3rd/bin:/usr/local/share/npm/bin:$PATH
export GOPATH=~/Library/go_3rd:$GOPATH
export NODE_PATH=/usr/local/share/npm/lib/node_modules:$NODE_PATH

export PS1='@\t [\w] \[\033[32m\]`git branch 2>/dev/null | grep ^* | sed "s/^\* \(.*\)$/on branch \1/g"`\[\033[31m\]`git status 2>/dev/null | grep "git add" | head -1 | sed "s/.*/*/g"`\n\n\[\033[m\]`if [ $? = 0 ]; then echo 😃; else echo 😓; fi` \u@\h`if [ "$(id -u)" = "0" ]; then echo "# "; else echo "$ "; fi`'

if [ -f `brew --prefix`/etc/bash_completion ]; then
  . `brew --prefix`/etc/bash_completion
fi

[[ -s "$HOME/.gvm/scripts/gvm" ]] && source "$HOME/.gvm/scripts/gvm"
