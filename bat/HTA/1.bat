@echo off
echo start
ffmpeg -ss 00:00 -t 5 -i "N:\下载\qBittorrent 下载\沦落者之夜\[BeingNoability] Nokemono-tachi no Yoru - 01 [CR][1080P][AVC AAC MKV][CHS].mkv" -c copy "C:\Users\Administrator\Documents\新建文件夹\1.mkv" | find > "C:\Users\Administrator\Documents\新建文件夹\output.txt"
pause