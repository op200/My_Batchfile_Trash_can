@echo off
color 70&title 合并视音频
:A
cls
set /p p=视频文件路径:
set /p o=音频文件路径:
set /p u=输出文件路径:

set i=%p:~-1%
if not ^%i%==^" (set p=^"%p%^")

set i=%o:~-1%
if not ^%i%==^" (set o=^"%o%^")

set i=%u:~-1%
if not ^%i%==^" (set u=^"%u%^")

ffmpeg -i %p% -i %o% -vcodec copy -acodec copy %u%

pause
goto A




