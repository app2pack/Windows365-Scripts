# Define the registry path and value
$registryPath = "HKLM:\Software\Policies\Microsoft\Windows NT\Terminal Services"
$valueName = "fdisconnectonlockmicrosoftidentity"
$valueData = 1

# Define the log file path
$logFile = "C:\temp\RegistryScriptLog.txt"

# Function to write logs and display output
function Write-Log {
    param (
        [string]$message
    )
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $logMessage = "$timestamp - $message"
    
    # Write to log file
    Add-Content -Path $logFile -Value $logMessage
    
    # Display in terminal
    Write-Output $logMessage
}

# Create the registry key if it doesn't exist
try {
    if (-not (Test-Path $registryPath)) {
        New-Item -Path $registryPath -Force
        Write-Log "Created registry key: $registryPath"
    } else {
        Write-Log "Registry key already exists: $registryPath"
    }
} catch {
    Write-Log "Error creating registry key: $_"
    exit 1
}

# Set the DWORD value
try {
    New-ItemProperty -Path $registryPath -Name $valueName -Value $valueData -PropertyType DWORD -Force
    Write-Log "Set $valueName to $valueData in $registryPath"
    Write-Output "Disconnect the session enabled"
} catch {
    Write-Log "Error setting registry value: $_"
    exit 1
}
