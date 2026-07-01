#!/bin/sh

set -eu

plugins_dir="$HOME/.config/amp/plugins"
tools_dir="$HOME/.local/share/src"

install_amp_plugin() {
    repo=$1
    plugin_name=$2
    source_file=$3
    repo_name=${repo##*/}
    plugin_dir="$tools_dir/$repo_name"

    mkdir -p "$tools_dir"

    if [ -d "$plugin_dir/.git" ]; then
        git -C "$plugin_dir" pull --ff-only
    elif [ -e "$plugin_dir" ]; then
        echo "$plugin_dir exists but is not a git checkout" >&2
        exit 1
    else
        git clone "https://github.com/$repo.git" "$plugin_dir"
    fi

    if [ ! -f "$plugin_dir/$source_file" ]; then
        echo "$source_file not found in $plugin_dir" >&2
        exit 1
    fi

    mkdir -p "$plugins_dir"
    ln -sf "$plugin_dir/$source_file" "$plugins_dir/$plugin_name.ts"
}

install_amp_plugin rockorager/amp-zmx zmx plugin.ts
