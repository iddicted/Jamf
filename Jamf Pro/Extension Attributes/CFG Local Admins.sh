#!/bin/bash

# copied from https://jamfnation.jamfsoftware.com/discussion.html?id=3506
# and slightly adapted by cvongablersahm

list=()

for username in $(dscl . list /Users UniqueID | awk '$2 > 500 { print $1 }'); do
    if [[ "$(dsmemberutil checkmembership -U "${username}" -G admin)" != *not* ]]; then
        list+=("${username}")
    fi
done

echo "<result>${list[@]}</result>"
