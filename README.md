1. W365-AdminPrompt.ps1- This powershell script can be used inside windows 365 cloud pc to add the user to the local admin group and help to elevate permissions using run as admin where they have to enter their credentials to allow admin access. By default the allow local admin user settings suppress this and just prompt user to accept or cancel the elevation.

2. W365-Block clipboard redirection-from cloud pc to local pc.ps1 - This script will block the copy paste clipboard redirection from session host i.e w365 cloud pc to the local pc. This script will create registry entries that can be manually tested instead of Intune or GPO method. 

3. w365-Block bidirectional clipboard redirection.ps1 - This script can be used to test the blocking of bidirectional copy paste from both cloud pc to laptop and vice versa.

4. W365-AdminPrompt-SystemContext.ps1 - This script can be used to fetch the username who has currently logged in even through system context. If you want go get the username as system context through Intune portal then make use of this script.

5. Create W365-Block clipboard redirection-from local pc to cloud pc.ps1 - This script can be used to manually test the registry method to allow copy paste from cloud pc to laptop but block copy paste clipboard redirection from laptop to cloud pc. This script will create registry entries that can be manually tested instead of Intune or GPO method.
