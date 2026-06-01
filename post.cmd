@echo off
:: WinGet most of the apps
winget install --silent --accept-package-agreements ^
GillesVollantSoftware.WinImage ^
TrackerSoftware.PDF-XChangeEditor ^
PassmarkSoftware.OSFMount ^
PeterDaveHello.TransmissionRemoteGUI ^
RedHat.VirtViewer ^
Google.Chrome ^
Notepad++.Notepad++ ^
Valve.Steam ^
Microsoft.DotNet.DesktopRuntime.3_1 ^
Microsoft.DotNet.DesktopRuntime.5 ^
Microsoft.DotNet.DesktopRuntime.6 ^
Microsoft.DotNet.DesktopRuntime.7 ^
Microsoft.DotNet.Runtime.Preview ^
Microsoft.VCRedist.2005.x86 ^
Microsoft.VCRedist.2005.x64 ^
Microsoft.VCRedist.2008.x86 ^
Microsoft.VCRedist.2008.x64 ^
Microsoft.VCRedist.2010.x86 ^
Microsoft.VCRedist.2010.x64 ^
Microsoft.VCRedist.2012.x86 ^
Microsoft.VCRedist.2012.x64 ^
Microsoft.VCRedist.2015+.x86 ^
Microsoft.VCRedist.2015+.x64 ^
RealVNC.VNCViewer ^
Quassel.QuasselIRC

:: Download FileZilla using Powershell, for some reason this makes sense to the dev
echo $installerUrl = "https://filezilla-project.org" >> FileZilla.ps1
echo $outputPath = ".\FileZilla_Setup.exe" >> FileZilla.ps1
echo. >> FileZilla.ps1
echo Invoke-WebRequest -Uri $installerUrl -OutFile $outputPath >> FileZilla.ps1
echo. >> FileZilla.ps1
echo $processInfo = Start-Process -FilePath $outputPath -ArgumentList "/S /NCRC /ALLUSERS" -Wait -PassThru >> FileZilla.ps1
echo. >> FileZilla.ps1
echo Remove-Item $outputPath >> FileZilla.ps1

powershell.exe -ExecutionPolicy Unrestricted -File FileZilla.ps1
del FileZilla.ps1

:: Enable WSL2 and VM Platform
dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart

:: Download Ubuntu 24.04.4 WSL VM
curl -O https://releases.ubuntu.com/noble/ubuntu-24.04.4-wsl-amd64.wsl
