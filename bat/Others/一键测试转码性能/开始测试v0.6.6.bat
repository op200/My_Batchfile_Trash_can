@echo off
set tit=一键测试转码性能
color 70&title %tit%
set line=——————————————————————————————————
:A

if exist "测试用视频01.mkv" (goto M)

echo 未检测到测试用视频文件
echo 将自动从网络下载测试用视频文件
echo 请确保网络通畅
echo 请确保该文件夹有3GiB以上空闲空间
echo %line%
echo 您也可以手动将测试文件(种子内的1.21GiB视频)下载好后
echo 放在与该脚本同目录下
echo 并重命名为"测试用视频01.mkv"
echo %line%

choice /m 是否自动下载
if %errorlevel%==2 (goto A)

echo 下载过程可能较慢
echo 前几分钟可能没有下载速率
echo 请耐心等待
pause

aria2c --select-file=219 -T 01.torrent --conf-path=aria2.conf


ren "[MakiYuu&VCB-Studio] THE IDOLM@STER VOY@GER MMXXI [Ma10p_1080p]\[MakiYuu&VCB-Studio] THE IDOLM@STER VOY@GER MMXXI [Ma10p_1080p][X265_flac].mkv" "测试用视频01.mkv"

xcopy "[MakiYuu&VCB-Studio] THE IDOLM@STER VOY@GER MMXXI [Ma10p_1080p]\测试用视频01.mkv"&&if exist "[MakiYuu&VCB-Studio] THE IDOLM@STER VOY@GER MMXXI [Ma10p_1080p]" (rd /s /q "[MakiYuu&VCB-Studio] THE IDOLM@STER VOY@GER MMXXI [Ma10p_1080p]")
if exist "[MakiYuu&VCB-Studio] THE IDOLM@STER VOY@GER MMXXI [Ma10p_1080p].aria2" (del /q "[MakiYuu&VCB-Studio] THE IDOLM@STER VOY@GER MMXXI [Ma10p_1080p].aria2")
if exist "测试用视频01.mkv" (
	echo 下载完成
	echo 进入测试
	goto M
)

::↑下载测试视频
:M
::↓检测到视频，开始测试
echo 校验哈希中…
for /f "skip=1 delims=" %%a in ('certutil -hashfile 测试用视频01.mkv SHA256') do (set sha256=%%a
goto HASH)
:HASH
if not %sha256%==c95256f623f79a2d68686d5d2b53cf9fd1f0fff8a43105b08525c739ba3d4b3f (
	echo "测试用视频01.mkv"存在错误
	pause
	goto A
)
echo 校验成功

echo %line%

::for /f "delims=" %%a in ('findstr 显卡信息 "预设.ini"') do (set "preset=%%a")
::set "gpu=%preset:~5%"
::if "%gpu%"=="" (echo 未预设显卡信息) else (goto GPUOK)
echo 获取显卡信息中…
if exist dxdiag-out.txt (goto GPUA)
dxdiag /t dxdiag-out.txt
:GPUA
timeout /t 1 /nobreak >nul
if not exist dxdiag-out.txt (goto GPUA)
set gpunum=0
for /f "delims=" %%a in ('findstr Card dxdiag-out.txt') do (set /a gpunum+=1)
for /f "delims=" %%a in ('findstr Card dxdiag-out.txt') do (set gpu=%%a
goto GPUB)
:GPUB
set gpu=%gpu:~22%
if %gpunum%==1 (goto GPUOK)
set skip=0
:GPUC
set /a skip+=1
if %skip%==%gpunum% (goto GPUOK)
for /f "skip=%skip% delims=" %%a in ('findstr Card dxdiag-out.txt') do (set gpu2=%%a
goto GPUD)
:GPUD
set gpu2=%gpu2:~22%
set "gpu=%gpu%	&	%gpu2%"
goto GPUC
:GPUOK
echo 获取到您的显卡信息为
echo "%gpu%"

echo %line%

echo 保证CPU在测试期间不被其他程序占用
echo 测试硬件编解码时也不要占用CPU和GPU
echo 符合以上要求才能测试出最大性能

echo %line%

