
#!/bin/bash

# Must run as root
if [ "$EUID" -ne 0 ]; then
  echo "[!] Please run this script as root (use sudo)"
  exit 1
fi

# Ask for username and password
read -p "Enter the new username: " username
read -s -p "Enter password for $username: " password
echo ""

# Detect OS Type
if [ -f /etc/os-release ]; then
  . /etc/os-release
  os_name=$ID
else
  echo "[!] Cannot detect OS."
  exit 1
fi

# Check if user already exists
if id "$username" &>/dev/null; then
  echo "[!] User '$username' already exists!"
  exit 1
fi

# Create user and set password
useradd -m "$username"
if [ $? -ne 0 ]; then
  echo "[X] Failed to create user '$username'."
  exit 1
fi

echo "$username:$password" | chpasswd
if [ $? -ne 0 ]; then
  echo "[X] Failed to set password for '$username'."
  exit 1
fi

# Assign to sudo or wheel group based on OS
case "$os_name" in
  ubuntu|debian)
    usermod -aG sudo "$username"
    echo "$username ALL=(ALL) NOPASSWD:ALL" > "/etc/sudoers.d/$username"
    ;;
  centos|rhel|rocky|almalinux|ol)
    usermod -aG wheel "$username"
    echo "$username ALL=(ALL) NOPASSWD:ALL" > "/etc/sudoers.d/$username"
    ;;
  *)
    echo "[!] Unknown OS: $os_name — please add sudo rights manually for '$username'."
    exit 1
    ;;
esac

chmod 440 "/etc/sudoers.d/$username"
echo "[✔] User '$username' setup completed successfully with passwordless sudo."

