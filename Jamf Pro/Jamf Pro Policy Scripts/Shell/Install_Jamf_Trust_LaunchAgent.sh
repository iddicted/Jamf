#!/bin/sh
/bin/cat > "/Library/LaunchAgents/com.jamf.trust.plist" << 'JT_LaunchAgent'
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
 
<plist version="1.0">
    <dict>
        <key>KeepAlive</key>
        <true/>
        <key>Label</key>
        <string>com.jamf.trust</string>
        <key>LimitLoadToSessionType</key>
        <array>
            <string>Aqua</string>
        </array>
        <key>Program</key>
        <string>/Applications/Jamf Trust.app/Contents/MacOS/Jamf Trust</string>
        <key>RunAtLoad</key>
        <true/>
    </dict>
</plist>
JT_LaunchAgent