import requests
import json

'''

This Script can be used to cleanup multiple Jamf configurations.
It first deletes the objects that might be a depency to others, to avoid errors and conflicts.
Uses bearer token authentication to cover both APIs (new + old).
Author: @iddicted
'''


# Set the Jamf Pro API URL and credentials
jamf_url = "https://domain.jamfcloud.com"
bearer_token =""

# Set the variables needed for each API Endpoint
macos_configuration_profiles = "/JSSResource/osxconfigurationprofiles"
mobiledevice_configuration_profiles = "/JSSResource/mobiledeviceconfigurationprofiles"
macos_policies = "/JSSResource/policies"
macos_packages = "/JSSResource/packages"
macos_scripts = "/JSSResource/scripts"
macos_extension_attributes = "/JSSResource/computerextensionattributes"
macos_groups = "/JSSResource/computergroups"
macos_apps = "/JSSResource/macapplications"
macos_advanced_searches = "/JSSResource/advancedcomputersearches"
mobiledevice_groups = "/JSSResource/mobiledevicegroups"
general_departments = "/JSSResource/departments"
general_categories = "/JSSResource/categories"
general_buildings = "/JSSResource/buildings"
general_sites = "/JSSResource/sites"
user_groups = "/JSSResource/usergroups"
general_restricted_software = "/JSSResource/restrictedsoftware"
# Define headers and authentication for API requests
headers = {
    'accept': 'application/json',
    'Authorization': f'Bearer {bearer_token}'
    }
    # auth = (api_username, api_password)

# Function to get all departments and delete them
def delete_departments():
    # Make API request to get all departments
    response = requests.get(jamf_url + general_departments, headers=headers)
    # print(response.text)
    # If the request is successful, delete each Policy
    if response.status_code == 200:
        departments = json.loads(response.text)['departments']
        print('Deleting ' + str(len(departments)) + ' departments')
        for department in departments:
            department_id = department['id']
            department_name = department['name']
            delete_response = requests.delete(jamf_url + general_departments + "/id/" + str(department_id), headers=headers)
            if delete_response.status_code == 200:
                print('department with ID ' + str(department_id) + str() + ' deleted successfully')
            else:
                print('Error deleting department with ID ' + str(department_id) + "and name: " + str(department_name) + ' error: ' + delete_response.text)
    else:
        print('Error getting policies: ' + response.text)

# Function to get all categories and delete them
def delete_categories():
    # Make API request to get all categories
    response = requests.get(jamf_url + general_categories, headers=headers)
    # print(response.text)
    # If the request is successful, delete each Policy
    if response.status_code == 200:
        categories = json.loads(response.text)['categories']
        print('Deleting ' + str(len(categories)) + ' categories')
        for category in categories:
            category_id = category['id']
            category_name = category['name']
            delete_response = requests.delete(jamf_url + general_categories + "/id/" + str(category_id), headers=headers)
            if delete_response.status_code == 200:
                print('category with ID ' + str(category_id) + str() + ' deleted successfully')
            else:
                print('Error deleting category with ID ' + str(category_id) + "and name: " + str(category_name) + ' error: ' + delete_response.text)
    else:
        print('Error getting policies: ' + response.text)

# Function to get all buildings and delete them
def delete_buildings():
    # Make API request to get all buildings
    response = requests.get(jamf_url + general_buildings, headers=headers)
    # print(response.text)
    # If the request is successful, delete each Policy
    if response.status_code == 200:
        buildings = json.loads(response.text)['buildings']
        print('Deleting ' + str(len(buildings)) + ' buildings')
        for building in buildings:
            building_id = building['id']
            building_name = building['name']
            delete_response = requests.delete(jamf_url + general_buildings + "/id/" + str(building_id), headers=headers)
            if delete_response.status_code == 200:
                print('building with ID ' + str(building_id) + str() + ' deleted successfully')
            else:
                print('Error deleting building with ID ' + str(building_id) + "and name: " + str(building_name) + ' error: ' + delete_response.text)
    else:
        print('Error getting policies: ' + response.text)

