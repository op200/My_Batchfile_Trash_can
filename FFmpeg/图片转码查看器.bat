@echo off
mode con cols=25 lines=3
color 34&title ͼƬת��鿴��

set in=%1
set in="%in:"=%"
for %%a in ("%in:"=%") do (set out="%%~dpna-��ʱ�ļ�.png")
echo ����������
ffmpeg -y -i %in% %out% 2>nul
attrib +h %out%
echo ���潨���ɹ�
::ffplay %out% -y 1080 2>nul
%out%

if exist %out% (del /q /ah %out%)


