#!/bin/sh

bin_dir="$HOME/.local/bin"
tools_dir="$HOME/.local/share/src"

install_zig_tool() {
    repo=$1
    binary=$2
    optimize=$3
    tool_dir="$tools_dir/$binary"

    mkdir -p "$tools_dir"

    if [ -d "$tool_dir/.git" ]; then
        git -C "$tool_dir" pull --ff-only
    elif [ -e "$tool_dir" ]; then
        echo "$tool_dir exists but is not a git checkout" >&2
        exit 1
    else
        git clone "https://github.com/$repo.git" "$tool_dir"
    fi

    old_pwd=$PWD
    cd "$tool_dir"
    zig build install -Doptimize="$optimize" --prefix "$HOME/.local"
    cd "$old_pwd"
}

install_github_binary() {
    repo=$1
    binary=$2

    os=$(uname -s)
    arch=$(uname -m)

    case $os in
        Linux) os_pattern=linux ;;
        Darwin) os_pattern='(macos|darwin)' ;;
        *) echo "unsupported $binary OS: $os" >&2; exit 1 ;;
    esac

    case $arch in
        x86_64|amd64) arch_pattern='(x64|amd64)' ;;
        aarch64|arm64) arch_pattern='(arm64|aarch64)' ;;
        *) echo "unsupported $binary architecture: $arch" >&2; exit 1 ;;
    esac

    asset_url=$(curl -fsSL "https://api.github.com/repos/$repo/releases/latest" |
        jq -r ".assets[] | select(.name | test(\"^$binary[-_].*[-_]$os_pattern[-_]$arch_pattern[.]tar[.]gz$\")) | .browser_download_url" |
        head -n1)

    if [ -z "$asset_url" ]; then
        echo "no $binary release asset found for $os-$arch" >&2
        exit 1
    fi

    tmp_dir=$(mktemp -d)
    trap 'rm -rf "$tmp_dir"' EXIT HUP INT TERM

    curl -fsSL "$asset_url" | tar -xzf - -C "$tmp_dir"
    install -d "$bin_dir"

    if [ -f "$tmp_dir/$binary" ]; then
        binary_path="$tmp_dir/$binary"
    else
        binary_path=$(find "$tmp_dir" -mindepth 2 -maxdepth 2 -type f -name "$binary" | head -n1)
    fi

    if [ -z "$binary_path" ]; then
        echo "$binary not found in release archive" >&2
        exit 1
    fi

    install -m 0755 "$binary_path" "$bin_dir/$binary"

    trap - EXIT HUP INT TERM
    rm -rf "$tmp_dir"
}

install_github_binary rockorager/comview comview
install_github_binary rockorager/zigdoc zigdoc
install_zig_tool rockorager/comlink comlink ReleaseSafe
