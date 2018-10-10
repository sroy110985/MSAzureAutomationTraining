
[DSCLocalConfigurationManager()]
configuration ChangeMyLCM {
    Settings {
        ConfigurationMode = "ApplyAndAutoCorrect"
    }
}

ChangeMyLCM -outputPath "C:\DSCLCM"

Set-DscLocalConfigurationManager -Path "C:\DSClCM" -Force -Verbose
