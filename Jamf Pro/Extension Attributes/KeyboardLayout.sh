#!/bin/sh
# Author: @iddicted
#Fetching the current set layout
KeyboardLayout=$(defaults read com.apple.HIToolbox.plist AppleCurrentKeyboardLayoutInputSourceID | awk -F'[= |.]' '{print $4}')

echo "<result>$KeyboardLayout</result>"