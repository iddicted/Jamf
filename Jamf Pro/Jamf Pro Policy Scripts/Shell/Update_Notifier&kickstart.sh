#!/bin/bash

############################### DESCRIPTION ###############################
# This script is used to send a Notification to devices, that an update is required
# The Notification window features and 'OK' Button
# Clicking the 'OK' Button will kickstart the software update process (launchctl kickstart -k system/com.apple.softwareupdated )
# and open the Software Update System Preferences window
# All other windows will become hidden prior to that
# Author: @iddicted
##########################################

# Variables
title="${4}" # Use Script paramater to set the window title
version="${5}" # Use Script paramater to set macOS Version
icon="${6}" # # Use Script paramater to set the displayed icon

# Hide all active Windows
#osascript <<'EOF'
#tell application "Finder"
#set visible of every process whose visible is true and name is not "Finder" to false
#close every window 
#end tell
#EOF

# Displaying a message to the user to inform about the required update
osascript <<EOF
display dialog "Your Mac needs to be updated to $version! \n\nThis is a required update, and it has been approved by the Client IT Team. \nClicking on 'OK' will prompt you to install the update. \n\nIMPORTANT: \nSave all your data to the Cloud. \nConnect your Mac to a power source. \n\nPlease click OK to continue!" with title "$title" with icon POSIX file "$icon" buttons {"OK"} default button 1
EOF

## -Kickstart the softwareupdate process:- ##
# In case the device was in a Configuration profile that defers updates for a certain amount of days
# and the profile gets removed, the Mac does not automatically find the software updates right away. It needs a reboot first.
# this can be solved running this command:

launchctl kickstart -k system/com.apple.softwareupdated


# open System Preferences > Software udpates.
# In case the user will have to click on isntall.
open 'x-apple.systempreferences:com.apple.preferences.softwareupdate'
