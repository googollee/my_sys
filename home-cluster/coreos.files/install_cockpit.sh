#!/bin/sh

rpm-ostree install \
  screen avahi samba \
  cockpit-system cockpit-ostree cockpit-podman cockpit-networkmanager cockpit-selinux cockpit-files
podman container runlabel --name cockpit-ws RUN quay.io/cockpit/ws
podman container runlabel INSTALL quay.io/cockpit/ws

echo Enable units after rebooting
echo $ sudo passwd googol
echo $ systemctl enable cockpit.service
