#!/bin/bash
################################################################################
# This script is used to check the firmware password and erase a Mac.
# It is specifically designed to check for multiple different FW passwords if unsure which one was used on the device.
# It will check the firmware password of the Mac and trigger the appropriated policy in Jamf Pro,
# to remove the firmware password from the Mac and delete the Mac.
# IF the firmware password can not be identified it will display a message to contact IT.
# Checks if the current user is admin
# Checks if Mac uses a T1 or T2+ security Chip
# -T1 use startosinstall command (Erase assistant not supported)
# -T2 launch Erase assistant.
# to be used with Intel Chip Macs

# Author: @iddicted


################################################################################

# Jamf Pro Paramenters for use with policies
Password1="$4"
Password2="$5"
Password3="$6"
Password4="$7"
Password5="$8"
Password6="$9"

## Exporting into Environment Variables ##
export oldpass1="$Password1"
export oldpass2="$Password2"
export oldpass3="$Password3"
export oldpass4="$Password4"
export oldpass5="$Password5"
export oldpass6="$Password6"


# Variables
UserName="$(/usr/bin/defaults read /Library/Preferences/com.apple.loginwindow lastUserName)"
jamfHelper="/Library/Application Support/JAMF/bin/jamfHelper.app/Contents/MacOS/jamfHelper"
helper_icon="/System/Library/CoreServices/Diagnostics Reporter.app/Contents/Resources/AppIcon.icns"
securityChip="$(/usr/sbin/system_profiler SPiBridgeDataType | /usr/bin/awk -F": " '/Model Name/ {print $NF}')"


################################################################################
# Check if user is admin
if groups $UserName | grep -q -w admin; 
then 
    echo "Is admin"; 
else 
    echo "Not admin"; 
   "$jamfHelper" -windowType hud -lockhud -title "Admin Account Required" -description "Please use 'Privileges' app to elevate your permissions and try again." -icon "$helper_icon" &
   echo "Could not continue, admin permissions required"
   sleep 5
   /usr/bin/open -b "corp.sap.privileges" &
   exit 1;

fi

############ Function for Displaying a message to the user to inform about error 
HelperErrorNotication() {
   ##### Notification Message can be changed #####
   inprogress="Your Macbook could not be deleted.

   An error occured while preparing the Mac for deletion.

   Please Contact the IT Team for assistance!"

   # Send Notification Window
   "$jamfHelper" -windowType hud -lockhud -title "Upgrade Required" -description "$inprogress" -icon "$helper_icon" &
}

T1DeletionNotification() {
   ##### Notification Message can be changed #####
   inprogress="Your Macbook is now preparing for deletion.

   This process is happening in the background and can take a while.

   Your Mac will then be rebooted and re-installed.

   Please connect the device to power adapter and internet, and wait for the installation to complete."

   # Send Notification Window
   "$jamfHelper" -windowType hud -lockhud -title "Erasing Mac" -description "$inprogress" -icon "$helper_icon" &
}

###### Function for displaying HelperErrorNotication 
# if firmware password check failed the notification will be displayed to the user
displayErrorMessage () {
if [[ "$errorCode" -eq 1 ]]; 
then
   HelperErrorNotication
   exit 0
fi
}



##########################################################################################################
######################### starting FW Password verification ########################################
# IMPORTANT: Each run requires a new password to be entered in the Jamf Pro Parameters
# If only two passwords are entered in the Jamf Pro Parameters, you have to remove the runs below so only 2 loops are performed.
echo ""
echo "Testing all Firmware passwords"
echo "##############################"

/usr/bin/expect -c '

# set password and check if the specified password matches the firmware password.

# Run 1
set oldpass $env(oldpass1)
spawn firmwarepasswd -verify
expect { 
	"Enter password:" { 
		send "$oldpass\r" 
		exp_continue
    }
   "ERROR | main | Exiting with error: 4" {
   #exit 1
	}
   "Correct" {
   exit 10
   }
}


# Run 2: Continue if the password is was not correct
set oldpass $env(oldpass2)
spawn firmwarepasswd -verify
expect { 
	"Enter password:" { 
		send "$oldpass\r" 
		exp_continue
    }
   "ERROR | main | Exiting with error: 4" {
   #exit 1
	}
   "Correct" {
   exit 11
   }
}

