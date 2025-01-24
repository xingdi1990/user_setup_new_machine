#!/bin/bash

# Prompt for the username
read -p "Enter the username for the new account: " username
read -p "Enter the home directory (default: /home/$username): " home_dir

# Set default home directory if none is provided
home_dir=${home_dir:-/home/$username}

# Install sudo if it's not already installed
if ! command -v sudo &> /dev/null; then
    echo "sudo is not installed. Installing sudo..."
    apt update && apt install -y sudo
fi

# Add the new user with the specified home directory
echo "Creating user '$username' with home directory '$home_dir'..."
sudo adduser "$username" --home "$home_dir"

# Add the user to the sudo group
echo "Adding '$username' to the sudo group..."
sudo usermod -aG sudo "$username"

# Optionally add to the wheel group if required by the distribution
if grep -q "^wheel:" /etc/group; then
    echo "Adding '$username' to the wheel group (if required)..."
    sudo usermod -aG wheel "$username"
fi

# Verify sudo privileges for the new user
echo "Switching to the new user account to test sudo access..."
su - "$username" -c "sudo whoami"

echo "'$username' has sudo privileges."

# to login with new user, you need to copy the authorized_keys 

mkdir -p /home/$username/.ssh

sudo cp ~/.ssh/authorized_keys /home/$username/.ssh/authorized_keys

echo "User '$username' setup authorized. Now login with your new user account!"
