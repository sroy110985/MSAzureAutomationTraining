
Login-AzureRmAccount

Set-AzureRmContext -Subscription 


Import-AzureRmAutomationDscConfiguration `
-SourcePath "C:\Users\rites\Desktop\mclass\AzureDSCConfig.ps1" `
-ResourceGroupName dsc `
-AutomationAccountName mclassoct10  -Published -Force -verbose

Start-AzureRmAutomationDscCompilationJob -ConfigurationName AzureDSCConfig -ResourceGroupName dsc -AutomationAccountName mclassoct10  -Verbose

Register-AzureRmAutomationDscNode -AzureVMName Client-01 -NodeConfigurationName AzureDSCConfig.localhost -AzureVMResourceGroup dsc -AzureVMLocation "West US 2" -ResourceGroupName dsc -AutomationAccountName mclassoct10 -ConfigurationMode ApplyAndAutocorrect
