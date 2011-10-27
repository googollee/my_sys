alias ls='ls -G'
alias ll='ls -lh'
alias la='ls -a'
alias grep='grep --color'

export PATH=/usr/local/bin:/usr/local/sbin::$PATH:~/Library/bin
export PYTHONPATH=~/Library/python/2.6
export PS1='\u:\W \$ '

[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"  # This loads RVM into a shell session.

if [ -f `brew --prefix`/etc/bash_completion ]; then
  . `brew --prefix`/etc/bash_completion
fi
