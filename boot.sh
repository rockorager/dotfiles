#!/bin/sh

set -e

sudo pacman -S --needed --noconfirm \
  base-devel \
  git

dotfiles_dir="$HOME/.local/share/dotfiles"

if [ -d "$dotfiles_dir/.git" ]; then
  git -C "$dotfiles_dir" pull
else
  git clone https://github.com/rockorager/dotfiles "$dotfiles_dir"
fi

printf "\nInstallation starting..."
sh "$dotfiles_dir/install.sh"
