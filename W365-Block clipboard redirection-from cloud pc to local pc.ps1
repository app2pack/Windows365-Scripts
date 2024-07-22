try {
    # Path to the registry key
    $regPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services"

    # Ensure the registry path exists
    if (-not (Test-Path $regPath)) {
        New-Item -Path $regPath -Force -ErrorAction Stop
        Write-Host "Created registry path: $regPath"
    } else {
        Write-Host "Registry path already exists: $regPath"
    }

    # Set the registry values
    Set-ItemProperty -Path $regPath -Name "CSClipLevel" -Value 1 -Type DWord -ErrorAction Stop
    Write-Host "Set CSClipLevel to 1"

    Set-ItemProperty -Path $regPath -Name "SCClipLevel" -Value 0 -Type DWord -ErrorAction Stop
    Write-Host "Set SCClipLevel to 0"

    Write-Host "Registry keys have been set successfully."
} catch {
    Write-Host "An error occurred: $_"
    Write-EventLog -LogName Application -Source PowerShell -EntryType Error -EventId 1000 -Message "Failed to set registry keys: $_"
    exit 1
}
