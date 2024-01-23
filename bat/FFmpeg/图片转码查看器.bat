@echo off
mode con cols=25 lines=3
color 34&title 图片转码查看器

set in=%1
set in="%in:"=%"
for %%a in ("%in:"=%") do (set out="%%~dpna-临时文件.png")
echo 建立缓存中
ffmpeg -y -i %in% %out% 2>nul
attrib +h %out%
echo 缓存建立成功
::ffplay %out% -y 1080 2>nul
%out%

if exist %out% (del /q /ah %out%)


