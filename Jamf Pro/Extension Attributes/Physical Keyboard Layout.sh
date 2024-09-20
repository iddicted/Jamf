#!/bin/bash
PhysicalKeyboardLanguage=$(ioreg -l | grep KeyboardLanguage | cut -d\" -f 4)

echo "<result>${PhysicalKeyboardLanguage}</result>"
