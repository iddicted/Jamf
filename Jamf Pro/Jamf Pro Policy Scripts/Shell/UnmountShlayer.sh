#!/bin/sh

# Description #
# This script is triggered by Jamf Protect
# It undmounts the volume where shlayer is mounted.
# Author: @iddicted


# Check for Precence of shlayer
declare -a FileList=(
"/Volumes/Install/.hidden/Install.command" )
 


# Iterate through filelist to see if they exist
for file in "${FileList[@]}"; do
   if [[ -f ${file} ]];
    then
        echo ""
        echo "File EXISTS: '${file}'"
        echo ""
        # Unmount the Volume
        echo "unmounting Volume"
        diskutil unmount "/Volumes/Install"
    else 
        echo "File or Directory does not exist: '${file}'"

    fi 
done