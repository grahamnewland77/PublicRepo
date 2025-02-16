# Install-Application.ps1
#
# -- Graham Newland <graham@grahamnewland.co.uk>
#
# This script needs to be hosted publicly (or in an Azure Storage account), and
# the path and name of the script need be given in DeployCustomer.ps1, eg:
#
# $scriptUri = "https://raw.githubusercontent.com/grahamnewland77/PublicRepo/refs/heads/main/install-notepadplusplus.ps1"
# $commandToExecute = "powershell -ExecutionPolicy Unrestricted -File install-notepadplusplus.ps1"
# 
# The script will then be executed once the VM has been deployed.
#

param (
    [string]$FDQN,
    [string]$password,
)
start-transcript -path c:\customscript.txt
#$plainPassword = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto([System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($password))

import-module ServerManager
install-windowsfeature -name AD-Domain-Services,DNS -includeManagementTools
import-module ADDSDeployment

$securePassword = ConvertTo-SecureString -String $Password -AsPlainText -Force
Install-ADDSForest -DomainName $FQDN -InstallDNS -CreateDnsDelegation:$false -DatabasePath "C:\Windows\NTDS" -LogPath "C:\Windows\NTDS" -SysvolPath "C:\Windows\SYSVOL" -Force -NoRebootOnCompletion:$true -safeModeAdministratorPassword $securepassword

stop-transcript
#Restart-Computer -force
