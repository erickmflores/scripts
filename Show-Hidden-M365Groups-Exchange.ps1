# Show hidden Office 365 groups in Exchange clients (like Outlook)
Install-Module ExchangeOnlineManagement -Scope CurrentUser
Connect-ExchangeOnline -UserPrincipalName erick.flores@leschaco.com -ShowProgress $true
Get-UnifiedGroup -Identity ""
Set-UnifiedGroup -Identity "" -HiddenFromExchangeClientsEnabled:$false
$group = Get-UnifiedGroup -Identity ""
$group.HiddenFromExchangeClientsEnabled