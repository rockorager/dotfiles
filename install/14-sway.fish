yay -S --noconfirm --needed \
    adwaita-cursors \
    autotiling-rs \
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
    swaybg \
    swayidle \
    sway-systemd \
    waybar \
    xdg-desktop-portal \
    xdg-desktop-portal-wlr

sudo systemctl enable gdm.service

systemctl enable --now --user autotiling.service
systemctl enable --now --user mako.service
systemctl enable --now --user polkit-gnome.service
systemctl enable --now --user swaybg.service
systemctl enable --now --user waybar.service
