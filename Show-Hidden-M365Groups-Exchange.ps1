# Show hidden Office 365 groups in Exchange clients (like Outlook)
Install-Module ExchangeOnlineManagement -Scope CurrentUser
Connect-ExchangeOnline -UserPrincipalName 'INSERT EMAIL HERE' -ShowProgress $true
Get-UnifiedGroup -Identity "INSERT MICROSOFT 365 GROUP NAME HERE"
Set-UnifiedGroup -Identity "INSERT MICROSOFT 365 GROUP NAME HERE" -HiddenFromExchangeClientsEnabled:$false
$group = Get-UnifiedGroup -Identity "INSERT MICROSOFT 365 GROUP NAME HERE"
$group.HiddenFromExchangeClientsEnabled