#!/bin/sh

# scp 00-init.sh 00-init.files/* <target>:~

# Set up ssh login
mkdir -m=700 .ssh
tee .ssh/authorized_keys <<EOF
ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILRbXerF24s/H59FsEaPYfHZ1113Eij81+1ED7VGPK+p googol@mbp-laptop
EOF
chmod 600 .ssh/authorized_keys

# Allow nopassword sudo
sudo sed -i -E 's/^# (.+NOPASSWD: ALL)$/\1/' /etc/sudoers
# Disable root
sudo passwd -l root

# Set up auto update
sudo tee /etc/rpm-ostreed.conf <<EOF
[Daemon]
AutomaticUpdatePolicy=stage
IdleExitTimeout=60
EOF
sudo cp schedule-reboot.timer /etc/systemd/system/
sudo systemctl enable --now rpm-ostreed-automatic.timer
sudo systemctl enable --now schedule-reboot.timer

# Upgrade to the latest
sudo rpm-ostree update

# Install k3s
sudo mkdir -p /etc/rancher/k3s
sudo cp k3s.yaml /etc/rancher/k3s/config.yaml
curl -o k3s.sh https://get.k3s.io
sed -i 's/"${VARIANT_ID:-}" = coreos/"${VARIANT_ID:-}" = iot/' k3s.sh
chmod +x k3s.sh
K3S_CONFIG_FILE=/etc/rancher/k3s/config.yaml ./k3s.sh
sudo firewall-cmd --permanent --add-port=6443/tcp #apiserver
sudo firewall-cmd --permanent --add-port=10250/tcp #apiserver
sudo firewall-cmd --permanent --zone=trusted --add-source=10.42.0.0/16 #pods
sudo firewall-cmd --permanent --zone=trusted --add-source=10.43.0.0/16 #services
sudo firewall-cmd --reload

# Install cockpit
sudo rpm-ostree install --assumeyes --allow-inactive git samba smartmontools net-tools virt-manager cockpit cockpit-ws cockpit-system cockpit-ostree cockpit-storaged cockpit-networkmanager cockpit-selinux cockpit-navigator cockpit-machines cockpit-file-sharing

cat <<EOF
Reboot the system to apply the change:

sudo systemctl reboot
EOF
