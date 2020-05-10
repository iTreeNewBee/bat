@echo off
::设置ETGS电脑ip、用户名、密码
set /p ip=Please input the IP of ETGS:
set /p user=input username:
set /p pwd=input password:
::建立空连接
net use \\%ip%\ipc$ "%pwd%" /user:"%user%">nul
echo Command execution takes one minute , please wait...
::删除已存在所有任务
at \\%ip% /delete /yes>nul
::设置时间，只取小时和分钟
set hour=%time:~0,2%
set min=%time:~3,2%
::设置计划任务当前时间延迟一分钟
set /a min=min+1
::设置计划任务执行停止ETGS脚本
at \\%ip% %hour%:%min% "C:\Chnsys\ETGS\etgs_bat\etgs_bat\stop_remote.bat">nul
::等待1分钟
ping -n 60 127.0.0.1>nul
set hour=%time:~0,2%
set min=%time:~3,2%
set /a min=min+1
::设置计划任务执行启动脚本
at \\%ip% %hour%:%min% "C:\Chnsys\ETGS\etgs_bat\etgs_bat\start_remote.bat">nul
ping -n 30 127.0.0.1>nul
echo ETGS restart successful !!!
::是否copy日志文件
choice /c yn /m "is download log file?" /d y /t 30
if %errorlevel%==1 xcopy \\%ip%\D$\etgs_bak\* %CD%\ /E /Y /D>nul | echo "file download success!!!"
::删除空连接
net use \\%ip%\ipc$ /del>nul

