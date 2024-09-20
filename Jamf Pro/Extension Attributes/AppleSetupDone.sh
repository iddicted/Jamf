#!/bin/bash
# checks for presence of the AppleSetupdone file
# Author: @iddicted
FILE=/var/db/.AppleSetupDone
if [ -f "$FILE" ]; then
    echo "<result>Setup Done</result>"
fi
