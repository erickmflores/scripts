$DN = 'OU=Brasilien,OU=Others,OU=Users,OU=Leschaco,DC=hq,DC=LESCHACO,DC=org' #usuários BR
    
$Props = [ordered]@{
    Nome             = ""
    Sobrenome        = ""
    'Citrix ID'      = ""
    'E-mail'         = ""
    Departamento     = ""
    Cargo            = ""
    'Gerente Direto' = ""
    'Status Conta'   = ""
    'Member Of'      = ""
}

cls
   
Get-ADUser -filter * -SearchBase $DN -Property Department, Title, Manager |
ForEach-Object {
    $Props.Nome = $_.givenName
    $Props.Sobrenome = $_.Surname
    $Props."Citrix ID" = $_.SamAccountName
    $Props."E-mail" = $_.UserPrincipalName
    $Props.Departamento = ($_ | Select-Object -Expand Department)
    $Props.Cargo = ($_ | Select-Object -Expand title) 
    Try {
        $Props."Gerente Direto" = (Get-ADUser -Identity $_.manager -ErrorAction STOP | Select-Object -Expand DisplayName) 
    }
    Catch {
        $Props."Gerente Direto" = ""
    }
    $Props."Status Conta" = $_.Enabled
           
    Get-ADPrincipalGroupMembership -Identity $_.samaccountname |
    ForEach-Object {
        $Props."Member Of" = ($_ | Select-Object -ExpandProperty Name)
        [PSCustomObject]$Props
    }
} | Export-CSV "I:\Brasil\IT\Controles\Scripts\Active Users BR\lista.csv" -NoTypeInformation
   
#Get-ADUser -Filter * -SearchBase $DN -Properties name,memberof | 
#   Select-Object name,memberof | 
#      Sort-Object -Property name | 
#         Format-Table -AutoSize

Write-Output "Lista Exportada para I:\Brasil\IT\Controles\Scripts\Active Users BR\lista.csv" #Mensagem via console
Write-Output "OK" #Mensagem no console
Write-Output "`n" #Quebra de linha