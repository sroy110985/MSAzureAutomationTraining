

param(
$port = 9100
)



$cert = New-SelfSignedCertificate -CertstoreLocation Cert:\LocalMachine\My -DnsName $env:COMPUTERNAME

$ComputerName = "Localhost"
$PowershellRootFeatureName = "PowershellRoot" 
$Powershell4FeatureName = "Powershell" 
$PowershellISEFeatureName = "Powershell-ISE" 
$IISWindowsFeature = "Web-Server"
$NET35WindowsFeature = "NET-Framework-Features"
$NET45WindowsFeature = "NET-Framework-45-Features"
$ODataWindowsFeature = "ManagementOData"
$DSCWindowsFeatureName = "DSC-Service"


$PULLServerWebDirectory = "C:\PSDSCPullServer"
$PULLServerSubDirectory = "bin"
$iisAppPoolName = "DSCPullServer"
$iisAppPoolDotNetVersion = "v4.0"
$iisAppName = "PSDSCPullServer"

$certificateThumbPrint = $cert.Thumbprint


if( (Get-WindowsFeature -Name $IISWindowsFeature) -eq $null )
{
    Install-WindowsFeature -Name $IISWindowsFeature -IncludeManagementTools -ComputerName $ComputerName | out-null
}
if( (Get-WindowsFeature -Name $NET45WindowsFeature) -eq $null )
{
    Install-WindowsFeature -Name $NET45WindowsFeature -IncludeManagementTools  -ComputerName $ComputerName | out-null
}
if( (Get-WindowsFeature -Name $ODataWindowsFeature) -eq $null )
{
    Install-WindowsFeature -Name $ODataWindowsFeature -IncludeManagementTools  -ComputerName $ComputerName | out-null
}
if( (Get-WindowsFeature -Name $DSCWindowsFeatureName) -eq $null )
{
    Install-WindowsFeature -Name $DSCWindowsFeatureName -IncludeManagementTools  -ComputerName $ComputerName | out-null
}


