set r=%random%
set "n=�� ����ַ���"

start "" /wait /b "%batLib%\DBL\�����ַ���λ��.bat" %r% n

set /p z=<"%batLib%\DBL\��ʱ�ļ�\�����ַ���λ��-%r%.��ʱ�ļ�"

del /q "%batLib%\DBL\��ʱ�ļ�\�����ַ���λ��-%r%.��ʱ�ļ�"

echo %z%
pause