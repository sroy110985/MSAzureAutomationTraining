Get-AutomationVariable -name testvariable

$connection = get-AutomationConnection -name AzureRunAsConnection

$tenantid = $connection.TenantId
$subscriptionid  = $connection.SubscriptionId
$applicationid = $connection.ApplicationId 
$certprint = $connection.CertificateThumbprint


Login-AzureRmAccount -ServicePrincipal -TenantId $tenantid -CertificateThumbprint $certprint -ApplicationId $ApplicationId 
set-AzurermContext -subscriptionid "8e0502bf-56ff-4d96-81e7-11725e8065dd"

stop-AzurermVM -name MyUniqueVM0 -resourcegroupname dscmachines -Force
