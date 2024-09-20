#!/bin/bash


###############################
# This Script is to be used with Jamf pro
# It can be triggered by Jamf Protect if desired
# The script checks for files installed 
#
# You can check the policy log details for results.

# Author: @iddicted
###############################

# $3 == current user
file_1=${4}
file_2=${5}
file_3=${6}
file_4=${7}
file_5=${8}

# Declare files. You can add more files in the new lines if required.
declare -a FileList=(
"$file_1" )
 


# Iterate through filelist to see if they exist
for file in "${FileList[@]}"; do
   if [[ -f ${file} ]];
    then
        echo ""
        echo "File EXISTS: '${file}'"
        echo ""

    elif [[ -d ${file} ]];
        then
            echo ""
            echo "Directory EXISTS: '${file}'"
            echo ""
    else 
        echo "File or Directory does not exist: '${file}'"

    fi 
done
