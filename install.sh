#!/bin/sh

set -e

dotfiles_dir=${DOTFILES_DIR:-"$HOME/.local/share/dotfiles"}

for f in "$dotfiles_dir"/install/*.sh; do
    [ -e "$f" ] || continue
    printf '\nRunning installer: %s\n' "$f"
    sh -e "$f"
done