# Function to get all sites and delete them
def delete_sites():
    # Make API request to get all sites
    response = requests.get(jamf_url + general_sites, headers=headers)
    # print(response.text)
    # If the request is successful, delete each Policy
    if response.status_code == 200:
        sites = json.loads(response.text)['sites']
        print('Deleting ' + str(len(sites)) + ' sites')
        for site in sites:
            site_id = site['id']
            site_name = site['name']
            delete_response = requests.delete(jamf_url + general_sites + "/id/" + str(site_id), headers=headers)
            if delete_response.status_code == 200:
                print('site with ID ' + str(site_id) + str() + ' deleted successfully')
            else:
                print('Error deleting site with ID ' + str(site_id) + "and name: " + str(site_name) + ' error: ' + delete_response.text)
    else:
        print('Error getting policies: ' + response.text)

# Function to get all restricted softwares and delete them
def delete_restricted_software():
    # Make API request to get all sites
    response = requests.get(jamf_url + general_restricted_software, headers=headers)
    # print(response.text)
    # If the request is successful, delete each Policy
    if response.status_code == 200:
        restricted_softwares = json.loads(response.text)['restricted_software']
        print('Deleting ' + str(len(restricted_softwares)) + ' restricted_software')
        for software in restricted_softwares:
            software_id = software['id']
            software_name = software['name']
            delete_response = requests.delete(jamf_url + general_restricted_software + "/id/" + str(software_id), headers=headers)
            if delete_response.status_code == 200:
                print('software with ID ' + str(software_id) + str() + ' deleted successfully')
            else:
                print('Error deleting software with ID ' + str(software_id) + "and name: " + str(software_name) + ' error: ' + delete_response.text)
    else:
        print('Error getting policies: ' + response.text)


# Function to get all osx config profiles and delete them
def delete_macos_configuration_profiles():
    # Make API request to get all configuration profiles
    response = requests.get(jamf_url + macos_configuration_profiles, headers=headers)

    # If the request is successful, delete each configuration profile
    if response.status_code == 200:
        profiles = json.loads(response.text)['os_x_configuration_profiles']
        print('Deleting ' + str(len(profiles)) + ' profiles')
        for profile in profiles:
            profile_id = profile['id']
            profile_name = profile['name']
            delete_response = requests.delete(jamf_url + macos_configuration_profiles + "/id/" + str(profile_id), headers=headers)
            if delete_response.status_code == 200:
                print('Configuration profile with ID ' + str(profile_id) + str(profile_name) + ' deleted successfully')
            else:
                print('Error deleting configuration profile with ID ' + str(profile_id) + "and name: " + str(profile_name) + ' error: ' + delete_response.text)
    else:
        print('Error getting configuration profiles: ' + response.text)
# Function to get all mobile device config profiles and delete them
def delete_mobiledevice_configuration_profiles():
    # Make API request to get all configuration profiles
    response = requests.get(jamf_url + mobiledevice_configuration_profiles, headers=headers)


    # If the request is successful, delete each configuration profile
    if response.status_code == 200:
        profiles = json.loads(response.text)['configuration_profiles']
        print('Deleting ' + str(len(profiles)) + ' profiles')
        for profile in profiles:
            profile_id = profile['id']
            profile_name = profile['name']
            delete_response = requests.delete(jamf_url + mobiledevice_configuration_profiles + "/id/" + str(profile_id), headers=headers)
            if delete_response.status_code == 200:
                print('Configuration profile with ID ' + str(profile_id) + str(profile_name) + ' deleted successfully')
            else:
                print('Error deleting configuration profile with ID ' + str(profile_id) + "and name: " + str(profile_name) + ' error: ' + delete_response.text)
    else:
        print('Error getting configuration profiles: ' + response.text)
# Function to get all osx policies and delete them
def delete_macos_policies():
    # Make API request to get all policies
    response = requests.get(jamf_url + macos_policies, headers=headers)

    # If the request is successful, delete each Policy
    if response.status_code == 200:
        policies = json.loads(response.text)['policies']
        print('Deleting ' + str(len(policies)) + ' policies')
        for policy in policies:
            policy_id = policy['id']
            policy_name = policy['name']
            delete_response = requests.delete(jamf_url + macos_policies + "/id/" + str(policy_id), headers=headers)
            if delete_response.status_code == 200:
                print('Policy with ID ' + str(policy_id) + str() + ' deleted successfully')
            else:
                print('Error deleting Policy with ID ' + str(policy_id) + "and name: " + str(policy_name) + ' error: ' + delete_response.text)
    else:
        print('Error getting policies: ' + response.text)
