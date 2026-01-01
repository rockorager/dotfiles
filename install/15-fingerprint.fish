# Install fprintd for fingerprint authentication
yay -S --noconfirm --needed fprintd

# Configure PAM for sudo - add fingerprint auth before password
if not grep -q pam_fprintd.so /etc/pam.d/sudo
    sudo sed -i '/^auth.*substack.*system-auth/i auth      sufficient pam_fprintd.so' /etc/pam.d/sudo
end

# Configure PAM for polkit (used by 1Password)
# The file doesn't exist by default on Arch (vendor default is in /usr/lib/pam.d/)
if not test -f /etc/pam.d/polkit-1
    sudo cp ~/.local/share/dotfiles/config/pam.d/polkit-1 /etc/pam.d/polkit-1
else if not grep -q pam_fprintd.so /etc/pam.d/polkit-1
    sudo sed -i '/^auth.*include.*system-auth/i auth      sufficient pam_fprintd.so' /etc/pam.d/polkit-1
end

# Enable and start fprintd service
sudo systemctl enable --now fprintd.service

echo ""
echo "Fingerprint daemon installed. Run 'fprintd-enroll' to register your fingerprint."
echo "For 1Password: Settings → Security → Unlock with system authentication"
