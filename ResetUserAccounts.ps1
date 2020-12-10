Set-Location \\bre3fil03.hq.leschaco.org\User_AMERICAS_1
$User = Read-Host "Type the user to be reset"
Rename-Item "$User" "User" + ".tmp"
Remove-Item folder -Recurse 
Copy-Item -Path folder -Destination folder2 -Recurse
Set-Location \\bre3fil04.hq.leschaco.org\Mail_O365_AMERICAS_1
Set-Location \\bre3profiles.hq.leschaco.org\TSProfiles