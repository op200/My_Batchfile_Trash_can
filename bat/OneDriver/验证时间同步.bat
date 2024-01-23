::@echo off
color 70
cls
:A
set a=%date:~0,4%-%date:~5,2%-%date:~8,2%--%time:~0,2%-%time:~3,2%-%time:~6,2%&set b=%date:~0,4%-%date:~5,2%-%date:~8,2%--%time:~0,2%-%time:~3,2%-%time:~6,2%
echo %a%
echo %b%
if not "%a%"=="%b%" (
	echo error
	pause)
goto a