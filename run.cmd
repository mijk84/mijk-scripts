@echo off
setlocal enabledelayedexpansion
:: QEMU Run Script 1.0
:: Mike Ladouceur (mgladouceur at gmail dot com)
::
:: * Place QEMU switches/options here.
:: * Blank switches will go unused.
:: * Adding double brackets will allow for switches without further
:: settings to be used (eg. nographics).
:: * Customize to your needs.

set qemu=qemu-system-i386
set kernel=
set initrd=
set cpu=core2duo
set m=256
set vga=
set soundhw=
set device=
set net=
set hda=hda.img
set cdrom=
set fda=
set redir=tcp:8022::22
set nographic=""
set boot=c

for /f "tokens=2 delims== " %%n in ('type %~n0.cmd ^| find "set " ^| find /v "!" ^| find /v "%%"') do <nul set /p "=%%n " >> %temp%\%~n0.tmp
  for /f "tokens=*" %%n in ('type %temp%\%~n0.tmp') do set qemusw=%%n

for %%n in (%qemusw%) do (
  if defined %%n set qemurun=!qemurun! -%%n !%%n!
)

%qemu%%qemurun%
for %%n in (%qemusw% qemusw) do set %%n=
del %temp%\%~n0.tmp
