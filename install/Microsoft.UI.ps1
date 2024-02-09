Invoke-WebRequest `
    -URI https://www.nuget.org/api/v2/package/Microsoft.UI.Xaml/2.7.3 `
    -OutFile xaml.zip -UseBasicParsing
New-Item -ItemType Directory -Path xaml
Expand-Archive -Path xaml.zip -DestinationPath xaml
Add-AppxPackage -Path "xaml\tools\AppX\x64\Release\Microsoft.UI.Xaml.2.7.appx"
Remove-Item xaml.zip
Remove-Item xaml -Recurse

Invoke-WebRequest `
    -URI https://aka.ms/Microsoft.VCLibs.x64.14.00.Desktop.appx `
    -OutFile UWPDesktop.appx -UseBasicParsing
Add-AppxPackage UWPDesktop.appx
Remove-Item UWPDesktop.appx