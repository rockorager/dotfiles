yay -S --noconfirm --needed \
    1password \
    1password-cli \
    brightnessctl \
    btop \
    comlink-git \
    discord \
    fd \
    github-cli \
    imv \
    less \
    libnotify \
    lsr-iouring-git \
    man \
    mpv \
    pavucontrol \
    playerctl \
    ripgrep \
    wf-recorder \
    wireplumber \
    wl-clipboard \
    xorg-xwayland \
    zen-browser-bin

systemctl enable --now --user 1password.service
echo zen-bin | sudo tee /etc/1password/custom_allowed_browsers
