@echo off
::���ETGS��־
del /f /s /q C:\CHNSYS\ETGS\log\*.* 
::����ETGS�ػ�����
for /f "tokens=1,2,* " %%i in ('REG QUERY HKEY_CURRENT_USER\Software\Chnsys\ETGS /v ETGS_TRTCDeamon.exe ^| find /i "ETGS_TRTCDeamon.exe"') do set "regvalue=%%k"
start "" "%regvalue%"

echo