::检测预设
for /f "delims=" %%a in ('findstr 开启输出 "预设.ini"') do (set preset=%%a)
set "enableout=%preset:~5%"
for /f "delims=" %%a in ('findstr CPU信息 "预设.ini"') do (set preset=%%a)
set "cpu=%preset:~6%"
echo 检测到您的预设为:
type 预设.ini
echo.
echo %line%
::加载预设
set "output=-f null -"
if %enableout%==1 (set output=输出视频.mkv)


::获取CPU信息
if "%cpu%"=="" (echo 未预设CPU信息) else (goto FFVER)
for /f "skip=1 delims=" %%a in ('wmic cpu list brief') do (set cpu=%%a
goto B)
:B
set cpu=%cpu:~78,37%
echo 获取到您的CPU信息为
echo %cpu%
choice /m 是否正确
if %errorlevel%==2 (set /p cpu=手动输入您的CPU信息:)


:FFVER
::获取ffmpeg版本
for /f "delims=" %%a in ('ffmpeg -version') do (set ffmpegver=%%a
goto C)
:C

set "head=ffmpeg -y -progress progress.log -i 测试用视频01.mkv -map 0:v"

:START
if exist progress.log (del /q progress.log)
echo %line%
echo %line%
echo %line%
set "project="
set "speed="
echo 	A	HEVC软解速率-全长测试
echo %line%
echo 	D	硬件解码速率测试
echo %line%
echo 	B	X265编码速率测试
echo %line%
echo 	C	X264编码速率测试
echo %line%
echo 	F	SVT-AV1编码速率测试
echo %line%
echo 	E	AV1-QSV-veryslow编码速率-全长测试
echo 	M	HEVC-QSV-veryslow编码速率-全长测试
echo 	N	AVC-QSV-veryslow编码速率-全长测试
echo %line%
echo 	O	HEVC-NVENC-p7编码速率-全长测试
echo 	P	AVC-NVENC-p7编码速率-全长测试

echo %line%
echo %line%

set "choose="
choice /c abcdefghijklmnop
set choose=%errorlevel%

::获取开始时间
set optime=%date:~0,10%--%time%
set optime=%optime: =0%

if %choose%==1 (goto MA)
if %choose%==2 (goto MXB)
if %choose%==3 (goto MXC)
if %choose%==4 (goto MXD)
if %choose%==5 (goto ME)
if %choose%==6 (goto MXF)
if %choose%==7 (goto MG)
if %choose%==8 (goto MH)
if %choose%==9 (goto MI)
::if %choose%==10 (goto MJ)
::if %choose%==11 (goto MK)
::if %choose%==12 (goto ML)
if %choose%==13 (goto MM)
if %choose%==14 (goto MN)
if %choose%==15 (goto MO)
if %choose%==16 (goto MP)

echo 空的选项
pause
goto START

:MXB
echo %line%
echo 	A	X265-ultrafast极速编码速率-全长测试
::echo 	B	X265-medium编码速率-快速测试
echo 	C	X265-medium编码速率-全长测试
echo 	D	X265-slower编码速率-快速测试
echo 	E	X265-slower编码速率-全长测试
echo 	F	X265-placebo编码速率-快速测试
echo 	G	X265-placebo编码速率-全长测试
echo 	H	X265中画质编码速率-快速测试
echo 	I	X265中画质编码速率-全长测试
echo %line%
echo %line%

choice /c abcdefghi
set choose=%errorlevel%

set optime=%date:~0,10%--%time%
set optime=%optime: =0%

if %choose%==1 (goto MXBA)
if %choose%==3 (goto MXBC)
if %choose%==4 (goto MXBD)
if %choose%==5 (goto MXBE)
if %choose%==6 (goto MXBF)
if %choose%==7 (goto MXBG)
if %choose%==8 (goto MXBH)
if %choose%==9 (goto MXBI)

echo 空的选项
pause
goto START

:MXBA
set project=X265-ultrafast极速编码速率-全长测试v0.1
title 测试中-%project%-%tit%
%head% -c:v libx265 -preset ultrafast %output%
goto LOG

:MXBC
set project=X265-medium编码速率-全长测试v0.1
title 测试中-%project%-%tit%
%head% -c:v libx265 %output%
goto LOG

:MXBD
set project=X265-slower编码速率-快速测试v0.1
title 测试中-%project%-%tit%
%head% -t 60 -c:v libx265 -preset slower %output%
goto LOG

