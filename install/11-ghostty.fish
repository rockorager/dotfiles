yay -S --noconfirm --needed \
    ghostty-git \
    ghostty-terminfo-git \
    ghostty-shell-integration-git

systemctl enable --now --user com.mitchellh.ghostty.service
