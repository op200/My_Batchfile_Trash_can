::���������ļ�Ԥ�蹦�ܣ����.ini
::������־����--��־����(0|1)/N��־·��(PATH)/N��־��С(n/B)
::���·������.bat����������������
::���ӻ�����й���

@echo off
color 70&title ����GIF
:INI
set ini=1
set lsw=0
if not exist "%~dp0����GIF.ini" (
	echo δ��⵽"%~dp0����GIF.ini",���ֹ��ܹر�
	set ini=0
	set lsw=0
	goto A
)
for /f "delims=" %%i in ('findstr ��־���� "%~dp0����GIF.ini"') do (set lsw=%%i)
set lsw=%lsw:~4%
if %lsw%==0 (goto A)
if not exist "%batLib%\DBL\��ȡʱ��.bat" (
	echo δ�ҵ�"%batLib%\DBL\��ȡʱ��.bat",���ֹ��ܹر�
	set lsw=0
)
for /f "delims=" %%i in ('findstr ��־·�� "%~dp0����GIF.ini"') do (set lp="%%i")
set lp="%lp:~5%
md %lp% 2>nul
for /f "delims=" %%i in ('findstr ��־��С "%~dp0����GIF.ini"') do (set pls=%%i)
set pls=%pls:~4%
:A
choice /m �Ƿ����������ģʽ
cls
if %errorlevel%==1 (goto BP)
set /p p=����·����:
set p="%p:"=%"
:O
set /p o=���·����:
set o="%o:"=%"
if 1%co%==11 (goto C)
set /p s=��ʼʱ��:
set /p t=����ʱ��:
set /p r=֡��:

:C
for %%a in (%o%) do (set y=1%%~xa)
if  %y%==1.gif (goto B)
for %%a in (%o%) do (set o="%%~dpna.gif")
echo ��⵽����ļ���׺��gif
echo �ѽ����·������Ϊ
echo %o%
:B
if 1%co%==11 (goto P)

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
set co=0
if %sf%==0 (set sc=<nul)
if %bs%==0 (set sp=<nul)
if %sf%==1 (set "sc=scale=%c%x%k%,")
if %bs%==1 (set "sp=setpts=%m%*PTS,")

ffmpeg -ss %s% -t %t% -i %p% -map 0:v -vf "%sc%%sp%fps=%r%,split[s0][s1];[s0]palettegen[p];[s1][p]paletteuse" %o%
ffplay %o% -loop 99

if %lsw%==0 (goto PM)
start /wait /b "" "%batLib%\DBL\��ȡʱ��.bat" GIF
for /f "skip=1 delims=" %%i in ('type "%batLib%\DBL\��ʱ�ļ�\timecache-GIF.txt"') do (set sd=%%i
goto PA)
:PA
for /f "skip=3 delims=" %%i in ('type "%batLib%\DBL\��ʱ�ļ�\timecache-GIF.txt"') do (set st=%%i
goto PB)
:PB
if exist "%batLib%\DBL\��ʱ�ļ�\timecache-GIF.txt" (del /q "%batLib%\DBL\��ʱ�ļ�\timecache-GIF.txt")
copy %o% %lp% >nul
for /f "delims=" %%i in (%o%) do (set lfnx="%%~nxi")
set lf="%lp:"=%\%lfnx:"=%"
set lf="%lf:"=%"
echo %p%>"%lp:"=%\%sd%--%st%.log"
echo ��	��%o%>>"%lp:"=%\%sd%--%st%.log"
echo ��ʼʱ��%s%--����ʱ��%t%--����%sf%--����%bs%>>"%lp:"=%\%sd%--%st%.log"
echo ffmpeg -ss %s% -t %t% -vf "%sc%%sp%fps=%r%">>"%lp:"=%\%sd%--%st%.log"
ren %lf% "%sd%--%st%--��ʼʱ��%s%--����ʱ��%t%--����%sf%--����%bs%"
:PM
choice /m �Ƿ����Ԥ��
if %errorlevel%==1 (goto Z)

if exist %o% (del /q %o%)
choice /c abcdefgh /m ������ֵ:A��ʼʱ��;B����ʱ��;C֡��;D����;E����;Fȡ������;Gȡ������;H�������·����
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
if %errorlevel%==8 (
	set co=1
	goto O
)
goto P


:BP
if not exist "%batLib%\DBL\·������.bat" (echo δ�ҵ�"%batLib%\DBL\·������.bat"
pause
goto A)

echo ������
pause
goto A





:Z
if %lsw%==0 (goto ZZ)
:ZA
for /f "delims=" %%i in ('dir /-c %lp% ^| findstr �ֽ�') do (set ls=%%i
goto ZB)
:ZB
set ls=%ls:~20,-2%
set ls=%ls: =%
if %ls% GTR %pls% (
	for  /f "delims=" %%i in ('dir /a-d /s /b /od %lp%') do (
		if exist "%%i" (del /q "%%i")
		goto ZA
	)
)
:ZZ
pause
goto A