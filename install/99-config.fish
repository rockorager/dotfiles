mkdir -p ~/.config

cp --recursive --verbose ~/.local/share/dotfiles/config/* ~/.config/

touch $HOME/.config/git/config
git config --global include.path default
