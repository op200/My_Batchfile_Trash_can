@echo off
set /p p=输入被改文件夹路径
set /p o=输入对照文件夹路径
set /p k=输入二者比值k=
if %k% LEQ 0 (echo the "k" don't be allowed
pause
exit)
md "%~dp0\provisional"
copy "%p%" "%~dp0\provisional"
cd /d "%~dp0\provisional"
set /a m=1
set /a n=1
for /f "tokens=*" %%b in ('dir /a-d /b "%o%"') do (for /f "tokens=*" %%a in ('dir /a-d /b "%p%"') do (ren "%%~a" "%%~nb-1%%~xa"
if %k%==1 (goto X) else (set /a v=2
goto A)))
:A
for /f "tokens=*" %%b in ('dir /a-d /b "%o%"') do (for /f "tokens=* skip=%m%" %%a in ('dir /a-d /b "%p%"') do (ren "%%~a" "%%~nb-%v%%%~xa"
goto B))
:B
set /a m=m+1
set /a v=v+1
if %m%==%k% (set /a v=1
goto C) else (goto A)
:C
for /f "tokens=* skip=%n%" %%b in ('dir /a-d /b "%o%"') do (for /f "tokens=* skip=%m%" %%a in ('dir /a-d /b "%p%"') do (ren "%%~a" "%%~nb-%v%%%~xa"
goto D)
goto F)
goto F
:D
set /a m=m+1
set /a j=n*k+k
if %m%==%j% (set /a n=n+1
set /a v=1
goto C) else (set /a v=v+1
goto C)
:F
del "%~dp0\provisional"
echo about to exit
pause
exit
:X
set /a n=1
:Y
for /f "tokens=* skip=%n%" %%a in ('dir /a-d /b "%p%"') do (for /f "tokens=* skip=%n%" %%b in ('dir /a-d /b "%o%"') do (ren "%%~a" "%%~nb%%~xa"
set /a n=n+1
goto Y))
del "%~dp0\provisional"
echo about to exit
pause
exit