@echo off
color 70&title �������ļ���
if defined h (goto AA)
for /f "tokens=1,2" %%a in ('"wmic desktopmonitor get screenheight,screenwidth"') do (set /a h=%%a
set /a w=%%b)>nul 2>nul
if %w% LSS 1280 (goto AA)&if %h% LSS 720 (goto AA)
set /a h2=h/32&set /a w2=w/16
if %w% GEQ 2560 (set /a w2=w/24)&if %h% GEQ 1440 (set /a h2=h/40)
setlocal enabledelayedexpansion
for /l %%a in (0,1,99) do (set /a wp+=1
if not "!w2:~%%a,1!"=="" (set w3=!wp!))
setlocal disabledelayedexpansion
if %w3%==2 (set w4=00%w2%) else (set w4=0%w2%)
set r="HKCU\Console\%%SystemRoot%%_system32_cmd.exe"
reg add %r% /v "ScreenBufferSize" /t REG_DWORD /d 0x23290094 /f>nul
reg add %r% /v "WindowPosition" /t REG_DWORD /d 0x00140014 /f>nul
reg add %r% /v "WindowSize" /t REG_DWORD /d 0x%h2%%w4% /f
start "" %0&exit
:AA
color 70
cls
echo ԭ�ļ����ᱻ�޸�,���޸ĵ��ļ���������batͬ·���µ�provisional��&echo.
set /p p=���뱻���ļ���·��
set /p o=��������ļ���·��
set /p k=������߱�ֵk=
echo %k%|findstr "^[1-9][0-9]*$">nul&&echo.||echo "k=%k%" don't be allowed&&pause&&goto AA
choice /m �Ƿ�ȷ��?
if %errorlevel%==2 (goto AA)
set str1=echo %%~a		��	%%~nb-1%%~xa
set str2=echo %%~a		��	%%~nb-%%v%%~xa
set str=1
set sk=0
goto MAIN
:STR
choice /c ync /m �Ƿ���и��������?����������������ļ�
if %errorlevel%==2 (goto AA)
if %errorlevel%==3 (set /p sk=������Ҫ�����Ķ����ļ��ĸ���&&goto MAIN&&set /a sk=sk-1)
echo.
set str1=ren "%%~a" "%%~nb-1%%~xa"
set str2=ren "%%~a" "%%~nb-%%v%%~xa"
set str=2
md "%~dp0provisional"
copy "%p%" "%~dp0provisional"
echo.
cd /d "%~dp0provisional"
:MAIN
set m=1
set /a n=sk+1
set "ts=tokens=* skip=%sk%"
if %sk%==0 (set "ts=tokens=*")
for /f "%ts%" %%b in ('dir /a-d /b "%o%"') do (for /f "tokens=*" %%a in ('dir /a-d /b "%p%"') do (%str1%
if %k%==1 (goto X) else (set v=2
goto A)))
:A
for /f "%ts%" %%b in ('dir /a-d /b "%o%"') do (for /f "tokens=* skip=%m%" %%a in ('dir /a-d /b "%p%"') do (for /f %%v in ("%v%") do (%str2%
goto B)))
:B
set /a m=m+1
set /a v=v+1
if %m%==%k% (set v=1
goto C) else (goto A)
:C
for /f "tokens=* skip=%n%" %%b in ('dir /a-d /b "%o%"') do (for /f "tokens=* skip=%m%" %%a in ('dir /a-d /b "%p%"') do (for /f %%v in ("%v%") do (%str2%
if %sk%==0 (goto D) else (goto D)))
goto Z)
goto Z
:D
set /a m=m+1
set /a j=(n-sk)*k+k
set /a g=m+sk
if %m%==%j% (set /a n=n+1
set v=1
goto C) else (set /a v=v+1
goto C)
:X
set n=1&set m=1
if not %sk%==0 (set /a n=sk+1)
:Y
for /f "tokens=* skip=%m%" %%a in ('dir /a-d /b "%p%"') do (for /f "tokens=* skip=%n%" %%b in ('dir /a-d /b "%o%"') do (%str1%
set /a n=n+1&set /a m=m+1
goto Y))
:Z
if %str%==1 (goto STR)
start "" "%~dp0provisional"
pause
cls
color ec
:ZZ
cd /d "%~dp0"
echo ����ɾ������·��,�뼰ʱ����
rd /s "%~dp0provisional"
choice /c der /m D�ٴγ���ɾ��;E�˳�;R����ʹ��
if %errorlevel%==1 (goto ZZ)
if %errorlevel%==2 (exit)
if %errorlevel%==3 (goto AA)