# Install the Microsoft Graph PowerShell SDK if not already installed
# Install-Module Microsoft.Graph -Scope CurrentUser

# Import the Microsoft Graph module
Import-Module Microsoft.Graph

# Define the output paths for the CSV file and the error log
$outputPath = "C:\CloudPCs_In_Grace_Period.csv"
$errorLogPath = "C:\CloudPCs_Error_Log.txt"

# Clear any existing error log
if (Test-Path $errorLogPath) { Remove-Item $errorLogPath }

# Connect to Microsoft Graph using CloudPC.Read.All scope with Beta profile
try {
    # Set the Microsoft Graph API profile to 'beta' to access Cloud PC functionalities
    Select-MgProfile -Name 'beta'
    
    # Authenticate and request the required CloudPC scope
    Connect-MgGraph -Scopes "CloudPC.Read.All"
    Write-Host "Successfully connected to Microsoft Graph using the beta profile."
} catch {
    Write-Error "Error connecting to Microsoft Graph: $_"
    Add-Content $errorLogPath "Error connecting to Microsoft Graph: $_"
    exit
}

# Query Cloud PCs in grace period
try {
    # Retrieve Cloud PCs via Microsoft Graph API in beta
    $cloudPCs = Get-MgBetaDeviceManagementVirtualEndpointCloudPc | Where-Object { $_.provisioningState -eq 'InGracePeriod' }

    # Check if any Cloud PCs are found in grace period
    if ($cloudPCs.Count -eq 0) {
        Write-Host "No Cloud PCs found in grace period."
        Add-Content $errorLogPath "No Cloud PCs found in grace period on $(Get-Date)."
        exit
    }

    # Select the relevant properties to export
    $cloudPCsFormatted = $cloudPCs | Select-Object displayName, userPrincipalName, provisioningState, lastModifiedDateTime

    # Export the Cloud PCs to a CSV file
    $cloudPCsFormatted | Export-Csv -Path $outputPath -NoTypeInformation
    Write-Host "Export completed. CSV file saved at $outputPath"
} catch {
    Write-Error "Error retrieving or exporting Cloud PC data: $_"
    Add-Content $errorLogPath "Error retrieving or exporting Cloud PC data: $_"
}

# Disconnect from Microsoft Graph
Disconnect-MgGraph
