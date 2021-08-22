@echo off
set curl=C:\windows\system32\curl.exe
set qemuurl=https://qemu.weilnetz.de/w64/
set token=for /f "tokens=
set qemuvar=delims==^<^>/ " %%n in ('%curl% -s https://qemu.weilnetz.de/w64/ ^| find ".exe"') do set

echo Checking for updates ...
echo.

:: Get latest qemu build exe.
%token% 12 %qemuvar% qemudl=%%n

:: Get qemu build date.
%token% 14 %qemuvar% qemudt=%%n

:: Check for update.
for /f %%n in ('type C:\qemu\update.ini') do set lastupd=%%n
	if %qemudt% GTR %lastupd% (%curl% -s %qemuurl%/%qemudl% -O && echo %qemudt%>C:\qemu\update.ini)  else echo No update yet.
