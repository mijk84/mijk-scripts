@echo off

Title: Final Check for Windows 11 GCI 2025 2H2 and previous images (April 2025)

:: Re-add WMIC command to Windows 11 24H2 to facilitate FinalCheck and RemoteConsole use.
powershell.exe -ExecutionPolicy Bypass -File Files\Install_WMIC_W11.ps1

::Change to run in current directory
PUSHD %~dp0
echo.

echo Firewall enable jump and mapping
Powershell.exe -ExecutionPolicy Bypass -File .\Files\firewall.ps1
echo.

echo Updating Group Policy
START /MIN GPUPDATE /Force 
echo.

::Set variable for registry path based on 32 or 64 bit
IF /I "%PROCESSOR_ARCHITECTURE%" == "AMD64" set Bitness=Wow6432Node\

::Get model
FOR /F "tokens=2 delims==" %%A IN ('WMIC csproduct GET Version /VALUE ^| FIND /I "Version="') DO SET machine=%%A
IF /I "%machine%" == "" FOR /F "tokens=2 delims==" %%A IN ('WMIC csproduct GET Name /VALUE ^| FIND /I "Name="') DO SET machine=%%A
ECHO Computer model: "%machine%"
SET machine=%machine: =%
echo.

echo OS = %PROCESSOR_ARCHITECTURE%
echo.

::check for uninitialized HDD in technical desktop
set RawDisks=
for /f "usebackq delims=" %%i in (`powershell "Get-Disk | Where-Object {($_.PartitionStyle -eq 'Raw') -or ($_.OperationalStatus -eq 'Offline')}"`) do set RawDisks=%%i

echo.%RawDisks% | findstr /C:"RAW" /C:"Offline" >nul 2>&1
if not errorlevel 1 (
   echo Check if hard drive is initialized:
   echo Raw Disks: %RawDisks%
   MSG %username% /W /TIME:0 Might want to check disks -  %RawDisks% 
   diskmgmt.msc
)


echo Setting time zone based on DHCP server location
TZUTIL /s "Eastern Standard Time"
for /f "tokens=1-2 delims=:" %%a in ('ipconfig -all^|find "DHCP Server"') do set ip=%%b
set ip=%ip:~1%
IF /I "%ip%" == "10.32.147.26" (
	echo Changing Time Zone
	TZUTIL /s "Newfoundland Standard Time"
)
IF /I "%ip%" == "142.40.109.14" (
	echo Changing Time Zone
	TZUTIL /s "Atlantic Standard Time"
)
IF /I "%ip%" == "142.40.200.39" (
	echo Changing Time Zone
	TZUTIL /s "Central Standard Time"
)
echo.

echo Disabling Sleep and Hibernation
powercfg /x -hibernate-timeout-ac 0
powercfg /x -standby-timeout-ac 0
echo.

echo Setting Folder Options
regedit /s "Files\Explorer.reg"
echo.

echo Sound Test
echo   BEEP!
powershell "[console]::beep(262,500)"
echo   BEEP!
powershell "[console]::beep(294,500)"
echo   BEEP!
powershell "[console]::beep(330,500)"
echo   BEEP!
powershell "[console]::beep(349,500)"
echo   BEEP!
powershell "[console]::beep(392,500)"
echo   BEEP!
powershell "[console]::beep(440,500)"
echo   BEEP!
powershell "[console]::beep(493,500)"
echo   BEEP!
powershell "[console]::beep(523,500)"
echo.

REM Detect if laptop
FOR /F "tokens=2 delims==" %%A IN ('WMIC SystemEnclosure GET ChassisTypes/VALUE ^| FIND /I "ChassisTypes"') DO SET chassis=%%A
REM ECHO Computer type: "%chassis%"


echo Checking for Office 2016
IF EXIST "%ProgramFiles%\Microsoft Office\root\Office16\winword.exe" (
echo Adding Outlook 2016 Desktop Icon
	regedit /s "Files\Add_Outlook shortcut_All_Users_Office2016.reg"
echo.	
)

echo Setting Max Token Size
reg add "HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Lsa\Kerberos\Parameters" /v MaxTokenSize /t REG_DWORD /d 65535 /f > NUL
echo.
echo Enabling Remote Desktop locally
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Terminal Server" /v fDenyTSConnections /t REG_DWORD /d 0 /f > NUL
echo.

:: Clear temp driver files
echo Deleting driver folders
rmdir /s /q "C:\Out-of-Box Drivers"
rmdir /s /q "C:\Dell"
rmdir /s /q "C:\Intel"
echo.

:: Check for LAPS dll file

if not exist "%WINDIR%"\AdmPwd.dll (
copy /y "Files\AdmPwd.dll" "%WINDIR%"
"regsvr32.exe" /s "%WINDIR%\AdmPwd.dll"
gpupdate /force
)

echo Refreshing SCCM policies
WMIC /namespace:\\root\ccm path sms_client CALL TriggerSchedule "{00000000-0000-0000-0000-000000000022}" /NOINTERACTIVE
echo.

echo Remove Zscaler
"%PROGRAMFILES%"\Zscaler\ZSAInstaller\uninstall.exe --mode unattended
echo.

echo Enabling SecureBoot
FOR /F "tokens=2 delims==" %%A IN ('WMIC COMPUTERSYSTEM GET Manufacturer/VALUE ^| FIND /I "Manufacturer"') DO SET Manufacturer=%%A
echo Manufacturer = %manufacturer%
IF /I "%Manufacturer%" == "LENOVO" (
"Files\ThinkBiosConfig.hta" "config=SecureBoot,Enable" 
"Files\ThinkBiosConfig.hta" "config=Secure Boot,Enabled" 
) else IF /I "%Manufacturer%" == "Dell Inc." (
robocopy "Files\X86_64" "C:\temp\X86_64" /e > NUL
"C:\temp\X86_64\cctk.exe" "--secureboot=enable"
"C:\temp\X86_64\cctk.exe" "--wakeonlan=lanonly"
"C:\temp\X86_64\cctk.exe" "--WlanAutoSense=enabled"
"C:\temp\X86_64\cctk.exe" "--sata0=enabled"
rmdir "C:\temp\X86_64" /s /q
)
echo.

pause
