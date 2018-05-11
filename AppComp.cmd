@ECHO OFF

CLS

SETLOCAL ENABLEDELAYEDEXPANSION

TITLE Application Compatibility Launcher

ECHO Drag and drop an EXE file here.
ECHO(
SET /P F=

FOR /F "tokens=* delims=" %%A IN ("%F%") DO (
	FOR /F "tokens=1" %%B IN ("%%~nA") DO FOR %%C IN (Firefox Thunderbird) DO IF /I "%%B"=="%%C" (
		SET FILEN=setup
		SET FILEX=.exe
		CALL :ApplicationGoo
	)
	SET FILEN=%%~nA
	SET FILEX=%%~xA
	CALL :ApplicationGoo
)
START "AppComLauncher" ""%F%""
ECHO(
ECHO Do you want to save your settings^?
ECHO(
ECHO [Y]es.
ECHO [N]o.
ECHO(
SET /P C=
IF /I NOT "%C%"=="Y" (
	IF DEFINED BAKF (
		REG.EXE ADD "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\%FILEN%%FILEX%" /v ApplicationGoo /t REG_BINARY /d "%BAKF%" /f >NUL
	) ELSE (
		REG.EXE DELETE "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\%FILEN%%FILEX%" /v ApplicationGoo /f >NUL
	)
)
REG.EXE DELETE "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\%FILEN%.tmp" /v ApplicationGoo /f >NUL
EXIT

:ApplicationGoo
FOR /F "skip=4 tokens=3" %%B IN ('REG.EXE QUERY "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\!FILEN!!FILEX!" /v ApplicationGoo ^2^>NUL') DO SET BAKF=%%B
REG.EXE ADD "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\!FILEN!!FILEX!" /v ApplicationGoo /t REG_BINARY /d 5600000052000000000000000200000000000000010000004A0000003CFD06000500000001000000280A0000020000000300000000000000530065007200760069006300650020005000610063006B00200033000000 /f >NUL
IF /I "!FILEX!"==".exe" REG.EXE ADD "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\!FILEN!.tmp" /v ApplicationGoo /t REG_BINARY /d 5600000052000000000000000200000000000000010000004A0000003CFD06000500000001000000280A0000020000000300000000000000530065007200760069006300650020005000610063006B00200033000000 /f >NUL
GOTO :EOF

:EOF
