@echo off
color 70&title ����ѹ��

set /p in=��ѹ���ļ�·��:
set in="%in:"=%"
set /p out=����ļ�·��:
set out="%out:"=%"
if exist %out% (echo.) else (echo δ�ҵ����·��,���Զ�����
md %out%)
cd /d %out%

set "to=timeout /t 1"
choice /m �Ƿ�������ʱ
if %errorlevel%==2 (set "to=")

set x=mkv
set /p x=��װ(%x%):

set map=0
set /p map=������(%map%):

set cv=libx265
set /p cv=��Ƶ������(%cv%):

set pix=yuv420p10le
set /p pix=���ظ�ʽ(%pix%):

set pa=x265
set /p pa=��Ƶ������ѡ��ĸ�ʽ(%pa%):

set hi=720
set /p hi=�߶�(%hi%):

set bf=12
set /p bf=BFrames(%bf%):

set qc=0.7
set /p qc=qcomp(%qc%):

set ca=copy
set /p ca=��Ƶ������(%ca%):

set ba=120k
set /p ba=��Ƶ����(%ba%):

set q=0
for /f "delims=" %%a in ('dir /a-d /b /s "%in:"=%"') do (set /a q+=1)

set i=0
for /f "delims=" %%a in ('dir /a-d /b /s "%in:"=%"') do (
	title 1/%q%-����ѹ��-"%%~nxa"
	echo 1-"%%~nxa"��������������������������������
	ffmpeg -i "%%a" -map %map% -c copy -c:a %ca% -b:a %ba% -c:v %cv% -pix_fmt %pix% -%pa%-params "subme=7:qpmin=18:qpmax=26:qcomp=%qc%:merange=127:bframes=%bf%" -vf "scale=h=%hi%:w=-1" "%%~na.%x%"
	echo ������������������������������������������������������������������������
	%to%
	goto C
)
:C
set /a i+=1
set /a ii=i+1
for /f "skip=%i% delims=" %%a in ('dir /a-d /b /s "%in:"=%"') do (
	title %ii%/%q%-����ѹ��-"%%~nxa"
	echo %ii%-"%%~nxa"��������������������������������
	ffmpeg -i "%%a" -map %map% -c copy -c:a %ca% -b:a %ba% -c:v %cv% -pix_fmt %pix% -%pa%-params "subme=7:qpmin=18:qpmax=26:qcomp=%qc%:merange=127:bframes=%bf%" -vf "scale=h=%hi%:w=-1" "%%~na.%x%"
	echo ������������������������������������������������������������������������
	%to%
	goto C
)
echo END
title END
choice /c e /m �˳