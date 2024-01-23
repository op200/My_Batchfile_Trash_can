@echo off
color 70&title 文件映射
:A
set /p p=输入创建映射的父文件夹路径
set /p o=输入目标路径

set "i=%p:~-1%"
if ^%i%==^" (set "p=%p:"=%")

set "i=%o:~-1%"
if ^%i%==^" (set "o=%o:"=%")

if %o:~-1%==\ (set "i=%o:~0,-1%") else (set "i=%o%")
for %%a in ("%i%") do set "u=%%~na"

mklink /h /j "%p%\%u%" "%o%"
echo.
goto A