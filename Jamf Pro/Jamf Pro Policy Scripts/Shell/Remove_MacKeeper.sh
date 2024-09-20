#!/bin/bash


###############################
# This Script is to be used with Jamf pro
# It can be triggered by Jamf Protect if desired
# The script checks for files installed by the Mackeeper app and removes them if present
#
# You can check the policy log details for results.
# Author: @iddicted
###############################

# $3 == current user

# Remove launchAgents and kill process
declare -a MackeeperlaunchAgents=(
"/Users/$3/Library/LaunchAgents/com.zeobit.MacKeeper.Helper.plist"
"/Users/$3/Library/LaunchAgents/com.mackeeper.MacKeeper.Helper.plist" )

# Iterate through MacKeeper LaunchAgents to see if they exist and remove them
for file in "${MackeeperlaunchAgents[@]}"; do
   if [[ -f ${file} ]];
    then
        echo ""
        echo "LaunchAgent: '${file}' EXISTS. 
        Removing..."
        rm -rf "${file}"
        echo "removed file: '${file}' "
        echo ""
        # Unload Mackeeper extension
        echo "unloading agent"
        launchctl unload "${file}"
    else 
        echo ""
        echo "File or Directory does not exist: '${file}'"

    fi 
done


sleep 5

# Kill mackeeper processes
echo killing "MacKeeper Helper"
pkill "MacKeeper Helper"
echo killing "MKCleanService"
pkill "MKCleanService"
echo killing "MacKeeper"
pkill "MacKeeper"

# Declare MacKeeper related files
declare -a FileList=(
"/Applications/MacKeeper.app"
"/private/tmp/MacKeeper"
"/private/var/folders/mh/yprf0vxs3mx_n2lg3tjgqddm0000gn/T/MacKeeper"
"/Users/$3/Users/$3/Downloads/MacKeeper"
"/Users/$3/Users/$3/Documents/MacKeeper"
"/Users/$3/Library/Application Support/MacKeeper"
"/Users/$3/Library/Launch Agents/com.zeobit.MacKeeper.Helper.plist"
"/Users/$3/Library/Logs/MacKeeper.log"
"/Users/$3/Library/Logs/MacKeeper.log.signed"
"/Users/$3/Library/Logs/SparkleUpdateLog.log"
"/Users/$3/Library/Preferences/.3246584E-0CF8-4153-835D-C7D952862F9D"
"/Users/$3/Library/Preferences/com.zeobit.MacKeeper.Helper.plist"
"/Users/$3/Library/Preferences/com.zeobit.MacKeeper.plist"
"/Users/$3/Library/Saved Application State/com.zeobit.MacKeeper.savedState"
"/Users/$3/Library/Application Support/com.mackeeper.MacKeeper"
"/Users/$3/Library/Application Support/com.mackeeper.MacKeeper.Helper"
"/Users/$3/Library/Application Support/com.mackeeper.MacKeeper.MKCleanService"
"/Users/$3/Library/Preferences.3FAD0F65-FC6E-4889-B975-B96CBF807B78"
"/Users/$3/Library/Preferences/com.mackeeper.MacKeeper.Helper.plist"
"/Users/$3/Library/Preferences/com.mackeeper.MacKeeper.plist"
"/Users/$3/Library/Saved Application State/com.mackeeper.MacKeeper.savedState" )
 


# Iterate through Mackeeperfiles to see if they exist
for file in "${FileList[@]}"; do
   if [[ -f ${file} ]];
    then
        echo ""
        echo "File EXISTS: '${file}'"
        rm -rf "${file}"
       	echo "Removed file"
        echo ""

    elif [[ -d ${file} ]];
        then
            echo ""
            echo "Directory EXISTS: '${file}'"
            rm -rf "${file}"
            echo "Removed directory"
            echo ""
    else 
        echo "File or Directory does not exist: '${file}'"

    fi 
done
