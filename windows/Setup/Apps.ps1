##########################################################################
# Disable UAC (temporarily)
##########################################################################

Disable-UAC

##########################################################################
# Utility stuff
##########################################################################

Function Test-Rust() {
    return Test-Path -Path (Join-Path $env:USERPROFILE ".cargo");
}

$Architecture = (Get-WmiObject Win32_OperatingSystem).OSArchitecture;
$IsArm = $false;
if($Architecture.StartsWith("ARM")) {
    Write-Host "##########################################################################"
    Write-Host "# RUNNING ON ARM COMPUTER"
    Write-Host "##########################################################################"
    $IsArm = $true;
}

##########################################################################
# Create temporary directory
##########################################################################

# Workaround choco / boxstarter path too long error
# https://github.com/chocolatey/boxstarter/issues/241
$ChocoCachePath = "$env:USERPROFILE\AppData\Local\Temp\chocolatey"
New-Item -Path $ChocoCachePath -ItemType Directory -Force

##########################################################################
# Install applications
##########################################################################

choco upgrade --cache="$ChocoCachePath" --yes discord
choco upgrade --cache="$ChocoCachePath" --yes slack
choco upgrade --cache="$ChocoCachePath" --yes microsoft-edge
choco upgrade --cache="$ChocoCachePath" --yes git
choco upgrade --cache="$ChocoCachePath" --yes ghostscript.app
choco upgrade --cache="$ChocoCachePath" --yes 7zip.install
choco upgrade --cache="$ChocoCachePath" --yes screentogif
choco upgrade --cache="$ChocoCachePath" --yes paint.net
choco upgrade --cache="$ChocoCachePath" --yes chocolateygui
choco upgrade --cache="$ChocoCachePath" --yes powershell-core
choco upgrade --cache="$ChocoCachePath" --yes ripgrep
choco upgrade --cache="$ChocoCachePath" --yes microsoft-windows-terminal
choco upgrade --cache="$ChocoCachePath" --yes winsnap
choco upgrade --cache="$ChocoCachePath" --yes gsudo

if(!$IsArm) {
    # x86/x64 only
    choco upgrade --cache="$ChocoCachePath" --yes spotify
    choco upgrade --cache="$ChocoCachePath" --yes starship
    choco upgrade --cache="$ChocoCachePath" --yes nugetpackageexplorer
    choco upgrade --cache="$ChocoCachePath" --yes docker-for-windows
    choco upgrade --cache="$ChocoCachePath" --yes sysinternals
    choco upgrade --cache="$ChocoCachePath" --yes cmake
    choco upgrade --cache="$ChocoCachePath" --yes curl
    choco upgrade --cache="$ChocoCachePath" --yes vscode
    choco upgrade --cache="$ChocoCachePath" --yes dotpeek --pre 
    choco upgrade --cache="$ChocoCachePath" --yes ditto
    choco upgrade --cache="$ChocoCachePath" --yes dotnetcore
    choco upgrade --cache="$ChocoCachePath" --yes dotnetfx
    choco upgrade --cache="$ChocoCachePath" --yes everything
    choco upgrade --cache="$ChocoCachePath" --yes filezilla
    choco upgrade --cache="$ChocoCachePath" --yes foxitreader
    choco upgrade --cache="$ChocoCachePath" --yes gimp
    choco upgrade --cache="$ChocoCachePath" --yes git-credential-manager-for-windows
    choco upgrade --cache="$ChocoCachePath" --yes github-desktop
    choco upgrade --cache="$ChocoCachePath" --yes googlechrome
    choco upgrade --cache="$ChocoCachePath" --yes inkscape
    choco upgrade --cache="$ChocoCachePath" --yes jdk8
    choco upgrade --cache="$ChocoCachePath" --yes logexpert
    choco upgrade --cache="$ChocoCachePath" --yes microsoft-teams
    choco upgrade --cache="$ChocoCachePath" --yes notepadplusplus
    choco upgrade --cache="$ChocoCachePath" --yes pia
    choco upgrade --cache="$ChocoCachePath" --yes putty.install
    choco upgrade --cache="$ChocoCachePath" --yes sharex
    choco upgrade --cache="$ChocoCachePath" --yes spacesniffer
    choco upgrade --cache="$ChocoCachePath" --yes sql-server-management-studio
    choco upgrade --cache="$ChocoCachePath" --yes teamviewer
    choco upgrade --cache="$ChocoCachePath" --yes vmware-workstation-player
    choco upgrade --cache="$ChocoCachePath" --yes tightvnc
    choco upgrade --cache="$ChocoCachePath" --yes winscp
    choco upgrade --cache="$ChocoCachePath" --yes microsoftazurestorageexplorer
    choco upgrade --cache="$ChocoCachePath" --yes vnc-viewer
    choco upgrade --cache="$ChocoCachePath" --yes innosetup
    choco upgrade --cache="$ChocoCachePath" --yes 1password
    choco upgrade --cache="$ChocoCachePath" --yes sqlitebrowser
    choco upgrade --cache="$ChocoCachePath" --yes azure-functions-core-tools-3
}

##########################################################################
# Install VSCode extensions
##########################################################################

if(!$IsArm) {
    # x86/x64 only
    code --install-extension cake-build.cake-vscode
    code --install-extension matklad.rust-analyzer
    code --install-extension ms-vscode.powershell
    code --install-extension bungcip.better-toml
    code --install-extension ms-azuretools.vscode-docker
    code --install-extension octref.vetur
    code --install-extension ms-vscode-remote.remote-wsl
    code --install-extension jolaleye.horizon-theme-vscode
    code --install-extension vscode-icons-team.vscode-icons
    code --install-extension hediet.vscode-drawio
}

##########################################################################
# Install posh-git and oh-my-posh
##########################################################################

PowerShellGet\Install-Module posh-git -Scope CurrentUser -Force
PowerShellGet\Install-Module oh-my-posh -Scope CurrentUser -Force

##########################################################################
# Restore Temporary Settings
##########################################################################

Enable-UAC
Enable-MicrosoftUpdate