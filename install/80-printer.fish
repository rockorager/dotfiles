yay -S --noconfirm --needed \
    cups \
    cups-filters \
    cups-pdf \
    foomatic-db \
    foomatic-db-engine \
    foomatic-db-gutenprint-ppds \
    foomatic-db-nonfree \
    foomatic-db-nonfree-ppds \
    foomatic-db-ppds \
    system-config-printer

sudo systemctl enable --now cups.service
