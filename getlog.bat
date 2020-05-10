@echo off
::设置ETGS电脑ip、用户名、密码
set /p ip=Please input the IP of ETGS:
set /p user=input username:
set /p pwd=input password:
::建立空连接
net use \\%ip%\ipc$ "%pwd%" /user:"%user%">nul
call back_log.bat
echo Coping log , please wait...
xcopy \\%ip%\D$\etgs_bak\* %CD%\ /E /Y /D>nul | echo "file download success!!!"
::删除空连接
net use \\%ip%\ipc$ /del>nul
ping -n 4 127.0.0.1>nul

