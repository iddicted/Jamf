#!/bin/sh


JCloginEnabled=$(authchanger -print | grep JamfConnectLogin)
if [ $? == 0 ]; then
   echo "<result>Enabled</result>"
    else
        echo "<result>Disabled</result>"

fi