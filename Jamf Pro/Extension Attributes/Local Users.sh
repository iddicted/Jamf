#!/bin/bash
localAccounts=$(dscl . list /Users UniqueID | awk '$2 > 500 && $2 < 1000 { print $1 }')

echo "<result>${localAccounts}</result>"
