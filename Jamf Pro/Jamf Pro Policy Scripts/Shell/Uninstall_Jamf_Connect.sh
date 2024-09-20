#!/bin/bash
# Author: @iddicted



# Reset auth db
echo "Resetting the authentication database"
sudo /usr/local/bin/authchanger -reset

# Removing JC menu bar app
echo "killing JC process"
pkill "Jamf Connect"

# removing authchanger
rm /usr/local/bin/authchanger
#removing pam
rm /usr/local/lib/pam/pam_saml.so.2

# removing JCL bundle
rm -r /Library/Security/SecurityAgentPlugins/JamfConnectLogin.bundle

# removing JC App
echo "Removing JC"
sudo rm -rf /Applications/Jamf\ Connect.app

echo "Removing Launch Agent"
sudo rm -f /Library/LaunchAgents/com.jamf.connect.plist



# Reboot mac
echo "Initiating reboot sequence"
shutdown -r +5 &
exit 0



