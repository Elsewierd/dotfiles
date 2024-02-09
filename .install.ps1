# Check if the script is running with administrator privileges
$isAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)

if (-not $isAdmin) {
    # Relaunch the script with admin privileges
    Start-Process powershell.exe -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File $($MyInvocation.MyCommand.Path)" -Verb RunAs
    Exit
}

# Get the directory of the script
$scriptDirectory = Split-Path -Parent $MyInvocation.MyCommand.Path

# Define the paths
$installFilePath = "$scriptDirectory/install"
$homePath = "~"

# Get scripts
$scriptItems = Get-ChildItem -Path $installFilePath -Include *.ps1

# Run Each Script
foreach ($item in $scriptItems) {
	try {
		$item
	}
	catch {
		Write-Host "Error occurred: $_"
	}
}