$Date = Get-Date -Format dd/mm/yy
#Establecer el buzon a mover
$user = Read-Host "Ingresar el Alias o e-mail del usuario a migrar: "
$Batchname = "Migration-"+$user+"-rom-"+$Date 
#Paso 2, ejecutar el  Move Request
New-MoveRequest -Identity $user -remote -RemoteHostName webmail.leschaco.com -TargetDeliveryDomain leschacogroup.mail.onmicrosoft.com -RemoteCredential $OnPremCred -AcceptLargeDataLoss -BadItemLimit 500 -LargeItemLimit 100 -BatchName $Batchname

#Paso 3 Status de la operacion
Get-MoveRequest | ? {$_.alias -eq "$user"} | Get-MoveRequestStatistics | fl


#Get-MoveRequest -Identity trainee.airfreight@leschaco.com