#!/bin/bash
## v1.0
## Author: @iddicted

## This script is used as a Computer Extension Attribute in Jamf Pro to report if EULA agreement has been done.


# Declare a default variable value of Not Installed.
eaResult="Not Accepted"

# Declare the path for the eula accepted file
eulaAgreement="/var/tmp/com.depnotify.agreement.done"

# Check if the file exists.
if [[ -f $eulaAgreement ]]; then
    eaResult="Accepted"
fi

# Echo the eaResult variable for the Extension Attribute value.
/bin/echo "<result>$eaResult</result>"
