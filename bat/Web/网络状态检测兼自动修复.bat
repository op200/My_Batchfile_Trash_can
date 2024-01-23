@echo off
color 70&title 网络状态检测兼自动修复
echo 等待启动中
timeout /t 60
echo 启动	%date%	%time%
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
echo %date%	%time%	外网不通
set w=1

if defined ip (goto P)
echo 从未获取到本机IP
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
if %errorlevel%==1 (echo %date%	%time%	默认网关IP不通
	set /a pn+=1)
ping !ip:~0,%s%!2 -n 2 >nul
if %errorlevel%==1 (echo %date%	%time%	内网不通)
setlocal disabledelayedexpansion
ping 127.0.0.1 -n 1 >nul
if %errorlevel%==1 (echo %date%	%time%	TCP/IP协议异常)
timeout /t 1 /nobreak > nul
if %pn% GTR 9 (goto C)
goto A
:B
if 1%w%==11 (
	set w=0
	set e=0
	set pn=0
	echo 网络已恢复	%date%	%time%
	echo.&echo.
	goto S
)
::timeout /t 10 >nul
goto A
:C
if 1%e%==11 (goto Q) else (if 1%e%==12 (goto Q))
netsh interface set interface "以太网" enabled
if %errorlevel%==0 (
	timeout /t 15>nul
	set e=1
	goto A
)
:Q
if 1%e%==12 (
	netsh interface set interface "以太网 %i%" disabled
	goto W
)
::netsh interface set interface "以太网" disabled
set i=0
:W
set /a i+=1
if %i% GTR 100 (
	echo 无法修复，程序暂停
	pause
)
netsh interface set interface "以太网 %i%" enabled
if %errorlevel%==1 (goto W)
if %errorlevel%==0 (
	timeout /t 15>nul
	set e=2
	goto A
)