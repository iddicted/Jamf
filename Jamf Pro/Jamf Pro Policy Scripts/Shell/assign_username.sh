#!/bin/bash
# Author: @iddicted

# read the short name of last user logged in and flow it up to the computer record in JSS

FinalUserName=""

# read the short name of last user logged in
LastUser="$( /usr/bin/defaults read /Library/Preferences/com.apple.loginwindow lastUserName )"

# try to get network user name (available with Jamf Connect, not with NoMAD Pro)
NetworkUser="$( /usr/bin/dscl . -read /Users/${LastUser} | grep "NetworkUser" | awk -F': ' '{print $2}' )"

# prefer NetworkUser if available
if [[ -n "${NetworkUser}" ]]; then
	FinalUserName=${NetworkUser}
else
	FinalUserName=${LastUser}
fi
echo "Determined user name as ${FinalUserName}."

# push it to jamf
jamf recon -endUsername "${FinalUserName}" \
	&& echo "Sent inventory and username to Jamf Pro" \
	|| echo "Error sending inventory and username to Jamf Pro"

exit 0
