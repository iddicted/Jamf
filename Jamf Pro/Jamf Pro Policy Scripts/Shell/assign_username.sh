#!/bin/bash
# Author: @iddicted

# read the short name of last user logged in and flow it up to the computer record in JSS

sFinalUserName=""

# read the short name of last user logged in
sLastUser="$( /usr/bin/defaults read /Library/Preferences/com.apple.loginwindow lastUserName )"

# try to get network user name (available with Jamf Connect, not with NoMAD Pro)
sNetworkUser="$( /usr/bin/dscl -plist . -read "/Users/${sLastUser}" "dsAttrTypeStandard:NetworkUser" | /usr/bin/xpath "//string[1]/text()" 2>/dev/null )"

# prefer NetworkUser if available
if [[ -n "${sNetworkUser}" ]]; then
	sFinalUserName=${sNetworkUser}
else
	sFinalUserName=${sLastUser}
fi
echo "Determined user name as ${sFinalUserName}."

# push it to jamf
jamf recon -endUsername "${sFinalUserName}" \
	&& echo "Sent inventory and username to Jamf Pro" \
	|| echo "Error sending inventory and username to Jamf Pro"

exit 0
