@echo off
color 70&title ��Ƶ��ͼ

if exist "%1" (
	set in=%1
	goto A
)
set /p in=Input:
:A
set in="%in:"=%"
for %%a in ("%in:"=%") do (set out="%%~dpna-��ͼ.webp")
:S
set /p s=Time:

ffmpeg -y -ss %s% -i %in% -map 0:v -c:v libwebp -lossless 1 -vframes 1 %out%
attrib +h %out%

%out%

choice /m �Ƿ����Ԥ��
if %errorlevel%==1 (
	attrib -h %out%
	exit
)

if exist %out% (del /q /ah %out%)
goto S

