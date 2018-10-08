
param (
  [string] $resourceGroupName,
  [string] $location,
  [string] $storageAccountName,
  [string] $publicIPAddressName,
  [string] $networkName,
  [string] $nicName

)

$resourceGroup
$storageAccount
$publicIpAddres
$network

$nic

function CreateResourceGroup() {
    $resourceGroup = Get-AzureRmResourceGroup -Name $resourceGroupName -Location $location -ErrorAction SilentlyContinue
    if(!$resourceGroup) {
        New-AzureRmResourceGroup -Name "mclassoct" -Location "West Europe" -Verbose
    } else {
        Write-Output "Resource group already exists !! "
    }
}

function CreateStorageAccount() {
    $storageAccount = Get-AzureRmStorageAccount -ResourceGroupName $resourceGroupName -Name $storageAccountName -ErrorAction SilentlyContinue
    if(!$storageAccount) {
        $storageAccount = New-AzureRmStorageAccount -Name $storageAccountName -SkuName Standard_LRS `
            -Kind StorageV2 -AccessTier Hot -Location $location `
            -ResourceGroupName $resourceGroupName  -Verbose
    } else {
        Write-Output "Storage Account already exists !!"
    }
}

function createPublicIPAddress() {
    $publicIpAddres = Get-AzureRmPublicIpAddress -ResourceGroupName $resourceGroupName -Name $publicIPAddressName -ErrorAction SilentlyContinue
    if(!$publicIpAddres) {
        $publicIpAddres = New-AzureRmPublicIpAddress -ResourceGroupName $resourceGroupName `
        -Location $location -Name $publicIPAddressName -Sku Basic -AllocationMethod Static  `
        -IpAddressVersion IPv4 -DomainNameLabel $publicIPAddressName -Verbose
    } else {
        Write-Output "PublicIP address already exists !!"
    }
}

function createNetworkAndSubnet() {
    $network = Get-AzureRmVirtualNetwork -ResourceGroupName $resourceGroupName -Name $networkName -ErrorAction SilentlyContinue
    if(!$network) {
        $subnet = New-AzureRmVirtualNetworkSubnetConfig -Name "subnet01" -AddressPrefix "10.0.1.0/24" -Verbose

        $network = New-AzureRmVirtualNetwork -ResourceGroupName $resourceGroupName `
        -Name $networkName `
        -AddressPrefix "10.0.0.0/16" `
        -Subnet $subnet -Force -Verbose
        return $subnet
    } else {
        Write-Output "Newtork already exists !!"
        $subnet = Get-AzureRmVirtualNetworkSubnetConfig -Name "subnet01" -VirtualNetwork $network
        return $subnet
    }
}

function createNIC($subnet) {
    $nic = Get-AzureRmNetworkInterface -Name $nicName -ResourceGroupName $resourceGroupName -ErrorAction SilentlyContinue
    if(!$nic) {
        $nic = New-AzureRmNetworkInterface -ResourceGroupName $resourceGroupName -Location $location -Name $nicName -SubnetId $subnet.Id -PublicIpAddressId $publicIpAddres.Id -Force -Verbose
    } else {
        Write-Output "NIC already exists !!"
    }
}


function Master() {
    CreateResourceGroup
    CreateStorageAccount
    createPublicIPAddress
    $sub = createNetworkAndSubnet
    createNIC -subnet $sub
}

Master
