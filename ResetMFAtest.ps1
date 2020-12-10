function Reset-MFASettings {
     
    Param(
    [Parameter (Mandatory = $true)]
    [string] $UserPrincipalName,
    [Parameter (Mandatory = $true)]
    $Credentials
    )
 
    Connect-MSOLService -credential $credentials
 
    $MSOLUser = Get-MSOLUser -UserPrincipalName $UserPrincipalName | select FirstName
    $FirstName = $MSOLUser.FirstName
 
    if($MSOLUser -ne $Null)
    {
        $RoleAssigned = Get-MsolUserRole -UserPrincipalName $UserPrincipalName
        if($RoleAssigned -eq $Null)
        {
            Try
            {
                $AzureLogin = Login-AzureRmAccount -Credential $credentials
                $AzureConnect = Connect-AzureAD -Credential $credentials
                $UserManagerMail = (Get-AzureADUserManager -ObjectId $UserPrincipalName).Mail
            }
            Catch
            {
                $ExcMessage = $_.Exception.Message
                throw "Error: Can not connect to Azure AD!. Exception: $ExcMessage"
            }
             
            Try
            {
                Set-MSOLUser -UserPrincipalName $UserPrincipalName -StrongAuthenticationMethods @()
                Write-output "MFA settings has been removed for account $UserPrincipalName"
            }
            Catch
            {
                $ExcMessage = $_.Exception.Message
                throw "Error: Can not remove MFA settings!. Exception: $ExcMessage"
            }
 
            Try
            {    
                $Body= "Dear $FirstName, <br><br>Please be informed that MFA settings for your account $UserPrincipalName has been removed."
                $Subject = "$Incident"
                $CredUserName = $Credentials.UserName
             
                Send-MailMessage `
                    -To $UserPrincipalName  `
                    -Cc $UserManagerMail  `
                    -Subject $Subject  `
                    -Body $Body `
                    -UseSsl `
                    -Port 587 `
                    -SmtpServer 'smtp.office365.com' `
                    -From $CredUserName `
                    -BodyAsHtml `
                    -Credential $Credentials
                             
             
                Write-Output "Mail has been send!"
            }
            Catch
            {
                $ExcMessage = $_.Exception.Message
                throw "Error: Can not send email!. Exception: $ExcMessage"
            }
        }
        else
        {
                Write-Output "Account $UserPrincipalName has special role assigned and MFA settings can not be removed."
        }
         
    }
    else
    {
        Write-output "User with UPN $UserPrincipalName does not exist!"
    }
}