<#
Connect to CyberArk Target servers transparently

+V1.1
Enhancement Request - Add Description to Labels | https://github.com/TheMediocreCoder/CyberArk_RDPFile_Connector/issues/1
--- Added Descriptions to the Input Fields
    Username - Field must be in domain\user format.
    Target Username - Target Username can only contain AlphaNum _ (underscore) -(hyphen)
    Target Address - Address must be in either FQDN,hostname or IP format.

Enhancement Request - Add AutoSelection | https://github.com/TheMediocreCoder/CyberArk_RDPFile_Connector/issues/2
--- Added Functionality to Hit Submit button using Enter Button
--- Renamed the button text to Connect via CyberArk

#>

###################Update This#######################
#####################################################
#You can use PSM server IP or Load Balanced PSM server VIP
$psm_server_IP = "192.168.1.103"
###############End of Update Section#################
#####################################################

Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.Application]::EnableVisualStyles()
Add-Type -Name Window -Namespace Console -MemberDefinition '
[DllImport("Kernel32.dll")]
public static extern IntPtr GetConsoleWindow();

[DllImport("user32.dll")]
public static extern bool ShowWindow(IntPtr hWnd, Int32 nCmdShow);'

###############Form Design Parameters################
#####################################################
#Co-ordinates
$label_x = 100 
$txt_x = 450
$line1_y = 50
$line_increment = 50
$i=1

#Label & Text box width
$form_width =800
$form_height = 500
$txt_width = 200
$txt_height = 10
$lbl_width = 25
$lbl_height = 10

#Font settings
$lbl_font_size = 10
$txt_font_size = 10
$font_type = "Microsoft Sans Serif"

############End of Form Design Parameters############
#####################################################


###################Form Definition###################
#####################################################
#Add ToolTip
$Tooltip = New-Object System.Windows.Forms.ToolTip 
$ShowHelp = { 
    Switch ($this.name) { 
        'txt_Username'           {$Tip = "Username should be in format Domain\Username.`nTarget Username can only contain AlphaNum _ (underscore) -(hyphen)"; Break} 
        'txt_Target_Username'    {$Tip = "Target Username cannot be in domain\user format.`nTarget Username can only contain AlphaNum _ (underscore) -(hyphen)"; Break} 
        'txt_Target_Address'     {$Tip = "Address must be in either FQDN,hostname or IP format"; Break} 
    } 
    $Tooltip.SetToolTip($this,$Tip) 
}
$Tooltip.IsBalloon = $stream

#Define Form
$Generate_PSM_RDP_File                  = New-Object system.Windows.Forms.Form
$Generate_PSM_RDP_File.ClientSize       = "$form_width,$form_height"
$Generate_PSM_RDP_File.text             = "  CyberArk RDP File"
$Generate_PSM_RDP_File.TopMost          = $false
$Generate_PSM_RDP_File.StartPosition    = "CenterScreen"
$Generate_PSM_RDP_File.MaximizeBox      = $false
#$Generate_PSM_RDP_File.AutoScale        = $true
$Generate_PSM_RDP_File.AutoScroll       = $true

################End of Form Definition###############
#####################################################

function Hide-Console
{
    $consolePtr = [Console.Window]::GetConsoleWindow()
    [Console.Window]::ShowWindow($consolePtr, 0)
}

###################Define Elements###################
#####################################################
#Element1 - Username
$lbl_Username                    = New-Object system.Windows.Forms.Label
$lbl_Username.text               = "Username"
$lbl_Username.AutoSize           = $true
$lbl_Username.location           = New-Object System.Drawing.Point($label_x,($line1_y*$i))
$lbl_Username.Font               = "$($font_type),$($lbl_font_size)"

$txt_Username                    = New-Object system.Windows.Forms.TextBox
$txt_Username.Name               = "txt_Username"
$txt_Username.multiline          = $false
$txt_Username.AutoSize           = $true
$txt_Username.width              = $txt_width
$txt_Username.height             = $txt_height
$txt_Username.location           = New-Object System.Drawing.Point($txt_x,($line1_y*$i))
$txt_Username.Font               = "$($font_type),$($txt_font_size)"
$txt_Username.add_MouseHover($ShowHelp)
$txt_Username.add_MouseClick($ShowHelp)
$i++

#Element2 - Target Username
$lbl_Target_Username             = New-Object system.Windows.Forms.Label
$lbl_Target_Username.text        = "Target Username"
$lbl_Target_Username.AutoSize    = $true
$lbl_Target_Username.location    = New-Object System.Drawing.Point($label_x,($line1_y*$i))
$lbl_Target_Username.Font        = "$($font_type),$($lbl_font_size)"

