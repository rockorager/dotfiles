mkdir -p ~/.config

cp --recursive --verbose ~/.local/share/dotfiles/config/* ~/.config/

mkdir -p ~/.config/fish

if not test -f ~/.config/fish/config.fish
    printf '%s\n' \
        '# Managed defaults live in default.fish; put local/private config below.' \
        'source $__fish_config_dir/default.fish' \
        '' \
        > ~/.config/fish/config.fish
end

touch $HOME/.config/git/config
git config --global include.path default
