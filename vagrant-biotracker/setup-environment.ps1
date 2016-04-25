param([string]$ComputerName = "$env:computername", [int]$RDPEnable = "1", [int]$RDPFirewallOpen = "1", [int]$NLAEnable = "0")

# $RDPEnable - Set to 1 to enable remote desktop connections, 0 to disable
# $RDPFirewallOpen - Set to 1 to open RDP firewall port(s), 0 to close
# $NLAEnable - Set to 1 to enable, 0 to disable

if (($ComputerName -eq "") -or ($RDPEnable -eq "") -or ($RDPFirewallOpen -eq "") -or ($NLAEnable = "")){
   Write-Host "You need to specify all parameters, e.g.:" -ForegroundColor Yellow
   Write-Host " .\RemoteConnections.ps1 localhost 1 1 0" -ForegroundColor Yellow
   exit
 }

# Remote Desktop Connections
$RDP = Get-WmiObject -Class Win32_TerminalServiceSetting -ComputerName $ComputerName -Namespace root\CIMV2\TerminalServices -Authentication PacketPrivacy
$Result = $RDP.SetAllowTSConnections($RDPEnable,$RDPFirewallOpen) # First value enables remote connections, second opens firewall port(s)
if ($Result.ReturnValue -eq 0){
   Write-Host "Remote Connection settings changed sucessfully"
} else {
   Write-Host ("Failed to change Remote Connections setting(s), return code "+$Result.ReturnValue) -ForegroundColor Red
   exit
}

# NLA (Network Level Authentication)
$NLA = Get-WmiObject -Class Win32_TSGeneralSetting -ComputerName $ComputerName -Namespace root\CIMV2\TerminalServices -Authentication PacketPrivacy
$NLA.SetUserAuthenticationRequired($NLAEnable) | Out-Null # Does not set ReturnValue to 0 when it succeeds and we don't want to see screen output to pipe to null
# Recreate the WMI object so we can read out the (hopefully changed) setting
$NLA = Get-WmiObject -Class Win32_TSGeneralSetting -ComputerName $ComputerName -Namespace root\CIMV2\TerminalServices -Authentication PacketPrivacy
if ($NLA.UserAuthenticationRequired -eq $NLAEnable){
   Write-Host "NLA setting changed sucessfully"
} else {
   Write-Host "Failed to change NLA setting" -ForegroundColor Red
   exit
}

# Install Chocolatey
iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1'))

choco install -y git
choco install -y python2
choco install -y cygwin

# BioTracker dependencies
choco install -y cmake
choco install -y opencv
