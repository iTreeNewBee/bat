@echo off
::结束ETGS进程及守护进程
taskkill /f /im ETGS_TRTCDeamon.exe
taskkill /f /im ETGS-TRTC.exe

::设置7z的命令行程序路径
set zip7=C:\Program Files\7-Zip\7z.exe
::设置压缩包保存路径
set Save=D:\etgs_bak
::当天日期，备份文件名
set curdate=%date:~0,4%-%date:~5,2%-%date:~8,2%
::设置要打包压缩的文件夹
set zipfile=C:\CHNSYS\ETGS\log

::备份命令 -xr!.svn过滤.svn文件夹
"%zip7%" a -tzip "%Save%\%curdate%.zip" "%zipfile%" -mx0 -xr!.svn

::删除超过7天的备份--start--
forfiles /p "%Save%" /m *.zip -d -7 /c "cmd /c del /f @path"

echo