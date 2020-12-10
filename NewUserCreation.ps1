
#Creación de usuario en AD




#Usuario Creado en AD

#Creación de buzón EX

Function Create-PSCredential { 
 
    [CmdletBinding()] 
    Param( 
         [Parameter(Mandatory = $true)] 
         [string]$user, 
         [Parameter(Mandatory = $true)] 
         [string]$pass
)   
 
    $Securepass = ConvertTo-SecureString $pass -AsPlainText -Force 
    $Credential = New-Object System.Management.Automation.PSCredential ($user, $Securepass) 
    Return $Credential 
 
} 

$Credential = Create-PSCredential -Username "romer00a" -Password "contraseñasupersegura"
Enter-PSSession -ComputerName bre3ap40.leschaco.org -Credential $Credential
Set-Location C:\Users\romer00a\Desktop\
.\Create-Usermailbox.ps1 -user #usuario previamente creado







