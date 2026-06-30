#!/bin/sh

yay -S --noconfirm --needed obs-studio easyeffects lsp-plugins

mkdir -p "$HOME/.config/systemd/user"
ln -sf "$HOME/.local/share/dotfiles/services/virtual-mic.service" "$HOME/.config/systemd/user/"
systemctl --user daemon-reload
systemctl enable --now --user virtual-mic.service
