#!/bin/sh

# scp 00-init.sh 00-init.files/* <target>:~

# Set up ssh login
mkdir -m=700 .ssh
tee .ssh/authorized_keys <<EOF
ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAII45ZL2yn9EB+QQn3K+uoMmykFC0VvBT+PASX4EmCRQd googol@Googols-MBP.local
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC3gcEcKThasoZWYrEjBi4LQJAtVo2deuPl5JoxboKeVYJ8j4i4QtFjprh/aI0YfS6btf4xrNLuEIzySo3d9fkFk/EHSwzdYo0f52EQwJbMix7+nK6K3sea+SxWS5mc8YGZVWKHGpKChfJEwZOD6GMVH3AXZTUMIAjzxNF6LjoSF/Yx/YOAsWeAtDeiwp4jROMqtv45aq90jLqIZ857XRlQ8YHtoobPdmSUMoFFoy6A4TdaigWf93GSSqamJEV5WnSrGU6eOJLDsYwvJzuUskFV+H28mjjtP2FKHwC5uyGp/k9fyihnXHkodTtifx8ci8mPNgMzkQ/cDLoQ56sjeuBo1i+d4MOGThb/45+mcGDSOZCpOivz1uB9sM6Pj/virGqRLLhip6ehjIPtXch9wXrPiyG72xsNJSnYIJTsGuKl1rRzyk6o/miy5ckFZSYo7sdP9xfm9x9YcbT795lV4hg9T0cR0IryU01J4C6F+BCRoh78sxVEbmcU1ZLgXWrVrBMn4n1wK+06Cx3Vi7gpvTTiEq1opziKazLpRmkNH7ToMoLgUvH3AdeJ6mNENHv3nxYCNOrng18IesDn8gxVNiqKUPWW+Bloh1+/JZwOcdz6+cHJrf3lnwxTBlF9bRYHHDwUy+JuR2CXQ01pD16Bz741nnppkXjTPVWRAzwO4pS9vw== googollee@macOS
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
sudo rpm-ostree install --assumeyes --allow-inactive cockpit cockpit-ws cockpit-system cockpit-ostree cockpit-storaged cockpit-networkmanager cockpit-selinux cockpit-navigator cockpit-machines cockpit-file-sharing

cat <<EOF
Reboot the system to apply the change:

sudo systemctl reboot
EOF
