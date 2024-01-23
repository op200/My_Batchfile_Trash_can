@echo off
color 70&title 一键压缩

set /p in=被加密文件路径:
set in="%in:"=%"
set /p out=输出文件路径:
set out="%out:"=%"
if exist %out% (echo.) else (echo 未找到输出路径,已自动创建
md %out%)
cd /d %out%

set /p p=密码:
set p=-p%p%

set x=zip
set /p x=输出文件扩展名:
set m0=Copy
set /p m0=压缩算法:
set mx=0
set /p mx=压缩级别:

set /p pn=输入Y关闭密码模式
if 1%pn%==1y (set "p=")

for /f "delims=" %%a in ('dir /a-d /b /s "%in:"=%"') do (
	7z.exe a "%%~na.%x%" "%%a" -m0=%m0% -mx%mx% %p%
	echo ————————————————————————————————————
)
:Z
choice /m 是否退出