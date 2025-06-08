#!/bin/sh

curl -o /tmp/k3s.sh https://get.k3s.io
chmod +x /tmp/k3s.sh
K3S_CONFIG_FILE=/etc/rancher/k3s/config.yaml /tmp/k3s.sh

echo scp $(hostname):/etc/rancher/k3s/k3s.yaml ~/.kube/config
echo sed -i "" "s/127.0.0.1:6443/$(hostname):6443/" ~/.kube/config
