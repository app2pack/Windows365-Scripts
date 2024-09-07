# Define the registry path and key
$registryPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services"
$keyName = "fEnableScreenCaptureProtection"
$dwordValue = 1

# Create the registry key and set the DWORD value
try {
    # Check if the registry path exists, if not create it
    if (-not (Test-Path $registryPath)) {
        New-Item -Path $registryPath -Force | Out-Null
        Write-Host "Created registry path: $registryPath"
    }

    # Set the registry key with REG_DWORD value
    New-ItemProperty -Path $registryPath -Name $keyName -PropertyType DWORD -Value $dwordValue -Force | Out-Null
    Write-Host "Registry key '$keyName' set to $dwordValue"

    # Verify the value was set correctly
    $regValue = Get-ItemProperty -Path $registryPath -Name $keyName
    if ($regValue.$keyName -eq $dwordValue) {
        Write-Host "Success: The registry key '$keyName' is set to $dwordValue"
    } else {
        Write-Host "Error: The registry key '$keyName' was not set correctly"
    }

} catch {
    Write-Host "An error occurred: $_"
}
