@echo off
color 70&title 批量压制

set /p in=被压制文件路径:
set in="%in:"=%"
set /p out=输出文件路径:
set out="%out:"=%"
if exist %out% (echo.) else (echo 未找到输出路径,已自动创建
md %out%)
cd /d %out%

set "to=timeout /t 1"
choice /m 是否启用延时
if %errorlevel%==2 (set "to=")

set x=mkv
set /p x=封装(%x%):

set map=0
set /p map=传入流(%map%):

set cv=libx265
set /p cv=视频编码器(%cv%):

set pix=yuv420p10le
set /p pix=像素格式(%pix%):

set pa=x265
set /p pa=视频编码器选项的格式(%pa%):

set hi=720
set /p hi=高度(%hi%):

set bf=12
set /p bf=BFrames(%bf%):

set qc=0.7
set /p qc=qcomp(%qc%):

set ca=copy
set /p ca=音频编码器(%ca%):

set ba=120k
set /p ba=音频码率(%ba%):

set q=0
for /f "delims=" %%a in ('dir /a-d /b /s "%in:"=%"') do (set /a q+=1)

set i=0
for /f "delims=" %%a in ('dir /a-d /b /s "%in:"=%"') do (
	title 1/%q%-批量压制-"%%~nxa"
	echo 1-"%%~nxa"————————————————
	ffmpeg -i "%%a" -map %map% -c copy -c:a %ca% -b:a %ba% -c:v %cv% -pix_fmt %pix% -%pa%-params "subme=7:qpmin=18:qpmax=26:qcomp=%qc%:merange=127:bframes=%bf%" -vf "scale=h=%hi%:w=-1" "%%~na.%x%"
	echo ————————————————————————————————————
	%to%
	goto C
)
:C
set /a i+=1
set /a ii=i+1
for /f "skip=%i% delims=" %%a in ('dir /a-d /b /s "%in:"=%"') do (
	title %ii%/%q%-批量压制-"%%~nxa"
	echo %ii%-"%%~nxa"————————————————
	ffmpeg -i "%%a" -map %map% -c copy -c:a %ca% -b:a %ba% -c:v %cv% -pix_fmt %pix% -%pa%-params "subme=7:qpmin=18:qpmax=26:qcomp=%qc%:merange=127:bframes=%bf%" -vf "scale=h=%hi%:w=-1" "%%~na.%x%"
	echo ————————————————————————————————————
	%to%
	goto C
)
echo END
title END
choice /c e /m 退出