#!/bin/sh

yay -S --noconfirm --needed \
    tlp

sudo systemctl enable --now tlp.service
