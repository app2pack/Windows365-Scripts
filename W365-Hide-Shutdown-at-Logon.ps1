# Define the path to the registry subkey
$subkeyPath = "HKLM:\Software\Microsoft\Windows\CurrentVersion\Policies\System"

# Define the name of the DWORD value to check and set
$dwordName = "ShutDownWithoutLogon"

# Check if the registry subkey exists
if (-not (Test-Path $subkeyPath)) {
    # Create the registry subkey if it doesn't exist
    New-Item -Path $subkeyPath -Force
    Write-Output "Registry subkey '$subkeyPath' created."
}

# Check if the DWORD value exists
$dwordExists = Get-ItemProperty -Path $subkeyPath -Name $dwordName -ErrorAction SilentlyContinue

if ($null -ne $dwordExists) {
    # Set the DWORD value to 1
    Set-ItemProperty -Path $subkeyPath -Name $dwordName -Value 1 -Type DWord
    Write-Output "Registry DWORD value '$dwordName' set to 1 in '$subkeyPath'."
} else {
    # Create the DWORD value and set it to 0
    New-ItemProperty -Path $subkeyPath -Name $dwordName -Value 1 -PropertyType DWord
    Write-Output "Registry DWORD value '$dwordName' created and set to 1 in '$subkeyPath'."
}
