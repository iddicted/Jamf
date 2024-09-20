#!/bin/bash
## v1.0
## Author: @iddicted

## This script is used as a Computer Extension Attribute in Jamf Pro to report if Desktoppr is installed.


# Declare a default variable value of Not Installed.
eaResult="Not Installed"

# Declare the path for the binary file
desktopprBinary="/usr/local/bin/desktoppr"

# Check if the file exists.
if [[ -f $desktopprBinary ]]; then
    eaResult="Is Installed"
fi

# Echo the eaResult variable for the Extension Attribute value.
/bin/echo "<result>$eaResult</result>"
