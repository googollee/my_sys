#!/bin/sh

HOST="nas"

ssh ${HOST} "sudo sed -i '/\[global\]/a \\tinclude = registry\n' /etc/samba/smb.conf; \
sudo systemctl restart smb.service; \
sudo systemctl enable cockpit.socket; \
sudo systemctl start cockpit.socket; \
sudo firewall-cmd --permanent --add-service=cockpit; \
sudo firewall-cmd --reload; \
"

mkdir -p ~/.kube/
scp ${HOST}:/etc/rancher/k3s/k3s.yaml ~/.kube/config
sed -i "" "s/127.0.0.1:6443/${HOST}:6443/" ~/.kube/config
