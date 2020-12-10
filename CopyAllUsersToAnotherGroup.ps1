$GroupFrom = Read-Host "Type the group with the users to be copied"
$GroupTo = Read-Host "Type the new group"
$members = Get-ADGroupMember -Identity $GroupFrom
$members |ForEach-Object {Add-ADGroupMember -Identity $GroupTo -Members $members}