#!/bin/sh

yay -S --noconfirm --needed \
    pavucontrol \
    pipewire \
    pipewire-alsa \
    pipewire-jack \
    pipewire-pulse \
    playerctl \
    wireplumber

systemctl --user enable --now pipewire.socket pipewire-pulse.socket wireplumber.service
