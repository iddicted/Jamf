#!/bin/sh
##################################################
# ABOUT:
# Can be triggered during login
# Waits for the dock to laod, before continuing with the script

# Author: @iddicted
##################################################

# Wait for dock befor executing the rest of the script
# This prevents the script from executing before the
# setup assistant is finished
counterfile="/usr/local/lockcounter.txt"

dockStatus=$(pgrep -x Dock)
echo "Waiting for Desktop to load..."
while [ "$dockStatus" == "" ]; do
  echo "Desktop is not loaded. trying again in 2 seconds."
  sleep 2
  dockStatus=$(pgrep -x Dock)
done

echo "Dock has loaded"
echo "Continuing..."

# check if counter file exists
if [[ -f $counterfile ]]; then
    # check for number in counterfile
    count=${cat $counterfile | grep '{print $3}'}
else
    #create counter file
    touch $counterfile
    echo "count = 1"
fi


JAMFHelper screen with Screen Lock to prevent users from
quitting out of JAMFHelper
function LockScreen() {
	"/Library/Application Support/JAMF/bin/jamfHelper.app/Contents/MacOS/jamfhelper" \
	-windowType "fs" \
	-heading "Please return this device!" \
	-description "You Mac needs to be sent back.
    Please contact your It department" \
	-icon /System/Library/CoreServices/CoreTypes.bundle/Contents/Resources/com.apple.macbook-retina-space-gray.icns \
	-iconSize "256" \
	-alignDescription "center" \
	-alignHeading "center" &

	sudo /System/Library/CoreServices/RemoteManagement/AppleVNCServer.bundle/Contents/Support/LockScreen.app/Contents/MacOS/LockScreen -session 256
}

#starting lockscreen
echo "Running Jamfhelper locksreen"
LockScreen &

sleep 60
sudo reboot


