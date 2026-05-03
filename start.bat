@echo off
del /f "C:\Users\Public\Desktop\Epic Games Launcher.lnk" >nul 2>&1
net config server /srvcomment:"Windows Server 2022 by @Davitt" >nul 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /V EnableAutoTray /T REG_DWORD /D 0 /F >nul 2>&1
if exist "D:\a\wallpaper.bat" (
    REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /f /v Wallpaper /t REG_SZ /d "D:\a\wallpaper.bat" >nul 2>&1
)
net user Administrator W2016 >nul 2>&1
net localgroup administrators Administrator /add >nul 2>&1
net user Administrator /active:yes >nul 2>&1
net user installer /delete >nul 2>&1
diskperf -Y >nul 2>&1
sc config Audiosrv start= auto >nul 2>&1
sc start audiosrv >nul 2>&1
ICACLS C:\Windows\Temp /grant administrator:F /T /C >nul 2>&1
ICACLS C:\Windows\installer /grant administrator:F /T /C >nul 2>&1
echo Successfully Installed!
echo IP:
:: FIXED: Skip curl/jq check since they're not available in GitHub runners
tasklist | find /i "ngrok.exe" >Nul && echo "ngrok is running - check GitHub Actions logs for tunnel URL" || echo "ngrok not running"
echo Username: Administrator
echo Password: W2016
echo Please log in to your RDP!
:: Use timeout instead of ping for cleaner delay
timeout /t 10 /nobreak >nul
