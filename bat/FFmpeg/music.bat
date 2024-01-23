@echo off
color 70&title music
:A
cls
set /p p=输入文件路径:
set /p o=输出文件路径:
set /p s=开始时间:
set /p t=持续时间:
::set /p r=帧率:


set i=%p:~-1%
if not ^%i%==^" (set p=^"%p%^")

set i=%o:~-1%
if not ^%i%==^" (set o=^"%o%^")

choice /m 是否变速
if %errorlevel%==2 (goto B)
ffmpeg -i %p% -af "atempo=0.5" "%o%"

:B
ffmpeg -t %t% -ss %s% -i %p% -acodec copy %o%

:Z
pause
goto A




