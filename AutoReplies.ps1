#Configurar respuestas automáticas
$mailbox = Read-Host "Type the mailbox"
$Internal = Read-Host "Internal message"
$External = Read-Host "External message"
$start = Read-Host "Start time (dd/mm/yy)" 
$end = Read-Host "End time (dd/mm/yy)"
$timestart = "$start "+"00:00:00"
$timeend = "$end "+"00:00:00"

try {

Get-ADUser -Identity $mailbox

}

catch {


}

Set-MailboxAutoReplyConfiguration -Identity $mailbox -AutoReplyState Enabled -InternalMessage "$Internal" -ExternalMessage "$External" -AutoReplyState Scheduled -StartTime "7/10/2018 08:00:00" -EndTime "7/15/2018 17:00:00" 