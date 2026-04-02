yay -S --noconfirm --needed gammastep automatic-timezoned

mkdir -p ~/.config/systemd/user
ln -sf ~/.local/share/dotfiles/services/gammastep.service ~/.config/systemd/user/
systemctl --user daemon-reload
systemctl enable --now --user gammastep.service

sudo systemctl enable --now automatic-timezoned.service
