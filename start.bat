@echo off
::设置ETGS电脑ip、用户名、密码
set /p ip=Please input the IP of ETGS:
set /p user=input username:
set /p pwd=input password:
echo starting ETGS , please wait...
::建立空连接
net use \\%ip%\ipc$ "%pwd%" /user:"%user%">nul
::删除已存在所有任务
at \\%ip% /delete /yes>nul
set hour=%time:~0,2%
set min=%time:~3,2%
set /a min=min+1
::设置计划任务执行启动脚本
at \\%ip% %hour%:%min% "C:\Chnsys\ETGS\etgs_bat\etgs_bat\start_remote.bat">nul
::删除空连接
net use \\%ip%\ipc$ /del>nul
echo ETGS start successful !!!
pause