@echo off

set d=%date:~0,-3%&set t=%time:~0,-3%
set s-date=%d:/=-%
set t=%t: =0%
set s-time=%t::=-%
set sdate=%d:/=%
set stime=%t::=%

echo %sdate%>"%batLib%\DBL\��ʱ�ļ�\timecache-%1.txt"
echo %s-date%>>"%batLib%\DBL\��ʱ�ļ�\timecache-%1.txt"
echo %stime%>>"%batLib%\DBL\��ʱ�ļ�\timecache-%1.txt"
echo %s-time%>>"%batLib%\DBL\��ʱ�ļ�\timecache-%1.txt"
echo %sdate%-%stime%>>"%batLib%\DBL\��ʱ�ļ�\timecache-%1.txt"
echo %s-date%--%s-time%>>"%batLib%\DBL\��ʱ�ļ�\timecache-%1.txt"

exit

::���룺random�������sdate��s-date��stime��s-time��sdate-stime��s-date--s-time

