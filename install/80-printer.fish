yay -S --noconfirm --needed \
    avahi \
    cups \
    cups-filters \
    cups-pdf \
    foomatic-db \
    foomatic-db-engine \
    foomatic-db-gutenprint-ppds \
    foomatic-db-nonfree \
    foomatic-db-nonfree-ppds \
    foomatic-db-ppds \
    nss-mdns \
    system-config-printer

sudo systemctl enable --now cups.service

sudo mkdir -p /etc/systemd/resolved.conf.d
echo "[Resolve]\nMulticastDNS=no" | sudo tee /etc/systemd/resolved.conf.d/10-disable-multicast.conf

sudo systemctl enable --now avahi-daemon.service
