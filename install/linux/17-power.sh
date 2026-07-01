#!/bin/sh

yay -S --noconfirm --needed \
    power-profiles-daemon \
    thermald

sudo install -Dm755 ~/.local/share/dotfiles/system-bin/power-profile-auto /usr/local/bin/power-profile-auto
sudo install -Dm644 ~/.local/share/dotfiles/system-services/power-profile-auto.service /etc/systemd/system/power-profile-auto.service
sudo install -Dm644 ~/.local/share/dotfiles/system-services/thermald.service.d/override.conf /etc/systemd/system/thermald.service.d/override.conf
sudo install -Dm644 ~/.local/share/dotfiles/system-udev-rules/90-power-profile-auto.rules /etc/udev/rules.d/90-power-profile-auto.rules

sudo systemctl daemon-reload
sudo systemctl enable --now power-profiles-daemon.service
sudo systemctl enable --now thermald.service
sudo systemctl start power-profile-auto.service

sudo install -Dm644 ~/.local/share/dotfiles/system-udev-rules/90-tobenone-dock-usb-power.rules /etc/udev/rules.d/90-tobenone-dock-usb-power.rules
sudo udevadm control --reload-rules
sudo udevadm trigger --subsystem-match=power_supply
sudo udevadm trigger --subsystem-match=usb
