@echo off
color 70&title azusa�Զ�ǩ��
echo �ȴ�������
timeout /t 600
:A
start /b "" "%batLib%\DBL\����IE.bat" https://azusa.wiki/attendance.php
timeout /t 5
start /b "" "%batLib%\DBL\����IE.bat" https://ubits.club/attendance.php
timeout /t 400 /NOBREAK
taskkill /im iexplore.exe /f /t
timeout /t 6800 /NOBREAK
goto A