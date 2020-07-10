$OS_interest = @("version", "OSArchitecture", "MUILanguages")

function Test-Administrator-Token
{  
    $user = [Security.Principal.WindowsIdentity]::GetCurrent();
    (New-Object Security.Principal.WindowsPrincipal $user).IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)  
}

#CHECK ADMIN
$Admgroup = Get-LocalGroup | Where-Object Name -Like "Adm*"
foreach($group in $Admgroup)
{
    if ((Get-LocalGroupMember $group).Name -contains "$env:COMPUTERNAME\$env:USERNAME")
    {
        Write-Host "$env:USERNAME fait partie du groupe $group"
        $GroupBoolean = $True
        if (!(Test-Administrator-Token))
            { Write-host "Shell non execute en admin !" -ForegroundColor DarkRed }
        Else
            { Write-Host "Shell execute en admin" }
    }
}
if (!($GroupBoolean)) { Write-Host "$env:USERNAME est dans aucun groupe admin" }

## IP
$IPPublic = Invoke-WebRequest -Uri "http://whatismyip.akamai.com/"
Write-Host "IP Public : $IPPublic"

## OS Info
$OSInfo = Get-WMIObject win32_operatingsystem
foreach ($elements in $OS_interest)
{
    $OSInfo.$elements
}
Write-Host "Version : " (Get-Item "HKLM:SOFTWARE\Microsoft\Windows NT\CurrentVersion").GetValue('ReleaseID')


#Antivirus
$antivirus = Get-CimInstance -Namespace root/SecurityCenter2 -ClassName AntiVirusProduct

foreach ($AV in $antivirus) 
{
    $AV_Name = $AV.displayName
    $AV_Process = $AV.pathToSignedReportingExe
    $AV_Process = $AV_Process.Split('\')[-1]
    $AV_Process = $AV_Process.Split('.')[0]
    $Is_started = Get-Process | Where-Object -Property ProcessName -Like $AV_Process
    $AV_PID = (Get-Process | Where-Object ProcessName -Like MsMpeng).Id
    If ($Is_started)
        {
            Write-Host "$AV_Name est demarre $AV_Process (PID : $AV_PID)"
        }
}

##Check SMBv1
if(!(Get-SmbServerConfiguration).EnableSMB1Protocol)
{ Write-Host "SMBv1 desactive" }
else
{ Write-Host "SMBv1 active" }