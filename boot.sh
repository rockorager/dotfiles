#!/bin/sh

set -e

sudo pacman -S --needed --noconfirm \
  base-devel \
  fish \
  git

rm -rf ~/.local/share/dotfiles/
git clone https://github.com/rockorager/dotfiles ~/.local/share/dotfiles

cd ~/.local/share/dotfiles
git fetch origin installer && git checkout installer
cd ~

printf "\nInstallation starting..."
fish ~/.local/share/dotfiles/install.fish
