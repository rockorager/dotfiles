#!/bin/sh

yay -S --noconfirm --needed \
    1password \
    1password-cli \
    brightnessctl \
    btop \
    fd \
    github-cli \
    imv \
    less \
    libnotify \
    lsr-iouring-git \
    man \
    mpv \
    postgresql \
    ripgrep \
    wf-recorder \
    wl-clipboard \
    xorg-xwayland \
    zig

systemctl enable --now --user 1password.service
systemctl enable --now --user postgresql.service
