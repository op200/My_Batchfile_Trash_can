exit
@echo off
color 70
set s=600
set v="C:\Users\Administrator.WIN-HCQDE1L0A5U\OneDrive - op200reek (1)\log\刷新时间\刷新时间

set d=%date:/=-%&set t=%time%
set d=%d:~0,-3%
set a=%d:-=%
echo %d%	%t%	启动	延时%s%s>>%v%%d%.log"
title 延时刷新 启动时间 %d% %t%
echo 刷新时间:>>%v%%d%.log"
echo 刷新时间:
goto M
:A
set d=%date:/=-%&set t=%time%
set d=%d:~0,-3%
set a=%d:-=%
echo %t:~0,-3%>>%v%%d%.log"
:M
del /s /q "C:\Users\Administrator.WIN-HCQDE1L0A5U\OneDrive - op200reek (1)\视频\刷新时间">nul
type nul>"C:\Users\Administrator.WIN-HCQDE1L0A5U\OneDrive - op200reek (1)\视频\刷新时间\刷新时间%d%--%time:~0,2%-%time:~3,2%-%time:~6,2%"

echo %d%	%t%
timeout  /t %s% /nobreak>nul
set c=%date:~0,4%%date:~5,2%%date:~8,2%
if %c% GTR %a% (
	set d=%date:/=-%
	set d=%d:~0,-3%
	echo %d%	创建>>"C:\Users\Administrator.WIN-HCQDE1L0A5U\OneDrive - op200reek (1)\log\刷新时间\刷新时间%d%.log"
)

goto A