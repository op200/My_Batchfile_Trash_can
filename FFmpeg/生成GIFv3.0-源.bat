@echo off
color 70&title ����GIF
:A
cls
set /p p=����·����:
set /p o=���·����:
set /p s=��ʼʱ��:
set /p t=����ʱ��:
set /p r=֡��:

set i=%p:~-1%
if not ^%i%==^" (set p=^"%p%^")
set i=%o:~-1%
if not ^%i%==^" (set o=^"%o%^")
for %%a in (%o%) do (set y=1%%~xa)
if  %y%==1.gif (goto B)
for %%a in (%o%) do (set o=%%~dpna.gif)
echo ��⵽����ļ���׺��gif
echo �ѽ����·������Ϊ
echo %o%
timeout /t 5
:B

set sf=0
choice /m �Ƿ�����
if %errorlevel%==1 (
	set /p c=��:
	set /p k=��:
	set sf=1
)
set bs=0
choice /m �Ƿ����
if %errorlevel%==1 (
	set /p m=PTS*
	set bs=1
)

set sc=<nul
set sp=<nul

:P
if %sf%==0 (set sc=<nul)
if %bs%==0 (set sp=<nul)
if %sf%==1 (set "sc=scale=%c%x%k%,")
if %bs%==1 (set "sp=setpts=%m%*PTS,")

ffmpeg -ss %s% -t %t% -i %p% -vf "%sc%%sp%fps=%r%,split[s0][s1];[s0]palettegen[p];[s1][p]paletteuse" %o%
ffplay %o% -loop 99

choice /m �Ƿ����Ԥ��
if %errorlevel%==1 (goto Z)

if exist %o% (del /q %o%)
choice /c abcdefg /m ������ֵ:A��ʼʱ��;B����ʱ��;C֡��;D����;E����;Fȡ������;Gȡ������
if %errorlevel% LEQ 3 (set /p d=����ֵ:)
if %errorlevel%==1 (set s=%d%)
if %errorlevel%==2 (set t=%d%)
if %errorlevel%==3 (set r=%d%)
if %errorlevel%==4 (
	set /p c=��:
	set /p k=��:
	set sf=1
)
if %errorlevel%==5 (
	set /p m=PTS*
	set bs=1
)
if %errorlevel%==6 (set sf=0)
if %errorlevel%==7 (set bs=0)
goto P

:Z
pause
goto A