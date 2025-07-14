yay -S --noconfirm --needed \
    blueman \
    bluez

sudo systemctl enable --now bluetooth.service
