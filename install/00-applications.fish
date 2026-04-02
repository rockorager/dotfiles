mkdir -p ~/.local/share/applications

cp --verbose --no-clobber ~/.local/share/dotfiles/applications/*.desktop ~/.local/share/applications
cp --verbose --no-clobber ~/.local/share/dotfiles/applications/hidden/*.desktop ~/.local/share/applications

update-desktop-database ~/.local/share/applications

# Services
mkdir -p ~/.config/systemd/user

for service in ~/.local/share/dotfiles/services/*
    ln -sf "$service" ~/.config/systemd/user/
end

systemctl --user daemon-reload
