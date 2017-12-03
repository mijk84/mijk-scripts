@echo off
setlocal EnableDelayedExpansion
set os=os get name
set cores=cpu get numberofcores
set cpuid=cpu get name
set mem=memphysical get maxcapacity
set vga=path win32_VideoController get Description

for %%m in (os cores cpuid mem vga) do for /f "skip=2 tokens=2 delims=,|" %%n in ('wmic !%%m! /format:csv') do set %%m=%%n

for /f %%n in ('set /a %mem% / 1024') do set mem=%%nMB
	for /f "tokens=1" %%n in ('if %mem:~0,-2% GTR 1023 set /a %mem:~0,-2% / 1024 ^& echo GB') do set mem=%%n

echo Hostname: %computername% \** OS: %os% \** CPU: %cores% x %cpuid% \** RAM: %mem% \** VGA: %vga%|clip
