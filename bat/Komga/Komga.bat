@echo off
color 70&title Komga 等待启动中
echo 等待启动中
timeout /t 300
set x=0
:M
if %x%==0 (set "t=delims=") else (set "t=tokens=* skip=%x%")
for /f "%t%" %%i in ('dir /a-d /b /on C:\Komga\komga-*.jar') do (
	set n%x%=%%i
	set /a x=x+1
	goto M
)

Setlocal EnableDelayedExpansion
set y=0
set y1=%y%
set m1=!n%y%!
set v1=%m1:~6,-4%
set /a y=y+1
set y2=%y%
set m2=!n%y%!
set v2=%m2:~6,-4%
if %v1% GEQ %v2% (set b=%y1%) else (set b=%y2%)
if %x%==2 (goto J)

:B
set /a y=y+1
if %y% EQU %x% (goto J)
set y1=%y%
set m1=!n%y%!
set v1=%m1:~6,-4%
set m2=!n%b%!
set v2=%m2:~6,-4%
if %v1% GEQ %v2% (set b=%y1%)
goto B

:J
set j=!n%b%!
Setlocal DisableDelayedExpansion
set v=%j:~6,-4%
title Komga %v%
java -jar "C:\Komga\%j%" --server.port=8097