@echo off

set d=%date:~0,-3%&set t=%time:~0,-3%
set s-date=%d:/=-%
set t=%t: =0%
set s-time=%t::=-%
set sdate=%d:/=%
set stime=%t::=%

echo %sdate%>"%batLib%\DBL\临时文件\timecache-%1.txt"
echo %s-date%>>"%batLib%\DBL\临时文件\timecache-%1.txt"
echo %stime%>>"%batLib%\DBL\临时文件\timecache-%1.txt"
echo %s-time%>>"%batLib%\DBL\临时文件\timecache-%1.txt"
echo %sdate%-%stime%>>"%batLib%\DBL\临时文件\timecache-%1.txt"
echo %s-date%--%s-time%>>"%batLib%\DBL\临时文件\timecache-%1.txt"

exit

::输入：random；输出：sdate、s-date、stime、s-time、sdate-stime、s-date--s-time

