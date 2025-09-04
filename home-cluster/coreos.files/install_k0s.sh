#!/bin/sh

curl --proto '=https' --tlsv1.2 -sSf https://get.k0s.sh | sh
k0s install controller --single -c /etc/k0s/config.yaml
k0s start
