#Delete all E3 licenses from all the users in the tenant
# Install-Module MSOnline -Scope CurrentUser
#Update-Module -Force
Connect-MsolService
Get-MsolAccountSku

$userArray = Get-MsolUser -All | Where-Object { $_.isLicensed -eq $true }
for ($i = 0; $i -lt $userArray.Count; $i++) {
    Set-MsolUserLicense -UserPrincipalName $userArray[$i].UserPrincipalName -RemoveLicenses "leschacogroup:ENTERPRISEPACK"
}