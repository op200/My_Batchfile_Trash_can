exit
@echo off
color 70
set s=600
set v="C:\Users\Administrator.WIN-HCQDE1L0A5U\OneDrive - op200reek (1)\log\ˢ��ʱ��\ˢ��ʱ��

set d=%date:/=-%&set t=%time%
set d=%d:~0,-3%
set a=%d:-=%
echo %d%	%t%	����	��ʱ%s%s>>%v%%d%.log"
title ��ʱˢ�� ����ʱ�� %d% %t%
echo ˢ��ʱ��:>>%v%%d%.log"
echo ˢ��ʱ��:
goto M
:A
set d=%date:/=-%&set t=%time%
set d=%d:~0,-3%
set a=%d:-=%
echo %t:~0,-3%>>%v%%d%.log"
:M
del /s /q "C:\Users\Administrator.WIN-HCQDE1L0A5U\OneDrive - op200reek (1)\��Ƶ\ˢ��ʱ��">nul
type nul>"C:\Users\Administrator.WIN-HCQDE1L0A5U\OneDrive - op200reek (1)\��Ƶ\ˢ��ʱ��\ˢ��ʱ��%d%--%time:~0,2%-%time:~3,2%-%time:~6,2%"

echo %d%	%t%
timeout  /t %s% /nobreak>nul
set c=%date:~0,4%%date:~5,2%%date:~8,2%
if %c% GTR %a% (
	set d=%date:/=-%
	set d=%d:~0,-3%
	echo %d%	����>>"C:\Users\Administrator.WIN-HCQDE1L0A5U\OneDrive - op200reek (1)\log\ˢ��ʱ��\ˢ��ʱ��%d%.log"
)

goto A