#!/bin/sh

curl --proto '=https' --tlsv1.2 -sSf https://get.k0s.sh | sh
k0s install controller --single -c /etc/k0s/config.yaml --kubelet-extra-args="--node-ip=192.168.10.2"
k0s start
