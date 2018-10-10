Login-AzureRmAccount

Set-AzureRmContext -Subscription 8e0502bf-56ff-4d96-81e7-11725e8065dd

New-AzureRmResourceGroup -Name "dscmachines" -Location "West Europe"

Test-AzureRmResourceGroupDeployment -ResourceGroupName dscmachines -Mode Incremental `
-TemplateFile "C:\Users\rites\source\repos\AzureResourceGroup21\AzureResourceGroup21\json1.json" `
-verbose

New-AzureRmResourceGroupDeployment -Name deploy1 -ResourceGroupName dscmachines -Mode Incremental `
-TemplateFile "C:\Users\rites\source\repos\AzureResourceGroup21\AzureResourceGroup21\json1.json" `
-verbose
