#Set Windows Firewall to OFF
write-host "Setting Windows Firewall to OFF..."
set-NetFirewallProfile -All -Enabled False

Install-WindowsFeature -Name "RSAT-AD-PowerShell" -IncludeAllSubFeature

Import-Module "ActiveDirectory"


#Set DNS Suffix
Set-DnsClientGlobalSetting -SuffixSearchList @("stgent.stgcore.medtronic.com")

#Set Enable RDP
Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Terminal Server' -name "fDenyTSConnections" -value 0

Start-Sleep -Seconds 30

$domain = "${addomain}"
$password = "${adpass}" | ConvertTo-SecureString -asPlainText -Force
$username = "${aduser}" 
$credential = New-Object System.Management.Automation.PSCredential($username, $password)

# Check if the OU exists
if (-not (Get-ADOrganizationalUnit -Filter "DistinguishedName -eq '${oupath}'" -Server "MSPMCADC01.STGCFRF.MEDTRONIC.COM" -Credential $credential)) {
    # Create the OU
    New-ADOrganizationalUnit -Name "${appname}" -Path "${adou}"
    Write-Host "OU ${appname} created successfully."
} else {
    Write-Host "OU ${appname} already exists."
}

Start-Sleep -Seconds 30

#Add to domain
write-host "Add to domain"
Add-Computer -DomainName "${addomain}" -OUPath "${oupath}" -Credential $credential

# Define variables
$stgentDomain = "STGENT"
$stgcfrfDomain = "STGCFRF"

# Define group names
$gsGroup = "MSP-${vmname}-ADMINS-GS"
$dlGroup = "${vmname}-ADMINS-DL"

# Define Organizational Unit (OU) paths
$dOUPath = "OU=Itasca,OU=Server-Admins,OU=Groups,OU=Admins,DC=STGCFRF,DC=MEDTRONIC,DC=COM"
$gOUPath = "OU=Itasca,OU=Server Groups,OU=MIT Admin Accounts,OU=Admins,DC=stgent,DC=stgcore,DC=medtronic,DC=com"

# Create global security group in STGENT domain
New-ADGroup -Name $gsGroup `
            -GroupCategory Security `
            -GroupScope Global `
            -Path $gOUPath `
            -Description "Created by ITASCA MGO - Member of ${vmname} Domain Local Group" `
            -Credential $credential `
            -Server "MSPMSBDC101.stgent.stgcore.medtronic.com"

# Create domain local security group in STGCFRF domain
New-ADGroup -Name $dlGroup `
            -GroupCategory Security `
            -GroupScope DomainLocal `
            -Path $dOUPath `
            -Description "Created by ITASCA MGO - Nested to ${vmname} Local Administrators Group" `
            -Credential $credential
# Add the global security group to the domain local group
$dnGGroup = Get-ADGroup $gsGroup -Credential $credential -Server "MSPMSBDC101.stgent.stgcore.medtronic.com" 
                    
Get-ADGroup $dlGroup -Credential $credential | Add-ADGroupMember -Members $dnGGroup 
   
# Add the domain local group to local Administrators group
Add-LocalGroupMember -Group "Administrators" `
                     -Member "$stgcfrfDomain\$dlGroup"

#Onboard local Administrator account to CyberArk
$Url = "http://msplin800.corp.medtronic.com/pub/RtM/Windows/CyberArk.psm1" 
mkdir "C:\temp" -Force
$Destination = "C:\temp\CyberArk.psm1"      
Invoke-WebRequest -Uri $Url -OutFile $Destination -UseBasicParsing

ipconfig /registerdns

#Import the module
Import-Module "C:\temp\CyberArk.psm1"
Add-CyberArkAccount

#Clear userdata
write-host "Clear userdata"
set-location "C:\ProgramFiles\VMware\VMware~1\"
.\rpctool.exe "info-set guestinfo.userdata  "

#Remove Script
write-host "Remove Script"
Remove-Item -Path "C:\bootstrap.ps1" -Force
#Restart VM
write-host "Restart VM"
Restart-Computer -Force