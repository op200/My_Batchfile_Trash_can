@echo off
color 79&title ���������ļ����ַ�
setlocal enabledelayedexpansion
echo ���棺�����޸�������Ŀ¼�ļ���·�����İ�Ǹ�̾�Żᱻ���ԣ�
:A
set /p p=����·��:
::set /p o=���·��:

set i=%p:~-1%
if not ^%i%==^" (set p="%p%")
set i=%o:~-1%
if not ^%i%==^" (set o="%o%")
:C
choice /c abc /m Aɾ��;B����;C������·��
if %errorlevel%==1 (goto FA)
if %errorlevel%==2 (goto FB)
if %errorlevel%==3 (goto A)
:FA
choice /c abc /m A��ͷ�����λ��ɾ��;B��β�����λ��ɾ��
if %errorlevel%==1 (goto FAA)
if %errorlevel%==2 (goto FAB)


:FAA
set /p ss=�����ַ���:
set /a ss+=1
set /p d=ɾ���ַ���:
set /a sum=ss+d
set c=0
set r=0
:FAAF
set s=0
for /f "tokens=*" %%a in ('dir /a-d /b /s %p%') do (
	set in="%%a"
	goto FAAA
)
:FAAA
for %%a in (%in%) do (set out="%%~nxa")
set o1=!out:~0,%ss%!
set o2=!out:~%sum%!
set out=%o1%%o2%
if %c%==1 (goto FAAR)
echo %in%
set in%s%=%in%
echo 	��%out%
set out%s%=%out%

set /a s+=1
for /f "tokens=* skip=%s%" %%a in ('dir /a-d /b /s %p%') do (
	set in="%%a"
	goto FAAA
)
if %r%==1 (goto C)
set c=1
choice /m �Ƿ����
if %errorlevel%==1 (set r=1
	goto FR)
if %errorlevel%==2 (goto FAA)
::������������������������������������������������
:FAB
set /p ss=�����ַ���:
set /a ss+=1
set /p d=ɾ���ַ���:
set /a sum=ss+d
set c=0
set r=0
:FABF
set s=0
for /f "tokens=*" %%a in ('dir /a-d /b /s %p%') do (
	set in="%%a"
	goto FABA
)
:FABA
for %%a in (%in%) do (set out="%%~nxa")
set o1=!out:~-%ss%!
set o2=!out:~0,-%sum%!
set out=%o2%%o1%
if %c%==1 (goto FABR)
echo %in%
set in%s%=%in%
echo 	��%out%
set out%s%=%out%

set /a s+=1
for /f "tokens=* skip=%s%" %%a in ('dir /a-d /b /s %p%') do (
	set in="%%a"
	goto FABA
)
if %r%==1 (goto C)
set c=1
choice /m �Ƿ����
if %errorlevel%==1 (set r=1
	goto FR)
if %errorlevel%==2 (goto FAB)
::������������������������������������������������
::������������������������������������������������
:FB
choice /c abc /m A��ͷ�����λ������;B��β�����λ������
if %errorlevel%==1 (goto FBA)
if %errorlevel%==2 (goto FBB)


:FBA
set /p ss=�����ַ���:
set /a ss+=1
set /p ad=�����ַ�����:
set c=0
set r=0
:FBAF
set s=0
for /f "tokens=*" %%a in ('dir /a-d /b /s %p%') do (
	set in="%%a"
	goto FBAA
)
:FBAA
for %%a in (%in%) do (set out="%%~nxa")
set out=!out:~0,%ss%!!ad!!out:~%ss%!
if %c%==1 (goto FBAR)
echo %in%
set in%s%=%in%
echo 	��%out%
set out%s%=%out%

set /a s+=1
for /f "tokens=* skip=%s%" %%a in ('dir /a-d /b /s %p%') do (
	set in="%%a"
	goto FBAA
)
if %r%==1 (goto C)
set c=1
choice /m �Ƿ����
if %errorlevel%==1 (set r=1
	goto FR)
if %errorlevel%==2 (goto FBA)
::������������������������������������������������
:FBB
set /p ss=�����ַ���:
set /a ss+=1
set /p ad=�����ַ�����:
set c=0
set r=0
:FBBF
set s=0
for /f "tokens=*" %%a in ('dir /a-d /b /s %p%') do (
	set in="%%a"
	goto FBBA
)
:FBBA
for %%a in (%in%) do (set out="%%~nxa")
set out=!out:~0,-%ss%!!ad!!out:~-%ss%!
if %c%==1 (goto FBBR)
echo %in%
set in%s%=%in%
echo 	��%out%
set out%s%=%out%

set /a s+=1
for /f "tokens=* skip=%s%" %%a in ('dir /a-d /b /s %p%') do (
	set in="%%a"
	goto FBBA
)
if %r%==1 (goto C)
set c=1
choice /m �Ƿ����
if %errorlevel%==1 (set r=1
	goto FR)
if %errorlevel%==2 (goto FBB)
::������������������������������������������������
::������������������������������������������������
::������������������������������������������������
:FR
set i=0
:FRA
ren !in%i%! !out%i%!
set /a i+=1
if %i% GEQ %s% (goto C)
goto FRA


