$ErrorActionPreference = "silentlycontinue"
$logfile = "C:\Users\$env:USERNAME\Desktop\loginfinder.txt"
$nametable = @("pass", "passe", "password", "pwd", "secret", "pswd", "login", "compte")
$targetpath = New-Object System.Collections.ArrayList
$targetpath.Add('C:\Users')
foreach ( $share in (Get-SmbShare | Where-Object Path -NotLike "C:\*").path) { $targetpath.Add($share) }

Write-Host "Recherche de fichiers se nommants :" $nametable
foreach ($target in $targetpath)
{
    foreach ($name in $nametable)
    {
        If ($file = Get-ChildItem -Path $target -Recurse -Exclude $logfile -Filter $name*)
        {
            Write-Host "File found ! : " $file -ForegroundColor Green
            $file.FullName | Out-File -Encoding utf8 -FilePath $logpath
        }
    }
}


Write-Host "Recherche de fichiers contenants les mots clefs suivants :" $nametable
foreach ($target in $targetpath)
{
    foreach ($name in $nametable)
    {
        If ($file = Get-ChildItem -Path $share -Recurse -Exclude $logpath | Select-String -Pattern $name*)
        {
            Write-Host "File found ! : " $file.Filename -ForegroundColor Green
            $file.FullName | Out-File -Encoding utf8 -FilePath $logpath.FullName
        }
    }
}

$MyInvocation.MyCommand.Name