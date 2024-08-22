# Define the path to the registry key
$registryPath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced\TaskbarDeveloperSettings"

# Define the name and value of the DWORD
$dwordName = "TaskbarEndTask"
$dwordValue = 1

# Define the log file path
$logFilePath = "$env:USERPROFILE\Documents\TaskbarEndTaskLog.txt"

# Function to log messages
function Log-Message {
    param (
        [string]$message
    )
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $logMessage = "$timestamp - $message"
    Add-Content -Path $logFilePath -Value $logMessage
}

# Start script execution
Log-Message "Starting script to create registry key and set DWORD value."

try {
    # Create the registry key if it doesn't exist
    if (-not (Test-Path $registryPath)) {
        New-Item -Path $registryPath -Force -ErrorAction Stop
        Log-Message "Registry key '$registryPath' created successfully."
    } else {
        Log-Message "Registry key '$registryPath' already exists."
    }

    # Create the DWORD value and set it to 1
    Set-ItemProperty -Path $registryPath -Name $dwordName -Value $dwordValue -Type DWord -ErrorAction Stop
    Log-Message "DWORD value '$dwordName' set to '$dwordValue' successfully."

    # Confirm that the key and value were created
    $result = Get-ItemProperty -Path $registryPath -Name $dwordName -ErrorAction Stop
    Log-Message "Verified DWORD value: $($result.$dwordName)"
} catch {
    # Log any errors that occur
    Log-Message "Error: $($_.Exception.Message)"
}

# End script execution
Log-Message "Script execution completed."
