#!/bin/sh

yay -S --noconfirm --needed \
    curl \
    jq \
    wlsunset

sudo install -Dm755 ~/.local/share/dotfiles/system-bin/location-apply-timezone /usr/local/bin/location-apply-timezone
sudo install -Dm644 ~/.local/share/dotfiles/system-services/location-timezone@.service /etc/systemd/system/location-timezone@.service
sudo install -Dm644 ~/.local/share/dotfiles/system-services/location-timezone@.path /etc/systemd/system/location-timezone@.path

sudo systemctl daemon-reload
sudo systemctl reset-failed location-timezone@$USER.service
sudo systemctl enable --now location-timezone@$USER.path

systemctl --user daemon-reload
systemctl --user reset-failed location-refresh.service location-watch.service wlsunset.service
systemctl --user enable location-watch.service
systemctl --user enable location-refresh.timer
systemctl --user enable wlsunset.service

systemctl --user start location-watch.service
systemctl --user start location-refresh.timer
systemctl --user start location-refresh.service
