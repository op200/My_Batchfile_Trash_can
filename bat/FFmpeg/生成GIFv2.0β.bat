@echo off
color 70&title 生成GIF
:A
cls
set /p p=输入路径名:
set /p o=输出路径名:
set /p s=开始时间:
set /p t=持续时间:
set /p r=帧率:

set i=%p:~-1%
if not ^%i%==^" (set p=^"%p%^")
set i=%o:~-1%
if not ^%i%==^" (set o=^"%o%^")
for %%a in (%o%) do (set y=1%%~xa)
if  %y%==1.gif (goto G)
for %%a in (%o%) do (set o=%%~dpna.gif)
echo 检测到输出文件后缀非gif
echo 已将输出路径名改为
echo %o%
:G

set i=0
choice /m 是否缩放
if %errorlevel%==2 (goto B)
set /p c=长:
set /p k=宽:
set i=1
for %%a in (%o%) do (
	for %%b in (%p%) do (set u=^"%%~dpna-%random%%%~xb^")
)
ffmpeg -i %p% -ss %s% -an -s %c%x%k% -t %t% %u%

:B
choice /m 是否变速
if %errorlevel%==1 (goto D)

if %i%==1 (goto C)
ffmpeg -t %t% -ss %s% -i %p% -vf "fps=%r%,split[s0][s1];[s0]palettegen[p];[s1][p]paletteuse" %o%
goto Z
:C
ffmpeg -i %u% -vf "fps=%r%,split[s0][s1];[s0]palettegen[p];[s1][p]paletteuse" %o%
goto Z

:D
set /p m=PTS*
if %i%==1 (goto E)
ffmpeg -t %t% -ss %s% -i %p% -vf "fps=%r%,setpts=%m%*PTS,split[s0][s1];[s0]palettegen[p];[s1][p]paletteuse" %o%
goto Z
:E
ffmpeg -i %u% -vf "fps=%r%,setpts=%m%*PTS,split[s0][s1];[s0]palettegen[p];[s1][p]paletteuse" %o%

:Z
if exist %u% (del /q %u%)
pause
goto A