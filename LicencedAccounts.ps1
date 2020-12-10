$scanners = Get-ADUser -Filter * -Properties * |Where-Object {$PSItem.Userprincipalname -match "Scan"}   |Select-Object SamAccountName,UserprincipalName,Distinguishedname 
$licenced = ForEach ($scanner in $scanners) {Get-MsolUser -UserPrincipalName $scanner.UserPrincipalName} 
$truelicenced = $licenced |Where-Object {$PSItem.isLicensed -eq $true}
$truelicenced.count

