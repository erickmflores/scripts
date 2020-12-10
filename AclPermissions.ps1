#Mostrar permisos existentes en el folder y ofrecer la opción de modificarlos directamente o crear nuevos

$Path = Read-Host "Path"
$decision = Read-Host "Add(a) or Remove(r)?"



if ($decision -eq "a")
{

$Group = Read-Host "Type the new security group"
cls
Write-Host "Here are all the possible permissions to be set:"
[system.enum]::getnames([System.Security.AccessControl.FileSystemRights])
$Permissions = Read-Host "Type the permissions separed by a coma"
$type = Read-Host "Allow or Deny"
$Identity = "HQ\"+"$Group" 
$newrule = $Identity,$Permissions,$type
$nacl = New-Object -TypeName System.Security.AccessControl.FileSystemAccessRule("$Identity","$Permissions","$type")
$Folder = Get-Acl -Path $Path
$Folder.SetAccessRule($nacl)
Set-Acl -path $path -aclobject $Folder
Write-Host "Changes completed:"
$Folder  |fl
}

elseif ($decision -eq "r")

{
Write-Host "Current groups:"
Get-Acl -Path $Path  |fl
$Group = Read-Host "Type the group to be deleted"
$Permissions = Read-Host "Type the current permissions on the selected group: "
$type = Read-Host "Allow or Deny"
$Identity = "HQ\"+"$Group" 
$newrule = $Identity,$Permissions,$type
$nacl = New-Object -TypeName System.Security.AccessControl.FileSystemAccessRule("$Identity","$Permissions","$type")
$Folder = Get-Acl -Path $Path
$Folder.RemoveAccessRule($nacl)
#Set-Acl -path $path -aclobject $Folder
Write-Host "Changes completed:"
$Folder |fl

}

