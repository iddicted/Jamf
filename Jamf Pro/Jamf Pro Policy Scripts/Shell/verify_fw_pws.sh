#!/bin/bash
################################################################################
# This script is used to check the firmware password of a Mac.
# It will check the firmware password of the Mac and trigger the appropriated policy in Jamf Pro,
# to remove the firmware password from the Mac and delete the Mac.
# IF the firmware password can not be identified it will display a message to contact IT.
# Author: @iddicted
################################################################################

# Jamf Pro Paramenters
Password1="xxx!"
Password2="xxx"
Password3="xxx"
Password4="xxx"
Password5="xxx"
Password6="xxx"
Password7="xxx"
Password8="xxx"
Password9="xxx!"
Password10="xxx"
Password11="xxx"
Password12="xxx!"
Password13="xxx!"






## Exporting into Environment Variables ##
export oldpass1="$Password1"
export oldpass2="$Password2"
export oldpass3="$Password3"
export oldpass4="$Password4"
export oldpass5="$Password5"
export oldpass6="$Password6"
export oldpass7="$Password7"
export oldpass8="$Password8"
export oldpass9="$Password9"
export oldpass10="$Password10"
export oldpass11="$Password11"
export oldpass12="$Password12"
export oldpass13="$Password13"



# Variables
UserName="$(/usr/bin/defaults read /Library/Preferences/com.apple.loginwindow lastUserName)"
jamfHelper="/Library/Application Support/JAMF/bin/jamfHelper.app/Contents/MacOS/jamfHelper"
helper_icon="/System/Library/CoreServices/Diagnostics Reporter.app/Contents/Resources/AppIcon.icns"
securityChip="$(/usr/sbin/system_profiler SPiBridgeDataType | /usr/bin/awk -F": " '/Model Name/ {print $NF}')"


############ Function for Displaying a message to the user to inform about error 
HelperNotification() {

##### Notification Message can be changed #####
inprogress="Your Macbook could not be deleted.

An error occured while preparing the Mac for deletion.

Please Contact the Client IT Team for assistance!"

# Send Notification Window
"$jamfHelper" -windowType hud -lockhud -title "Upgrade Required" -description "$inprogress" -icon "$helper_icon" &
}


############ Function for displaying HelperNotification if password check failed
displayErrorMessage () {
if [[ "$errorCode" -eq 1 ]]; 
then
   HelperNotification
   exit 0
fi
}



####################################################################################################
######################### starting FW Password verification ########################################
# IMPORTANT: Each run requires a new password to be entered in the Jamf Pro Parameters
# If only two passwords are entered in the Jamf Pro Parameters, you have to remove the runs below
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
   #exit 20
	}
   "Correct" {
   exit 15
   }
}

# Run 7: Continue if the password is was not correct
set oldpass $env(oldpass7)
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
   exit 16
   }
}

# Run 8: Continue if the password is was not correct
set oldpass $env(oldpass8)
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
   exit 17
   }
}

# Run 9: Continue if the password is was not correct
set oldpass $env(oldpass9)
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
   exit 18
   }
}

# Run 10: Continue if the password is was not correct
set oldpass $env(oldpass10)
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
   exit 19
   }
}

# Run 11: Continue if the password is was not correct
set oldpass $env(oldpass11)
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
   exit 20
   }
}

# Run 12: Continue if the password is was not correct
set oldpass $env(oldpass12)
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
   exit 21
   }
}

# Run 13: Continue if the password is was not correct
set oldpass $env(oldpass13)
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
   exit 22
   }
}
'
########################## Evaluating the output of the expect script ##############################
# If the output of the expect script is 10, 11, 12, 13, 14, 15, it will set exit with specific error code and set the FWPW variable

exitCode="$?"

if [ "$exitCode" -eq "10" ]; then
   FWPW="$oldpass1"
   echo "Correct Password is Pasword 1"
elif [ "$exitCode" -eq "11" ]; then
   FWPW="$oldpass2"
   echo "Correct Password is Pasword 2"
elif [ "$exitCode" -eq "12" ]; then
   FWPW="$oldpass3"
   echo "Correct Password is Pasword 3"
elif [ "$exitCode" -eq "13" ]; then
   FWPW="$oldpass4"
   echo "Correct Password is Pasword 4"
elif [ "$exitCode" -eq "14" ]; then
   FWPW="$oldpass5"
   echo "Correct Password is Pasword 5"
elif [ "$exitCode" -eq "15" ]; then
   FWPW="$oldpass6"
   echo "Correct Password is Pasword 6"
elif [ "$exitCode" -eq "16" ]; then
   FWPW="$oldpass7"
   echo "Correct Password is Pasword 6"
elif [ "$exitCode" -eq "17" ]; then
   FWPW="$oldpass8"
   echo "Correct Password is Pasword 6"
elif [ "$exitCode" -eq "18" ]; then
   FWPW="$oldpass9"
   echo "Correct Password is Pasword 6"
elif [ "$exitCode" -eq "19" ]; then
   FWPW="$oldpass10"
   echo "Correct Password is Pasword 6"
elif [ "$exitCode" -eq "20" ]; then
   FWPW="$oldpass11"
   echo "Correct Password is Pasword 6"
elif [ "$exitCode" -eq "21" ]; then
   FWPW="$oldpass12"
   echo "Correct Password is Pasword 6"
elif [ "$exitCode" -eq "22" ]; then
   FWPW="$oldpass13"
   echo "Correct Password is Pasword 6"
   #/usr/local/bin/jamf policy -event "Delete_Mac_6"
else
   echo "#####################################################"
   echo "The password did not match the set firmware password."
   HelperNotification # Display a message to the user to inform about error
   exit 1
fi