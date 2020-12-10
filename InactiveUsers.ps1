$DaysInactive = 183
$OU = Read-Host -Prompt "Country"
if ($OU -eq 'Germany')
{$OUFull='OU='+$OU+',OU=Users,OU=Leschaco,DC=hq,DC=LESCHACO,DC=org'
}
else
{
$OUFull='OU='+$OU+',OU=Others,OU=Users,OU=Leschaco,DC=hq,DC=LESCHACO,DC=org'
}
$time =(Get-Date).Adddays(-($DaysInactive))
Get-ADUser -SearchBase $OUFull -Filter {LastLogonTimeStamp -lt $time} -Properties LastLogonTimeStamp |select-object Name,@{Name="Stamp"; Expression={[DateTime]::FromFileTime($_.lastLogonTimestamp).ToString('yyyy-MM-dd')} },UserPrincipalName,Enabled, DistinguishedName | sort Name