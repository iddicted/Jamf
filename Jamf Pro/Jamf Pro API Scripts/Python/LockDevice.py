import requests
import pip._vendor.requests 


'''
This script sends a ComputerCommand to Jamf Pro to lock a devices
It requires the correct ID of the computer. (can be found in the Jamf Pro URL for this devices)
Lock Message and passcode can be defined as desired. 
For authentication a bearer token is required and needs to be entered into this script.
# Author: @iddicted
'''

# Replace these with your actual Jamf Pro Instance, API token and endpoint
JAMF_INSTANCE = '' 
JAMF_API_TOKEN = ''
JAMF_API_ENDPOINT = f'https://{JAMF_INSTANCE}.jamfcloud.com/JSSResource/computercommands/command/DeviceLock'

# Replace with the ID of the Macbook you want to lock, the Passcode and the lock message.
DEVICE_ID = '123'
PASSCODE ='123456'
LOCK_MESSAGE ='This computer belongs to <CompanyName>, If found please contact: +49 1529 00000000 / <email address>. Thank You!'


### NO MORE MANUAL EDITS FROM HERE ONWARDS ###
# XML template for the lock command
lock_xml = f'''
<computer_command>
    <general>
        <command>DeviceLock</command>
        <passcode>{PASSCODE}</passcode>
    <lock_message>{LOCK_MESSAGE}</lock_message>
    </general>
    <computers>
		<computer>
			<id>{DEVICE_ID}</id>
		</computer>
	</computers>
</computer_command>
'''

# Set up the request headers with the bearer token
headers = {
    'Content-Type': 'application/xml',
    'Authorization': f'Bearer {JAMF_API_TOKEN}'
}

# Send the request
response = requests.post(
    JAMF_API_ENDPOINT,
    headers=headers,
    data=lock_xml
)

# Check the response
if response.status_code == 201:
    print("Device lock command sent successfully.")
else:
    print("Failed to send device lock command.")
    print("Response:", response.text)
