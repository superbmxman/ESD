$suspicious = @("-enc", "bypass")
$logpath = "C:\Users\$env:username\Desktop\logsearch.txt"

Write-Host "Log powershell suspect :" 
$logs = Get-WinEvent Microsoft-Windows-PowerShell/Operational | Where-Object Id -eq 4104

Write-Host "Nombres de logs : " $logs.count
foreach ($log in $logs )
{
    If (($log.Message | Select-String -Pattern $suspicious))
    {
        Write-Host "cmdlet suspecte le " $log.TimeCreated " executé par" ($user = Get-WmiObject -Class Win32_UserAccount | Where-Object SID -Match $log.UserId).Name | Out-File -Encoding utf8 -FilePath $logpath
    }
}

Write-Host "Historique antivirus :" -ForegroundColor DarkRed
$logs = Get-WinEvent -LogName 'Microsoft-Windows-Windows Defender/Operational' | Where-Object Id -eq 1116
Write-Host "Nombres d'alertes : " $logs.count
foreach ($log in $logs )
{
    Write-Host "Detection d'un fichier malveillant le :" $log.TimeCreated | Out-File -Encoding utf8 -FilePath $logpath
}



Write-Host "Utilisateurs créés :" -ForegroundColor DarkRed
$logs = Get-EventLog -LogName Security | Where-Object InstanceId -eq 4720
Write-Host "Nombres de logs : " $logs.count
foreach ($log in $logs )
{
    Write-Host "Utilisateur créé le " $log.TimeGenerated | Out-File -Encoding utf8 -FilePath $logpath
} 
