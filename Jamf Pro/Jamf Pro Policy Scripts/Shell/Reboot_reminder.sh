#!/bin/bash

##############
# This script checks for the current uptime in days 
# If the specified uptime is reached, it will display a message
# The message is displayed using JamfHelper

# Author: @iddicted
##############



########## Checking for uptime ############

# check for last boottime (unixtime)
lastBootRaw=$(sysctl kern.boottime | awk -F'[= |,]' '{print $6}')

#today=$(date +%s)
today=$(date -v+0d +%s) ###########For Testing #############################################

# convert into days
diffDays=$(( (today - lastBootRaw) / 86400 ))


# Displaying notification window including the current uptime
/Library/Application\ Support/JAMF/bin/jamfHelper.app/Contents/MacOS/jamfhelper -windowType utility -heading "Reboot Recommended" -description "Your Mac has not been rebooted for $diffDays days. 

Please restart your device to keep everything running smoothly ;) " -icon /System/Library/CoreServices/CoreTypes.bundle/Contents/Resources/com.apple.macbook-retina-space-gray.icns -button1 "Ok, will do." &
