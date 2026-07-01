#!/bin/sh

yay -S --noconfirm --needed \
    power-profiles-daemon

sudo systemctl enable --now power-profiles-daemon.service

sudo install -Dm644 ~/.local/share/dotfiles/system-udev-rules/90-tobenone-dock-usb-power.rules /etc/udev/rules.d/90-tobenone-dock-usb-power.rules
sudo udevadm control --reload-rules
sudo udevadm trigger --subsystem-match=usb
