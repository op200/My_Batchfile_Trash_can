::暂时可用

@echo off
:A
color 70&title 批处理文件名
if not exist "%batLib%\DBL\路径缓存.bat" (echo 未找到"%batLib%\DBL\路径缓存.bat"
pause
exit)
cls
echo 原文件不会被修改,被修改的文件将保存在bat同路径下的provisional里&echo.
set /p ip=输入被改文件夹路径
set /p cp=输入对照文件夹路径
set /p k=输入二者比值k=
echo %k%|findstr "^[1-9][0-9]*$">nul&&echo.||echo "k=%k%" error&&pause&&goto A

choice /m 是否确认?
if %errorlevel%==2 (goto A)

set r1=%random%
set r2=%random%
set "dblpco=%~dp0provisional"

if exist "%~dp0provisional" (rd /s /q "%~dp0provisional")
md "%~dp0provisional\ip"
cd /d "%~dp0provisional"

copy "%ip%" "ip"
set "ip=%~dp0provisional\ip"

set "dblpci=%ip%"
start "" /wait /b "%batLib%\DBL\路径缓存.bat" 1 2 %r1%
ren "pathcache-%r1%-.txt" ip.txt

set "dblpci=%cp%"
start "" /wait /b "%batLib%\DBL\路径缓存.bat" 1 2 %r2%
ren "pathcache-%r2%-.txt" cp.txt
pause
for /f "delims=" %%c in (cp.txt) do (echo %%~nxc>>cn.txt)

set cmd=echo ————————————————————————————————————
set mode=0

:MA
echo.&echo.&echo.
set v=1
for /f "delims=" %%c in (cn.txt) do (
	for /f "delims=" %%i in (ip.txt) do (
		echo %%~nxi
		echo →→%%~nc-1%%~xi
		for /f %%v in ("%v%") do (%cmd%)
		goto MB
	)
)
:MB
if not %k% GEQ 2 (goto MC)
set sk=0
:MBC
set /a sk+=1
if %sk% GEQ %k% (goto MC)
set /a v=sk+1
for /f "delims=" %%c in (cn.txt) do (
	for /f "skip=%sk% delims=" %%i in (ip.txt) do (
		echo %%~nxi
		echo →→%%~nc-%v%%%~xi
		for /f %%v in ("%v%") do (%cmd%)
		goto MBC
	)
)
:MC
set sk1=0
:MCCA
set /a sk1+=1
set /a sk2b=sk1*k+k
set /a sk2=sk1*k-1
:MCCB
set /a sk2+=1
if %sk2% GEQ %sk2b% (goto MCCA)
set /a v=k+sk2-sk2b+1
for /f "skip=%sk1% delims=" %%c in (cn.txt) do (
	for /f "skip=%sk2% delims=" %%i in (ip.txt) do (
		echo %%~nxi
		echo →→%%~nc-%v%%%~xi
		for /f %%v in ("%v%") do (%cmd%)
		goto MCCB
	)
)
if %mode%==1 (goto F)
choice /c ync /m 是否进行复制与更改?或逐个修改
if %errorlevel%==2 (goto A)
if %errorlevel%==3 (ip.txt&cn.txt&cls&goto MA)
set mode=1
set cmd=ren "%%i" "%%~nc-%%v%%~xi"&%cmd%
goto MA

:F
pause
cls
color ec
start "" "ip"
cd /d "%~dp0"
echo 即将删除临时文件,请及时保存
choice /c y /m 确认删除
if exist "%~dp0provisional" (rd /s /q "%~dp0provisional")
choice /c er /m E退出;R继续使用
if %errorlevel%==2 (goto A)