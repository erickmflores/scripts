Connect-MsolService
Get-MsolAccountSku
Get-MsolUser -All | Where-Object { ($_.licenses).AccountSkuId -match "VISIOCLIENT" } | Out-file $env:USERPROFILE\Desktop\Visio.csv
Get-MsolUser -All | Where-Object { ($_.licenses).AccountSkuId -match "POWER_BI_PRO" } | Out-file $env:USERPROFILE\Desktop\PowerBIPro.csv
Get-MsolUser -All | Where-Object { ($_.licenses).AccountSkuId -match "PROJECTPROFESSIONAL" } | Out-file $env:USERPROFILE\Desktop\Project.csv