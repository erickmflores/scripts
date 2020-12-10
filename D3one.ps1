Get-ADGroup -Identity GS-D3one-users
Get-ADGroup -Identity GS-D3-ReadOnly
Add-ADGroupMember -Identity GS-D3one-users -Members mitzi00m
Remove-ADGroupMember -Identity GS-D3-ReadOnly -Members mitzi00m