:MXBE
set project=X265-slower编码速率-全长测试v0.1
title 测试中-%project%-%tit%
%head% -c:v libx265 -preset slower %output%
goto LOG

:MXBF
set project=X265-placebo编码速率-快速测试v0.1
title 测试中-%project%-%tit%
%head% -t 60 -c:v libx265 -preset placebo %output%
goto LOG

:MXBG
set project=X265-placebo编码速率-全长测试v0.1
title 测试中-%project%-%tit%
%head% -c:v libx265 -preset placebo %output%
goto LOG

:MXBH
set project=X265中画质编码速率-快速测试v0.1.1
title 测试中-%project%-%tit%
%head% -t 60 -c:v libx265 -x265-params "crf=20:aq-mode=3:bframes=8:subme=5:me=star:rc-lookahead=60:rect=1:weightb=1:ref=4" %output%
goto LOG

:MXBI
set project=X265中画质编码速率-全长测试v0.1
title 测试中-%project%-%tit%
%head% -c:v libx265 -x265-params "crf=20:aq-mode=3:bframes=8:subme=5:me=star:rc-lookahead=60:rect=1:weightb=1:ref=4" %output%
goto LOG




:MXC
echo %line%
echo 	A	X264-ultrafast极速编码速率-全长测试
echo 	B	X264-medium编码速率-全长测试
echo 	C	X264-slower编码速率-全长测试
echo 	D	X264-placebo编码速率-快速测试
echo 	E	X264-placebo编码速率-全长测试
echo 	F	X264中画质编码速率-快速测试
echo 	G	X264中画质编码速率-全长测试
echo %line%
echo %line%

choice /c abcdefghi
set choose=%errorlevel%

set optime=%date:~0,10%--%time%
set optime=%optime: =0%

if %choose%==1 (goto MXCA)
if %choose%==2 (goto MXCB)
if %choose%==3 (goto MXCC)
if %choose%==4 (goto MXCD)
if %choose%==5 (goto MXCE)
if %choose%==6 (goto MXCF)
if %choose%==7 (goto MXCG)

:MXCA
set project=X264-ultrafast极速编码速率-全长测试v0.1
title 测试中-%project%-%tit%
%head% -c:v libx264 -preset ultrafast %output%
goto LOG

:MXCB
set project=X264-medium编码速率-全长测试v0.1
title 测试中-%project%-%tit%
%head% -c:v libx264 %output%
goto LOG

:MXCC
set project=X264-slower编码速率-全长测试v0.1
title 测试中-%project%-%tit%
%head% -c:v libx264 -preset slower %output%
goto LOG

:MXCD
set project=X264-placebo编码速率-快速测试v0.1
title 测试中-%project%-%tit%
%head% -t 60 -c:v libx264 -preset placebo %output%
goto LOG

:MXCE
set project=X264-placebo编码速率-全长测试v0.1
title 测试中-%project%-%tit%
%head% -c:v libx264 -preset placebo %output%
goto LOG

:MXCF
set project=X264中画质编码速率-快速测试v0.1.1
title 测试中-%project%-%tit%
%head% -t 60 -c:v libx264 -x264-params "crf=20:aq-mode=3:bframes=8:subme=8:me=umh:rc-lookahead=60:weightb=1:ref=5" %output%
goto LOG

:MXCG
set project=X264中画质编码速率-全长测试v0.1
title 测试中-%project%-%tit%
%head% -c:v libx264 -x264-params "crf=20:aq-mode=3:bframes=8:subme=8:me=umh:rc-lookahead=60:weightb=1:ref=5" %output%
goto LOG




:MXD
echo %line%
echo 	A	DXVA2(HEVC)解码速率-全长测试
echo 	B	D3D11VA(HEVC)解码速率-全长测试
echo 	E	D3D12VA(HEVC)解码速率-全长测试
echo 	F	OpenCL(HEVC)解码速率-全长测试
echo 	G	Vulkan(HEVC)解码速率-全长测试
echo %line%
echo 	C	HEVC-QSV解码速率-全长测试
echo 	D	HEVC-CUVID解码速率-全长测试
echo 	H	QSV(HEVC)解码速率-全长测试
echo 	I	CUDA(HEVC)解码速率-全长测试
echo %line%
echo %line%

choice /c abcdefghi
set choose=%errorlevel%

set optime=%date:~0,10%--%time%
set optime=%optime: =0%

