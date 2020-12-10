$Mexico = Get-ChildItem -Path I:\Mexico\
$Mexico |ForEach-Object {Get-FolderSize -Path $PSItem.PSPath} |Select-Object FullPath,SizeGB,SizeMB |Export-Csv -NoTypeInforma