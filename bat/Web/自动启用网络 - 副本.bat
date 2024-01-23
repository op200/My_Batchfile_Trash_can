for /f "tokens=16" %%i in ('ipconfig ^| find "IPv4"') do (
	set ip=%%i
	goto a
)

:a
echo %ip%
pause