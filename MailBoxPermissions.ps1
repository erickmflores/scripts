#Ver permisos sobre el buzón  #FullAccess,ReadPermissions,ExternalAccount
$mailboxes = Read-Host 
$groups = $mailboxes.split(",")

 Get-MailboxPermission -Identity $group
 #Añadir permisos
 Add-MailboxPermission -Identity  -User -AccessRights FullAccess -InheritanceType False -AutoMapping $false
 #Remover permisos
 Remove-MailboxPermission -Identity  -User -AccessRights FullAccess -InheritanceType False -AutoMapping $false
$mailbox = Get-EXOMailbox -Identity David.Simmons@leschaco.com 
