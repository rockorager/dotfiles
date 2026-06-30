#!/bin/sh

sudo pacman -S --needed --noconfirm fish

sudo usermod --shell /usr/bin/fish "$USER"
