setlocal enabledelayedexpansion
set "p=!%2!"
echo p=%p%
set i=1
:A
if not "!p:~%i%,1!"=="" (
	set /a i+=1
	goto A) else (goto B)
:B
(echo %i%)>"%batLib%\DBL\��ʱ�ļ�\�����ַ���λ��-%1.��ʱ�ļ�"
exit