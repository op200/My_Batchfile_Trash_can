@echo off
:AA
cls
color 70
echo ԭ�ļ����ᱻ�޸�,���޸ĵ��ļ���������batͬ·���µ�provisional��
set /p p=���뱻���ļ���·��
set /p o=��������ļ���·��
set /p k=������߱�ֵk=
choice /m �Ƿ�ȷ��?
if %errorlevel%==2 (goto AA)

echo %k%|findstr "^[1-9][0-9]*$">nul&&echo.||echo "k=%k%" don't be allowed&&pause&&goto AA

set str1=echo %%~a	��	%%~nb-1%%~xa
set str2=echo %%~a	��	%%~nb-%v%%%~xa
set str=1
goto MAIN
:STR
choice /m �Ƿ���и��������?
if %errorlevel%==2 (goto AA)
echo.
set str1=ren "%%~a" "%%~nb-1%%~xa"
set str2=ren "%%~a" "%%~nb-%v%%%~xa"
set str=2

md "%~dp0provisional"
copy "%p%" "%~dp0provisional"
echo.
cd /d "%~dp0provisional"

:MAIN
set m=1
set n=1
for /f "tokens=*" %%b in ('dir /a-d /b "%o%"') do (
	for /f "tokens=*" %%a in ('dir /a-d /b "%p%"') do (
		%str1%
		if %k%==1 (goto X
		) else (set /a v=2
		goto A)
	)
)
:A
for /f "tokens=*" %%b in ('dir /a-d /b "%o%"') do (
	for /f "tokens=* skip=%m%" %%a in ('dir /a-d /b "%p%"') do (
		%str2%
		goto B
	)
)
:B
set /a m=m+1
set /a v=v+1
if %m%==%k% (set /a v=1
goto C) else (goto A)
:C
for /f "tokens=* skip=%n%" %%b in ('dir /a-d /b "%o%"') do (
	for /f "tokens=* skip=%m%" %%a in ('dir /a-d /b "%p%"') do (
		%str2%
		goto D
	)
	goto Z
)
goto Z
:D
set /a m=m+1
set /a j=n*k+k
if %m%==%j% (
	set /a n=n+1
	set /a v=1
	goto C) else (set /a v=v+1
	goto C)
:X
set /a n=1
:Y
for /f "tokens=* skip=%n%" %%a in ('dir /a-d /b "%p%"') do (
	for /f "tokens=* skip=%n%" %%b in ('dir /a-d /b "%o%"') do (
		%str1%
		set /a n=n+1
		goto Y
	)
)
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