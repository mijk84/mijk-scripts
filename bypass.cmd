@echo off
﻿echo Windows Registry Editor Version 5.00 >> bypass.reg
echo.>> bypass.reg
echo [HKEY_LOCAL_MACHINE\SYSTEM\Setup\LabConfig] >> bypass.reg
echo "BypassTPMCheck"=dword:00000001 >> bypass.reg
echo "BypassSecureBootCheck"=dword:00000001 >> bypass.reg
echo "BypassRAMCheck"=dword:00000001 >> bypass.reg

reg import bypass.reg
del bypass.reg
