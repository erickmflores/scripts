$OUBASE=Read-Host "Por favor ingrese la OU Correspondiente"
if ($OUBASE -eq 'Germany')
{$CNFull='OU='+$OUBASE+',OU=Users,OU=Leschaco,DC=hq,DC=LESCHACO,DC=org'
}
else
{
$CNFull='OU='+$OUBASE+',OU=Others,OU=Users,OU=Leschaco,DC=hq,DC=LESCHACO,DC=org'
}
$DN = $CNFull #usuários BR
    
$Props = [ordered]@{
    Name             = ""
    Lastname        = ""
    'Citrix ID'      = ""
    'E-mail'         = ""
    Department     = ""
    Title            = ""
    'Manager' = ""
    'Enabled'   = ""
    'Member Of'      = ""
}

cls
   
Get-ADUser -filter * -SearchBase $DN -Property Department, Title, Manager |
ForEach-Object {
    $Props.Name = $_.givenName
    $Props.Lastname = $_.Surname
    $Props."Citrix ID" = $_.SamAccountName
    $Props."E-mail" = $_.UserPrincipalName
    $Props.Department = ($_ | Select-Object -Expand Department)
    $Props.Title = ($_ | Select-Object -Expand title) 
    Try {
        $Props."Manager" = (Get-ADUser -Identity $_.manager -ErrorAction STOP | Select-Object -Expand DisplayName) 
    }
    Catch {
        $Props."Manager" = ""
    }
    $Props."Enabled" = $_.Enabled
           
    Get-ADPrincipalGroupMembership -Identity $_.samaccountname |
    ForEach-Object {
        $Props."Member Of" = ($_ | Select-Object -ExpandProperty Name)
        [PSCustomObject]$Props
    }
} | Export-CSV H:\CTX-Profile\Desktop\List.csv -NoTypeInformation
   
#Get-ADUser -Filter * -SearchBase $DN -Properties name,memberof | 
#   Select-Object name,memberof | 
#      Sort-Object -Property name | 
#         Format-Table -AutoSize

Write-Output "H:\CTX-Profile\Desktop\List.csv" 
Write-Output "OK" 
Write-Output "`n" 



