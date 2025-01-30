#!/bin/bash

sudo apt install git

# Clone the repository if it doesn't exist
if [ ! -d "$HOME/linux" ]; then
    echo "Cloning the repository..."
    git clone https://github.com/sds-osint/linux.git "$HOME/linux"
else
    echo "Repository already exists. Skipping clone."
fi

# Make the update.sh script executable
if [ -f "$HOME/linux/update.sh" ]; then
    echo "Making update.sh executable..."
    chmod +x "$HOME/linux/update.sh"
else
    echo "update.sh does not exist in the linux directory."
    exit 1
fi

# Add to crontab if not already present
CRONJOB="@daily $HOME/linux/update.sh"
CRONTAB=$(crontab -l 2>/dev/null || true)

if echo "$CRONTAB" | grep -qF "$CRONJOB"; then
    echo "Cron job already exists. Skipping addition."
else
    echo "Adding cron job to crontab..."
    (echo "$CRONTAB"; echo "$CRONJOB") | crontab -
fi

echo "Setup complete."
