Get-ChildItem '\\bre3fil02\Data_AMERICAS\US\' -Recurse -File | Where-Object {​​​​​$PSItem.LastWriteTime -lt (Get-Date).AddDays(-3650)}​​​​​ | Export-Csv -NoTypeInformation -Encoding UTF8 $path
$date = Get-Date -Format dd-MM-yyyy
$path = 'I:\Softwareshare\Delete old files DFS Americas\USA-'+$date+'.csv'