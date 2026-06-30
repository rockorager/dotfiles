#!/bin/sh

mkdir -p "$HOME/.local/bin"

cp --verbose "$HOME/.local/share/dotfiles"/bin/* "$HOME/.local/bin/"
