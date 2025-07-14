mkdir -p ~/.local/share/applications

cp --verbose --no-clobber ~/.local/share/dotfiles/applications/*.desktop ~/.local/share/applications
cp --verbose --no-clobber ~/.local/share/dotfiles/applications/hidden/*.desktop ~/.local/share/applications

update-desktop-database ~/.local/share/applications

# Services
cp --verbose --no-clobber ~/.local/share/dotfiles/services/* ~/.config/systemd/user/
sudo systemctl daemon-reload
