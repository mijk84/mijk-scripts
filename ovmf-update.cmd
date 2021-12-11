@echo off
:: OVMF Updater 1.0
:: 2021 Mike Ladouceur
::
:: Set some variables
set Szip="C:\Program Files\7-Zip\7z.exe"
set curl=C:\windows\system32\curl.exe
set ovmfurl=https://www.kraxel.org/repos/jenkins/edk2/
set fdfile=OVMF_CODE-pure-efi.fd

echo Downloading latest OVMF image ...

:: Find and download the latest OVMF file
for /f "delims=^<^>=^&[] tokens=12*" %%n in ('%curl% --silent %ovmfurl% ^| find "ovmf"') do set OVMF=%%n
	set OVMF=%OVMF:"=%
%curl% -s %ovmfurl%%OVMF% --output %OVMF%

:: Extract the RPM, then the CPIO
%Szip% x %OVMF% > nul
%Szip% x %OVMF:~0,-3%cpio > nul

:: Move the fd image to the current directory
move usr\share\edk2.git\ovmf-x64\%fdfile% . > nul

:: Clean up
rd /s /q usr
del %OVMF%
del %OVMF:~0,-3%cpio
