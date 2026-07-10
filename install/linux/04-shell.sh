#!/bin/sh

sudo pacman -S --needed --noconfirm fish

shell=/usr/bin/fish

if [ -x /usr/local/bin/rush ]; then
    shell=/usr/local/bin/rush

    if ! grep -qx "$shell" /etc/shells; then
        echo "$shell" | sudo tee -a /etc/shells >/dev/null
    fi
fi

current=$(getent passwd "$USER" | cut -d: -f7)

if [ "$current" != "$shell" ]; then
    sudo usermod --shell "$shell" "$USER"
fi
