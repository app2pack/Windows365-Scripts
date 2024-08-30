# Define the registry path and value name
$registryPath = "HKLM:\Software\Policies\Microsoft\Windows NT\Terminal Services"
$valueName = "fdisconnectonlockmicrosoftidentity"

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

# Prompt the user to choose an option
Write-Output "Choose an option:"
Write-Output "0 - Remote lock screen enabled"
Write-Output "1 - Disconnect the session"
$userChoice = Read-Host -Prompt "Enter your choice (0 or 1)"

# Validate user input and set the corresponding value
if ($userChoice -eq "0") {
    $valueData = 0
    $userSelection = "Remote lock screen enabled"
} elseif ($userChoice -eq "1") {
    $valueData = 1
    $userSelection = "Disconnect the session"
} else {
    Write-Output "Invalid choice. Please run the script again and enter 0 or 1."
    exit 1
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

# Set the DWORD value based on user input
try {
    New-ItemProperty -Path $registryPath -Name $valueName -Value $valueData -PropertyType DWORD -Force
    Write-Log "Set $valueName to $valueData in $registryPath"
    Write-Output "$userSelection"
} catch {
    Write-Log "Error setting registry value: $_"
    exit 1
}
