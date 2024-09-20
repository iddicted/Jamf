#!/bin/bash
## v1.0
# Author: @iddicted
## This script is used as a Computer Extension Attribute in Jamf Pro to report if EULA agreement has been done.


# Declare a default variable value of Not Installed.
eaResult="Setup Pending"

# Declare the path for the eula accepted file
depnotifySetupDone="/var/tmp/com.depnotify.provisioning.restart"

# Check if the file exists.
if [[ -f $depnotifySetupDone ]]; then
    eaResult="Setup Done"
fi

# Echo the eaResult variable for the Extension Attribute value.
/bin/echo "<result>$eaResult</result>"
