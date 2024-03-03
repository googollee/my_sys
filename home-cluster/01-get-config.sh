#!/bin/sh

HOST="$1"

if [ "${HOST}" = "" ]
then
  echo "usage: $0 <host>"
  exit -1
fi

scp 01-get-config.files/smb.conf ${HOST}:~

ssh ${HOST} "sudo cp ~/smb.conf /etc/samba/smb.conf; \
sudo systemctl enable smb.service; \
sudo systemctl restart smb.service; \
sudo setsebool -P samba_export_all_ro=1 samba_export_all_rw=1; \
sudo semanage fcontext –at samba_share_t '/mnt/data/media'; \
sudo restorecon '/mnt/data/media'; \
sudo firewall-cmd --permanent --add-service=samba; \
sudo firewall-cmd --reload; \
sudo systemctl enable cockpit.socket; \
sudo systemctl start cockpit.socket; \
sudo firewall-cmd --permanent --add-service=cockpit; \
sudo firewall-cmd --reload; \
"

mkdir -p ~/.kube/
scp ${HOST}:/etc/rancher/k3s/k3s.yaml ~/.kube/config
sed -i "" "s/127.0.0.1:6443/${HOST}:6443/" ~/.kube/config
