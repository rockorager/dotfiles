#!/bin/sh

mkdir -p "$HOME/.local/share/backgrounds"

for background in "$HOME/.local/share/dotfiles"/backgrounds/*; do
    [ -e "$background" ] || continue
    ln -sf "$background" "$HOME/.local/share/backgrounds/"
done