$txt_Target_Username             = New-Object system.Windows.Forms.TextBox
$txt_Target_Username.Name        = "txt_Target_Username"
$txt_Target_Username.multiline   = $false
$txt_Target_Username.AutoSize    = $true
$txt_Target_Username.width       = $txt_width
$txt_Target_Username.height      = $txt_height
$txt_Target_Username.location    = New-Object System.Drawing.Point($txt_x,($line1_y*$i))
$txt_Target_Username.Font        = "$($font_type),$($txt_font_size)"
$txt_Target_Username.add_MouseHover($ShowHelp)
$txt_Target_Username.add_MouseClick($ShowHelp)
$Generate_PSM_RDP_File.add_Shown({$txt_Target_Username.Select()})
$i++


#Element3 - Target Addrsess
$lbl_Target_Address               = New-Object system.Windows.Forms.Label
$lbl_Target_Address.text          = "Target Address"
$lbl_Target_Address.AutoSize      = $true
$lbl_Target_Address.location      = New-Object System.Drawing.Point($label_x,($line1_y*$i))
$lbl_Target_Address.Font          = "$($font_type),$($lbl_font_size)"

$txt_Target_Address              = New-Object system.Windows.Forms.TextBox
$txt_Target_Address.Name         = "txt_Target_Address"
$txt_Target_Address.multiline    = $false
$txt_Target_Address.AutoSize     = $true
$txt_Target_Address.width        = $txt_width
$txt_Target_Address.height       = $txt_height
$txt_Target_Address.location     = New-Object System.Drawing.Point($txt_x,($line1_y*$i))
$txt_Target_Address.Font         = "$($font_type),$($txt_font_size)"
$txt_Target_Address.add_MouseHover($ShowHelp)
$txt_Target_Address.add_MouseClick($ShowHelp)
$i++

#Element4 - Domain Name
$lbl_Domain                       = New-Object system.Windows.Forms.Label
$lbl_Domain.text                  = "Domain"
$lbl_Domain.AutoSize              = $true
$lbl_Domain.location              = New-Object System.Drawing.Point($label_x,($line1_y*$i))
$lbl_Domain.Font                  = "$($font_type),$($lbl_font_size)"

$txt_Domain                       = New-Object system.Windows.Forms.TextBox
$txt_Domain.multiline             = $false
$txt_Domain.AutoSize              = $true
$txt_Domain.width                 = $txt_width
$txt_Domain.height                = $txt_height
$txt_Domain.location              = New-Object System.Drawing.Point($txt_x,($line1_y*$i))
$txt_Domain.Font                  = "$($font_type),$($txt_font_size)"
$i++

#Element5 - Connection Type - Dropdown - RDP,SSH (Default: RDP)
$lbl_Connection_Type              = New-Object system.Windows.Forms.Label
$lbl_Connection_Type.text         = "Connection Type"
$lbl_Connection_Type.AutoSize     = $true
$lbl_Connection_Type.location     = New-Object System.Drawing.Point($label_x,($line1_y*$i))
$lbl_Connection_Type.Font         = "$($font_type),$($lbl_font_size)"

$dd_Connection_Type               = New-Object System.Windows.Forms.ComboBox
$dd_Connection_Type.AutoSize      = $true
$dd_Connection_Type.width         = $txt_width
$dd_Connection_Type.height        = $txt_height
$dd_Connection_Type.location      = New-Object System.Drawing.Point($txt_x,($line1_y*$i))
$dd_Connection_Type.Font          = "$($font_type),$($txt_font_size)"
$dd_Connection_Type.DropDownStyle = "DropDownList"
$dd_Connection_Type.Items.AddRange(@('RDP','SSH'))
$i++

#Element6 - Account Type - Radio Button - Domain or Local (Default: Domain)
$lbl_Account_Type                 = New-Object system.Windows.Forms.Label
$lbl_Account_Type.text            = "Account Type"
$lbl_Account_Type.AutoSize        = $true
$lbl_Account_Type.location        = New-Object System.Drawing.Point($label_x,($line1_y*$i))
$lbl_Account_Type.Font            = "$($font_type),$($lbl_font_size)"

$rb_Account_Type1                 = New-Object System.Windows.Forms.RadioButton
$rb_Account_Type1.location        = New-Object System.Drawing.Point($txt_x,($line1_y*$i))
$rb_Account_Type1.Text            = "Domain"
$rb_Account_Type1.AutoSize        = $true
$rb_Account_Type1.Font            = "$($font_type),$($lbl_font_size)"
$rb_Account_Type2                 = New-Object System.Windows.Forms.RadioButton
$rb_Account_Type2.location        = New-Object System.Drawing.Point(($txt_x+200),($line1_y*$i))
$rb_Account_Type2.text            = "Local"
$rb_Account_Type2.AutoSize        = $true
$rb_Account_Type2.Font            = "$($font_type),$($lbl_font_size)"
#$rb_Account_Type2.AutoCheck      = $false
$i++

