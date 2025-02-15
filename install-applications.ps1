# This script needs to be hosted publicly (or in an Azure Storage account), and
# the path and name of the script need be given in DeployCustomer.ps1, eg:
#
# $scriptUri = "https://raw.githubusercontent.com/grahamnewland77/PublicRepo/refs/heads/main/install-notepadplusplus.ps1"
# $commandToExecute = "powershell -ExecutionPolicy Unrestricted -File install-notepadplusplus.ps1"
# 
# The script will then be executed once the VM has been deployed.
#

param (
    [string]$FDQN
)

$installerPath = "C:\Temp\npp.8.1.9.3.Installer.x64.exe"
Invoke-WebRequest -Uri "https://github.com/notepad-plus-plus/notepad-plus-plus/releases/download/v8.1.9.3/npp.8.1.9.3.Installer.x64.exe" -OutFile $installerPath
Start-Process -FilePath $installerPath -ArgumentList "/S" -Wait
Remove-Item -Path $installerPath

import-module ServerManager
install-windowsfeature -name AD-Domain-Services -includeManagementTools
import-module ADDSDeployment

Install-ADDSForest -DomainName $FQDN -InstallDNS -CreateDnsDelegation:$false -DatabasePath "C:\Windows\NTDS" -LogPath "C:\Windows\NTDS" -SysvolPath "C:\Windows\SYSVOL" -Force -NoRebootOnCompletion:$true

Restart-Computer -force