if %choose%==1 (goto MXDA)
if %choose%==2 (goto MXDB)
if %choose%==3 (goto MXDC)
if %choose%==4 (goto MXDD)
if %choose%==5 (goto MXDE)
if %choose%==6 (goto MXDF)
if %choose%==7 (goto MXDG)
if %choose%==8 (goto MXDH)
if %choose%==9 (goto MXDI)

:MXDA
set project=DXVA2(HEVC)解码速率-全长测试v0.1
title 测试中-%project%-%tit%
ffmpeg -y -progress progress.log -hwaccel dxva2 -i 测试用视频01.mkv -map 0:v -f null -
goto LOG

:MXDB
set project=D3D11VA(HEVC)解码速率-全长测试v0.1
title 测试中-%project%-%tit%
ffmpeg -y -progress progress.log -hwaccel d3d11va -i 测试用视频01.mkv -map 0:v -f null -
goto LOG

:MXDC
set project=HEVC-QSV解码速率-全长测试v0.1
title 测试中-%project%-%tit%
ffmpeg -y -progress progress.log -c:v hevc_qsv -i 测试用视频01.mkv -map 0:v -f null -
goto LOG

:MXDD
set project=HEVC-CUVID解码速率-全长测试v0.1
title 测试中-%project%-%tit%
ffmpeg -y -progress progress.log -c:v hevc_cuvid -i 测试用视频01.mkv -map 0:v -f null -
goto LOG

:MXDE
set project=D3D12VA(HEVC)解码速率-全长测试v0.1
title 测试中-%project%-%tit%
ffmpeg -y -progress progress.log -hwaccel d3d12va -i 测试用视频01.mkv -map 0:v -f null -
goto LOG

:MXDF
set project=OpenCL(HEVC)解码速率-全长测试v0.1
title 测试中-%project%-%tit%
ffmpeg -y -progress progress.log -hwaccel_device 0 -hwaccel opencl -i 测试用视频01.mkv -map 0:v -f null -
goto LOG

:MXDG
set project=Vulkan(HEVC)解码速率-全长测试v0.1
title 测试中-%project%-%tit%
ffmpeg -y -progress progress.log -hwaccel vulkan -i 测试用视频01.mkv -map 0:v -f null -
goto LOG

:MXDH
set project=QSV(HEVC)解码速率-全长测试v0.1
title 测试中-%project%-%tit%
ffmpeg -y -progress progress.log -hwaccel qsv -i 测试用视频01.mkv -map 0:v -f null -
goto LOG

:MXDI
set project=CUDA(HEVC)解码速率-全长测试v0.1
title 测试中-%project%-%tit%
ffmpeg -y -progress progress.log -hwaccel cuda -i 测试用视频01.mkv -map 0:v -f null -
goto LOG




:MXF
echo %line%
echo 	A	SVT-AV1-CRF18-preset5编码速率-快速测试
echo 	B	SVT-AV1-CRF18-preset5编码速率-全长测试
echo %line%
echo 	C	SVT-AV1-CRF12-preset5编码速率-快速测试
echo 	D	SVT-AV1-CRF12-preset5编码速率-全长测试
echo %line%
echo 	E	SVT-AV1-CRF6-preset5编码速率-快速测试
echo 	F	SVT-AV1-CRF6-preset5编码速率-全长测试
echo %line%
echo 	G	SVT-AV1-CRF6-preset2编码速率-快速测试
echo 	H	SVT-AV1-CRF6-preset2编码速率-全长测试
echo %line%
echo 	I	SVT-AV1-CRF6-preset1编码速率-快速测试
echo 	J	SVT-AV1-CRF6-preset1编码速率-全长测试
echo %line%
echo %line%

choice /c abcdefghi
set choose=%errorlevel%

set optime=%date:~0,10%--%time%
set optime=%optime: =0%

if %choose%==1 (goto MXFA)
if %choose%==2 (goto MXFB)
if %choose%==3 (goto MXFC)
if %choose%==4 (goto MXFD)
if %choose%==5 (goto MXFE)
if %choose%==6 (goto MXFF)
if %choose%==7 (goto MXFG)
if %choose%==8 (goto MXFH)
if %choose%==9 (goto MXFI)
if %choose%==10 (goto MXFJ)

