$newpass = Read-Host "Enter the new password" -AsSecureString
$user = Read-Host "Enter user"
Set-ADAccountPassword -Identity $user -NewPassword $newpass -PassThru | Set-ADuser -ChangePasswordAtLogon $True
