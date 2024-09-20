#!/bin/bash



########## Instructions ##########
# Checks for process name based on argument
# forcefully kills the process
# Author: @iddicted


####################

apptokill="$4"

# checking if app is running, and killing it, if true
PID=$(pgrep "$apptokill")
if [ "$?" -eq "0" ]; then
    echo "at least one instance of "$apptokill" found, killing all instances"
    kill -9 $PID
else
    echo "no running instances of "$apptokill" found, nothing to do"
fi