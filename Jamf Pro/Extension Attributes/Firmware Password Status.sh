#!/bin/bash
# only for intel cpu machines
# Author: @iddicted
FWPassCheck=$(/usr/sbin/firmwarepasswd -check)

if [[ "$FWPassCheck" =~ "Yes" ]]; then
    EA_RESULT="Set"
elif [[ "$FWPassCheck" =~ "No" ]]; then
   EA_RESULT="Not Set"
fi

echo "<result>${EA_RESULT}</result>"

exit 0