# Run 3: Continue if the password is was not correct
set oldpass $env(oldpass3)
spawn firmwarepasswd -verify
expect { 
	"Enter password:" { 
		send "$oldpass\r" 
		exp_continue
    }
   "ERROR | main | Exiting with error: 4" {
   #exit 1
	}
   "Correct" {
   exit 12
   }
}

# Run 4: Continue if the password is was not correct
set oldpass $env(oldpass4)
spawn firmwarepasswd -verify
expect { 
	"Enter password:" { 
		send "$oldpass\r" 
		exp_continue
    }
   "ERROR | main | Exiting with error: 4" {
   #exit 1
	}
   "Correct" {
   exit 13
   }
}


# Run 5: Continue if the password is was not correct
set oldpass $env(oldpass5)
spawn firmwarepasswd -verify
expect { 
	"Enter password:" { 
		send "$oldpass\r" 
		exp_continue
    }
   "ERROR | main | Exiting with error: 4" {
   #exit 1
	}
   "Correct" {
   exit 14
   }
}

# Run 6: Continue if the password is was not correct
set oldpass $env(oldpass6)
spawn firmwarepasswd -verify
expect { 
	"Enter password:" { 
		send "$oldpass\r" 
		exp_continue
    }
   "ERROR | main | Exiting with error: 4" {
   #exit 1
	}
   "Correct" {
   exit 15
   }
}
'
########################## Evaluating the output of the expect script ##############################
# If the output of the expect script is 10, 11, 12, 13, 14, 15, it will set exit with specific error code and set the FWPW variable

exitCode="$?"

if [ "$exitCode" -eq "10" ]; then
   FWPW="$oldpass1"
elif [ "$exitCode" -eq "11" ]; then
   FWPW="$oldpass2"
elif [ "$exitCode" -eq "12" ]; then
   FWPW="$oldpass3"
elif [ "$exitCode" -eq "13" ]; then
   FWPW="$oldpass4"
elif [ "$exitCode" -eq "14" ]; then
   FWPW="$oldpass5"
elif [ "$exitCode" -eq "15" ]; then
   FWPW="$oldpass6"
   #/usr/local/bin/jamf policy -event "Delete_Mac_6"
else
   echo "#####################################################"
   echo "The password did not match the set firmware password."
   HelperErrorNotication # Display a message to the user to inform about error
   exit 1
fi


####### Checking again, just in case #######
# Jamf Logs should show 'Correct' if the password is correct
echo ""
echo "Trying again with correct password"
echo ""

# Exporting the password to evnironment to be used with next script
export FWPW="$FWPW"



/usr/bin/expect -c '
set correctPW $env(FWPW)
spawn firmwarepasswd -verify
expect { 
	"Enter password:" { 
		send "$correctPW\r" 
		exp_continue
    }
   "ERROR | main | Exiting with error: 4" {
	}
   "Correct" {
   exit 0
   }
}
'
exitCode="$?"
displayErrorMessage
echo ""
echo "Removing firmware password"
# Now that we are certain, that the password is correct, we can delete the Firwmare password
# remove firmware password 
/usr/bin/expect -c '
set correctPW $env(FWPW)
spawn firmwarepasswd -delete
expect { 
   "Enter password:" { 
      send "$correctPW\r" 
      exp_continue
   }
   "ERROR | main | Exiting with error: 5" {
   exit 1
   }
   "Correct" {
   exit 0
   }
}
'

exitCode="$?"
displayErrorMessage

if [ "$exitCode" -eq "0" ]; then
   # Offer correct method for wipe depending on Security Chip
   if [[ "$securityChip" == *"T2"* ]]; then
      echo "Sucessfull removed Firmware Password. Launching Erase Process."
      /usr/bin/open /System/Library/CoreServices/Erase\ Assistant.app & # Launch Erase Assistant
   elif [[ "$securityChip" == *"T1"* ]]; then
    InstallerFile=$(find /Applications -type f -name startosinstall)
   	echo "Sucessfull removed Firmware Password. Launching Erase Process."
    "$InstallerFile" --eraseinstall --forcequitapps --agreetolicense --newvolumename 'Macintosh HD' & # Trigger the command to delete the Mac
    T1DeletionNotification # Display a message to the user to inform about deletion
   fi
fi
exit 0