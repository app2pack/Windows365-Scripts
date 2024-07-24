To retrieve Windows 365 Cloud PCs with connection issues and specific health statuses from Microsoft Intune, you can use the Microsoft Graph API.
PowerShell can be used to interact with the Graph API to fetch the relevant device details.

Prerequisites
1. You need the `Microsoft.Graph` PowerShell module.
2. You must have appropriate permissions to access Intune data via the Microsoft Graph API.
3. You need to authenticate with the Microsoft Graph API.

Explanation:

1. Install and Import Microsoft.Graph Module: The script ensures the `Microsoft.Graph` module is installed and imported.
2. Authenticate to Microsoft Graph: You need to authenticate to Microsoft Graph with appropriate scopes. This script uses `DeviceManagementManagedDevices.Read.All` scope.
3. Get Devices with Issues: The `Get-CloudPCWithIssues` function fetches all managed devices and filters those that are Windows 365 Cloud PCs with the specified health statuses.
4. Display the Results: The script formats and displays the results.
5. Disconnect: Finally, the script disconnects from the Microsoft Graph session.

Make sure you run this script in an environment where you have the necessary permissions and access to the Microsoft Graph API. 
Also, you might need to adjust the filtering logic based on the exact properties and values returned by your Intune environment.
