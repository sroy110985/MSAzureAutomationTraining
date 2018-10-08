Invoke-Command -ComputerName localhost -Port 5895 -Authentication Negotiate  -ScriptBlock {
    get-date

}

Invoke-Command -ComputerName localhost -Port 5895   -ScriptBlock {
    get-date

}

Invoke-Command -ComputerName localhost -Port 5985   -ScriptBlock {
    get-date

}

Invoke-Command -ComputerName 13.81.172.177 -Port 5985   -ScriptBlock {
    get-date

}

Invoke-Command -ComputerName 13.81.172.177 -Port 5985 -Authentication Negotiate -Credential $(get-cren
dial)   -ScriptBlock {
    get-date

}

Invoke-Command -ComputerName 13.81.172.177 -Port 5985 -Authentication Negotiate -Credential $(Get-Cred
ential)   -ScriptBlock {
    get-date

}
WSMan:\localhost
WSMan:\localhost\Client
Get-ChildItem WSMan:\localhost\Client
Set-Item WSMan:\localhost\Client\TrustedHosts -Value 40.115.27.171, 13.81.172.177
Set-Item WSMan:\localhost\Client\TrustedHosts -Value "40.115.27.171, 13.81.172.177"

Invoke-Command -ComputerName 13.81.172.177 -Port 5985 -Authentication Negotiate -Credential $(Get-Cred
ential)   -ScriptBlock {
    get-date

}
Set-Item WSMan:\localhost\Client\TrustedHosts -Value 13.81.172.177

Invoke-Command -ComputerName 13.81.172.177 -Port 5985 -Authentication Negotiate -Credential $(Get-Cred
ential)   -ScriptBlock {
    get-date

}

Invoke-Command -ComputerName 13.81.172.177 -Port 5985 -Authentication Negotiate -Credential $(Get-Cred
ential)   -ScriptBlock {
    get-date

}
Get-ChildItem WSMan:\localhost\Client
Get-ChildItem WSMan:\localhost\Client\TrustedHosts

Invoke-Command -ComputerName 13.81.172.177 -Port 5985 -Authentication Negotiate `
-Credential $(Get-Credential)   -ScriptBlock {
    get-date

}

$pass = "sfsfsfsf"
$username "sfsfsfsfsf"

$password = ConvertTo-SecureString -String $pass -AsPlainText -Force

$cred = New-Object System.Management.Automation.PSCredential -ArgumentList $username,$password


Invoke-Command -ComputerName 13.81.172.177 -Port 5985 -Authentication Negotiate `
-Credential $cred   -ScriptBlock {
    get-date

}

$pass = "citynext!1234"
$username = "citynextadmin"

$password = ConvertTo-SecureString -String $pass -AsPlainText -Force

$cred = New-Object System.Management.Automation.PSCredential -ArgumentList $username,$password


Invoke-Command -ComputerName 143.481.72.17 -Port 5985 -Authentication Negotiate `
-Credential $cred   -ScriptBlock {
    get-date

}

$pass = "sdfsfsfsf"
$username = "fssfsfsfsf"

$password = ConvertTo-SecureString -String $pass -AsPlainText -Force

$cred = New-Object System.Management.Automation.PSCredential -ArgumentList $username,$password


Invoke-Command -ComputerName 143.111.12.77 -Port 5985 -Authentication Negotiate `
-Credential $cred   -ScriptBlock {
    Get-ChildItem -Path "C:\"

}

$pass = "sdfsdfsdfs"
$username = "sdfsfsfs"

$password = ConvertTo-SecureString -String $pass -AsPlainText -Force

$cred = New-Object System.Management.Automation.PSCredential -ArgumentList $username,$password

$session = New-PSSession -ComputerName 113.181.12.17 -Port 5985 -Credential $cred -Authentication Nego
tiate -EnableNetworkAccess -SessionOption $(New-PSSessionOption -SkipCACheck -SkipCNCheck -SkipRevocat
ionCheck)

Invoke-Command -Session $session
-Credential $cred   -ScriptBlock {
    Get-ChildItem -Path "C:\"

}

$pass = "sdfsdff"
$username = "sdfsfsf"

$password = ConvertTo-SecureString -String $pass -AsPlainText -Force

$cred = New-Object System.Management.Automation.PSCredential -ArgumentList $username,$password

$session = New-PSSession -ComputerName 113.181.12.17 -Port 5985 -Credential $cred -Authentication Nego
tiate -EnableNetworkAccess -SessionOption $(New-PSSessionOption -SkipCACheck -SkipCNCheck -SkipRevocat
ionCheck)

