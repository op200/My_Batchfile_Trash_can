set r=%random%
set "n=需 输的字符串"

start "" /wait /b "%batLib%\DBL\计算字符串位数.bat" %r% n

set /p z=<"%batLib%\DBL\临时文件\计算字符串位数-%r%.临时文件"

del /q "%batLib%\DBL\临时文件\计算字符串位数-%r%.临时文件"

echo %z%
pause