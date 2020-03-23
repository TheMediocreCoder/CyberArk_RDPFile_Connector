# CyberArk_RDPFile_Connector
Connect to CyberArk Target servers transparently

## Are you Feeling Stranded after departure of Microsoft RDCMan (Microsoft Remote Desktop Connection Manager)?
Simply run this script and connect transparently to your Target without going to PVWA

Download the Create_RDP_Files.ps1 & update value of $psm_server_IP to your PSM server IP address or Loadbalanced VIP.

![Image of CyberArk RDP File Generator](https://github.com/TheMediocreCoder/CyberArk_RDPFile_Connector/blob/master/docs/images/RDP_File_Launcher.jpg)

## How to Run CyberArk RDP File Generator
### Option 1:

![Image of How](https://github.com/TheMediocreCoder/CyberArk_RDPFile_Connector/blob/master/docs/images/Run_PS_RDP_File.jpg)

### Option 2: If you don't have Run with PowerShell available in the Context Menu

![Image of How CLI](https://github.com/TheMediocreCoder/CyberArk_RDPFile_Connector/blob/master/docs/images/Launch_PowerShell_CMD.JPG)

P.S.:
If you are logged in with Domain credentials. Script will automatically fill your username in format Domain/Username & Domain DNS.

Thanks to @pspete for reviewing the code and suggesting Readme & adding PSM Server as User field.
