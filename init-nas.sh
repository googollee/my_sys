#!/bin/sh

ssh nas <<EOF
/bin/sh -c "
export PATH=/share/CACHEDEV1_DATA/.qpkg/container-station/bin:/bin:/sbin:/usr/bin:/usr/sbin:/usr/bin/X11:/usr/local/sbin:/usr/local/bin
docker rm -fv k3s
docker run -d \
  --name k3s \
  --restart always \
  --privileged \
  --mount type=tmpfs,destination=/run \
  --mount type=tmpfs,destination=/var/run \
  --mount type=volume,source=k3s-server,destination=/var/lib/rancher/k3s \
  --ulimit nofile=65535:65535 \
  --ulimit nproc=65535 \
  --env K3S_TOKEN=googol_nas_k3s \
  --env K3S_KUBECONFIG_OUTPUT=/output/kubeconfig.yaml \
  --env K3S_KUBECONFIG_MODE=666 \
  -p 6443:6443 \
  -p 80:80 \
  -p 443:443 \
  rancher/k3s:latest server
"
EOF

sleep 5

mkdir -p ~/.kube
ssh nas >~/.kube/config <<EOF
/bin/sh -c "
export PATH=/share/CACHEDEV1_DATA/.qpkg/container-station/bin:/bin:/sbin:/usr/bin:/usr/sbin:/usr/bin/X11:/usr/local/sbin:/usr/local/bin
docker exec k3s cat /output/kubeconfig.yaml | sed 's/127\.0\.0\.1/nas/'
"
EOF
