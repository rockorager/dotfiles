#!/bin/sh

install_cask() {
    cask=$1
    app_path=$2

    if brew list --cask "$cask" >/dev/null 2>&1; then
        return 0
    fi

    if [ -n "$app_path" ] && [ -e "$app_path" ]; then
        printf 'Skipping %s: %s already exists\n' "$cask" "$app_path"
        return 0
    fi

    brew install --cask "$cask"
}

brew install \
    1password-cli \
    fd \
    fish \
    fzf \
    gh \
    git \
    go \
    jq \
    less \
    mise \
    neovim \
    postgresql \
    redis \
    ripgrep \
    tree-sitter-cli \
    zig

install_cask 1password /Applications/1Password.app
install_cask font-fira-code ''
install_cask ghostty /Applications/Ghostty.app
