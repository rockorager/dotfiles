#!/bin/sh

yay -S --noconfirm --needed \
    impala \
    iwd

sudo systemctl enable --now iwd.service
