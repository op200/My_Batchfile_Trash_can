@echo off
set tit=һ������ת������
color 70&title %tit%
set line=��������������������������������������������������������������������
:A

if exist "��������Ƶ01.mkv" (goto M)

echo δ��⵽��������Ƶ�ļ�
echo ���Զ����������ز�������Ƶ�ļ�
echo ��ȷ������ͨ��
echo ��ȷ�����ļ�����3GiB���Ͽ��пռ�
echo %line%
echo ��Ҳ�����ֶ��������ļ�(�����ڵ�1.21GiB��Ƶ)���غú�
echo ������ýű�ͬĿ¼��
echo ��������Ϊ"��������Ƶ01.mkv"
echo %line%

choice /m �Ƿ��Զ�����
if %errorlevel%==2 (goto A)

echo ���ع��̿��ܽ���
echo ǰ�����ӿ���û����������
echo �����ĵȴ�
pause

aria2c --select-file=219 -T 01.torrent --conf-path=aria2.conf


ren "[MakiYuu&VCB-Studio] THE IDOLM@STER VOY@GER MMXXI [Ma10p_1080p]\[MakiYuu&VCB-Studio] THE IDOLM@STER VOY@GER MMXXI [Ma10p_1080p][X265_flac].mkv" "��������Ƶ01.mkv"

xcopy "[MakiYuu&VCB-Studio] THE IDOLM@STER VOY@GER MMXXI [Ma10p_1080p]\��������Ƶ01.mkv"&&if exist "[MakiYuu&VCB-Studio] THE IDOLM@STER VOY@GER MMXXI [Ma10p_1080p]" (rd /s /q "[MakiYuu&VCB-Studio] THE IDOLM@STER VOY@GER MMXXI [Ma10p_1080p]")
if exist "[MakiYuu&VCB-Studio] THE IDOLM@STER VOY@GER MMXXI [Ma10p_1080p].aria2" (del /q "[MakiYuu&VCB-Studio] THE IDOLM@STER VOY@GER MMXXI [Ma10p_1080p].aria2")
if exist "��������Ƶ01.mkv" (
	echo �������
	echo �������
	goto M
)

::�����ز�����Ƶ
:M
::����⵽��Ƶ����ʼ����
echo У���ϣ�С�
for /f "skip=1 delims=" %%a in ('certutil -hashfile ��������Ƶ01.mkv SHA256') do (set sha256=%%a
goto HASH)
:HASH
if not %sha256%==c95256f623f79a2d68686d5d2b53cf9fd1f0fff8a43105b08525c739ba3d4b3f (
	echo "��������Ƶ01.mkv"���ڴ���
	pause
	goto A
)
echo У��ɹ�

echo %line%

::for /f "delims=" %%a in ('findstr �Կ���Ϣ "Ԥ��.ini"') do (set "preset=%%a")
::set "gpu=%preset:~5%"
::if "%gpu%"=="" (echo δԤ���Կ���Ϣ) else (goto GPUOK)
echo ��ȡ�Կ���Ϣ�С�
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
echo ��ȡ�������Կ���ϢΪ
echo "%gpu%"

echo %line%

echo ��֤CPU�ڲ����ڼ䲻����������ռ��
echo ����Ӳ�������ʱҲ��Ҫռ��CPU��GPU
echo ��������Ҫ����ܲ��Գ��������

echo %line%

::���Ԥ��
for /f "delims=" %%a in ('findstr ������� "Ԥ��.ini"') do (set preset=%%a)
set "enableout=%preset:~5%"
for /f "delims=" %%a in ('findstr CPU��Ϣ "Ԥ��.ini"') do (set preset=%%a)
set "cpu=%preset:~6%"
echo ��⵽����Ԥ��Ϊ:
type Ԥ��.ini
echo.
echo %line%
::����Ԥ��
set "output=-f null -"
if %enableout%==1 (set output=�����Ƶ.mkv)


::��ȡCPU��Ϣ
if "%cpu%"=="" (echo δԤ��CPU��Ϣ) else (goto FFVER)
for /f "skip=1 delims=" %%a in ('wmic cpu list brief') do (set cpu=%%a
goto B)
:B
set cpu=%cpu:~78,37%
echo ��ȡ������CPU��ϢΪ
echo %cpu%
choice /m �Ƿ���ȷ
if %errorlevel%==2 (set /p cpu=�ֶ���������CPU��Ϣ:)


:FFVER
::��ȡffmpeg�汾
for /f "delims=" %%a in ('ffmpeg -version') do (set ffmpegver=%%a
goto C)
:C

