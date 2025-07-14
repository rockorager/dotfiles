# Function to check if a key exists (uncommented) in the config
function key_exists
    set key $argv[1]
    grep -q "^$key\$" /etc/pacman.conf
end

# Function to add a key to the [options] section
function add_key
    set key $argv[1]

    if key_exists $key
        return 0
    end

    # Add the key after the [options] line
    sudo sed -i "/^\\[options\\]/a $key" /etc/pacman.conf
end

# Add the keys
echo "Configuring pacman..."
add_key Color
add_key ILoveCandy
