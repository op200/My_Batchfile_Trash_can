@echo off
color 70&title �ϲ�����Ƶ
:A
cls
set /p p=��Ƶ�ļ�·��:
set /p o=��Ƶ�ļ�·��:
set /p u=����ļ�·��:

set i=%p:~-1%
if not ^%i%==^" (set p=^"%p%^")

set i=%o:~-1%
if not ^%i%==^" (set o=^"%o%^")

set i=%u:~-1%
if not ^%i%==^" (set u=^"%u%^")

ffmpeg -i %p% -i %o% -vcodec copy -acodec copy %u%

pause
goto A




