eval `gpg -d --quiet ~/Dropbox/passwords.gpg | sed 's/^/export /'`
ansible-playbook $*
