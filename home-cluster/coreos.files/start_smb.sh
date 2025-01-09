#!/bin/sh

sudo systemctl enable smb.service nmb.service
sudo systemctl restart smb.service nmb.service
sudo setsebool -P samba_export_all_ro=1 samba_export_all_rw=1
sudo semanage fcontext –at samba_share_t '/mnt/data/media'
sudo restorecon '/mnt/data/media'
sudo smbpasswd -a googol
