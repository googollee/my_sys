#!/bin/sh

curl -o /tmp/k3s.sh https://get.k3s.io
chmod +x /tmp/k3s.sh
K3S_CONFIG_FILE=/etc/rancher/k3s/config.yaml /tmp/k3s.sh
