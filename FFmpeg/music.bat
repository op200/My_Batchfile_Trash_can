@echo off
color 70&title music
:A
cls
set /p p=�����ļ�·��:
set /p o=����ļ�·��:
set /p s=��ʼʱ��:
set /p t=����ʱ��:
::set /p r=֡��:


set i=%p:~-1%
if not ^%i%==^" (set p=^"%p%^")

set i=%o:~-1%
if not ^%i%==^" (set o=^"%o%^")

choice /m �Ƿ����
if %errorlevel%==2 (goto B)
ffmpeg -i %p% -af "atempo=0.5" "%o%"

:B
ffmpeg -t %t% -ss %s% -i %p% -acodec copy %o%

:Z
pause
goto A




