[DSCLocalConfigurationManager()]
configuration PartialConfigDemoConfigID
{
    Node localhost
    {
        Settings
        {
            RefreshMode                     = 'Pull'
            RebootNodeIfNeeded              = $true
            ConfigurationMode               ="ApplyAndAutocorrect";

        }
        ConfigurationRepositoryWeb CONTOSO-PullSrv
        {
            ServerURL                       = 'http://13.66.165.194:8080/PSDSCPullServer.svc/'
            RegistrationKey                 = '775d5e20-637e-45db-8785-07eb28419539'
            ConfigurationNames              = @("EnableXPSViewer")
            AllowUnsecureConnection = $true


        }

        PartialConfiguration EnableXPSViewer
        {
            Description                     = 'Configuration for the Base OS'
            ConfigurationSource             = '[ConfigurationRepositoryWeb]CONTOSO-PullSrv'
            RefreshMode                     = 'Pull'
        }

    }
}
PartialConfigDemoConfigID -outputPath "C:\DSCLCM"



Set-DscLocalConfigurationManager -Path "C:\DSCLCM" -Verbose
Update-DscConfiguration -Wait
Get-WindowsFeature -name xps-viewer
