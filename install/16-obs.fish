yay -S --noconfirm --needed obs-studio

mkdir -p ~/.config/systemd/user
ln -sf ~/.local/share/dotfiles/services/virtual-mic.service ~/.config/systemd/user/
systemctl --user daemon-reload
systemctl enable --now --user virtual-mic.service
