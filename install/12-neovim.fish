if not command -v nvim >/dev/null 2>&1
    yay -S --noconfirm --needed \
        nvim \
        tree-sitter-cli

    # Install LazyVim
    rm -rf ~/.config/nvim
    git clone https://github.com/LazyVim/starter ~/.config/nvim
    rm -rf ~/.config/nvim/.git
end
