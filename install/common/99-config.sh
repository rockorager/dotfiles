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

link_environment() {
    dest_dir="$HOME/.config/environment.d"

    if [ -L "$dest_dir" ]; then
        rm -f "$dest_dir"
    fi

    mkdir -p "$dest_dir"

    for env_file in "$dotfiles_dir"/config/environment.d/*.conf; do
        [ -e "$env_file" ] || continue

        case $(basename "$env_file") in
            07-ssh-*.conf) continue ;;
        esac

        link_config "$env_file" "$dest_dir/$(basename "$env_file")"
    done

    case $(uname -s) in
        Linux) ssh_env=07-ssh-linux.conf ;;
        Darwin) ssh_env=07-ssh-macos.conf ;;
        *) ssh_env= ;;
    esac

    if [ -n "$ssh_env" ]; then
        link_config "$dotfiles_dir/config/environment.d/$ssh_env" "$dest_dir/07-ssh.conf"
    fi
}

link_ghostty_platform() {
    case $(uname -s) in
        Linux) ghostty_platform=linux ;;
        Darwin) ghostty_platform=macos ;;
        *) ghostty_platform= ;;
    esac

    rm -f "$HOME/.config/ghostty/platform"

    if [ -n "$ghostty_platform" ] && [ -e "$dotfiles_dir/config/ghostty/$ghostty_platform" ]; then
        link_config "$dotfiles_dir/config/ghostty/$ghostty_platform" "$HOME/.config/ghostty/platform"
    fi
}

mkdir -p "$HOME/.config"

for config in \
    comlink \
    fontconfig \
    ghostty \
    nvim
do
    link_config "$dotfiles_dir/config/$config" "$HOME/.config/$config"
done

link_ghostty_platform

case $(uname -s) in
    Linux)
        for config in \
            foot \
            fuzzel \
            kanshi \
            mako \
            sway \
            swaylock \
            waybar
        do
            link_config "$dotfiles_dir/config/$config" "$HOME/.config/$config"
        done
        ;;
    Darwin)
        link_config "$dotfiles_dir/config/macctl" "$HOME/.config/macctl"
        ;;
esac

link_environment

mkdir -p "$HOME/.config/fish"
link_config "$dotfiles_dir/config/fish/config.fish" "$HOME/.config/fish/config.fish"
link_config "$dotfiles_dir/config/fish/conf.d" "$HOME/.config/fish/conf.d"
link_config "$dotfiles_dir/config/fish/functions" "$HOME/.config/fish/functions"
rm -f "$HOME/.config/fish/default.fish"

mkdir -p "$HOME/.config/git"
link_config "$dotfiles_dir/config/git/config" "$HOME/.config/git/config"
link_config "$dotfiles_dir/config/git/allowed_signers" "$HOME/.config/git/allowed_signers"
rm -f "$HOME/.config/git/default"

mkdir -p "$HOME/.config/amp/skills"
link_config "$dotfiles_dir/config/amp/skills/writing-commit-messages" "$HOME/.config/amp/skills/writing-commit-messages"

if [ "$(uname -s)" = Darwin ] && command -v macctl >/dev/null 2>&1; then
    if ! macctl --user daemon-reload; then
        printf 'macctl daemon-reload failed; continuing with explicit service setup\n' >&2
    fi
    if ! macctl --user enable postgresql.service; then
        sleep 2
        macctl --user enable postgresql.service
    fi
    if ! macctl --user restart postgresql.service; then
        sleep 2
        macctl --user restart postgresql.service
    fi
    if ! macctl --user enable redis.service; then
        sleep 2
        macctl --user enable redis.service
    fi
    if ! macctl --user restart redis.service; then
        sleep 2
        macctl --user restart redis.service
    fi
fi
