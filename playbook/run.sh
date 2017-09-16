eval `gpg -d --quiet ~/Dropbox/keys/passwords.gpg | sed 's/^/export /'`
ansible-playbook $*
