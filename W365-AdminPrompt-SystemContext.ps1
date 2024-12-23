# Function to get the username and domain of the currently logged-in user
function Get-UsernameAndDomain {
$User = tasklist /v /FI "IMAGENAME eq explorer.exe" /FO list | find "User Name:"
$User = $User.Substring(14)
# Extract the username and domain from the whoami command
   $userDetails = $User.Split("\")
   $username = $userDetails[1]
   $domain = $userDetails[0]
   Write-Host "Username: $username"
   Write-Host "Domain: $domain"
   return @($username, $domain)
}
# Get the username and domain of the currently logged-in user
$userDetails = Get-UsernameAndDomain
$username = $userDetails[0]
$domain = $userDetails[1]
# Construct the full UPN
$fullUPN = "$username@$domain.com"
Write-Host "Full UPN: $fullUPN"
# Add the user to the local administrators group
$command = "net localgroup administrators AzureAD\$fullUPN /add"
Write-Host "Running command: $command"
Invoke-Expression $command
Write-Host "User $fullUPN has been added to the local administrators group."
