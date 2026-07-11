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
clone_or_pull rockorager/keywork-shell "$src_dir/keywork-shell"

old_pwd=$PWD
cd "$src_dir/keywork"
zig build install -Doptimize=ReleaseSafe --prefix "$HOME/.local"
cd "$old_pwd"

make -C "$src_dir/keywork-shell" install

# Disable services replaced by keywork-shell when upgrading an existing system.
for service in keywork-bar.service mako.service swayosd.service; do
    systemctl disable --now --user "$service" 2>/dev/null || true
done

systemctl enable --user keywork-shell.service
systemctl restart --user keywork-shell.service
