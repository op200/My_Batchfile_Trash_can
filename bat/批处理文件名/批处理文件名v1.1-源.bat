@echo off
:AA
cls
color 70
echo ԭ�ļ����ᱻ�޸�,���޸ĵ��ļ���������batͬ·���µ�provisional��
set /p p=���뱻���ļ���·��
set /p o=��������ļ���·��
set /p k=������߱�ֵk=

if %k% LEQ 0 (
echo the "k" don't be allowed
pause
exit)

md "%~dp0provisional"
copy "%p%" "%~dp0provisional"
cd /d "%~dp0provisional"

set m=1
set n=1

for /f "tokens=*" %%b in ('dir /a-d /b "%o%"') do (
	for /f "tokens=*" %%a in ('dir /a-d /b "%p%"') do (
		ren "%%~a" "%%~nb-1%%~xa"
		if %k%==1 (goto X
		) else (set /a v=2
		goto A)
	)
)
:A
for /f "tokens=*" %%b in ('dir /a-d /b "%o%"') do (
	for /f "tokens=* skip=%m%" %%a in ('dir /a-d /b "%p%"') do (
		ren "%%~a" "%%~nb-%v%%%~xa"
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
		ren "%%~a" "%%~nb-%v%%%~xa"
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
		ren "%%~a" "%%~nb-1%%~xa"
		set /a n=n+1
		goto Y
	)
)
:Z
pause
cls
color ec
:ZZ
echo ����ɾ������·��,�뼰ʱ����
rd /s "%~dp0provisional"
choice /c der /m D�ٴγ���ɾ��;E�˳�;R����ʹ��
if %errorlevel%==1 (goto ZZ)
if %errorlevel%==2 (exit)
if %errorlevel%==3 (goto AA)