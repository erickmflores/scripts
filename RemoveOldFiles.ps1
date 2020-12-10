Import-csv 'I:\Softwareshare\Delete old files DFS Americas\Chile-Comun-09-12-2020.csv' | Remove-Item -Verbose

 

$date = Get-Date -Format dd-MM-yyyy
$path = 'I:\Softwareshare\Delete old files DFS Americas\Chile-Comun-'+$date+'.csv'
Get-ChildItem I:\Chile\ -Recurse -File | Where-Object {$PSItem.LastWriteTime -lt (Get-Date).AddDays(-3650)} | Export-Csv -NoTypeInformation -Encoding UTF8 $path