set "head=ffmpeg -y -progress progress.log -i ��������Ƶ01.mkv -map 0:v"

:START
if exist progress.log (del /q progress.log)
echo %line%
echo %line%
echo %line%
set "project="
set "speed="
echo 	A	HEVC�������-ȫ������
echo %line%
echo 	D	Ӳ���������ʲ���
echo %line%
echo 	B	X265�������ʲ���
echo %line%
echo 	C	X264�������ʲ���
echo %line%
echo 	F	SVT-AV1�������ʲ���
echo %line%
echo 	E	AV1-QSV-veryslow��������-ȫ������
echo 	M	HEVC-QSV-veryslow��������-ȫ������
echo 	N	AVC-QSV-veryslow��������-ȫ������
echo %line%
echo 	O	HEVC-NVENC-p7��������-ȫ������
echo 	P	AVC-NVENC-p7��������-ȫ������

echo %line%
echo %line%

set "choose="
choice /c abcdefghijklmnop
set choose=%errorlevel%

::��ȡ��ʼʱ��
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

echo �յ�ѡ��
pause
goto START

:MXB
echo %line%
echo 	A	X265-ultrafast���ٱ�������-ȫ������
::echo 	B	X265-medium��������-���ٲ���
echo 	C	X265-medium��������-ȫ������
echo 	D	X265-slower��������-���ٲ���
echo 	E	X265-slower��������-ȫ������
echo 	F	X265-placebo��������-���ٲ���
echo 	G	X265-placebo��������-ȫ������
echo 	H	X265�л��ʱ�������-���ٲ���
echo 	I	X265�л��ʱ�������-ȫ������
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

echo �յ�ѡ��
pause
goto START

:MXBA
set project=X265-ultrafast���ٱ�������-ȫ������v0.1
title ������-%project%-%tit%
%head% -c:v libx265 -preset ultrafast %output%
goto LOG

:MXBC
set project=X265-medium��������-ȫ������v0.1
title ������-%project%-%tit%
%head% -c:v libx265 %output%
goto LOG

:MXBD
set project=X265-slower��������-���ٲ���v0.1
title ������-%project%-%tit%
%head% -t 60 -c:v libx265 -preset slower %output%
goto LOG

:MXBE
set project=X265-slower��������-ȫ������v0.1
title ������-%project%-%tit%
%head% -c:v libx265 -preset slower %output%
goto LOG

:MXBF
set project=X265-placebo��������-���ٲ���v0.1
title ������-%project%-%tit%
%head% -t 60 -c:v libx265 -preset placebo %output%
goto LOG

:MXBG
set project=X265-placebo��������-ȫ������v0.1
title ������-%project%-%tit%
%head% -c:v libx265 -preset placebo %output%
goto LOG

:MXBH
set project=X265�л��ʱ�������-���ٲ���v0.1.1
title ������-%project%-%tit%
%head% -t 60 -c:v libx265 -x265-params "crf=20:aq-mode=3:bframes=8:subme=5:me=star:rc-lookahead=60:rect=1:weightb=1:ref=4" %output%
goto LOG

:MXBI
set project=X265�л��ʱ�������-ȫ������v0.1
title ������-%project%-%tit%
%head% -c:v libx265 -x265-params "crf=20:aq-mode=3:bframes=8:subme=5:me=star:rc-lookahead=60:rect=1:weightb=1:ref=4" %output%
goto LOG




:MXC
echo %line%
echo 	A	X264-ultrafast���ٱ�������-ȫ������
echo 	B	X264-medium��������-ȫ������
echo 	C	X264-slower��������-ȫ������
echo 	D	X264-placebo��������-���ٲ���
echo 	E	X264-placebo��������-ȫ������
echo 	F	X264�л��ʱ�������-���ٲ���
echo 	G	X264�л��ʱ�������-ȫ������
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
set project=X264-ultrafast���ٱ�������-ȫ������v0.1
title ������-%project%-%tit%
%head% -c:v libx264 -preset ultrafast %output%
goto LOG

:MXCB
set project=X264-medium��������-ȫ������v0.1
title ������-%project%-%tit%
%head% -c:v libx264 %output%
goto LOG

:MXCC
set project=X264-slower��������-ȫ������v0.1
title ������-%project%-%tit%
%head% -c:v libx264 -preset slower %output%
goto LOG

:MXCD
set project=X264-placebo��������-���ٲ���v0.1
title ������-%project%-%tit%
%head% -t 60 -c:v libx264 -preset placebo %output%
goto LOG

