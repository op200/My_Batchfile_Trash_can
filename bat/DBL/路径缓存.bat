@echo off
if not 2%2==21 (
	if not 2%2==22 (exit
	) else (goto B)
) else (goto A)
:A
dir /s /b "%dblpci%">"%batLib%\DBL\��ʱ�ļ�\pathcache-%3-%4.txt"
goto E
:B
for /f "delims=" %%i in ('dir /a-d "%dblpci%"^|findstr "�ļ�.*�ֽ�"') do (set fn=%%i)
set fn=%fn:~0,17%
set fn=%fn: =%

for /f "delims=" %%i in ('dir /s /b /a-d "%dblpci%"') do (
	echo %%i>"%batLib%\DBL\��ʱ�ļ�\pathcache-%3-%4.txt"
	set sk=0
	goto D
)
:D
set /a sk+=1
if %sk% GEQ %fn% (goto E)
for /f "skip=%sk%  delims=" %%i in ('dir /s /b /a-d "%dblpci%"') do (
	echo %%i>>"%batLib%\DBL\��ʱ�ļ�\pathcache-%3-%4.txt"
	goto D
)
:E
if 1%1==11 (if exist "%batLib%\DBL\��ʱ�ļ�\pathcache-%3-%4.txt" (
	copy "%batLib%\DBL\��ʱ�ļ�\pathcache-%3-%4.txt" "%dblpco%"
	del /q "%batLib%\DBL\��ʱ�ļ�\pathcache-%3-%4.txt")
)
exit

::���룺mode1��mode2��random1��(random2)�����ݱ�����dblpci��(dblpco)
::mode1��1=����dblpco��2=������
::mode2��1=���dblpci��dir/s/b��2=���г�Ŀ¼