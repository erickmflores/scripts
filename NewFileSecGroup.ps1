$GroupName = Read-Host "Type the group name"
$Country = Read-Host "Type the country"
$OU = "OU="+$Country+",OU=FileSec,OU=Groups,OU=Leschaco,DC=hq,DC=LESCHACO,DC=org"
New-ADGroup -Name $GroupName -GroupScope Global -GroupCategory Security -Path $OU

Write-Output "New SecurityGroup successfully created"

$answer = Read-Host  "Do you want to add members? (y)Yes (n) No"
if ($answer -eq 'y')
{
$members = Read-Host -Prompt "Type all users separed by a coma"
$users = $members.Split(",")
$users |ForEach-Object {Add-ADGroupMember -Identity $GroupName -Members $users}

}

else

{

Write-Output "Process finished, bye"
Exit

}
