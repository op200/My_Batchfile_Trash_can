::增加配置文件预设功能，检测.ini
::增加日志功能--日志开关(0|1)/N日志路径(PATH)/N日志大小(n/B)
::结合路径缓存.bat，增加批量处理功能
::增加画面裁切功能

@echo off
color 70&title 生成GIF
:INI
set ini=1
set lsw=0
if not exist "%~dp0生成GIF.ini" (
	echo 未检测到"%~dp0生成GIF.ini",部分功能关闭
	set ini=0
	set lsw=0
	goto A
)
for /f "delims=" %%i in ('findstr 日志开关 "%~dp0生成GIF.ini"') do (set lsw=%%i)
set lsw=%lsw:~4%
if %lsw%==0 (goto A)
if not exist "%batLib%\DBL\获取时间.bat" (
	echo 未找到"%batLib%\DBL\获取时间.bat",部分功能关闭
	set lsw=0
)
for /f "delims=" %%i in ('findstr 日志路径 "%~dp0生成GIF.ini"') do (set lp="%%i")
set lp="%lp:~5%
md %lp% 2>nul
for /f "delims=" %%i in ('findstr 日志大小 "%~dp0生成GIF.ini"') do (set pls=%%i)
set pls=%pls:~4%
:A
choice /m 是否进入批处理模式
cls
if %errorlevel%==1 (goto BP)
set /p p=输入路径名:
set p="%p:"=%"
:O
set /p o=输出路径名:
set o="%o:"=%"
if 1%co%==11 (goto C)
set /p s=开始时间:
set /p t=持续时间:
set /p r=帧率:

:C
for %%a in (%o%) do (set y=1%%~xa)
if  %y%==1.gif (goto B)
for %%a in (%o%) do (set o="%%~dpna.gif")
echo 检测到输出文件后缀非gif
echo 已将输出路径名改为
echo %o%
:B
if 1%co%==11 (goto P)

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
set co=0
if %sf%==0 (set sc=<nul)
if %bs%==0 (set sp=<nul)
if %sf%==1 (set "sc=scale=%c%x%k%,")
if %bs%==1 (set "sp=setpts=%m%*PTS,")

ffmpeg -ss %s% -t %t% -i %p% -map 0:v -vf "%sc%%sp%fps=%r%,split[s0][s1];[s0]palettegen[p];[s1][p]paletteuse" %o%
ffplay %o% -loop 99

if %lsw%==0 (goto PM)
start /wait /b "" "%batLib%\DBL\获取时间.bat" GIF
for /f "skip=1 delims=" %%i in ('type "%batLib%\DBL\临时文件\timecache-GIF.txt"') do (set sd=%%i
goto PA)
:PA
for /f "skip=3 delims=" %%i in ('type "%batLib%\DBL\临时文件\timecache-GIF.txt"') do (set st=%%i
goto PB)
:PB
if exist "%batLib%\DBL\临时文件\timecache-GIF.txt" (del /q "%batLib%\DBL\临时文件\timecache-GIF.txt")
copy %o% %lp% >nul
for /f "delims=" %%i in (%o%) do (set lfnx="%%~nxi")
set lf="%lp:"=%\%lfnx:"=%"
set lf="%lf:"=%"
echo %p%>"%lp:"=%\%sd%--%st%.log"
echo →	→%o%>>"%lp:"=%\%sd%--%st%.log"
echo 开始时间%s%--持续时间%t%--缩放%sf%--变速%bs%>>"%lp:"=%\%sd%--%st%.log"
echo ffmpeg -ss %s% -t %t% -vf "%sc%%sp%fps=%r%">>"%lp:"=%\%sd%--%st%.log"
ren %lf% "%sd%--%st%--开始时间%s%--持续时间%t%--缩放%sf%--变速%bs%"
:PM
choice /m 是否符合预期
if %errorlevel%==1 (goto Z)

if exist %o% (del /q %o%)
choice /c abcdefgh /m 重新设值:A开始时间;B持续时间;C帧率;D缩放;E变速;F取消缩放;G取消变速;H更改输出路径名
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
if %errorlevel%==8 (
	set co=1
	goto O
)
goto P


:BP
if not exist "%batLib%\DBL\路径缓存.bat" (echo 未找到"%batLib%\DBL\路径缓存.bat"
pause
goto A)

echo 制作中
pause
goto A





:Z
if %lsw%==0 (goto ZZ)
:ZA
for /f "delims=" %%i in ('dir /-c %lp% ^| findstr 字节') do (set ls=%%i
goto ZB)
:ZB
set ls=%ls:~20,-2%
set ls=%ls: =%
if %ls% GTR %pls% (
	for  /f "delims=" %%i in ('dir /a-d /s /b /od %lp%') do (
		if exist "%%i" (del /q "%%i")
		goto ZA
	)
)
:ZZ
pause
goto A