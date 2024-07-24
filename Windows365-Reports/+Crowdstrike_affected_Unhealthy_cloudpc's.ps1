# Install Microsoft.Graph module if not already installed
if (-not (Get-Module -ListAvailable -Name Microsoft.Graph)) {
    Install-Module -Name Microsoft.Graph -Scope CurrentUser -Force
}

# Import the module
Import-Module Microsoft.Graph

# Authenticate to Microsoft Graph
$scopes = @("DeviceManagementManagedDevices.Read.All")
Connect-MgGraph -Scopes $scopes

# Function to get devices with specific health statuses
function Get-CloudPCWithIssues {
    param (
        [string[]]$HealthStatuses = @("ErrorResourceUnavailable", "ErrorResourceUnavailable_CustomerInitiatedActions")
    )

    # Get all managed devices
    $devices = Get-MgDeviceManagementManagedDevice -All

    # Filter devices based on the health statuses
    $problematicDevices = $devices | Where-Object {
        $_.ManagedDeviceOwnerType -eq "windows365" -and $_.HealthStatus -in $HealthStatuses
    }

    return $problematicDevices
}

# Get devices with connection issues and specific health statuses
$problematicDevices = Get-CloudPCWithIssues

# Display the results
$problematicDevices | Format-Table -Property DisplayName, UserPrincipalName, HealthStatus, DeviceId

# Disconnect from Microsoft Graph
Disconnect-MgGraph
