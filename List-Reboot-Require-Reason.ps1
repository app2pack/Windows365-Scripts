# Script to list reason for reboot required
$regpaths = @(
    'HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager',
    'HKLM:\SYSTEM\ControlSet001\Control\Session Manager',
    'HKLM:\SYSTEM\ControlSet002\Control\Session Manager',
    'HKLM:\SYSTEM\ControlSet001\Control\BackupRestore\KeysNotToRestore'
)
$name = 'PendingFileRenameOperations'
$pendingRenames = @()

# Loop through each registry path and check for the property
foreach ($regpath in $regpaths) {
    $result = Get-ItemProperty -Path $regpath | Select-Object -ExpandProperty $name -ErrorAction SilentlyContinue
    if ($result) {
        $pendingRenames += $result
    }
}

# Check if any results were found
if ($pendingRenames.Count -eq 0) {
    Write-Host "No reboot required"
} else {
    Write-Host "Pending reboot required for the following operations:"
    $pendingRenames | ForEach-Object { Write-Host $_ }
}
