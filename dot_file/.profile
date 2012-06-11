alias ls='ls -G'
alias ll='ls -lh'
alias la='ls -a'
alias grep='grep --color'
alias sshnas='ssh admin@googol.dyndns.info'

export GOPATH=/Users/googol/Library/go_3rd/

export PATH=/usr/local/bin:/usr/local/sbin:$PATH:~/Library/bin:~/Code/go/bin
export PYTHONPATH=~/Library/python/2.6
export PS1='\u:\W \$ '

if [ -f `brew --prefix`/etc/bash_completion ]; then
  . `brew --prefix`/etc/bash_completion
fi

[[ -s "/Users/googol/.rvm/scripts/rvm" ]] && source "/Users/googol/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
