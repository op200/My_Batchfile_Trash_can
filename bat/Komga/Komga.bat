@echo off
color 70&title Komga 等待启动中
echo 等待启动中
timeout /t 300
set x=0
:M
if %x%==0 (set "t=delims=") else (set "t=tokens=* skip=%x%")
for /f "%t%" %%i in ('dir /a-d /b /on C:\Komga\komga-*.jar') do (
	set n%x%=%%i
	set /a x+=1
	goto M
)

Setlocal EnableDelayedExpansion
set i=0
set b=0
set q=0.0.0.$
:R

set v=!n%i%!
set v=%v:~6,-4%.$

set qc=%q%
set qv=%v%
:RC

set q1=0
:RCQ1
set c=%qc:~0,1%
if "%c%"=="$" goto R
set qc=%qc:~1%
if not "%c%"=="." (
	set /a q1=q1*10+c
	goto RCQ1
)

set v1=0
:RCV1
set c=%qv:~0,1%
if "%c%"=="$" goto R
set qv=%qv:~1%
if not "%c%"=="." (
	set /a v1=v1*10+c
	goto RCV1
)

if %v1%==%q1% goto RC
if %v1% GTR %q1% (
	set b=%i%
	set q=%v%
)

set /a i+=1
if %i% LSS %x% goto R


:J
set j=!n%b%!
Setlocal DisableDelayedExpansion

title Komga %j:~6,-4%
java -jar "C:\Komga\%j%" --server.port=8097