# Function to get all packages and delete them
def delete_macos_packages():
    # Make API request to get all packages
    response = requests.get(jamf_url + macos_packages, headers=headers)
    # print(response.text)
    # If the request is successful, delete each Policy
    if response.status_code == 200:
        packages = json.loads(response.text)['packages']
        print('Deleting ' + str(len(packages)) + ' packages')
        for package in packages:
            package_id = package['id']
            package_name = package['name']
            delete_response = requests.delete(jamf_url + macos_packages + "/id/" + str(package_id), headers=headers)
            if delete_response.status_code == 200:
                print('Package with ID ' + str(package_id) + str() + ' deleted successfully')
            else:
                print('Error deleting package with ID ' + str(package_id) + "and name: " + str(package_name) + ' error: ' + delete_response.text)
    else:
        print('Error getting packages: ' + response.text)
# Function to get all scripts and delete them
def delete_macos_scripts():
    # Make API request to get all scripts
    response = requests.get(jamf_url + macos_scripts, headers=headers)
    # print(response.text)
    # If the request is successful, delete each Policy
    if response.status_code == 200:
        scripts = json.loads(response.text)['scripts']
        print('Deleting ' + str(len(scripts)) + ' scripts')
        for script in scripts:
            script_id = script['id']
            script_name = script['name']
            delete_response = requests.delete(jamf_url + macos_scripts + "/id/" + str(script_id), headers=headers)
            if delete_response.status_code == 200:
                print('Script with ID ' + str(script_id) + str() + ' deleted successfully')
            else:
                print('Error deleting script with ID ' + str(script_id) + "and name: " + str(script_name) + ' error: ' + delete_response.text)
    else:
        print('Error getting scripts: ' + response.text)
# Function to get all macos apps and delete them
def delete_macos_apps():
    # Make API request to get all apps
    response = requests.get(jamf_url + macos_apps, headers=headers)
    # print(response.text)
    # If the request is successful, delete each Policy
    if response.status_code == 200:
        mac_apps = json.loads(response.text)['mac_applications']
        print('Deleting ' + str(len(mac_apps)) + ' mac_apps')
        for app in mac_apps:
            app_id = app['id']
            app_name = app['name']
            delete_response = requests.delete(jamf_url + macos_apps + "/id/" + str(app_id), headers=headers)
            if delete_response.status_code == 200:
                print('app with ID ' + str(app_id) + str() + ' deleted successfully')
            else:
                print('Error deleting app with ID ' + str(app_id) + "and name: " + str(app_name) + ' error: ' + delete_response.text)
    else:
        print('Error getting mac_apps: ' + response.text)
# Function to get all macos advanced searches and delete them
def delete_macos_advanced_searches():
    # Make API request to get all advanced_searches
    response = requests.get(jamf_url + macos_advanced_searches, headers=headers)
    # print(response.text)
    # If the request is successful, delete each Policy
    if response.status_code == 200:
        mac_advanced_searches = json.loads(response.text)['advanced_computer_searches']
        print('Deleting ' + str(len(mac_advanced_searches)) + ' mac_advanced_searches')
        for advanced_search in mac_advanced_searches:
            advanced_search_id = advanced_search['id']
            advanced_search_name = advanced_search['name']
            delete_response = requests.delete(jamf_url + macos_advanced_searches + "/id/" + str(advanced_search_id), headers=headers)
            if delete_response.status_code == 200:
                print('advanced_search with ID ' + str(advanced_search_id) + str() + ' deleted successfully')
            else:
                print('Error deleting advanced_search with ID ' + str(advanced_search_id) + "and name: " + str(advanced_search_name) + ' error: ' + delete_response.text)
    else:
        print('Error getting mac_advanced_searches: ' + response.text)
