@echo off
color 70&title �����ϲ�����Ƶ
:S

echo ���·����ֹ������·����
set /p p=����·��:
set /p o=���·��:
set /p e=��չ��:

set p="%p:"=%"
set o="%o:"=%"

cd /d %o%
set c=0
set r=0
:M
for /f "tokens=*" %%a in ('dir /a-d /b /s %p%') do (
	set in1="%%a"
	goto A
)
:A
for /f "tokens=* skip=1" %%a in ('dir /a-d /b /s %p%') do (
	set in2="%%a"
	goto B
)
:B
set s=1
:D
for %%a in (%in1%) do (set out="%%~na.%e%")
if %c%==1 (goto F)
echo %in1%
echo %in2%
echo 	%out%
echo.
goto X

:F
ffmpeg -i %in1% -i %in2% -c copy %out%

:X
set /a s+=1
for /f "tokens=* skip=%s%" %%a in ('dir /a-d /b /s %p%') do (
	set in1="%%a"
	goto C
)
:C
set /a s+=1
for /f "tokens=* skip=%s%" %%a in ('dir /a-d /b /s %p%') do (
	set in2="%%a"
	goto D
)
if %r%==1 (goto S)
choice /m �Ƿ�ѹ��
if %errorlevel%==1 (set c=1
set r=1
goto M)
if %errorlevel%==2 (goto S)