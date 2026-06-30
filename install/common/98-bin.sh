#!/bin/sh

mkdir -p "$HOME/.local/bin"

for script in "$HOME/.local/share/dotfiles"/bin/*; do
    [ -e "$script" ] || continue
    ln -sf "$script" "$HOME/.local/bin/"
done