# Function to delete all Groups
def delete_macos_groups():
    # Make API request to get all groups
    response = requests.get(jamf_url + macos_groups, headers=headers)
    # print(response.text)
    # Check: If the request is successful, delete each Policy
    if response.status_code == 200:
        groups = json.loads(response.text)['computer_groups']
        print('Deleting ' + str(len(groups)) + ' groups')
        # print(type(len(groups)))
        # Continue as long as groups still exist because of errors caused by group dependecies.
        while len(groups) > 0:
            for group in groups:
                group_id = group['id']
                group_name = group['name']
                delete_response = requests.delete(jamf_url + macos_groups + "/id/" + str(group_id), headers=headers)
                if delete_response.status_code == 200:
                    print('Group with ID ' + str(group_id) + str() + ' deleted successfully')
                else:
                    print('Error deleting group with ID ' + str(group_id) + "and name: " + str(group_name) + ' error: ' + delete_response.text)
            groups = json.loads(response.text)['computer_groups']
            return(groups)
    else:
        print('Error getting groups: ' + response.text)
# Function to delete all User Groups
def delete_user_groups():
    # Make API request to get all groups
    response = requests.get(jamf_url + user_groups, headers=headers)
    print(response.text)
    # Check: If the request is successful, delete each Policy
    if response.status_code == 200:
        groups = json.loads(response.text)['user_groups']
        print('Deleting ' + str(len(groups)) + 'user groups')
        # print(type(len(groups)))
        # Continue as long as groups still exist because of errors caused by group dependecies.
        while len(groups) > 0:
            for group in groups:
                group_id = group['id']
                group_name = group['name']
                delete_response = requests.delete(jamf_url + user_groups + "/id/" + str(group_id), headers=headers)
                if delete_response.status_code == 200:
                    print('Group with ID ' + str(group_id) + str() + ' deleted successfully')
                else:
                    print('Error deleting group with ID ' + str(group_id) + "and name: " + str(group_name) + ' error: ' + delete_response.text)
            groups = json.loads(response.text)['user_groups']
            return(groups)
    else:
        print('Error getting groups: ' + response.text)
# Function to get all macos extension attributes and delete them
def delete_macos_extension_attributes():
    # Make API request to get all extension_attributes
    response = requests.get(jamf_url + macos_extension_attributes, headers=headers)
    # print(response.text)
    # If the request is successful, delete each Policy
    if response.status_code == 200:
        extension_attributes = json.loads(response.text)['computer_extension_attributes']
        print('Deleting ' + str(len(extension_attributes)) + ' extension_attributes')
        for ea in extension_attributes:
            ea_id = ea['id']
            ea_name = ea['name']
            delete_response = requests.delete(jamf_url + macos_extension_attributes + "/id/" + str(ea_id), headers=headers)
            if delete_response.status_code == 200:
                print('ea with ID ' + str(ea_id) + str() + ' deleted successfully')
            else:
                print('Error deleting ea with ID ' + str(ea_id) + " and name: " + str(ea_name) + ' error: ' + delete_response.text)
    else:
        print('Error getting extension_attributes: ' + response.text)

def delete_mobile_device_groups():
    # Make API request to get all groups
    response = requests.get(jamf_url + mobiledevice_groups, headers=headers)
    # print(response.text)
    # Check: If the request is successful, delete each Policy
    if response.status_code == 200:
        mobile_device_groups = json.loads(response.text)['mobile_device_groups']
        print('Deleting ' + str(len(mobile_device_groups)) + ' groups')
        # print(type(len(groups)))
        # Continue as long as groups still exist because of errors caused by group dependecies.
        while len(mobile_device_groups) > 0:
            for group in mobile_device_groups:
                group_id = group['id']
                group_name = group['name']
                delete_response = requests.delete(jamf_url + mobiledevice_groups + "/id/" + str(group_id), headers=headers)
                if delete_response.status_code == 200:
                    print('Group with ID ' + str(group_id) + str() + ' deleted successfully')
                else:
                    print('Error deleting mobile device group with ID ' + str(group_id) + "and name: " + str(group_name) + ' error: ' + delete_response.text)
            
            mobile_device_groups = json.loads(response.text)['mobile_device_groups']
            return(mobile_device_groups)
    else:
        print('Error getting groups: ' + response.text)


######## RUN ALL FUCNTIONS ########
delete_departments()
delete_categories()
delete_buildings()
delete_sites()
delete_restricted_software()
delete_user_groups()
delete_macos_configuration_profiles()
delete_macos_policies()
delete_macos_packages()
delete_macos_scripts()
delete_macos_apps()
delete_macos_advanced_searches()
delete_macos_groups()
delete_macos_extension_attributes()
delete_mobiledevice_configuration_profiles()
delete_mobile_device_groups()
delete_user_groups()
