# Define the path to the registry subkey
$subkeyPath = "HKLM:\SOFTWARE\Microsoft\PolicyManager\default\Start\HideRestart"

# Define the name of the DWORD value to check and set
$dwordName = "value"

# Check if the registry subkey exists
if (-not (Test-Path $subkeyPath)) {
    # Create the registry subkey if it doesn't exist
    New-Item -Path $subkeyPath -Force
    Write-Output "Registry subkey '$subkeyPath' created."
}

# Check if the DWORD value exists
$dwordExists = Get-ItemProperty -Path $subkeyPath -Name $dwordName -ErrorAction SilentlyContinue

if ($null -ne $dwordExists) {
    # Set the DWORD value to 0
    Set-ItemProperty -Path $subkeyPath -Name $dwordName -Value 0 -Type DWord
    Write-Output "Registry DWORD value '$dwordName' set to 0 in '$subkeyPath'."
} else {
    # Create the DWORD value and set it to 0
    New-ItemProperty -Path $subkeyPath -Name $dwordName -Value 0 -PropertyType DWord
    Write-Output "Registry DWORD value '$dwordName' created and set to 0 in '$subkeyPath'."
}
