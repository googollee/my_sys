#!/bin/sh

rpm-ostree override remove nfs-utils-coreos
rpm-ostree install --assumeyes nfs-utils \
  git avahi samba virt-manager \
  cockpit-system cockpit-ostree cockpit-podman cockpit-storaged cockpit-networkmanager cockpit-machines cockpit-selinux cockpit-files
podman container runlabel --name cockpit-ws RUN quay.io/cockpit/ws
podman container runlabel INSTALL quay.io/cockpit/ws
systemctl enable libvirtd.service
systemctl enable cockpit.servic
