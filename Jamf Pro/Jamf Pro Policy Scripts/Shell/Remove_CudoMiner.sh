#!/bin/sh

########################################
# Script to remove Cudo miner and additional binaries
# Jamf Protect should automatically block this process
# However there might be some configuration files that we need to remove
# This script checks if the files are present and removes them if they are

# You can check the policy logs for more details

# Author: @iddicted
########################################

function removeFile() {
	if [[ -f ${file_name} ]]; # checking for a file
    then
        echo "File: '${file_name}' exists"
        rm -rf "${file_name}"
        echo "Removed '${file_name}'"
    elif [[ -d ${file_name} ]]; # if not a file, check for directory
        then
            echo "Directory: '${file_name}' exists"
            rm -rf "${file_name}"
            echo "Removed '${file_name}'"
    else 
        echo "File or Directory DOES NOT exist: '${file_name}'"

    fi 
}

file_name="/Applications/Cudo Miner.app" # Cudo Miner App
removeFile

file_name="/var/lib/cudo-miner/" # Main direcdtory for Parent process for settings binary
removeFile

file_name="/usr/local/cudo-miner/" # Child process Main directory
removeFile
