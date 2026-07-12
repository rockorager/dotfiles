#!/bin/sh

yay -S --noconfirm --needed \
    adwaita-cursors \
    autotiling-rs \
    foot \
    fuzzel \
    gdm \
    gnome-themes-extra \
    gradia \
    grim \
    kanshi \
    mako \
    nautilus \
    polkit-gnome \
    slurp \
    sway \
    swaylock \
    swayosd \
    sway-contrib \
    sway-systemd \
    waybar \
    xdg-desktop-portal \
    xdg-desktop-portal-gtk \
    xdg-desktop-portal-wlr

sudo systemctl enable gdm.service

systemctl enable --now --user autotiling.service
systemctl enable --now --user kanshi.service
systemctl enable --now --user polkit-gnome.service
systemctl enable --now --user "$HOME/.local/share/dotfiles/services/sway-urgent-focus.service"
# Notifications and hardware OSD are provided by keywork-shell.
# Temporarily disabled in favor of keywork-shell (see 21-keywork-shell.sh)
# systemctl enable --now --user waybar.service

# Lid close behavior: suspend on battery, ignore when docked/external power
sudo mkdir -p /etc/systemd/logind.conf.d
printf '%s\n' \
    '[Login]' \
    'HandleLidSwitch=suspend' \
    'HandleLidSwitchExternalPower=ignore' \
    'HandleLidSwitchDocked=ignore' \
    | sudo tee /etc/systemd/logind.conf.d/lid.conf

sudo install -d /usr/local/bin
sudo ln -sf /usr/share/sway-contrib/grimshot /usr/local/bin/grimshot
sudo ln -sf /usr/share/sway-contrib/grimpicker /usr/local/bin/grimpicker