:MXCE
set project=X264-placebo��������-ȫ������v0.1
title ������-%project%-%tit%
%head% -c:v libx264 -preset placebo %output%
goto LOG

:MXCF
set project=X264�л��ʱ�������-���ٲ���v0.1.1
title ������-%project%-%tit%
%head% -t 60 -c:v libx264 -x264-params "crf=20:aq-mode=3:bframes=8:subme=8:me=umh:rc-lookahead=60:weightb=1:ref=5" %output%
goto LOG

:MXCG
set project=X264�л��ʱ�������-ȫ������v0.1
title ������-%project%-%tit%
%head% -c:v libx264 -x264-params "crf=20:aq-mode=3:bframes=8:subme=8:me=umh:rc-lookahead=60:weightb=1:ref=5" %output%
goto LOG




:MXD
echo %line%
echo 	A	DXVA2(HEVC)��������-ȫ������
echo 	B	D3D11VA(HEVC)��������-ȫ������
echo 	E	D3D12VA(HEVC)��������-ȫ������
echo 	F	OpenCL(HEVC)��������-ȫ������
echo 	G	Vulkan(HEVC)��������-ȫ������
echo %line%
echo 	C	HEVC-QSV��������-ȫ������
echo 	D	HEVC-CUVID��������-ȫ������
echo 	H	QSV(HEVC)��������-ȫ������
echo 	I	CUDA(HEVC)��������-ȫ������
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
set project=DXVA2(HEVC)��������-ȫ������v0.1
title ������-%project%-%tit%
ffmpeg -y -progress progress.log -hwaccel dxva2 -i ��������Ƶ01.mkv -map 0:v -f null -
goto LOG

:MXDB
set project=D3D11VA(HEVC)��������-ȫ������v0.1
title ������-%project%-%tit%
ffmpeg -y -progress progress.log -hwaccel d3d11va -i ��������Ƶ01.mkv -map 0:v -f null -
goto LOG

:MXDC
set project=HEVC-QSV��������-ȫ������v0.1
title ������-%project%-%tit%
ffmpeg -y -progress progress.log -c:v hevc_qsv -i ��������Ƶ01.mkv -map 0:v -f null -
goto LOG

:MXDD
set project=HEVC-CUVID��������-ȫ������v0.1
title ������-%project%-%tit%
ffmpeg -y -progress progress.log -c:v hevc_cuvid -i ��������Ƶ01.mkv -map 0:v -f null -
goto LOG

:MXDE
set project=D3D12VA(HEVC)��������-ȫ������v0.1
title ������-%project%-%tit%
ffmpeg -y -progress progress.log -hwaccel d3d12va -i ��������Ƶ01.mkv -map 0:v -f null -
goto LOG

:MXDF
set project=OpenCL(HEVC)��������-ȫ������v0.1
title ������-%project%-%tit%
ffmpeg -y -progress progress.log -hwaccel_device 0 -hwaccel opencl -i ��������Ƶ01.mkv -map 0:v -f null -
goto LOG

:MXDG
set project=Vulkan(HEVC)��������-ȫ������v0.1
title ������-%project%-%tit%
ffmpeg -y -progress progress.log -hwaccel vulkan -i ��������Ƶ01.mkv -map 0:v -f null -
goto LOG

:MXDH
set project=QSV(HEVC)��������-ȫ������v0.1
title ������-%project%-%tit%
ffmpeg -y -progress progress.log -hwaccel qsv -i ��������Ƶ01.mkv -map 0:v -f null -
goto LOG

:MXDI
set project=CUDA(HEVC)��������-ȫ������v0.1
title ������-%project%-%tit%
ffmpeg -y -progress progress.log -hwaccel cuda -i ��������Ƶ01.mkv -map 0:v -f null -
goto LOG




:MXF
echo %line%
echo 	A	SVT-AV1-CRF18-preset5��������-���ٲ���
echo 	B	SVT-AV1-CRF18-preset5��������-ȫ������
echo %line%
echo 	C	SVT-AV1-CRF12-preset5��������-���ٲ���
echo 	D	SVT-AV1-CRF12-preset5��������-ȫ������
echo %line%
echo 	E	SVT-AV1-CRF6-preset5��������-���ٲ���
echo 	F	SVT-AV1-CRF6-preset5��������-ȫ������
echo %line%
echo 	G	SVT-AV1-CRF6-preset2��������-���ٲ���
echo 	H	SVT-AV1-CRF6-preset2��������-ȫ������
echo %line%
echo 	I	SVT-AV1-CRF6-preset1��������-���ٲ���
echo 	J	SVT-AV1-CRF6-preset1��������-ȫ������
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
set project=SVT-AV1-CRF18-preset5��������-���ٲ���v0.1
title ������-%project%-%tit%
%head% -t 60 -c:v libsvtav1 -crf 18 -preset 5 %output%
goto LOG

