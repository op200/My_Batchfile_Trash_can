@echo off
color 70
setlocal enabledelayedexpansion
:S
cls
title ����ת��װ
echo ���棺·�����İ�Ǹ�̾�Żᱻ���ԣ�
set /p p=����·��:
set /p o=���·��:
choice /m �Ƿ�ת����Ƶ
set ad=-c:a copy
if %errorlevel%==1 (set ad=-c:a aac -q:a 2)

set p="%p:"=%"
set o="%o:"=%"

cd /d %o%

set n=1
for /f "tokens=*" %%a in ('dir /a-d /b /s %p%') do (
	set in%n%="%%a"
	set out%n%="%%~na-ת��.mp4"
	goto A
)
:A
set s=0
:B
set /a s+=1
set /a n+=1
for /f "tokens=* skip=%s%" %%a in ('dir /a-d /b /s %p%') do (
	set in%n%="%%a"
	set out%n%="%%~na-ת��.mp4"
	goto B
)
set m=1
:E
echo !in%m%!
echo 	!out%m%!
echo.
set /a m+=1
if %m% GEQ %n% (goto CH)
goto E
:F
set m=1
:G
title ����ת��װ-%m%-!out%m%!
ffmpeg -i !in%m%! -c:v copy %ad% !out%m%!
set /a m+=1
if %m% GEQ %n% (goto Z)
goto G

:CH
choice /m �Ƿ�ѹ��
if %errorlevel%==1 (goto F)
if %errorlevel%==2 (goto S)
:Z
echo END
title END
pause
goto S