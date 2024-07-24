$loggedInUser = tasklist /v /FI "IMAGENAME eq explorer.exe" /FO list | find "User Name:"
$loggedInUser = $loggedInUser.Substring(14)
$loggedInUser = $loggedInUser.Split("\")
$loggedInUser = $loggedInUser[1]
write-host $loggedInUser
$UserName = "$loggedInUser"
$GroupName = "Administrators"

$GroupMembers = net localgroup "$GroupName" | Select-String -Pattern "$UserName"

if ($GroupMembers) {
   Write-Host "The user account '$UserName' is a member of the '$GroupName' group."
   exit 0
} else {
   Write-Host "The user account '$UserName' is not a member of the '$GroupName' group."
   exit 1
}