:MXFA
set project=SVT-AV1-CRF18-preset5编码速率-快速测试v0.1
title 测试中-%project%-%tit%
%head% -t 60 -c:v libsvtav1 -crf 18 -preset 5 %output%
goto LOG

:MXFB
set project=SVT-AV1-CRF18-preset5编码速率-全长测试v0.1
title 测试中-%project%-%tit%
%head% -c:v libsvtav1 -crf 18 -preset 5 %output%
goto LOG

:MXFC
set project=SVT-AV1-CRF12-preset5编码速率-快速测试v0.1
title 测试中-%project%-%tit%
%head% -t 60 -c:v libsvtav1 -crf 12 -preset 5 %output%
goto LOG

:MXFD
set project=SVT-AV1-CRF12-preset5编码速率-全长测试v0.1
title 测试中-%project%-%tit%
%head% -c:v libsvtav1 -crf 12 -preset 5 %output%
goto LOG

:MXFE
set project=SVT-AV1-CRF6-preset5编码速率-快速测试v0.1
title 测试中-%project%-%tit%
%head% -t 60 -c:v libsvtav1 -crf 6 -preset 5 %output%
goto LOG

:MXFF
set project=SVT-AV1-CRF6-preset5编码速率-全长测试v0.1
title 测试中-%project%-%tit%
%head% -c:v libsvtav1 -crf 6 -preset 5 %output%
goto LOG

:MXFG
set project=SVT-AV1-CRF6-preset2编码速率-快速测试v0.1
title 测试中-%project%-%tit%
%head% -t 60 -c:v libsvtav1 -crf 6 -preset 2 %output%
goto LOG

:MXFH
set project=SVT-AV1-CRF6-preset2编码速率-全长测试v0.1
title 测试中-%project%-%tit%
%head% -c:v libsvtav1 -crf 6 -preset 2 %output%
goto LOG

:MXFI
set project=SVT-AV1-CRF6-preset1编码速率-快速测试v0.1
title 测试中-%project%-%tit%
%head% -t 60 -c:v libsvtav1 -crf 6 -preset 1 %output%
goto LOG

:MXFJ
set project=SVT-AV1-CRF6-preset1编码速率-全长测试v0.1
title 测试中-%project%-%tit%
%head% -c:v libsvtav1 -crf 6 -preset 1 %output%
goto LOG










:MA
set project=HEVC软解速率-全长测试v0.1
title 测试中-%project%-%tit%
%head% -f null -
goto LOG

:ME
set project=AV1-QSV-veryslow编码速率-全长测试v0.1
title 测试中-%project%-%tit%
%head% -c:v av1_qsv -preset 1 %output%
goto LOG

:MM
set project=HEVC-QSV-veryslow编码速率-全长测试v0.1
title 测试中-%project%-%tit%
%head% -c:v hevc_qsv -preset 1 %output%
goto LOG

:MN
set project=AVC-QSV-veryslow编码速率-全长测试v0.1
title 测试中-%project%-%tit%
%head% -c:v h264_qsv -preset 1 %output%
goto LOG

:MO
set project=HEVC-NVENC-p7编码速率-全长测试v0.1
title 测试中-%project%-%tit%
%head% -c:v hevc_nvenc -preset 18 %output%
goto LOG

:MP
set project=AVC-NVENC-p7编码速率-全长测试v0.1
title 测试中-%project%-%tit%
%head% -c:v h264_nvenc -preset 18 %output%
goto LOG




:LOG
for /f "delims=" %%a in ('findstr "speed" progress.log') do (set speed=%%a)
set speed=%speed: =%
set speed=%speed:~6%
echo %line%
echo 测试结果:%speed%

title 测试完成-%project%-%tit%
::获取结束时间
set endtime=%date:~0,10%--%time%
set endtime=%endtime: =0%

if %enableout%2==02 (goto WRI)
set outtime=%endtime:~0,20%
set outtime=%outtime:/=-%
set outtime=%outtime::=-%
ren "输出视频.mkv" "%project%--%outtime%的输出.mkv"
:WRI

echo %project%>>测试结果.log
echo speed:%speed%>>测试结果.log
echo %cpu%>>测试结果.log
echo "%gpu:"=%">>测试结果.log
echo %ffmpegver%>>测试结果.log
echo %optime%----%endtime%>>测试结果.log
echo %line%>>测试结果.log
pause
goto START