#!/bin/sh
###########
# Script to determine the updtime of a mac in days
# Author: @iddicted

lastBootRaw=$(sysctl kern.boottime | awk -F'[= |,]' '{print $6}') # last reboot in unix time
today=$(date -v+0d +%s) # today in unix time
upTime=$(( (today - lastBootRaw) / 86400 ))

/bin/echo "<result>$upTime</result>"
