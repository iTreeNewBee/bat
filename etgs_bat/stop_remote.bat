@echo off
::����ETGS���̼��ػ�����
taskkill /f /im ETGS_TRTCDeamon.exe
taskkill /f /im ETGS-TRTC.exe

::����7z�������г���·��
set zip7=C:\Program Files\7-Zip\7z.exe
::����ѹ��������·��
set Save=D:\etgs_bak
::�������ڣ������ļ���
set curdate=%date:~0,4%-%date:~5,2%-%date:~8,2%
::����Ҫ���ѹ�����ļ���
set zipfile=C:\CHNSYS\ETGS\log

::�������� -xr!.svn����.svn�ļ���
"%zip7%" a -tzip "%Save%\%curdate%.zip" "%zipfile%" -mx0 -xr!.svn

::ɾ������7��ı���--start--
forfiles /p "%Save%" /m *.zip -d -7 /c "cmd /c del /f @path"

echo