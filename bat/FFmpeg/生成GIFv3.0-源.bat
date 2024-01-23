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
if  %y%==1.gif (goto B)
for %%a in (%o%) do (set o=%%~dpna.gif)
echo 检测到输出文件后缀非gif
echo 已将输出路径名改为
echo %o%
timeout /t 5
:B

set sf=0
choice /m 是否缩放
if %errorlevel%==1 (
	set /p c=长:
	set /p k=宽:
	set sf=1
)
set bs=0
choice /m 是否变速
if %errorlevel%==1 (
	set /p m=PTS*
	set bs=1
)

set sc=<nul
set sp=<nul

:P
if %sf%==0 (set sc=<nul)
if %bs%==0 (set sp=<nul)
if %sf%==1 (set "sc=scale=%c%x%k%,")
if %bs%==1 (set "sp=setpts=%m%*PTS,")

ffmpeg -ss %s% -t %t% -i %p% -vf "%sc%%sp%fps=%r%,split[s0][s1];[s0]palettegen[p];[s1][p]paletteuse" %o%
ffplay %o% -loop 99

choice /m 是否符合预期
if %errorlevel%==1 (goto Z)

if exist %o% (del /q %o%)
choice /c abcdefg /m 重新设值:A开始时间;B持续时间;C帧率;D缩放;E变速;F取消缩放;G取消变速
if %errorlevel% LEQ 3 (set /p d=输入值:)
if %errorlevel%==1 (set s=%d%)
if %errorlevel%==2 (set t=%d%)
if %errorlevel%==3 (set r=%d%)
if %errorlevel%==4 (
	set /p c=长:
	set /p k=宽:
	set sf=1
)
if %errorlevel%==5 (
	set /p m=PTS*
	set bs=1
)
if %errorlevel%==6 (set sf=0)
if %errorlevel%==7 (set bs=0)
goto P

:Z
pause
goto A