#!/bin/bash
################################ Description ################################
# This Script shows a prompt to enter the local mac password
# If the correct password is entered the window will close and scriipt can be continued
# If the wrong password is entered it will display an error and ask again (5 times total)
# After 5 wrong attempts it will display an error and text ($forgot_password variable is customisable)
# 
# 
# Author: @iddicted
# used password verification loop from James Barclay (@futureimperfect)

################################ Setting Variables #################################


# jamf pro variables #
app_name="${4}"
it_contact="${5}"

########### changable variables ###########
policyTrigger=""
filevaulticon="/System/Library/CoreServices/CoreTypes.bundle/Contents/Resources/FileVaultIcon.icns" # required
forgot_password="You made too many incorrect password attempts!
Please make sure your local password is in sync with your Okta Password.

To do this:
1. Click on the Okta icon in the top right Menubar.
2. Select 'Okta Signin + Mac Password Sync' and authenticate as usual.

If this works without a Sync prompt, then your Okta and Mac Passwords are the same.
If you need help, please contact $it_contact."




########### fixed variables ###########
jamf="/usr/local/bin/jamf"
jamfHelper="/Library/Application Support/JAMF/bin/jamfHelper.app/Contents/MacOS/jamfHelper"
logged_in_user="$(/usr/sbin/scutil <<< "show State:/Users/ConsoleUser" | /usr/bin/awk '/Name :/ && ! /loginwindow/ { print $3 }')" # required 
os_ver="$(/usr/bin/sw_vers -productVersion)"
os_major_ver="$(echo $os_ver | /usr/bin/cut -d . -f 1)" # required
os_minor_ver="$(echo $os_ver | /usr/bin/cut -d . -f 2)" # required
os_patch_ver="$(echo $os_ver | /usr/bin/cut -d . -f 3)"




 ################################ Verifying User Password #################################

# Get information necessary to display messages in the current user's context for the correct OS Version.
user_id=$(/usr/bin/id -u "$logged_in_user")
if [[ "$os_major_ver" -eq 10 && "$os_minor_ver" -le 9 ]]; then # for old OS version use "bsexec"
    l_id=$(pgrep -x -u "$user_id" loginwindow)
    l_method="bsexec"
elif [[ "$os_major_ver" -ge 11 || "$os_major_ver" -eq 10 && "$os_minor_ver" -gt 9 ]]; then # for newer OS versions use "asuser"
    l_id=$user_id
    l_method="asuser"
fi

filevaulticon_as="$(/usr/bin/osascript -e 'tell application "System Events" to return POSIX file "'"$filevaulticon"'" as text')"


## Get the logged in user's password via a prompt.
# Uses Osascript to display message and return the value that is input by the user

echo "Prompting $logged_in_user for their Mac password..."
#user_pw="$(/bin/launchctl "$l_method" "$l_id" /usr/bin/osascript -e 'display dialog "Please enter the password for the account you use to log in to your Mac:" default answer "" with title "FileVault Authentication Restart" giving up after 86400 with text buttons {"OK"} default button 1 with hidden answer with icon file "'"${filevaulticon_as//\"/\\\"}"'"' -e 'return text returned of result')"
user_pw="$(/bin/launchctl "$l_method" "$l_id" /usr/bin/osascript << EOF
return text returned of (display dialog "We are applying a security patch to your Mac.

First we need to verify your password. 

Please enter the password for the account \"$logged_in_user\" you use to log in to your Mac:" default answer "" with title "Security Patch Required" giving up after 86400 with text buttons {"OK"} default button 1 with hidden answer with icon file "${filevaulticon_as}")
EOF
)"


# Thanks to James Barclay (@futureimperfect) for this password validation loop.
TRY=1
until /usr/bin/dscl /Search -authonly "$logged_in_user" "$user_pw" &>/dev/null; do
    (( TRY++ ))
    if (( TRY >= 6 )); then
        echo "Password prompt unsuccessful after 5 attempts."
        "$jamfHelper" -windowType utility -icon "$filevaulticon" -title "Password Authentication Error" -description "$forgot_password" -button1 "OK" -defaultButton 1 &
        
        exit 1
    else
        echo "Prompting $logged_in_user for their Mac password (attempt $TRY)..."
        user_pw="$(/bin/launchctl "$l_method" "$l_id" /usr/bin/osascript -e 'display dialog "Sorry, that password was incorrect. Please try again:" default answer "" with title "Password Authentication Required" giving up after 86400 with text buttons {"OK"} default button 1 with hidden answer with icon file "'"${filevaulticon_as//\"/\\\"}"'"' -e 'return text returned of result')"
    
    fi
done
echo "Successfully prompted for Account password."
"$jamfHelper" -windowType utility -icon "$filevaulticon" -title "Password Authentication Successful" -description "Your Password has been successfully verified! 
Applying security patch... " -button1 "OK" -defaultButton 1 &

######################## End of Password verification ########################

# Script exits if more than five wrong password attempts
# Script continues if Password verification successful


################################ Place to put follow up commands #################################
 
# Triggering Firmware Password Change policy 
sudo jamf policy -event $policyTrigger