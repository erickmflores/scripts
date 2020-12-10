Get-EXOMailbox -RecipientTypeDetails SharedMailbox -ResultSize Unlimited |Select-Object UserPrincipalName

Get-EXOMailbox -RecipientTypeDetails UserMailbox -ResultSize Unlimited|Select-Object UserPrincipalName
$mailboxes = Get-EXOMailbox -RecipientTypeDetails UserMailbox -ResultSize Unlimited|Select-Object UserPrincipalName
foreach ($mailbox in $mailboxes) {Get-MsolUser -UserPrincipalName $mailbox.UserPrincipalName |Select-Object Licenses,UserPrincipalName,DisplayName,isLicensed,Licenses |Export-Csv -NoTypeInformation -Append H:\CTX-Profile\Desktop\NotSharedMailboxesLicensed.csv } 

$Germany = Get-ADUser -SearchBase "OU=Germany,OU=Users,OU=Leschaco,DC=hq,DC=LESCHACO,DC=org" -filter * -Properties *|Select-Object UserprincipalName
$Others =   Get-ADUser -SearchBase "OU=Others,OU=Users,OU=Leschaco,DC=hq,DC=LESCHACO,DC=org" -filter * -Properties *|Select-Object UserprincipalName
$users = $Germany + $Others
foreach ($user in $users) {Get-ADUser -Filter * -Properties * |Select-Object Userprincipalname |Where-Object {$PSItem.Userprincipalname -notmatch $user.userprincipalname}} 