#Element7 - Account Type - Radio Button - Domain or Local (Default: Domain)
$bttn_Connect                     = New-Object System.Windows.Forms.Button
$bttn_Connect.Location            = New-Object System.Drawing.Point((($form_width/2)-70),($line1_y*$i))
$bttn_Connect.AutoSize            = $true
$bttn_Connect.Font                = "$($font_type),$($lbl_font_size)"
$bttn_Connect.Text                = "Connect via CyberArk"
$i++

$lbl_Status = New-Object System.Windows.Forms.Label
$lbl_Status.Location              = New-Object System.Drawing.Point($lbl_x,($line1_y*$i))
$lbl_Status.AutoSize              = $true
$lbl_Status.Text                  = ""
$lbl_height                       = 80
$lbl_Status.Font                  = "$($font_type),$($lbl_font_size)"
$lbl_Status.ForeColor             = "Red"

$statusbar = New-Object System.Windows.Forms.StatusBar
$statusbar.Text = "This Script is not affiliated to CyberArk Software Ltd.`n`rCreated & Managed by: https://github.com/TheMediocreCoder"

$Generate_PSM_RDP_File.AcceptButton = $bttn_Connect

###################End of Elements###################
#####################################################

#####################################################
###############Default Element Values################
#Element1 - Get Logged In Username & Domain
$txt_Username.Text = "$env:USERDOMAIN\$env:USERNAME"
#Element4 - Get Domian FQDN
$txt_Domain.Text = "$env:USERDNSDOMAIN"
#Element5 - Default Connection Component - RDP
$dd_Connection_Type.SelectedItem = 'RDP'
#Element5 - Default Account Type - Domain
$rb_Account_Type1.Checked = $true
#################End Default Values##################
#####################################################

#####################################################
#############Define RDP File Parms###################
$RDP_File_Defaults = "
screen mode id:i:2
use multimon:i:0
desktopwidth:i:3091
desktopheight:i:1889
session bpp:i:32
winposstr:s:0,3,0,0,800,600
compression:i:1
keyboardhook:i:2
audiocapturemode:i:0
videoplaybackmode:i:1
connection type:i:7
networkautodetect:i:1
bandwidthautodetect:i:1
displayconnectionbar:i:1
enableworkspacereconnect:i:0
disable wallpaper:i:0
allow font smoothing:i:0
allow desktop composition:i:0
disable full window drag:i:1
disable menu anims:i:1
disable themes:i:0
disable cursor setting:i:0
bitmapcachepersistenable:i:1
full address:s:$psm_server_IP
audiomode:i:0
redirectprinters:i:1
redirectcomports:i:0
redirectsmartcards:i:1
redirectclipboard:i:1
redirectposdevices:i:0
drivestoredirect:s:
autoreconnection enabled:i:1
authentication level:i:2
prompt for credentials:i:0
negotiate security layer:i:1
remoteapplicationmode:i:0
shell working directory:s:
gatewayhostname:s:
gatewayusagemethod:i:4
gatewaycredentialssource:i:4
gatewayprofileusagemethod:i:0
promptcredentialonce:i:0
gatewaybrokeringtype:i:0
use redirection server name:i:0
rdgiskdcproxy:i:0
kdcproxyname:s:"
###################End RDP File#####################
####################################################


