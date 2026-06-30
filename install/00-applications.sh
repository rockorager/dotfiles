#!/bin/sh

mkdir -p "$HOME/.local/share/applications"

for application in "$HOME/.local/share/dotfiles"/applications/*.desktop "$HOME/.local/share/dotfiles"/applications/hidden/*.desktop; do
    [ -e "$application" ] || continue
    ln -sf "$application" "$HOME/.local/share/applications/"
done

update-desktop-database "$HOME/.local/share/applications"

# Services
mkdir -p "$HOME/.config/systemd/user"

for service in "$HOME/.local/share/dotfiles"/services/*; do
    [ -e "$service" ] || continue
    ln -sf "$service" "$HOME/.config/systemd/user/"
done

systemctl --user daemon-reload
