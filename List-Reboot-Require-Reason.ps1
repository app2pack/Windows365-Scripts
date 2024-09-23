#Script to list reason for reboot required
$regpath = 'HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager'
$regpath1 = 'HKLM:\SYSTEM\ControlSet001\Control\Session Manager'
$regpath2 = 'HKLM:\SYSTEM\ControlSet002\Control\Session Manager'
$regpath3 = 'HKLM:\SYSTEM\ControlSet001\Control\BackupRestore\KeysNotToRestore'
$name = 'PendingFileRenameOperations'
#Test-Path $regpath 
Get-ItemProperty -Path $regpath |select-object -ExpandProperty $name -ErrorAction SilentlyContinue
Get-ItemProperty -Path $regpath1 |select-object -ExpandProperty $name -ErrorAction SilentlyContinue
Get-ItemProperty -Path $regpath2 |select-object -ExpandProperty $name -ErrorAction SilentlyContinue
Get-ItemProperty -Path $regpath3 |select-object -ExpandProperty $name -ErrorAction SilentlyContinue