:MXFB
set project=SVT-AV1-CRF18-preset5��������-ȫ������v0.1
title ������-%project%-%tit%
%head% -c:v libsvtav1 -crf 18 -preset 5 %output%
goto LOG

:MXFC
set project=SVT-AV1-CRF12-preset5��������-���ٲ���v0.1
title ������-%project%-%tit%
%head% -t 60 -c:v libsvtav1 -crf 12 -preset 5 %output%
goto LOG

:MXFD
set project=SVT-AV1-CRF12-preset5��������-ȫ������v0.1
title ������-%project%-%tit%
%head% -c:v libsvtav1 -crf 12 -preset 5 %output%
goto LOG

:MXFE
set project=SVT-AV1-CRF6-preset5��������-���ٲ���v0.1
title ������-%project%-%tit%
%head% -t 60 -c:v libsvtav1 -crf 6 -preset 5 %output%
goto LOG

:MXFF
set project=SVT-AV1-CRF6-preset5��������-ȫ������v0.1
title ������-%project%-%tit%
%head% -c:v libsvtav1 -crf 6 -preset 5 %output%
goto LOG

:MXFG
set project=SVT-AV1-CRF6-preset2��������-���ٲ���v0.1
title ������-%project%-%tit%
%head% -t 60 -c:v libsvtav1 -crf 6 -preset 2 %output%
goto LOG

:MXFH
set project=SVT-AV1-CRF6-preset2��������-ȫ������v0.1
title ������-%project%-%tit%
%head% -c:v libsvtav1 -crf 6 -preset 2 %output%
goto LOG

:MXFI
set project=SVT-AV1-CRF6-preset1��������-���ٲ���v0.1
title ������-%project%-%tit%
%head% -t 60 -c:v libsvtav1 -crf 6 -preset 1 %output%
goto LOG

:MXFJ
set project=SVT-AV1-CRF6-preset1��������-ȫ������v0.1
title ������-%project%-%tit%
%head% -c:v libsvtav1 -crf 6 -preset 1 %output%
goto LOG










:MA
set project=HEVC�������-ȫ������v0.1
title ������-%project%-%tit%
%head% -f null -
goto LOG

:ME
set project=AV1-QSV-veryslow��������-ȫ������v0.1
title ������-%project%-%tit%
%head% -c:v av1_qsv -preset 1 %output%
goto LOG

:MM
set project=HEVC-QSV-veryslow��������-ȫ������v0.1
title ������-%project%-%tit%
%head% -c:v hevc_qsv -preset 1 %output%
goto LOG

:MN
set project=AVC-QSV-veryslow��������-ȫ������v0.1
title ������-%project%-%tit%
%head% -c:v h264_qsv -preset 1 %output%
goto LOG

:MO
set project=HEVC-NVENC-p7��������-ȫ������v0.1
title ������-%project%-%tit%
%head% -c:v hevc_nvenc -preset 18 %output%
goto LOG

:MP
set project=AVC-NVENC-p7��������-ȫ������v0.1
title ������-%project%-%tit%
%head% -c:v h264_nvenc -preset 18 %output%
goto LOG




:LOG
for /f "delims=" %%a in ('findstr "speed" progress.log') do (set speed=%%a)
set speed=%speed: =%
set speed=%speed:~6%
echo %line%
echo ���Խ��:%speed%

title �������-%project%-%tit%
::��ȡ����ʱ��
set endtime=%date:~0,10%--%time%
set endtime=%endtime: =0%

if %enableout%2==02 (goto WRI)
set outtime=%endtime:~0,20%
set outtime=%outtime:/=-%
set outtime=%outtime::=-%
ren "�����Ƶ.mkv" "%project%--%outtime%�����.mkv"
:WRI

echo %project%>>���Խ��.log
echo speed:%speed%>>���Խ��.log
echo %cpu%>>���Խ��.log
echo "%gpu:"=%">>���Խ��.log
echo %ffmpegver%>>���Խ��.log
echo %optime%----%endtime%>>���Խ��.log
echo %line%>>���Խ��.log
pause
goto START