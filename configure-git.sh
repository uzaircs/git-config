#!/bin/bash

# Function to set Git email and username globally
configure_git() {
    echo "Enter your Git email:"
    read git_email
    git config --global user.email "$git_email"

    echo "Enter your Git username:"
    read git_name
    git config --global user.name "$git_name"
}

# Function to start ssh-agent if it's not running
start_ssh_agent() {
    # Check if ssh-agent is already running
    if ! pgrep -u "$USER" ssh-agent > /dev/null; then
        echo "Starting ssh-agent..."
        eval "$(ssh-agent -s)"
    fi
}

# Function to add the SSH private key
configure_ssh() {
    start_ssh_agent  # Ensure ssh-agent is running

    echo "Would you like to paste your private key or enter the path to the key?"
    echo "Type 'paste' to paste the key or 'path' to provide the path:"
    read option

    if [ "$option" = "paste" ]; then
        echo "Paste your private key below (End with Ctrl-D):"
        key=$(cat)  # Reads multi-line input (private key)
        echo "$key" > ~/.ssh/temp_key
        chmod 600 ~/.ssh/temp_key
        ssh-add ~/.ssh/temp_key
    elif [ "$option" = "path" ]; then
        echo "Enter the path to your private key:"
        read key_path
        ssh-add "$key_path"
    else
        echo "Invalid option. Please enter either 'paste' or 'path'."
        configure_ssh
    fi
}

# Function to test the SSH connection to GitHub
test_ssh_connection() {
    ssh -T git@github.com 2>&1 | grep -q "successfully authenticated"
    return $?
}

# Main function that loops until the configuration is valid
configure_git_and_ssh() {
    configure_git
    configure_ssh

    echo "Testing SSH connection to GitHub..."
    if test_ssh_connection; then
        echo "Git and SSH configuration successful!"
    else
        echo "SSH connection failed. Let's try the steps again."
        configure_git_and_ssh
    fi
}

# Start the configuration process
configure_git_and_ssh
