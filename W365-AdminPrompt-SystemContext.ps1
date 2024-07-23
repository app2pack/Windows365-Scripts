$User = tasklist /v /FI "IMAGENAME eq explorer.exe" /FO list | find "User Name:"
$User = $User.Substring(14)
$User = $User.Split("\")
$User = $User[1]
write-host $User