#####################################################
#############Button Click Function###################
$bttn_Connect.Add_Click(
{
    $flag_Validation_error = 0
    $lbl_Status.Text = "Error:"
    
    #Validate Username
    if ($txt_Username.Text -eq $null -or $txt_Username.Text -eq '' -or $txt_Username.Text -eq "")
    {
        $lbl_Status.Text += "`n`rUsername Value Missing"
        $flag_Validation_error = 1
    }
    elseif ($txt_Username.Text -notmatch "^[a-z A-z]{2,20}\\[a-z A-Z 0-9]+$")
    {
        $lbl_Status.Text += "`n`rUsername should be in format Domain\Username"
        $flag_Validation_error = 1
    }
    elseif(($txt_Username.Text.Length -lt 3) -or ($txt_Username.Text.Length -ge 25))
    {
        $lbl_Status.Text += "`n`rAllowed length of Username is 3 to 25 characters."
        $flag_Validation_error = 1
    }

    #Validate Target Username
    if ($txt_Target_Username.Text -eq $null -or $txt_Target_Username.Text -eq '' -or $txt_Target_Username.Text -eq "")
    {
        $lbl_Status.Text += "`n`rTarget Username Value Missing"
        $flag_Validation_error = 1
    }
    elseif ($txt_Target_Username.Text -notmatch "^[a-zA-Z0-9-_]+$")
    { 
        $lbl_Status.Text += "`n`rTarget Username can only contain AlphaNum _ (underscore) -(hyphen) "
        $flag_Validation_error = 1
    }
    elseif(($txt_Target_Username.Text.Length -lt 3) -or ($txt_Target_Username.Text.Length -ge 20))
    {
        $lbl_Status.Text += "`n`rAllowed length of Target Username is 3 to 20 characters."
        $flag_Validation_error = 1
    }

    #Validate Domain DNS
    if ($txt_Domain.Text -eq $null -or $txt_Domain.Text -eq '' -or $txt_Domain.Text -eq "")
    {
        $lbl_Status.Text += "`n`rDomain value Missing"
        $flag_Validation_error = 1
    }
    elseif ($txt_Domain.Text -notmatch "^[a-zA-Z0-9-\._]+$")
    { 
        $lbl_Status.Text += "`n`rDomain can only contain AlphaNum, _(underscore), -(hyphen), .(dot)"
        $flag_Validation_error = 1
    }
    elseif(($txt_Domain.Text.Length -le 3) -or ($txt_Domain.Text.Length -ge 25))
    {
        $lbl_Status.Text += "`n`rAllowed length of Domain name is 3 to 25 characters."
        $flag_Validation_error = 1
    }

    #Validate Target Address Input
    if ($txt_Target_Address.Text -eq $null -or $txt_Target_Address.Text -eq '' -or $txt_Target_Address.Text -eq "")
    {
            $lbl_Status.Text += "`r`nTarget Address Value Missing"
            $flag_Validation_error = 1
    }
    elseif (($txt_Target_Address.Text -notmatch "^((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$") -and ($txt_Target_Address.Text -notmatch "^[a-zA-Z0-9-\._]+$"))
    {
        $lbl_Status.Text += "`r`nInvalid IP address or Hostname.`r`nHostname only accepts Alphanum, _(underscore), -(hyphen)."
        $flag_Validation_error = 1
    }
    elseif(($txt_Target_Address.Text.Length -le 3) -or ($txt_Target_Address.Text.Length -ge 20))
    {
        $lbl_Status.Text += "`n`rAllowed length of Target Address name is 3 to 20 characters."
        $flag_Validation_error = 1
    }

    if($flag_Validation_error)
    {
        return
    }
    else
    {
        $lbl_Status.Text = ""
        if($dd_Connection_Type.SelectedItem -eq "RDP")
        {
            $connection_type = "PSM-RDP"
        }
        elseif($dd_Connection_Type.SelectedItem -eq "SSH")
        {
            $connection_type = "PSM-SSH"
        }

        if($rb_Account_Type1.Checked)
        {
            $temp_Target_username = $txt_Target_Username.Text + "@" + $txt_Domain.Text
        }
        elseif($rb_Account_Type2.Checked)
        {
            $temp_Target_username = $txt_Target_Username.Text 
        }
        
        #Generate RDP File
        $RDP_File_parms = $RDP_File_Defaults + "`r`nusername:s:$($txt_Username.Text)" + "`r`nalternate shell:s:psm /u $($temp_Target_username) /a $($txt_Target_Address.Text) /c $($connection_type)"
        Add-Content $env:TEMP\launchrdp.rdp $RDP_File_parms
        
        #Launch RDP File
        try
        {
            Invoke-Expression "mstsc.exe $env:TEMP\launchrdp.rdp" -ErrorAction Stop
            Start-Sleep 5
        }
        catch
        {
            [System.Windows.MessageBox]::Show("Failed to Lauch RDPFile. `r`n $($ERROR[0])")
        }
        Remove-Item $env:TEMP\launchrdp.rdp -ErrorAction SilentlyContinue
    }
})

Hide-Console | Out-Null
$Generate_PSM_RDP_File.controls.AddRange(@($lbl_Username,$txt_Username,$lbl_Target_Username,$txt_Target_Username,$lbl_Target_Address,$txt_Target_Address,$lbl_Domain,$txt_Domain,$lbl_Connection_Type,$dd_Connection_Type,$lbl_Account_Type,$rb_Account_Type1,$rb_Account_Type2,$bttn_Connect,$lbl_Status,$statusbar))
$Generate_PSM_RDP_File.ShowDialog()