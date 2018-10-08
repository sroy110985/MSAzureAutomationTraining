Login-AzureRmAccount

Set-AzureRmContext -Subscription riteshsubscription

New-AzureRmResourceGroup -Name "mclassoct" -Location "West Europe" -Verbose

$splat = @{'resourcegroupname' = 'mclassoct'; 'location'='west europe'}


$storage = New-AzureRmStorageAccount -Name mclassoctpitrewq -SkuName Standard_LRS `
-Kind StorageV2 -AccessTier Hot -Location 'West Europe' -ResourceGroupName mclassoct  -Verbose

New-AzureStorageContainer -Name "myfiles" -Permission Container -Context $storage.Context

Set-AzureStorageBlobContent -Container "myfiles" -Context $storage.Context `
-Force -File "C:\abcd.txt.txt" -BlobType Block -Verbose

$pip = New-AzureRmPublicIpAddress @splat -Name "mypip" -Sku Basic -AllocationMethod Static `
-IpAddressVersion IPv4 -DomainNameLabel mytestmclassoct -Verbose

Get-AzureRmResource -ResourceId /subscriptions/9755ffce-e94b-4332-9be8-1ade15e78909/`
resourceGroups/mclassoct/providers/Microsoft.Storage/storageAccounts/mclassoctpitrewq -Verbose

$subnet = New-AzureRmVirtualNetworkSubnetConfig -Name "subnet01" -AddressPrefix "10.0.1.0/24" -Verbose

$network = New-AzureRmVirtualNetwork @splat -Name "mynetwork" -AddressPrefix "10.0.0.0/16" `
-Subnet $subnet -Force -Verbose

$vm = New-AzureRmVMConfig -VMName "vm01" -VMSize "Standard_A3"

Set-AzureRmVMOperatingSystem -VM $vm -Windows -ComputerName vm01 -Credential $(Get-Credential)

$nic = Get-AzureRmNetworkInterface -Name nic01 -ResourceGroupName mclassoct
Add-AzureRmVMNetworkInterface -VM $vm -Id $nic.Id

Set-AzureRmVMSourceImage -VM $vm -PublisherName "MicrosoftWindowsServer" -Offer "WindowsServer" `
-Skus "2016-Datacenter" -Version latest

Set-AzureRmVMOSDisk -VM $vm -Name "myvm01disk" -VhdUri $($storage.PrimaryEndpoints.Blob + "vhds/vm01disk.vhd") -CreateOption FromImage -Caching ReadWrite -Windows

New-AzurermVM -ResourceGroupName mclassoct -Location "West Europe" -VM $vm -Verbose