Invoke-Command -Session $session
-Credential $cred   -ScriptBlock {
    Get-ChildItem -Path "C:\"

}



$pass = "sfsfsf"
$username = "sfsdfsfsdf"

$password = ConvertTo-SecureString -String $pass -AsPlainText -Force

$cred = New-Object System.Management.Automation.PSCredential -ArgumentList $username,$password

$session = New-PSSession -ComputerName 113.181.12.17 -Port 5985  -Authentication Negotiate -EnableNetw
orkAccess -SessionOption $(New-PSSessionOption -SkipCACheck -SkipCNCheck -SkipRevocationCheck)

Invoke-Command -Session $session -Credential $cred
-Credential $cred   -ScriptBlock {
    Get-ChildItem -Path "C:\"

}



$pass = "sdfsdfsfsdf"
$username = "sdfsdfsdfsf"

$password = ConvertTo-SecureString -String $pass -AsPlainText -Force

$cred = New-Object System.Management.Automation.PSCredential -ArgumentList $username,$password

$session = New-PSSession -ComputerName 113.181.12.17 -Port 5985 -Credential $cred  -Authentication Neg
otiate -EnableNetworkAccess -SessionOption $(New-PSSessionOption -SkipCACheck -SkipCNCheck -SkipRevoca
tionCheck)

Invoke-Command -Session $session   -ScriptBlock {
    Get-ChildItem -Path "C:\"

}




Invoke-Command -Session $session   -ScriptBlock {
    get-date

}



1,2,3,4,5 | Sort-Object -Descending | foreach {$_ + 1} | Where-Object {$_ -gt 3}

1,2,3,4,5 | Sort-Object -Descending | foreach {$PSItem + 1} | Where-Object {$_ -gt 3}
Get-Content -Path "C:\abcd.txt.txt"
Get-Content -Path "C:\abcd.txt.txt" > "C:\xyz.txt"
Get-Content -Path "C:\xyz.txt"
1/0

1/0
Write-Output "it got divided"
$ErrorActionPreference
$ErrorActionPreference ="silentlyContinue"

1/0
Write-Output "it got divided"
$ErrorActionPreference ="stop"

1/0
Write-Output "it got divided"
Get-ChildItem -ErrorAction Stop

#1,2,3,4,5 | Sort-Object -Descending | foreach {$PSItem + 1} | Where-Object {$_ -gt 3}

try {
    1/0
} 

catch{
    Write-Output "got an exception"
}
finally {
    Write-Output "executing finally block"
}

#1,2,3,4,5 | Sort-Object -Descending | foreach {$PSItem + 1} | Where-Object {$_ -gt 3}

try {
    1/0
} 

catch{
    Write-Output "got an exception"
    1/1
    throw
}
finally {
    Write-Output "executing finally block"
}

#1,2,3,4,5 | Sort-Object -Descending | foreach {$PSItem + 1} | Where-Object {$_ -gt 3}

try {
    1/0
} 

catch{
    Write-Output "got an exception"
    1/1
    throw "does not work !!"
}
finally {
    Write-Output "executing finally block"
}
$Error
$Error[0]
$Error[1]
$Error[0].ErrorDetails
$Error[0].Exception
cls

#1,2,3,4,5 | Sort-Object -Descending | foreach {$PSItem + 1} | Where-Object {$_ -gt 3}

try {
    1/0
} 

catch{
    Write-Output "got an exception"
    1/1
    throw "does not work !!"
}
finally {
    Write-Output "executing finally block"
}

#1,2,3,4,5 | Sort-Object -Descending | foreach {$PSItem + 1} | Where-Object {$_ -gt 3}

try {
    1/0
} 

catch{
    Write-Output "got an exception"
    1/1
    Write-Output "does not work !!"
}
finally {
    Write-Output "executing finally block"
}
$env:PSModulePath
AddTwoNumbers -a 10 -b 20
Import-Module MyMaths
Update-Module myMaths
get-module -Name PackageManagement
get-command -Module PackageManagement
(Get-Command Update-Module).ModuleName
Get-Command -Module PowerShellGet
New-ModuleManifest -Path "C:\Program Files\WindowsPowerShell\Modules\MyMaths\MyMaths.psd1" -RootModule
 "MyMaths" -FunctionsToExport "*" 
(Get-History -Count 500).CommandLine
cls
