#!/bin/sh

dotfiles_dir=${DOTFILES_DIR:-"$HOME/.local/share/dotfiles"}

link_config() {
    src=$1
    dest=$2

    if [ -e "$dest" ] || [ -L "$dest" ]; then
        rm -rf "$dest"
    fi

    mkdir -p "$(dirname "$dest")"
    ln -s "$src" "$dest"
}

mkdir -p "$HOME/.config"

for config in \
    environment.d \
    fontconfig \
    foot \
    fuzzel \
    ghostty \
    kanshi \
    mako \
    nvim \
    sway \
    swaylock \
    waybar
do
    link_config "$dotfiles_dir/config/$config" "$HOME/.config/$config"
done

mkdir -p "$HOME/.config/fish"
link_config "$dotfiles_dir/config/fish/config.fish" "$HOME/.config/fish/config.fish"
link_config "$dotfiles_dir/config/fish/conf.d" "$HOME/.config/fish/conf.d"
link_config "$dotfiles_dir/config/fish/functions" "$HOME/.config/fish/functions"
rm -f "$HOME/.config/fish/default.fish"

mkdir -p "$HOME/.config/git"
link_config "$dotfiles_dir/config/git/config" "$HOME/.config/git/config"
link_config "$dotfiles_dir/config/git/allowed_signers" "$HOME/.config/git/allowed_signers"
rm -f "$HOME/.config/git/default"
