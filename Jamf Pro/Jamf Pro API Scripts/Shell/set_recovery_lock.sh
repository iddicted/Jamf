#!/bin/zsh --no-rcs

# Script to set Recovery Lock on all computers in a specified Smart Group in Jamf Pro
# Requires: jq, curl
# Preparation:
# 1. Create a Smart Group with the following criteria:
# 	Criteria: "Recovery Lock Enabled"
# 	Operator: "is"
# 	Value: "Not Enabled"
# 2. Open the smart group and copy the ID from the URL
# 3. Replace the placeholders in the script with your Jamf Pro URL, client ID, client secret, and Smart Group ID
# by Raphael Eckersley
# Date: 2023-10-30
# Version: 1.0
#####



#### Configuration Variables ####
JamfProURL="JAMF_PRO_URL_HERE" # Replace with your Jamf Pro URL
client_id="CLIENT_ID_HERE" # Replace with your client ID
client_secret="CLIENT_SECRET_HERE" # Replace with your client secret
GroupID="42" # Replace with your Smart Group ID
#### End Configuration Variables ####


#### Authentication Functions ####
getAccessToken() {
    response=$(curl --silent --location --request POST "${JamfProURL}/api/oauth/token" \
        --header "Content-Type: application/x-www-form-urlencoded" \
        --data-urlencode "client_id=${client_id}" \
        --data-urlencode "grant_type=client_credentials" \
        --data-urlencode "client_secret=${client_secret}")
    access_token=$(echo "$response" | jq -r '.access_token')
    token_expires_in=$(echo "$response" | jq -r '.expires_in')
    token_expiration_epoch=$(($current_epoch + $token_expires_in - 1))
	if [[ "$response" == *error* ]]; then
		echo "Failed to retrieve access token or expiration time."
		exit 1
	fi
	echo "Access token retrieved successfully."
	echo "Token expires in: $token_expires_in seconds"
}
checkTokenExpiration() {
    current_epoch=$(date +%s)
    if [[ token_expiration_epoch -ge current_epoch ]]
    then
        echo "Token valid until the following epoch time: " "$token_expiration_epoch"
    else
        echo "No valid token available, getting new token"
        getAccessToken
    fi
}
invalidateToken() {
    responseCode=$(curl -w "%{http_code}" -H "Authorization: Bearer ${access_token}" $JamfProURL/api/v1/auth/invalidate-token -X POST -s -o /dev/null)
    if [[ ${responseCode} == 204 ]]
    then
        echo "Token successfully invalidated"
        access_token=""
        token_expiration_epoch="0"
    elif [[ ${responseCode} == 401 ]]
    then
        echo "Token already invalid"
    else
        echo "An unknown error occurred invalidating the token"
    fi
}
###### End Authentication Functions #####


#### Main Script Execution #####
# check / get access token
echo "#### Checking / retrieving access token ####"
checkTokenExpiration



# BEGIN API COMMANDS #
echo "#### Authentication successful. proceeding with API commands ####"
echo ""
# Get members of Smart Computer Group
group_members=$(curl --request GET \
	--url "$JamfProURL/api/v2/computer-groups/smart-group-membership/$GroupID" \
	--silent \
	--header 'accept: application/json' \
	--header "Authorization: Bearer ${access_token}")

# echo "DEBUG $group_members"

# extract computer IDs from the group members
computer_ids=$(echo "$group_members" | jq -r '.members[]')

# iterate through each computer ID
echo "$computer_ids" | while read -r computer_id; do
	[[ -z "$computer_id" ]] && continue
	echo "#################### Processing computer ID: $computer_id ####################"
	# get computer inventory information by computer ID
	echo "Getting management ID for computer ID: $computer_id"
	computer_inventory=$(curl -s --location --request GET "${JamfProURL}/api/v1/computers-inventory-detail/${computer_id}" \
	--header "accept: application/json" \
	--header "Authorization: Bearer ${access_token}")

	managementId=$(echo "$computer_inventory" | tr -d '\000-\037' | jq -r '.general.managementId')
	echo "Management ID: $managementId"

	# set recovery lock
	echo "Setting Recovery Lock for Management ID: $managementId"
	response=$(curl -s -w "%{http_code}" -o /tmp/set_recovery_lock_response.json \
	--location \
	--request POST "${JamfProURL}/api/v2/mdm/commands" \
	--header "Authorization: Bearer $access_token" \
	--header "Content-Type: application/json" \
	--data-raw "{
		\"clientData\": [
			{
				\"managementId\": \"${managementId}\",
				\"clientType\": \"COMPUTER\"
			}
		],
		\"commandData\": {
			\"commandType\": \"SET_RECOVERY_LOCK\",
			\"newPassword\": \"\"
		}
	}")

	echo "Response code: $response"
	if [[ "$response" -eq 201 ]]; then
		echo "Recovery Lock set successfully."
	else
		echo "Failed to set Recovery Lock. Response code: $response"
		cat /tmp/set_recovery_lock_response.json
	fi
	echo "#################### Finished processing computer ID: $computer_id ####################"
	echo ""
done
# END API COMMANDS #

echo ""
checkTokenExpiration
invalidateToken
