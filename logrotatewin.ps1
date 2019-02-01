# Define where Application writes the log files
$logFiles = "C:\path\"

# Define the location the log files should be archived to
$logArchive = "C:\path\"

# Define for how many days we should retain logs in the archive location
[int] $KeepRaw = 1
#$logLimitarchive = (Get-Date).day
$logLimitdelete = (Get-Date).AddDays(-7)
$CurrentDate = Get-Date -Hour 0 -Minute 0 -Second 0
$CompressBefore = (Get-Date -Date $CurrentDate).AddDays( - $KeepRaw)

# Delete log files older than the defined number of days
Get-ChildItem -Path $logArchive | Where-Object {$_.LastWriteTime -lt $logLimitdelete} | Remove-Item -Force

# Datestamp the current log files and move them to the archive location
Get-ChildItem -Path $logFiles -Filter * |Where-Object {$_.LastWriteTime -lt $CompressBefore} | Move-Item -Destination $logArchive -Force
