#!/bin/sh

rpm-ostree override remove nfs-utils-coreos
rpm-ostree install --assumeyes nfs-utils \
  git docker-buildx screen avahi samba virt-manager \
  cockpit-system cockpit-ostree cockpit-podman cockpit-storaged cockpit-networkmanager cockpit-machines cockpit-selinux cockpit-files
podman container runlabel --name cockpit-ws RUN quay.io/cockpit/ws
podman container runlabel INSTALL quay.io/cockpit/ws

echo Enable units after rebooting
echo $ sudo passwd googol
echo $ systemctl enable libvirtd.service
echo $ systemctl enable cockpit.service
