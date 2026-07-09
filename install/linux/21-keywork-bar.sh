#!/bin/sh

set -eu

# Build dependencies for keywork (zig comes from 20-utilities.sh)
yay -S --noconfirm --needed \
    dbus \
    fontconfig \
    freetype2 \
    harfbuzz \
    libxkbcommon \
    luajit \
    vulkan-icd-loader \
    wayland

src_dir="$HOME/.local/share/src"

clone_or_pull() {
    repo=$1
    dir=$2

    if [ -d "$dir/.git" ]; then
        git -C "$dir" pull --ff-only
    elif [ -e "$dir" ]; then
        echo "$dir exists but is not a git checkout" >&2
        exit 1
    else
        git clone "https://github.com/$repo.git" "$dir"
    fi
}

mkdir -p "$src_dir"

clone_or_pull rockorager/keywork "$src_dir/keywork"
clone_or_pull rockorager/keywork-bar "$src_dir/keywork-bar"
clone_or_pull rockorager/keywork-launcher "$src_dir/keywork-launcher"

old_pwd=$PWD
cd "$src_dir/keywork"
zig build install -Doptimize=ReleaseSafe --prefix "$HOME/.local"
cd "$old_pwd"

make -C "$src_dir/keywork-bar" install
make -C "$src_dir/keywork-launcher" install

systemctl enable --now --user keywork-bar.service
