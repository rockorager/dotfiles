#!/bin/sh

set -eu

bin_dir="$HOME/.local/bin"
tools_dir="$HOME/.local/share/src"

install_zig_tool() {
    repo=$1
    binary=$2
    optimize=$3
    zig_cmd=${4:-zig}
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
    "$zig_cmd" build install -Doptimize="$optimize" --prefix "$HOME/.local"
    cd "$old_pwd"
}

zig_for_version() {
    version=$1
    os=$(uname -s)
    arch=$(uname -m)

    case $os in
        Linux) zig_os=linux ;;
        Darwin) zig_os=macos ;;
        *) echo "unsupported Zig OS: $os" >&2; exit 1 ;;
    esac

    case $arch in
        x86_64|amd64) zig_arch=x86_64 ;;
        aarch64|arm64) zig_arch=aarch64 ;;
        *) echo "unsupported Zig architecture: $arch" >&2; exit 1 ;;
    esac

    zig_key="$zig_arch-$zig_os"
    zig_dir="$tools_dir/zig-$version-$zig_key"

    if [ ! -x "$zig_dir/zig" ]; then
        tmp_dir=$(mktemp -d)

        tarball=$(curl -fsSL https://ziglang.org/download/index.json |
            jq -r --arg version "$version" --arg key "$zig_key" '.[$version][$key].tarball')
        shasum=$(curl -fsSL https://ziglang.org/download/index.json |
            jq -r --arg version "$version" --arg key "$zig_key" '.[$version][$key].shasum')

        if [ -z "$tarball" ] || [ "$tarball" = null ] || [ -z "$shasum" ] || [ "$shasum" = null ]; then
            echo "no Zig $version download found for $zig_key" >&2
            rm -rf "$tmp_dir"
            exit 1
        fi

        archive="$tmp_dir/zig.tar.xz"
        curl -fsSL "$tarball" -o "$archive"

        if command -v sha256sum >/dev/null 2>&1; then
            printf '%s  %s\n' "$shasum" "$archive" | sha256sum -c -
        elif command -v shasum >/dev/null 2>&1; then
            printf '%s  %s\n' "$shasum" "$archive" | shasum -a 256 -c -
        else
            echo "no sha256 checksum tool found" >&2
            rm -rf "$tmp_dir"
            exit 1
        fi

        tar -xJf "$archive" -C "$tmp_dir"

        extracted_dir=$(find "$tmp_dir" -mindepth 1 -maxdepth 1 -type d -name 'zig-*' | head -n1)
        if [ -z "$extracted_dir" ]; then
            echo "Zig $version archive did not contain a Zig directory" >&2
            rm -rf "$tmp_dir"
            exit 1
        fi

        rm -rf "$zig_dir"
        mkdir -p "$tools_dir"
        mv "$extracted_dir" "$zig_dir"
        rm -rf "$tmp_dir"
    fi

    printf '%s\n' "$zig_dir/zig"
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
zig_0_15_1=$(zig_for_version 0.15.1)
install_zig_tool rockorager/lsr lsr ReleaseSmall "$zig_0_15_1"
