
configuration InstallIIS {
    node localhost {
        WindowsFeature myOwnWebServer {
            Name = "web-server"
            Ensure = "Present"
        }
    }
}

# generating the configuration file
InstallIIS -outputPath "C:\DSC\"

# sending the configuration file
Publish-DscConfiguration -Path "C:\DSC\" -Force -Verbose

# applying the configuration file
Start-DscConfiguration -Wait -Force -UseExisting