New-item -Path $PULLServerWebDirectory -ItemType Directory -Force -Confirm:$false  | out-null
New-item -Path $($PULLServerWebDirectory + "\" + $PULLServerSubDirectory) -ItemType Directory -Force -Confirm:$false | out-null

if ((Get-Item -LiteralPath "$PULLServerWebDirectory\Global.asax") -eq $null)
{
Copy-Item -Path "$pshome\modules\psdesiredstateconfiguration\pullserver\Global.asax" -Destination "$PULLServerWebDirectory\Global.asax" -Force -Confirm:$false | out-null
}
if ((Get-Item -LiteralPath "$PULLServerWebDirectory\PSDSCPullServer.mof") -eq $null)
{
Copy-Item -Path "$pshome\modules\psdesiredstateconfiguration\pullserver\PSDSCPullServer.mof" `
          -Destination "$PULLServerWebDirectory\PSDSCPullServer.mof" -Force -Confirm:$false | out-null
Copy-Item -Path "$pshome\modules\psdesiredstateconfiguration\pullserver\PSDSCPullServer.svc" `
          -Destination "$PULLServerWebDirectory\PSDSCPullServer.svc" -Force -Confirm:$false | out-null
Copy-Item -Path "$pshome\modules\psdesiredstateconfiguration\pullserver\PSDSCPullServer.xml" `
          -Destination "$PULLServerWebDirectory\PSDSCPullServer.xml" -Force -Confirm:$false | out-null
Copy-Item -Path "$pshome\modules\psdesiredstateconfiguration\pullserver\PSDSCPullServer.config" `
          -Destination "$PULLServerWebDirectory\web.config" -Force -Confirm:$false | out-null

Copy-Item -Path "$pshome\modules\psdesiredstateconfiguration\pullserver\IISSelfSignedCertModule.dll" `
    -Destination "$($PULLServerWebDirectory + "\" + $PULLServerSubDirectory + "\IISSelfSignedCertModule.dll")" -Force -Confirm:$false| out-null

Copy-Item -Path "$pshome\modules\psdesiredstateconfiguration\pullserver\Microsoft.Powershell.DesiredStateConfiguration.Service.dll" `
    -Destination "$($PULLServerWebDirectory + "\" + $PULLServerSubDirectory + "\Microsoft.Powershell.DesiredStateConfiguration.Service.dll")" -Force -Confirm:$false | out-null

Copy-Item -Path "$pshome\modules\psdesiredstateconfiguration\pullserver\Devices.mdb" `
          -Destination "$env:programfiles\WindowsPowerShell\DscService\Devices.mdb" | out-null
}



$siteID = ((Get-Website | % { $_.Id } | Measure-Object -Maximum).Maximum + 1)

if ( (Get-Item IIS:\AppPools\$iisAppPoolName) -eq $null)
{
$null = New-WebAppPool -Name $iisAppPoolName

$appPoolItem = Get-Item IIS:\AppPools\$iisAppPoolName
    $appPoolItem.managedRuntimeVersion = "v4.0"
    $appPoolItem.enable32BitAppOnWin64 = $true
    $appPoolItem.processModel.identityType = 0
    $appPoolItem | Set-Item
 }

 if ( (Get-Website -Name $iisAppName) -eq $null)
 {
$webSite = New-WebSite -Name $iisAppName -Id $siteID -Port $port -IPAddress "*" -PhysicalPath $PULLServerWebDirectory -ApplicationPool $iisAppPoolName -Ssl

        # Remove existing binding for $port
Remove-Item IIS:\SSLBindings\0.0.0.0!$port -ErrorAction Ignore | out-null

        # Create a new binding using the supplied certificate
$null = Get-Item CERT:\LocalMachine\MY\$certificateThumbPrint | New-Item IIS:\SSLBindings\0.0.0.0!$port
}
  
Start-Website -Name $iisAppName  | out-null

$appcmd = "$env:windir\system32\inetsrv\appcmd.exe" 

& $appCmd set AppPool $appPoolItem.name /processModel.identityType:LocalSystem | out-null
& $appCmd unlock config -section:access | out-null
& $appCmd unlock config -section:anonymousAuthentication | out-null
& $appCmd unlock config -section:basicAuthentication | out-null
& $appCmd unlock config -section:windowsAuthentication | out-null



$guid = [guid]::NewGuid()

New-Item -ItemType File -Value $guid -Path "C:\Program Files\WindowsPowerShell\DscService" -Name "RegistrationKeys.txt" -Force -confirm:$false | out-null

  $xml = [XML](Get-Content "$PULLServerWebDirectory\web.config")                                                                                   
  $RootDoc = $xml.get_DocumentElement()                                                                                                                          
  $subnode = $xml.CreateElement("add")  
  $subnode.SetAttribute("key", "dbprovider")                                                                                                                    
  $subnode.SetAttribute("value", "System.Data.OleDb")                                                                                                                    
  $RootDoc.appSettings.AppendChild($subnode) | out-null
  
  $subnode = $xml.CreateElement("add")  
  $subnode.SetAttribute("key", "dbconnectionstr")                                                                                                                    
  $subnode.SetAttribute("value", "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=C:\Program Files\WindowsPowerShell\DscService\Devices.mdb;")                                                                                                                    
  $RootDoc.appSettings.AppendChild($subnode) | out-null

  $subnode = $xml.CreateElement("add")  
  $subnode.SetAttribute("key", "ConfigurationPath")  | out-null                                                                                                                  
  $subnode.SetAttribute("value", "C:\Program Files\WindowsPowerShell\DscService\Configuration")                                                                                                                    
  $RootDoc.appSettings.AppendChild($subnode) | out-null

  $subnode = $xml.CreateElement("add")  
  $subnode.SetAttribute("key", "ModulePath")                                                                                                                    
  $subnode.SetAttribute("value", "C:\Program Files\WindowsPowerShell\DscService\Modules")                                                                                                                    
  $RootDoc.appSettings.AppendChild($subnode) | out-null

  $subnode = $xml.CreateElement("add")  
  $subnode.SetAttribute("key", "RegistrationKeyPath")                                                                                                                    
  $subnode.SetAttribute("value", "C:\Program Files\WindowsPowerShell\DscService")                                                                                                                    
  $RootDoc.appSettings.AppendChild($subnode)  | out-null
                                                                                                                      
  $xml.Save("$PULLServerWebDirectory\web.config")  
  CD C:\ | out-null
 
 if (!(Get-NetFirewallRule | where {$_.Name -eq "PullServerRule"})) {
 New-NetFirewallRule -Name "PullServerRule" -DisplayName "Ninety" -Protocol tcp -LocalPort $port -Action Allow -Enabled True | out-null
 }

 Write-Output $guid.Guid
