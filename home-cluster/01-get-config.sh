#!/bin/sh

HOST="iot"

ssh ${HOST} "sudo systemctl enable cockpit.socket; \
sudo systemctl start cockpit.socket; \
sudo firewall-cmd --permanent --add-service=cockpit; \
sudo firewall-cmd --reload; \
"

mkdir -p ~/.kube/
scp iot:/etc/rancher/k3s/k3s.yaml ~/.kube/config
sed -i "" "s/127.0.0.1:6443/${HOST}:6443/" ~/.kube/config
