alias ls='ls -G'
alias ll='ls -lh'
alias la='ls -a'
alias grep='grep --color'
alias sshnas='ssh admin@googol.dyndns.info'

export GOPATH=/Users/googol/Library/go_3rd/

export PATH=~/Library/bin:/usr/local/bin:/usr/local/sbin:$PATH
export PYTHONPATH=~/Library/python/2.6
export PS1='\u:\W \$ '

if [ -f `brew --prefix`/etc/bash_completion ]; then
  . `brew --prefix`/etc/bash_completion
fi

[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"
