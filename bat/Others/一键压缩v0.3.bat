@echo off
color 70&title һ��ѹ��

set /p in=�������ļ�·��:
set in="%in:"=%"
set /p out=����ļ�·��:
set out="%out:"=%"
if exist %out% (echo.) else (echo δ�ҵ����·��,���Զ�����
md %out%)
cd /d %out%

set /p p=����:
set p=-p%p%

set x=zip
set /p x=����ļ���չ��:
set m0=Copy
set /p m0=ѹ���㷨:
set mx=0
set /p mx=ѹ������:

set /p pn=����Y�ر�����ģʽ
if 1%pn%==1y (set "p=")

for /f "delims=" %%a in ('dir /a-d /b /s "%in:"=%"') do (
	7z.exe a "%%~na.%x%" "%%a" -m0=%m0% -mx%mx% %p%
	echo ������������������������������������������������������������������������
)
:Z
choice /m �Ƿ��˳