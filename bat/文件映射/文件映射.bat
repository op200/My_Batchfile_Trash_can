@echo off
color 70&title �ļ�ӳ��
:A
set /p p=���봴��ӳ��ĸ��ļ���·��
set /p o=����Ŀ��·��

set "i=%p:~-1%"
if ^%i%==^" (set "p=%p:"=%")

set "i=%o:~-1%"
if ^%i%==^" (set "o=%o:"=%")

if %o:~-1%==\ (set "i=%o:~0,-1%") else (set "i=%o%")
for %%a in ("%i%") do set "u=%%~na"

mklink /h /j "%p%\%u%" "%o%"
echo.
goto A