@echo off
color 70&title Aria2

:A
set /p p=����·����:


set p=%p:"=%


aria2c --conf-path=aria2.conf -i %p%

goto A