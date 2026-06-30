#!/bin/sh

yay -S --noconfirm --needed \
    avahi \
    brlaser \
    cups \
    cups-filters \
    nss-mdns \
    system-config-printer

sudo systemctl enable --now cups.service

sudo mkdir -p /etc/systemd/resolved.conf.d
printf '%s\n' '[Resolve]' 'MulticastDNS=no' | sudo tee /etc/systemd/resolved.conf.d/10-disable-multicast.conf

sudo systemctl enable --now avahi-daemon.service

# Enable mDNS hostname resolution for .local addresses
sudo sed -i 's/^hosts:.*/hosts: mymachines mdns_minimal [NOTFOUND=return] resolve [!UNAVAIL=return] files myhostname dns/' /etc/nsswitch.conf
