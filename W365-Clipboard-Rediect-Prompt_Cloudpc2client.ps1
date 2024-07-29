# Define the registry path and the DWORD name
$regPath = "HKLM:\Software\Policies\Microsoft\Windows NT\Terminal Services"
$regName = "SCClipLevel"

# Display options to the user
Write-Host "Please enter a value from 0 to 4 based on the following options:"
Write-Host "0 - Disable clipboard transfers from session host to client."
Write-Host "1 - Allow plain text."
Write-Host "2 - Allow plain text and images."
Write-Host "3 - Allow plain text, images, and Rich Text Format."
Write-Host "4 - Allow plain text, images, Rich Text Format, and HTML."

# Prompt the user for input
do {
    $inputValue = Read-Host -Prompt "Enter your choice (0-4)"
} while ($inputValue -notmatch "^[0-4]$")

# Convert the input to an integer
$inputValue = [int]$inputValue

# Create or update the registry entry
if (-not (Test-Path $regPath)) {
    New-Item -Path $regPath -Force | Out-Null
}
Set-ItemProperty -Path $regPath -Name $regName -Value $inputValue

Write-Host "Registry entry created/updated successfully. SCClipLevel is set to $inputValue."
