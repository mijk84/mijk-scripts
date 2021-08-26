@echo off
:: User editable variables
set curl=C:\windows\system32\curl.exe
set qemuurl=https://qemu.weilnetz.de/w64/
set updfile=C:\qemu\update.ini

:: Dev editable variables
set gettoken=for /f "tokens=
set setvar=delims==^<^>/ " %%n in ('%curl% -s %qemuurl% ^| find ".exe"') do set

:: The rest of the script
echo Checking for updates ...
echo.

:: Get latest qemu build exe.
%gettoken% 12 %setvar% qemudl=%%n

:: Get qemu build date.
%gettoken% 14 %setvar% qemudt=%%n

:: Check for update.
for /f %%n in ('type C:\qemu\update.ini') do set lastupd=%%n
	if %qemudt% GTR %lastupd% (echo Downloading %qemudl% ... & %curl% -s %qemuurl%/%qemudl% -O && echo %qemudt%>%updfile%)  else echo No update yet.
