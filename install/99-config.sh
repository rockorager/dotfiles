#!/bin/sh

mkdir -p "$HOME/.config"

cp --recursive --verbose "$HOME/.local/share/dotfiles"/config/* "$HOME/.config/"

mkdir -p "$HOME/.config/fish"

if ! test -f "$HOME/.config/fish/config.fish"; then
    printf '%s\n' \
        '# Managed defaults live in default.fish; put local/private config below.' \
        'source $__fish_config_dir/default.fish' \
        '' \
        > "$HOME/.config/fish/config.fish"
fi

touch "$HOME/.config/git/config"
git config --global include.path default
