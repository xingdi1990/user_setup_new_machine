#!/bin/bash

# Prompt for the username
read -p "Enter the username for the new account: " username

# Set the home directory to the data drive under /ephemeral
home_dir="/ephemeral/$username"

# Install sudo if it's not already installed
if ! command -v sudo &> /dev/null; then
    echo "sudo is not installed. Installing sudo..."
    apt update && apt install -y sudo
fi

# Create the new user with the specified home directory
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

# Create the .ssh directory in the new home directory and set permissions
echo "Setting up SSH for the new user..."
sudo mkdir -p "$home_dir/.ssh"
sudo cp ~/.ssh/authorized_keys "$home_dir/.ssh/authorized_keys"
sudo chmod 700 "$home_dir/.ssh"
sudo chmod 600 "$home_dir/.ssh/authorized_keys"
sudo chown -R "$username:$username" "$home_dir/.ssh"

echo "Mapping user '$username' home directory to data drive '/ephemeral'. Setup complete!"
