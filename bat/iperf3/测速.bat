@echo off
:A
set ip=89
set /p ip= The 4th domain of server's IP:

set n=1
set /p n=Êý¾ÝÁ¿/G:

iperf3 -c 192.168.31.%ip% -n %n%G

echo.&echo.&echo.&echo.
goto A