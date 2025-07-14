#!/bin/bash

#Get current signed in user
currentUser=$(ls -l /dev/console | awk '/ / { print $3 }')

#com.jamf.connect.state.plist location
jamfConnectStateLocation=/Users/$currentUser/Library/Preferences/com.jamf.connect.state.plist

DisplayName=$(/usr/libexec/PlistBuddy -c "Print :DisplayName" $jamfConnectStateLocation || echo "Does not exist")

/usr/local/bin/jamf recon -endUsername $DisplayName -email $DisplayName