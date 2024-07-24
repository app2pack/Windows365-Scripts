# Install Microsoft.Graph module if not already installed
if (-not (Get-Module -ListAvailable -Name Microsoft.Graph)) {
    Install-Module -Name Microsoft.Graph -Scope CurrentUser -Force
}

# Import the module
Import-Module Microsoft.Graph

# Authenticate to Microsoft Graph
$scopes = @("DeviceManagementManagedDevices.Read.All", "DeviceManagementVirtualEndpoint.Read.All")
Connect-MgGraph -Scopes $scopes

# Function to get Cloud PCs with specific health statuses
function Get-CloudPCWithIssues {
    param (
        [string[]]$HealthStatuses = @("ErrorResourceUnavailable", "ErrorResourceUnavailable_CustomerInitiatedActions")
    )

    # Get all Cloud PCs
    $cloudPCs = Get-MgDeviceManagementVirtualEndpointCloudPC -All

    # Filter Cloud PCs based on the health statuses
    $problematicCloudPCs = $cloudPCs | Where-Object {
        $_.HealthStatus -in $HealthStatuses
    }

    return $problematicCloudPCs
}

# Get Cloud PCs with connection issues and specific health statuses
$problematicCloudPCs = Get-CloudPCWithIssues

# Display the results
$problematicCloudPCs | Format-Table -Property DisplayName, UserPrincipalName, HealthStatus, Id

# Disconnect from Microsoft Graph
Disconnect-MgGraph
