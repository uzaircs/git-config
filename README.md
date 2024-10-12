# Git & SSH Configuration Script

This bash script helps you configure your Git email, username, and SSH key for seamless Git authentication using SSH. The script will ask for your Git credentials, allow you to paste or provide a path to your private key, and test your SSH connection to GitHub. If the configuration is invalid, the script will retry the setup process.

## Features

- Sets global Git email and username.
- Adds an SSH private key to the SSH agent.
- Option to either paste the private key or provide the key's file path.
- Tests the SSH connection to GitHub.
- Automatically retries if the SSH connection fails.

## Prerequisites

Before using this script, ensure that:
- You have Git installed on your system.
- You have an existing SSH key or plan to paste a valid private key.

## Usage

1. **Clone or download the script:**

```bash
   git clone <repository-url>
   cd <repository-directory>
```
2. **Make the script executable:**

```bash
   chmod +x git_setup.sh
```
3 **Run the script:**
```bash
./git_setup.sh
```

Follow the prompts:

- Enter your Git email and username when prompted.
- You can either paste your SSH private key or provide the path to your private key file.
- The script will automatically test the SSH connection to GitHub.
- If the connection fails, it will ask you to re-enter your credentials and try again.


## Example

```bash
$ ./git_setup.sh
Enter your Git email:
user@example.com

Enter your Git username:
JohnDoe

Would you like to paste your private key or enter the path to the key?
Type 'paste' to paste the key or 'path' to provide the path:
path

Enter the path to your private key:
~/.ssh/id_ed25519

Testing SSH connection to GitHub...
Hi JohnDoe! You've successfully authenticated, but GitHub does not provide shell access.

Git and SSH configuration successful!
```
