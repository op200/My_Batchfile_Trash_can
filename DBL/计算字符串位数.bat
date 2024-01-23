setlocal enabledelayedexpansion
set "p=!%2!"
echo p=%p%
set i=1
:A
if not "!p:~%i%,1!"=="" (
	set /a i+=1
	goto A) else (goto B)
:B
(echo %i%)>"%batLib%\DBL\临时文件\计算字符串位数-%1.临时文件"
exit