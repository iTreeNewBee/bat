@echo off
::设置ETGS电脑ip、用户名、密码
set /p ip=Please input the IP of ETGS:
set /p user=input username:
set /p pwd=input password:
::建立空连接
echo stopping ETGS , please wait...
net use \\%ip%\ipc$ "%pwd%" /user:"%user%">nul
::删除已存在所有任务
at \\%ip% /delete /yes>nul
::设置时间，只取小时和分钟
set hour=%time:~0,2%
set min=%time:~3,2%
set /a min=min+1
::设置计划任务执行停止ETGS脚本
at \\%ip% %hour%:%min% "C:\Chnsys\ETGS\etgs_bat\etgs_bat\stop_remote.bat">nul
::是否copy日志文件
choice /c yn /m "is download log file?" /d y /t 10
if %errorlevel%==1 xcopy \\%ip%\D$\etgs_bak\* D:\etgs_recv\ /E /Y /D>nul
::删除空连接
net use \\%ip%\ipc$ /del>nul
echo ETGS stop successful !!!
pause