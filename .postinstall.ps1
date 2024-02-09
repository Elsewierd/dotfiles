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
$dotfilesPath = $scriptDirectory
$homePath = "~"
$ignoreFile = "$dotfilesPath\.ignore"

# Read the content of the ignore file
$ignoreList = Get-Content -Path $ignoreFile -ErrorAction SilentlyContinue

# Get all items in dotfiles directory starting with '.'
$itemsToLink = Get-ChildItem -Path $dotfilesPath | Where-Object { $_.Name -match '^\.' -and $_.Name -notin $ignoreList }

# Create symbolic links for each item
foreach ($item in $ItemsToLink) {
    $linkPath = Join-Path $homePath $item.Name
    $targetPath = $item.FullName
    New-Item -ItemType SymbolicLink -Path $linkPath -Target $targetPath -Force
}

git config --global user.name "DEAN FREEMAN"
git config --global user.email "112786466+Elsewierd@users.noreply.github.com"