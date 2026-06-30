#!/bin/sh

yay -S --noconfirm --needed \
    power-profiles-daemon

sudo systemctl enable --now power-profiles-daemon.service
