if not command -v yay >/dev/null 2>&1
    cd /tmp
    git clone https://aur.archlinux.org/yay-bin.git
    cd yay-bin
    makepkg -si --noconfirm
    cd -
    rm -rf /tmp/yay-bin
    cd $HOME
end
