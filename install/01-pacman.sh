#!/bin/sh

# Function to check if a key exists (uncommented) in the config
key_exists() {
    key=$1
    grep -q "^$key\$" /etc/pacman.conf
}

# Function to add a key to the [options] section
add_key() {
    key=$1

    if key_exists "$key"; then
        return 0
    fi

    # Add the key after the [options] line
    sudo sed -i "/^\\[options\\]/a $key" /etc/pacman.conf
}

# Add the keys
echo "Configuring pacman..."
add_key Color
add_key ILoveCandy
