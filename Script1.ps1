import-module ActiveDirectory 
$DaysInactive = 183
$time = (Get-Date).Adddays( - ($DaysInactive))
$location = "OU=Mexiko,OU=Others,OU=Users,OU=Leschaco,DC=hq,DC=LESCHACO,DC=org" 
$users = Get-ADUser -SearchBase $location -Filter { LastLogonTimeStamp -lt $time } -Properties LastLogonTimeStamp 
$users |
select-object Name, @{Name = "Stamp"; Expression = { [DateTime]::FromFileTime($_.lastLogonTimestamp).ToString('yyyy-MM-dd') } }, UserPrincipalName, Enabled, DistinguishedName, Licenses | sort Name 
Connect-MsolService
ForEach ($user in  $users) { Get-MsolUser -UserPrincipalName $user.UserPrincipalName | DisplayName, Licenses }
#testcomment1