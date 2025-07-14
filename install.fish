for f in ~/.local/share/dotfiles/install/*.fish
    printf "\nRunning installer: %s\n" "$f"
    source "$f"
end
