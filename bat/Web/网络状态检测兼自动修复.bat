@echo off
color 70&title ����״̬�����Զ��޸�
echo �ȴ�������
timeout /t 60
echo ����	%date%	%time%
:S
for /f "tokens=16" %%i in ('ipconfig ^| find "IPv4"') do (
	set ip=%%i
	goto A
)
:A
ping 223.5.5.5 -n 2 >nul
if %errorlevel%==1 (ping 180.76.76.76 -n 2 >nul)
if %errorlevel%==1 (ping 8.8.8.8 -n 2 >nul)
if %errorlevel%==0 (goto B)
echo %date%	%time%	������ͨ
set w=1

if defined ip (goto P)
echo ��δ��ȡ������IP
goto C
:P
set s=1
set d=0
set pn=0
setlocal enabledelayedexpansion
:N
set p=!ip:~%s%,1!
if %p%==. (set /a d+=1)
set /a s+=1
if %d%==3 (goto M) else (goto N)
:M
ping !ip:~0,%s%!1 -n 2 >nul
if %errorlevel%==1 (echo %date%	%time%	Ĭ������IP��ͨ
	set /a pn+=1)
ping !ip:~0,%s%!2 -n 2 >nul
if %errorlevel%==1 (echo %date%	%time%	������ͨ)
setlocal disabledelayedexpansion
ping 127.0.0.1 -n 1 >nul
if %errorlevel%==1 (echo %date%	%time%	TCP/IPЭ���쳣)
timeout /t 1 /nobreak > nul
if %pn% GTR 9 (goto C)
goto A
:B
if 1%w%==11 (
	set w=0
	set e=0
	set pn=0
	echo �����ѻָ�	%date%	%time%
	echo.&echo.
	goto S
)
::timeout /t 10 >nul
goto A
:C
if 1%e%==11 (goto Q) else (if 1%e%==12 (goto Q))
netsh interface set interface "��̫��" enabled
if %errorlevel%==0 (
	timeout /t 15>nul
	set e=1
	goto A
)
:Q
if 1%e%==12 (
	netsh interface set interface "��̫�� %i%" disabled
	goto W
)
::netsh interface set interface "��̫��" disabled
set i=0
:W
set /a i+=1
if %i% GTR 100 (
	echo �޷��޸���������ͣ
	pause
)
netsh interface set interface "��̫�� %i%" enabled
if %errorlevel%==1 (goto W)
if %errorlevel%==0 (
	timeout /t 15>nul
	set e=2
	goto A
)