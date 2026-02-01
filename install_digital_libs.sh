#! /bin/bash -l

echo "Setting up ssh key"

KEY_FILE="/run/secrets/SSH_PRIVATE_KEY"
PHRASE_FILE="/run/secrets/SSH_PASSPHRASE"

SSH_PRIVATE_KEY=$(cat $KEY_FILE)

if [ -f $PHRASE_FILE ]; then
    SSH_PASSPHRASE=$(cat $PHRASE_FILE)
fi


echo "passphrase: $SSH_PASSPHRASE"
echo "private key: $SSH_PRIVATE_KEY"

eval $(ssh-agent -s)

echo 'echo $SSH_PASSPHRASE' > ~/.ssh_askpass && chmod +x ~/.ssh_askpass

echo "$SSH_PRIVATE_KEY" | tr -d '\r' | DISPLAY=None SSH_ASKPASS=~/.ssh_askpass ssh-add - >/dev/null

ssh-add -l # debug SSH Key

echo "Downloading Digital Library..."

if [ -f "$KEY_FILE" ]; then
    echo "SSH key found. cloning digital-lib via SSH..."
    fusesoc library add digital-lib git@github.com:Purdue-SoCET/digital-lib.git || {
        echo "Failed to fetch digital-lib using SSH."
        exit 1
    }
else
    echo "Cloning digital-lib via HTTPS..."
    fusesoc library add digital-lib https://github.com/Purdue-SoCET/digital-lib.git || {
        echo "HTTPS clone failed, continuing locally."
    }
fi

echo "Downloading Bus Components..."

if [ -f "$KEY_FILE" ]; then
    echo "SSH key found, cloning bus-components via SSH..."
    fusesoc library add bus-components git@github.com:Purdue-SoCET/bus-components.git || {
        echo "Failed to fetch bus, components using SSH."
        exit 1
    }
else
    echo "No SSH key, cloning bus-components via HTTPS..."
    fusesoc library add bus-components https://github.com/Purdue-SoCET/bus-components.git || {
        echo "HTTPS clone failed, continuing (local mode)."
    }
fi

echo "Removing ssh key"

rm -r ~/.ssh
rm ~/.ssh_askpass
