#!/bin/sh

set -e

sudo pacman -S --needed --noconfirm \
  base-devel \
  fish \
  git

rm -rf $HOME/.local/share/dotfiles/
git clone https://github.com/rockorager/dotfiles $HOME/.local/share/dotfiles

printf "\nInstallation starting..."
fish $HOME/.local/share/dotfiles/install.fish
