#!/bin/sh

sshkeyName = "$4"

# Generate ssh key without passphrase
ssh-keygen -t rsa -f ~/.ssh/$sshkeyName -N ""
# copy public key to clipboard
pbcopy < ~/.ssh/$sshkeyName.pub
# paste into new file on desktop
pbpaste > ~/Desktop/$sshkeyName.txt

echo "SSH key '$sshkeyName' generated and public key copied to clipboard. File '$sshkeyName.txt' created on Desktop "
