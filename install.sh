#!/bin/sh

set -e

dotfiles_dir=${DOTFILES_DIR:-"$HOME/.local/share/dotfiles"}

case $(uname -s) in
    Linux) platform=linux ;;
    Darwin) platform=macos ;;
    *) echo "unsupported OS: $(uname -s)" >&2; exit 1 ;;
esac

if [ "$platform" = macos ]; then
    PATH="/opt/homebrew/bin:/usr/local/bin:$PATH"
    export PATH
fi

run_install_dir() {
    dir=$1

    [ -d "$dir" ] || return 0

    for f in "$dir"/*.sh; do
        [ -e "$f" ] || continue
        printf '\nRunning installer: %s\n' "$f"
        sh -e "$f"
    done
}

run_install_dir "$dotfiles_dir/install/$platform"
run_install_dir "$dotfiles_dir/install/common"
