yay -S --noconfirm --needed \
    adwaita-cursors \
    autotiling-rs \
    fnott \
    fuzzel \
    gdm \
    gnome-themes-extra \
    gradia \
    grim \
    kanshi \
    nautilus \
    polkit-gnome \
    slurp \
    sway \
    swaybg \
    swayidle \
    sway-contrib \
    sway-systemd \
    waybar \
    xdg-desktop-portal \
    xdg-desktop-portal-wlr

sudo systemctl enable gdm.service

systemctl enable --now --user autotiling.service
systemctl enable --now --user kanshi.service
systemctl enable --now --user fnott.service
systemctl enable --now --user polkit-gnome.service
systemctl enable --now --user swaybg.service
systemctl enable --now --user waybar.service

sudo ln -s /usr/share/sway-contrib/grimshot /usr/bin/grimshot
sudo ln -s /usr/share/sway-contrib/grimpicker /usr/bin/grimpicker
